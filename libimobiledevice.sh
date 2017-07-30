#!/bin/bash
#######################################################################
#
#  Project......: autobuild.sh
#  Creator......: Dev-Jam remasterized by matteyeux on 27/12/15
#######################################################################

echo -e "\033[31mDev-Jam 12/01/2015 - Script to build & install Libimobiledevice\033[0m"
echo -e "\033[32m\033[1m\033[4m\033[5m\033[7mCreated by Dev-Jam, improved by @matteyeux on 27/12/15\033[0m"

function linux_depends(){

        if [[ $(which apt-get) ]]; then
                sudo apt-get install -y git build-essential make autoconf \
                automake libtool openssl tar perl binutils gcc g++ \
                libc6-dev libssl-dev libusb-1.0-0-dev \
                libcurl4-gnutls-dev fuse libxml2-dev \
                libgcc1 libreadline-dev libglib2.0-dev libzip-dev \
                libclutter-1.0-dev  \
                libfuse-dev cython python2.7 \
                libncurses5
        else
                echo "Package manager is not supported"
                exit 1
        fi
}

function macos_depends(){
        # Install Hombrew.
        if [[ ! -e $(which brew) ]]; then
                echo "Brew is not installed..."
                echo "installing brew..."
                sleep 1
                ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        else
                echo "Brew already installed"
        fi
	
        # Ask for the administrator password upfront.
        sudo -v

        # Keep-alive: update existing `sudo` time stamp until the script has finished.
        while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

        # Make sure we’re using the latest Homebrew.
        brew update

        # Upgrade any already-installed formulae.
        brew upgrade

	# Install Development Packages;
        brew install libxml2
        brew install libzip
        brew install libplist
        brew install usbmuxd

        # Install Software;
        brew install automake
        brew install cmake
        brew install colormake
        brew install autoconf
        brew install libtool
        brew install pkg-config
        brew install gcc
        brew install libusb
        brew install glib

        # Install Optional;
        brew install Caskroom/cask/osxfuse

        
        # Install other useful binaries.
        brew install ack
        brew install git

        # Remove outdated versions from the cellar.
        brew cleanup
	
	# OpenSSL shit
	git clone https://github.com/openssl/openssl.git
        cd openssl
 	./config
	make && sudo make install
	cd ..
	rm -rf openssl # clean
}

function build_libimobiledevice(){
        libs=( "libplist" "libusbmuxd" "libimobiledevice" "usbmuxd" "libirecovery" \
                "ideviceinstaller" "libideviceactivation" "idevicerestore" "ifuse" )

        buildlibs() {
                for i in "${libs[@]}"
                do
                        echo -e "\033[1;32mFetching $i..."
                        git clone https://github.com/libimobiledevice/${i}.git
                        cd $i
                        echo -e "\033[1;32mConfiguring $i..."
                        ./autogen.sh
                        echo -e "\033[1;32mBuilding $i..."
                        make && sudo make install
                        echo -e "\033[1;32mInstalling $i..."
                        cd ..
                done
        }

        buildlibs
        if [[ -e $(which ldconfig) ]]; then
        	ldconfig
        else 
        	echo " "
        fi
}

if [[ $(uname) == 'Linux' ]]; then
        linux_depends
elif [[ $(uname) == 'Darwin' ]]; then
        macos_depends
fi
build_libimobiledevice
echo -e "\033[32m\033[1m\033[4m\033[5m\033[7mLibimobiledevice successfully installed thanks for using this script\033[0m"
