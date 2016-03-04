# file-processing-tool
Tool for quick and easy work with large numbers of files. Mainly oriented to search for viruses in files.

## Usage:
* Get file-processing-tool.sh
```bash
wget https://raw.githubusercontent.com/hedgeven/file-processing-tool/master/file-processing-tool.sh
```
* Find files by any criteria and save result to temporary file
```bash
find . -type f -name '*.php' > php_files
```
or find by regexp
```bash
{ find . -type f -name '*.php'|xargs -L1 -I'f' sh -c "echo -n \"f \"; head -n1 'f' | wc -c" | awk '$2 > 256 {print $1}' ; find . -type f -name '*.php' -exec egrep 'strtoupper.*php|strtolower.*php|eval|base64|$GLOBALS|$_REQUEST|preg_replace|shell' -il {} \; ; } | sort -u > php_files
```
* Run file-processing-tool.sh
```bash
bash file-processing-tool.sh `cat php_files`
```
