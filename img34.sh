#!/bin/bash
#######################################################################
#
#  Project......: setup.sh
#  Creator......: matteyeux
#  Description..: Script to install usefull tools for Decrypt0r
#
######################################################################
# Language :
#               bash
# Version : 0.3
#
#  Change Log
#  ==========
#	 DD/MM/YY
#   ===============================================================
#    Date     |       Who          |      What
#   ---------------------------------------------------------------
#    04/10/15 | Mathieu Hautebas   | Script creation

if [[ "$(whoami)" != "root" ]]; then
    echo "Please run this script as root"
    exit 1
fi

if [[ $(uname) != 'Linux' ]]; then
  echo "This script is only for Linux"
  exit 1
fi

apt-get -y install 	binutils p7zip-full git \
					build-essential make cmake \
					openssl libcrypto++-dev bsdiff \
					libbz2-dev libpng3 libusb-1.0.0 \
					libusb-1.0.0-dev libssl-dev libcurl3 \
					python-pip

cd ~/Documents
git clone https://github.com/xerub/xpwn.git
mkdir ~/Documents/build
cd ~/Documents/build
cmake ~/Documents/xpwn
make package
tar jxvf XPwn-0.5.8-Linux.tar.bz2
cd XPwn-0.5.8-Linux/
cp hfsplus ipsw hdutil dmg ticket validate xpwntool /usr/local/bin

git clone --recursive https://github.com/xerub/img4tool ~/Documents/img4tool
cd ~/Documents/img4tool
make -C lzfse
make && cp img4 /usr/local/bin/
