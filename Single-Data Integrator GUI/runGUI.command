SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$( dirname "${BASH_SOURCE[0]}" )"

./runGUI/singleGUI.command

rm -rf runGUI/data

mv runGUI/output .
mv runGUI/used\ data/ .