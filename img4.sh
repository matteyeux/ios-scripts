#!/bin/bash
# you may have to install openssl first
if [[ "$(whoami)" != "root" ]]; then
    echo "Please run this script as root"
    exit 1
fi

git clone --recursive https://github.com/xerub/img4lib ~/Documents/img4lib
cd ~/Documents/img4lib
make -C lzfse && make
sudo cp img4 /usr/local/bin/
