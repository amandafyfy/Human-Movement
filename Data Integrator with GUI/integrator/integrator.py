# -*- coding: utf-8 -*-

"""This module provides the Integrator class to merge multiple files."""

import time
import subprocess
import os
from pathlib import Path

from PyQt5.QtCore import QObject, pyqtSignal


class Integrator(QObject):
    # Define custom signals
    progressed = pyqtSignal(int)
    integratedFile = pyqtSignal(Path)
    finished = pyqtSignal()

    def __init__(self, files, prefix):
        super().__init__()
        self._files = files
        self._prefix = prefix

    def integrateFiles(self):
        cwd = os.getcwd()
        for fileNumber, file in enumerate(self._files, 1):
            oldName = file.name
            newFile = file.parent.joinpath(
                f"{cwd}/data/{self._prefix}{str(fileNumber)}{file.suffix}"
            )
            file.rename(newFile)
            time.sleep(0.1)  # Comment this line to rename files faster.
            self.progressed.emit(fileNumber)
            self.integratedFile.emit(newFile)
        self.progressed.emit(0)  # Reset the progress
        self.finished.emit()
        cmd = '''
        touch file1.txt
        touch file2.txt
        '''
        cmd2 = '''
        mkdir output

        head -1 data/records1.csv > output/all_records_final.csv
        tail -n +2 -q data/records*.csv >> output/all_records_final.csv

        grep -q "" data/locations.csv
        if [[ $? != 0 ]] ; then
            sqlite3 < sqlscript-no-locations.txt
        else
            sqlite3 < sqlscript.txt
        fi

        '''
        os.system(cmd)
