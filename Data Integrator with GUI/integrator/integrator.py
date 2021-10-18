# -*- coding: utf-8 -*-

"""This module provides the Integrator class to merge multiple files."""

import time
import os
from pathlib import Path

from PyQt5.QtCore import QObject, pyqtSignal


class Integrator(QObject):
    # Define custom signals
    progressed = pyqtSignal(int)
    integratedFile = pyqtSignal(Path)
    finished = pyqtSignal()

    def __init__(self, files):
        super().__init__()
        self._files = files

    def integrateFiles(self):
        os.system('mkdir data')
        cwd = os.getcwd()
        for fileNumber, file in enumerate(self._files, 1):
            oldName = file.name
            newPath = file.parent.joinpath(
                f"{cwd}/data/{str(oldName)}"
            )
            file.rename(newPath)
            time.sleep(0.1)  # Comment this line to integrate move faster.
            self.progressed.emit(fileNumber)
            self.integratedFile.emit(newPath)
        self.progressed.emit(0)  # Reset the progress
        self.finished.emit()

        cmd = '''
        mkdir output
        mkdir data/Used\ Data/

        for i in data/*records*.csv
        do 
            echo "\n" >> $i
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
        mv output/finalData.csv output/${userID}/${userID}$(date +%Y%m%d%H%M%S).csv
        cp data/*.json output/${userID}/profile_${userID}$(date +%Y%m%d%H%M%S).json
        echo "Output files are stored in output folder"

        mkdir data/Used\ Data/${userID}/
        mkdir data/Used\ Data/${userID}/$(date +%Y%m%d%H%M%S)/
        mv data/*.csv data/Used\ Data/${userID}/$(date +%Y%m%d%H%M%S)/
        mv data/*.json data/Used\ Data/${userID}/$(date +%Y%m%d%H%M%S)/
        mv data/*.gpx data/Used\ Data/${userID}/$(date +%Y%m%d%H%M%S)/

        echo "Used files are moved to Data/Used Data"

        '''
        os.system(cmd)
