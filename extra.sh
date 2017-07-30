#!/bin/bash
if [ -d "WD" ]; then
	echo "Removing WD"
	sudo rm -rf WD
fi

mkdir WD
cd WD
# Useful if you don't want to dl entire firmware
git clone https://github.com/matteyeux/libcrippy && cd libcrippy
./autogen.sh && sudo make install

git clone https://github.com/matteyeux/libpartialzip && cd libpartialzip
./autogen.sh && sudo make install
sudo ldconfig
git clone https://github.com/radare/radare2 && cd radare2
./sys/install.sh

git clone --recursive https://github.com/xerub/img4lib.git #&& cd img4lib
make -C img4lib/lzfse 
make -C img4lib && sudo cp img4lib/img4 /usr/local/bin/img4tool # sorry for name it will conflict with img4
