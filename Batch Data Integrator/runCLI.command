SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$( dirname "${BASH_SOURCE[0]}" )"

	mkdir data
        mkdir output

        for i in data/*records*.csv
        do 
            printf "\n" >> $i
        done

        head -1 data/*records*.csv | sed -n '2p' > output/finalData.csv
        tail -n +3 -q data/*records*.csv >> output/finalData.csv
        sqlite3 < preprocess.sql

        FILE_poi=data/point_of_interest.csv
        FILE_garmin=data/garmin_gpx.gpx
        FILE_vis=data/visited_places.csv

        if [[ -f "$FILE_vis" ]]; then
          head -1 data/visited_places.csv > data/visited_places_formatted.csv
          tail -n +3 -q data/visited_places.csv >> data/visited_places_formatted.csv
        fi


        if [[ -f "$FILE_garmin" ]]; then
            echo "Garmin File Exists -> Creating Garming CSV"
            gpx_converter --function "gpx_to_csv" --input_file "$FILE_garmin" --output_file "output/output_garmin.csv"
        fi

        if [[ -f "$FILE_vis" && -f "$FILE_poi" && -f "$FILE_garmin" ]]; then
            echo "All Files Provided -> Merging"
            sqlite3 < merge_visited.sql
            sqlite3 < merge_POI.sql
            sqlite3 < merge_garmin.sql
        elif [[ -f "$FILE_vis" && -f "$FILE_poi" ]]; then
            echo "Garmin File Not Provided -> Merging"
            sqlite3 < merge_visited.sql
            sqlite3 < merge_POI.sql
        elif [[ -f "$FILE_vis" && -f "$FILE_garmin" ]]; then
            echo "Location File Not Provided -> Merging"
            sqlite3 < merge_visited.sql
            sqlite3 < merge_garmin.sql
        elif [[ -f "$FILE_poi" && -f "$FILE_garmin" ]]; then
            echo "Visited File Not Provided  -> Merging"
            sqlite3 < merge_POI.sql
            sqlite3 < merge_garmin.sql
        elif [ -f "$FILE_vis" ]; then
            echo "VISITED FILE ONLY -> Merging"
            sqlite3 < merge_visited.sql
        elif [ -f "$FILE_poi" ]; then
            echo "LOCATION FILE ONLY -> Merging"
            sqlite3 < merge_POI.sql
        elif [ -f "$FILE_garmin" ]; then
            echo "GARMIN FILE ONLY -> Merging"
            sqlite3 < merge_garmin.sql
        fi

        rm data/visited_places_formatted.csv
        echo "Data Integration Completed"

        cat output/finalData.csv >> output/allBatches.csv
        echo "END OF BATCH \n" >> output/allBatches.csv

        userID=$(head -3 data/*records*.csv | sed -n '4p' | cut -d ',' -f1)
        echo SET USER ID
        echo $userID

        mkdir output/${userID}/
        mkdir output/${userID}/${userID}_$(date +%Y%m%d%H%M%S)
        mv output/finalData.csv output/${userID}/${userID}_$(date +%Y%m%d%H%M%S)/${userID}_$(date +%Y%m%d%H%M%S).csv
        cp data/*.json output/${userID}/${userID}_$(date +%Y%m%d%H%M%S)/profile_${userID}_$(date +%Y%m%d%H%M%S).json
        mv output/output_garmin.csv output/${userID}/${userID}_$(date +%Y%m%d%H%M%S)/garmin_${userID}_$(date +%Y%m%d%H%M%S).csv
        echo "Output files are stored in output folder"

        mkdir used\ data/
        mkdir used\ data/${userID}/
        mkdir used\ data/${userID}/${userID}_$(date +%Y%m%d%H%M%S)/
        mv data/*.csv used\ data/${userID}/${userID}_$(date +%Y%m%d%H%M%S)/
        mv data/*.json used\ data/${userID}/${userID}_$(date +%Y%m%d%H%M%S)/
        mv data/*.gpx used\ data/${userID}/${userID}_$(date +%Y%m%d%H%M%S)/

        echo "Used files are moved to "used data" folder"

echo "#################################"
echo "#################################"
echo "#################################"
echo "## DATA INTEGRATION COMPLETED. ##"
echo "#################################"
echo "########## THANK YOU! ###########"
echo "#################################"
echo "#################################"
echo "#################################"