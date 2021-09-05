SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$( dirname "${BASH_SOURCE[0]}" )"

head -1 data/1records.csv > all_records_final.csv
tail -n +2 -q data/*records.csv >> all_records_final.csv

sqlite3 < sqlscript.txt