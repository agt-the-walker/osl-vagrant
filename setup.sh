#!/bin/bash

set -e

has_update_run=

function Install {
    local package=$1
    if [[ -z "$has_update_run" ]]; then
        apt-get update
        has_update_run=1
    fi
    apt-get install -y $package
}

### Check environment

if [[ $SUDO_USER != vagrant ]]; then
    echo 'Please run "vagrant up" or "vagrant provision" to run this script' >&2
    exit 1
fi

### Install dependencies

[[ -d /usr/include/boost ]] || Install libboost-all.dev
c++ --version >/dev/null 2>&1 || Install g++
make --version >/dev/null 2>&1 || Install make

### Download/compile OpenShogiLib

URL='http://gps.tanaka.ecc.u-tokyo.ac.jp/cgi-bin/viewvc.cgi/trunk/osl/?view=tar'
if [[ ! -d osl ]]; then
    wget -q -O - "$URL" | tar xzf -
fi

cd osl
make
