
from mmap import ACCESS_WRITE
from typing import Text
import pytest

from PyQt5 import QtCore
from PyQt5.QtWidgets import QWidget
from .ui.window import Ui_Window
from .views import Window
import time
import os
import pandas as pd


@pytest.fixture
def app(qtbot):
    integrator_app = Window()
    qtbot.addWidget(integrator_app)

    return integrator_app


def test_label(app):
    assert app.label.text() == "User Data Files:"


def test_label2(app):
    assert app.label_2.text() == "Data Files for Integration"


def test_label3(app):
    assert app.label_3.text() == "Integrated Files"


def test_loadFilesButton(app):
    assert app.loadFilesButton.text() == "&Load Files"
    assert app.loadFilesButton.isEnabled() == True


def test_integrateButton(app):
    assert app.integrateButton.text() == "Integrate"
    assert app.integrateButton.isEnabled() == False


def test_click(app, qtbot):
    qtbot.mouseClick(app.loadFilesButton, QtCore.Qt.LeftButton)
    qtbot.mouseClick(app.integrateButton, QtCore.Qt.LeftButton)
    time.sleep(10)


def test_base_files_exist():
    assert os.path.isfile("../firstSetup.command") == True
    assert os.path.isfile("../runGUI.command") == True
    assert os.path.isfile("../Integrator_User_Manual_GUI.pdf") == True


def test_output_exist():
    assert os.path.isfile("../output/allBatches.csv") == True


def test_output_content():
    # test using Real Test Data only
    with open("../output/allBatches.csv") as f:
        txt = f.read().split("\n")
    assert txt[0] == "userId,unixTime,date,latitude,longitude,speed,mode_of_transport,anomalies,vis_lat,vis_long,vis_locName,vis_transport,vis_act1,vis_act_enjoyment1,vis_act2,vis_act_enjoyment2,vis_act3,vis_act_enjoyment3,vis_comment,poi_name,poi_lat,poi_long,garmin_lat,garmin_long,garmin_alt,lat_dif,lon_dif"
