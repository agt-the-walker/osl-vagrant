#!/bin/bash

set -e

[[ $USER = vagrant ]] || exec vagrant ssh -- /vagrant/test.sh

cd osl

[[ -h data ]] || ln -s ../gpsshogi/data .
[[ -h public-data ]] || ln -s ../data public-data .
make run-test
