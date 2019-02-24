#!/bin/bash
#######################################################################
#
#  Project......: jinstall
#  Creator......: matteyeux
#  Description..: Script to install or update some tools made by J Levin 
#                 (Too lazy to download and extract myself) 
#  Type.........: Public
#

INSTALL_DIR='/usr/local/bin/'
WD=~/.tmp_update #Working Directory

function jtinstall {
	wget http://newosxbook.com/tools/jtool2.tgz -P /tmp/
	tar zxvf /tmp/jtool2.tgz -C /tmp/

	if [[ $(uname) == 'Darwin' ]]; then
			sudo cp /tmp/jtool2 /usr/local/bin
	elif [[ $(uname) == 'Linux' ]]; then
			sudo cp /tmp/jtool2.ELF64 /usr/local/bin/jtool2
	else
			echo "$(uname) not supported"
	fi

	echo -e "\033[1;32mInstalled jtool2 to $INSTALL_DIR"
}

function jokerinstall {
		wget http://www.newosxbook.com/tools/joker.tar
		tar xvf joker.tar
		if [[ $(uname) == 'Darwin' ]]; then
			cp joker.universal /usr/local/bin/joker
		else
			mv joker.ELF64 joker
			sudo cp joker $INSTALL_DIR
		fi
		echo -e "\033[1;32mInstalled joker to $INSTALL_DIR"
}

function disarm_install {
		wget http://newosxbook.com/tools/disarm.tar
		tar xvf disarm.tar
		if [[ $(uname) == 'Darwin' ]]; then
			cp disarm /usr/local/bin/
		else
			rm disarm
			mv disarm.ELF64 disarm
			sudo cp disarm $INSTALL_DIR
		fi
		echo -e "\033[1;32mInstalled disarm to $INSTALL_DIR"
}

function otastuff {
		git clone https://gist.github.com/683ec721655f3729f9fad23b052384e3.git pbzx
		cd pbzx
		gcc pbzx.c -o pbzx
		cd ..
		git clone https://gist.github.com/be2a4f32a3ba49ad477b34292d728914.git ota
		cd ota
		gcc ota.c -o ota
		cd ..
		sudo cp pbzx/pbzx ota/ota $INSTALL_DIR
		echo -e "\033[1;32mInstalled OTA stuff to $INSTALL_DIR"
}

function main {
		if [[ $(uname) == 'Linux' && $(arch) == 'x86_64' || $(uname) == 'Darwin' ]]; then
			echo "starting script..."
		else
			echo "This script is only for Linux 64 bits or macOS"
			exit 1
		fi
		if [[ -e $WD ]]; then
				rm -rf $WD
		fi
		mkdir $WD
		cd $WD
		jtinstall
		jokerinstall
		disarm_install
		#otastuff
		echo -e "\033[1;32mAll tools are installed"
		echo -e "\033[1;32mCleaning"
		rm -rf $WD
		echo -e "\033[1;32mDone"
}

main
