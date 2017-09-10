#!/bin/bash
if [ -d "WD" ]; then
	echo "Removing WD"
	sudo rm -rf WD
fi

mkdir WD
cd WD

# crappy code I use to enter in recovery mode without udid
git clone https://gist.github.com/0c272be43e70ad02012242921dd418be.git ideviceenterrecovery && cd ideviceenterrecovery
gcc ideviceenterrecovery/ideviceenterrecovery.c -o ideviceenterrecovery/ideviceenterrecovery -limobiledevice
sudo cp ideviceenterrecovery/ideviceenterrecovery /usr/local/bin

# Useful if you don't want to dl entire firmware
git clone https://github.com/matteyeux/libcrippy && cd libcrippy
./autogen.sh && sudo make install

git clone https://github.com/matteyeux/libpartialzip && cd libpartialzip
./autogen.sh && sudo make install
sudo ldconfig
git clone https://github.com/radare/radare2 && cd radare2
./sys/install.sh

git clone https://github.com/matteyeux/iBoot32Patcher
make -C iBoot32Patcher install

git clone --recursive https://github.com/xerub/img4lib.git 
make -C img4lib/lzfse 
make -C img4lib && sudo cp img4lib/img4 /usr/local/bin/img4 

# I use it with qwertyoruiop's serialsh
git clone https://github.com/matteyeux/term.git
sudo make -C term install

sudo apt-get install -y libboost-dev libcurl-dev
git clone https://github.com/ABeltramo/otachecker-u
make -C otachecker-u && cp bin/otachecker /usr/local/bin

wget https://d2ap6ypl1xbe4k.cloudfront.net/Hopper-v4-4.2.10-Linux.deb
sudo dpkg -i Hopper-v4-4.2.10-Linux.deb
