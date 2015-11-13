#!/bin/bash
hg clone https://hg.mozilla.org/releases/mozilla-release firefox
cp .mozconfig firefox/
cd firefox


cd ../memcached
AUTOMAKE=automake-1.15 ./autogen.sh && ./configure && make && sudo make install

cd ..
hg clone http://hg.nginx.org/nginx
cd nginx
hg tags -T '{tag}\n' | grep -m1 release | hg checkout
auto/configure && make && sudo make install

cd ../postgresql
./configure && make && sudo make install

mkdir -p ../sqlite
cd ../sqlite
fossil clone http://www.sqlite.org/cgi/src sqlite.fossil
fossil open sqlite.fossil
fossil update tag:release

cd ../sqlite-bld
make