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


chmod u+x multiCLI.command
chmod u+x /runCLI/singleCLI.command


# MIGHT NEED

# pip3 install gpx_converter --user
# sudo pip3 install gpx_converter
# sudo pip3 install gpx_converter --user