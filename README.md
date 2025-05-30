# LocalStoragePlugin
Access and store data in localStorage easily (web builds)

- To store some data just use
```LocalStorage.set_item("key", value)```
- To take it back use
```LocalStorage.get_item("key")```

In ```localstorage.gd``` file you can switch debug mode (if _DEBUG_MODE false - all keys and values are encrypted in localStorage) and assign _ENCRYPTION_KEY
