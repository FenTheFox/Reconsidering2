#!/bin/bash
cd Hoard/src
make

cd ../../gperftools
./autogen.sh
./configure
make

cd ../jemalloc
./autogen.sh
./configure
make