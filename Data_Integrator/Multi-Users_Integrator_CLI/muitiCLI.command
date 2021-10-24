SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$( dirname "${BASH_SOURCE[0]}" )"


rm -rf runCLI/output
rm -rf runCLI/used\ data/

mv output runCLI/output
mv used\ data/ runCLI/used\ data/

mkdir runCLI/data
folderCount=0

for f in multi-data/*/ ; do
	echo " "
	folderCount=$(( folderCount + 1 ))
	echo Folder Number ${folderCount} :
	echo ${f} 
	mv ${f}/* runCLI/data 
	./runCLI/singleCLI.command
	sleep 1
	echo " "
done

rm -rf runCLI/data

mv runCLI/output .
mv runCLI/used\ data/ .

rm -rf multi-data/*

echo " "
echo " "
echo " "
echo " "
echo " "
echo "#######################################################################"
echo "#######################################################################"
echo "#######################################################################"
echo "################ MULTI-DATA INTEGRATION COMPLETED #####################"
echo "#######################################################################"
echo "#################### INTEGRATED ${folderCount} DATA FOLDERS ########################"
echo "#######################################################################"
echo "########################### THANK YOU! ################################"
echo "#######################################################################"
echo "#######################################################################"
echo "#######################################################################"

