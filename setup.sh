#!/bin/bash

set -e

has_update_run=

function Install {
    local package=$1
    if [[ -z "$has_update_run" ]]; then
        apt-get update
        has_update_run=1
    fi
    apt-get install -y "$package"
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

### Download OpenShogiLib (and test dependencies) then build it

URL='https://gps.tanaka.ecc.u-tokyo.ac.jp/cgi-bin/viewvc.cgi/trunk/osl/?view=tar'
if [[ ! -d osl ]]; then
    wget -q -O - "$URL" | tar xzf -
fi

GPS_URL='https://gps.tanaka.ecc.u-tokyo.ac.jp/cgi-bin/viewvc.cgi/trunk/gpsshogi/?root=gpsshogi&view=tar'
if [[ ! -d gpsshogi ]]; then
    wget -q -O - "$GPS_URL" | tar xzf -
fi

DATA_URL='https://gps.tanaka.ecc.u-tokyo.ac.jp/cgi-bin/viewvc.cgi/data/?view=tar'
if [[ ! -d data ]]; then
    wget -q -O - "$DATA_URL" | tar xzf -
fi

if [[ ! -f osl/full/osl/libosl_full.a ]]; then
    make -C osl
fi

### Change ownership to run the tests

for dir in */; do
    if [[ -O $dir ]]; then
        chown -R vagrant "$dir"
    fi
done
