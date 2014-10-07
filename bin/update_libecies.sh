#!/bin/bash

GITREPO=https://gitlab.asynchrony.com/proj-1016/libecies.git
TMPDIR=/tmp/libecies

### update openssl
brew update
brew upgrade openssl
brew unlink openssl && brew link --force openssl

### update libecies
mkdir $TMPDIR
cd $TMPDIR
git clone $GITREPO libecies
cd libecies

export PKG_CONFIG_PATH=`brew --prefix openssl`/lib/pkgconfig
./configure
make check
if [ "$?" -ne 0 ]; then
     echo "libecies tests failed, aborting install!!!"
     exit 1
fi
make install

cd $HOME
rm -rf $TMPDIR
echo "All done."
