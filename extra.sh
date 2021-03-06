#!/bin/bash
if [ -d "WD" ]; then
	echo "Removing WD"
	sudo rm -rf WD
fi

mkdir WD
cd WD

# crappy code I use to enter in recovery mode without udid
git clone https://gist.github.com/0c272be43e70ad02012242921dd418be.git ideviceenterrecovery
gcc ideviceenterrecovery/ideviceenterrecovery.c -o ideviceenterrecovery/ideviceenterrecovery.c -limobiledevice
sudo cp ideviceenterrecovery/ideviceenterrecovery /usr/local/bin

# Useful if you don't want to dl entire firmware
git clone https://github.com/matteyeux/libcrippy && cd libcrippy
./autogen.sh && sudo make install
cd ..

git clone https://github.com/matteyeux/libpartialzip && cd libpartialzip
./autogen.sh && sudo make install
if [[ $(uname) == 'Linux' ]]; then
	sudo ldconfig
fi
cd ..

git clone https://github.com/radare/radare2 && cd radare2
./sys/install.sh
cd ..

git clone https://github.com/matteyeux/iBoot32Patcher
make -C iBoot32Patcher install

# I use it with qwertyoruiop's serialsh
git clone https://github.com/matteyeux/term.git
sudo make -C term install

if [[ $(uname) == 'Darwin']]; then
	brew install boost curl
else
	sudo apt-get install -y libboost-dev libcurl-dev
fi

git clone https://github.com/ABeltramo/otachecker-u
make -C otachecker-u && cp bin/otachecker /usr/local/bin

if [[ $(uname) == 'Linux' ]]; then
	wget https://d2ap6ypl1xbe4k.cloudfront.net/Hopper-v4-4.2.10-Linux.deb
	sudo dpkg -i Hopper-v4-4.2.10-Linux.deb
fi
