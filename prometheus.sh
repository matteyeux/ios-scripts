#!/bin/bash
if [ -d "WD" ]; then
	echo "Removing WD"
	sudo rm -rf WD
fi

mkdir WD
cd WD



if [[ $(uname) == 'Darwin' ]]; then
	tool=futurerestore_macos
elif [[ $(uname) == 'Linux' ]]; then
	tool=futurerestore_linux
else
	echo "$(uname) not supported"
fi

git clone https://github.com/tihmstar/libfragmentzip && cd libfragmentzip
./autogen.sh && sudo make install
cd ..

git clone --recursive https://github.com/tihmstar/tsschecker
./tsschecker/autogen.sh
sudo make -C tsschecker install

mkdir tmp && cd tmp
wget http://api.tihmstar.net/builds/futurerestore/futurerestore-latest.zip
unzip futurerestore-latest.zip

chmod +x $tool && sudo cp $tool /usr/local/bin/futurerestore
cd ../ && rm -rf tmp
