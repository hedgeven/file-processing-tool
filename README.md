# file-processing-tool
Tool for quick and easy work with large numbers of files. Mainly oriented to search for viruses in files.

## Usage:
1. Get file-processing-tool.sh
```bash
wget https://raw.githubusercontent.com/hedgeven/file-processing-tool/master/file-processing-tool.sh
```
2. Find files by any criteria and save result to temporary file
```bash
find . -type f -name '*.php' > php_files
```
3. Run file-processing-tool.sh
```bash
bash file-processing-tool.sh `cat php_files`
```
