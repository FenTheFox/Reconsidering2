#!/bin/bash
SRC_DIR=`pwd`

hg clone https://hg.mozilla.org/releases/mozilla-release firefox
hg clone http://hg.nginx.org/nginx

mkdir -p $SRC_DIR/sqlite
cd $SRC_DIR/sqlite
fossil clone http://www.sqlite.org/cgi/src sqlite.fossil
fossil open sqlite.fossil
fossil update tag:release

cd $SRC_DIR/firefox
cp ../.mozconfig .
hg tags -T '{tag}\n' | grep -E -m1 "FIREFOX(_|\w)*RELEASE" | hg checkout
./mach bootstrap
./mach build
$SRC_DIR/firefox-bld/dist/bin/firefox -no-remote -CreateProfile jsbench
$SRC_DIR/firefox-bld/dist/bin/firefox -no-remote -CreateProfile renderbench

cd $SRC_DIR/memcached
AUTOMAKE=automake-1.15 ./autogen.sh && ./configure -q --enable-64bit && make -s && sudo make -s install

cd $SRC_DIR/nginx
hg tags -T '{tag}\n' | grep -m1 release | hg checkout
auto/configure --with-http_ssl_module && make -s && sudo make -s install

cd $SRC_DIR/postgresql
./configure -q && make -s && sudo make -s install

cd $SRC_DIR/sqlite-bld
make -s

cd $SRC_DIR/Hoard/src
make -s

cd $SRC_DIR/gperftools
./autogen.sh
./configure -q
make -s

cd $SRC_DIR/jemalloc
./autogen.sh
./configure -q
make -s