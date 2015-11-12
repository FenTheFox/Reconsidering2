#!/bin/bash
cd memcached
./autogen.sh && ./configure && make
cd ..
hg clone http://hg.nginx.org/nginx
cd nginx
hg tags -T '{tag}\n' | grep -m1 release | hg checkout
auto/configure && make
cd ../postgresql
./configure && make