#!/bin/bash

git clone --recursive https://github.com/tihmstar/tsschecker
./tsschecker/autohen.sh
sudo make -C tsschecker install

mkdir tmp && cd tmp
wget http://api.tihmstar.net/builds/futurerestore/futurerestore-latest.zip
unzip futurerestore-latest.zip

chmod +x futurerestore_linux && cp futurerestore_linux /usr/local/bin/futurerestore
cd ../ && rm -rf tmp
