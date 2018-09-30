#!/bin/bash
# will merge with jinstall.sh once jtool2 hits beta/release stage
wget http://newosxbook.com/tools/jtool2.tgz -P /tmp/
tar zxvf /tmp/jtool2.tgz -C /tmp/

if [[ $(uname) == 'Darwin' ]]; then
	sudo cp /tmp/jtool2 /usr/local/bin
elif [[ $(uname) == 'Linux' ]]; then
	sudo cp /tmp/jtool2.ELF64 /usr/local/bin/jtool2
else
	echo "$(uname) not supported"
fi
