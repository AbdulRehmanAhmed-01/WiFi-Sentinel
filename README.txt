FIXED VERSION
The previous version failed because Chrome blocks fetch() of wifi-data.json when index.html is opened as file://.
This version fixes that by generating wifi-data.js instead. The browser can load a local JavaScript file directly.
Run START_SCANNER.bat. No Node.js or npm required.