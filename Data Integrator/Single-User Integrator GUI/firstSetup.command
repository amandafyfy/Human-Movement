which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

brew install sqlite3
brew install python3
brew install pip3
pip3 install gpx_converter
pip3 install pytest.qt
pip3 install PyQt5

chmod u+x runGUI.command
chmod u+x runGUI/singleGUI.command
chmod u+x runGUI/runTest.command

python3 -m venv runGUI/integrator/venv
source runGUI/integrator/venv/bin/activate
pip3 install PyQt5 --user
pip3 install gpx_converter --user
pip3 install pytest.qt --user


# MIGHT NEED

# pip3 install gpx_converter --user
# sudo pip3 install gpx_converter
# sudo pip3 install gpx_converter --user

# pip3 install PyQt5 --user
# sudo pip3 install PyQt5
# sudo pip3 install PyQt5 --user

# pip3 install pytest.qt --user
# sudo pip3 install pytest.qt
# sudo pip3 install pytest.qt --user