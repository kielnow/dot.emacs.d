#!/bin/sh

# setup apt-cyg
apt-cyg -m ftp://ftp.iij.ad.jp/pub/cygwin/ update
apt-cyg install gcc-core gcc-g++ git

# setup qkc
cd /usr/src
wget http://hp.vector.co.jp/authors/VA000501/qkcc100.zip
unzip qkcc100.xip -d qkcc100
cd qkcc100
cp qkc.exe /usr/sbin/

# setup cmigemo
cd /usr/src
git clone https://github.com/koron/cmigemo
cd cmigemo
./configure
make cyg
make cyg-dict
make cyg-install
