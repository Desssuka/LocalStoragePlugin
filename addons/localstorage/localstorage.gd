@tool
class_name LocalStorage extends Object

static var _ENCRYPTION_KEY: String = "YOUR_SECRET_KEY";
static var _DEBUG_MODE: bool = true;

static func get_item(key: String) -> String:
	var js_eval_code = 'localStorage.getItem("%s")' % [key if _DEBUG_MODE else _encrypt(key)];
	var local_storage_item = JavaScriptBridge.eval(js_eval_code);
	var value = JSON.stringify(local_storage_item) if _DEBUG_MODE else _decrypt(local_storage_item);
	var parsed_value = JSON.parse_string(value);

	return parsed_value;

static func set_item(key: String, value: Variant):
	var formattedValue = JSON.stringify(value);
	var js_eval_code = 'localStorage.setItem("%s", %s)' % [key if _DEBUG_MODE else _encrypt(key), formattedValue if _DEBUG_MODE else '"' + _encrypt(formattedValue) + '"'];
	JavaScriptBridge.eval(js_eval_code);

static func _encrypt(text: String) -> String:
	var result = PackedByteArray();
	var key_bytes = _ENCRYPTION_KEY.to_utf8_buffer();
	var text_bytes = text.to_utf8_buffer();
	
	for i in range(text_bytes.size()):
		result.append(text_bytes[i] ^ key_bytes[i % key_bytes.size()]);
	
	return Marshalls.raw_to_base64(result);

static func _decrypt(encrypted: String) -> String:
	var result = PackedByteArray();
	var key_bytes = _ENCRYPTION_KEY.to_utf8_buffer();
	var encrypted_bytes = Marshalls.base64_to_raw(encrypted);
	
	for i in range(encrypted_bytes.size()):
		result.append(encrypted_bytes[i] ^ key_bytes[i % key_bytes.size()]);
	
	return result.get_string_from_utf8();
