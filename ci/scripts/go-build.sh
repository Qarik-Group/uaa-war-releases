#!/bin/bash

set -eu

env

source=$PWD/uaa-cli/source.tar.gz
mkdir -p $GOPATH/src/github.com/code.cloudfoundry.org/uaa-cli
cd $GOPATH/src/github.com/code.cloudfoundry.org/uaa-cli
tar xfz $source
dep ensure
go build github.com/code.cloudfoundry.org/uaa-cli

ls $GOPATH/bin

uaa
