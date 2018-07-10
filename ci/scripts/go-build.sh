#!/bin/bash

set -eu

# VERSION required to build uaa with a version number
export VERSION=$(cat uaa-cli/version)

curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

tar xfz uaa-cli/source.tar.gz

mkdir -p $GOPATH/src/code.cloudfoundry.org/uaa-cli
cp -r $PWD/cloudfoundry*/* $GOPATH/src/code.cloudfoundry.org/uaa-cli

cd $GOPATH/src/code.cloudfoundry.org/uaa-cli
dep ensure
make build
make install

uaa version
