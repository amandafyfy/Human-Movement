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

        head -1 data/records1.csv > output/finalData.csv
        tail -n +2 -q data/records*.csv >> output/finalData.csv

        FILE_loc=data/locations.csv
        FILE_garmin=data/garmin.csv
        FILE_vis=data/visited_places.csv

        if [[ -f "$FILE_vis" && -f "$FILE_loc" && -f "$FILE_garmin" ]]; then
            sqlite3 < sqlscript-no-locations.txt
            sqlite3 < sqlscript.txt
            sqlite3 < sqlscript_garmin.txt
        elif [[ -f "$FILE_vis" && -f "$FILE_loc" ]]; then
            sqlite3 < sqlscript-no-locations.txt
            echo "Amanda"
            cat output/finalData.csv
            sqlite3 < sqlscript.txt
        elif [[ -f "$FILE_vis" && -f "$FILE_garmin" ]]; then
            sqlite3 < sqlscript-no-locations.txt
            sqlite3 < sqlscript_garmin.txt
        elif [[ -f "$FILE_loc" && -f "$FILE_garmin" ]]; then
            sqlite3 < sqlscript.txt
            sqlite3 < sqlscript_garmin.txt
        elif [ -f "$FILE_vis" ]; then
            sqlite3 < sqlscript-no-locations.txt
        elif [ -f "$FILE_loc" ]; then
            sqlite3 < sqlscript.txt
        elif [ -f "$FILE_garmin" ]; then
            sqlite3 < sqlscript_garmin.txt
        fi

        mv data/*.csv data/Integrated\ Data/

        '''
        os.system(cmd)
