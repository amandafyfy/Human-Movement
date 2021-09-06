SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$( dirname "${BASH_SOURCE[0]}" )"

mkdir output

head -1 data/records1.csv > output/all_records_final.csv
tail -n +2 -q data/records*.csv >> output/all_records_final.csv

grep -q "" data/locations.csv
if [[ $? != 0 ]] ; then
    sqlite3 < sqlscript-no-locations.txt
else
    sqlite3 < sqlscript.txt
fi

