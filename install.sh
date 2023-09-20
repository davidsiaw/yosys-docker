#!/bin/bash

set -eo pipefail

cd $RUNNER_TEMP

# install oss suite
mkdir -p .setup-oss-cad-suite
pushd .setup-oss-cad-suite

case $TARGETARCH in
    "amd64")
    arch=x64
    ;;
    "arm64") 
    arch=arm64
    ;;
esac

build=`curl -s https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | grep browser_download_url | grep linux-$arch | cut -f4 -d\"`

wget --no-check-certificate $build -O build.tgz
tar xfz build.tgz
rm build.tgz

mv oss-cad-suite /opt
popd

git clone https://github.com/trabucayre/openFPGALoader
cd openFPGALoader
mkdir -p /etc/udev/rules.d/
cp 99-openfpgaloader.rules /etc/udev/rules.d/
service udev restart
udevadm control --reload-rules && udevadm trigger

mkdir build
cd build
cmake ..
make install -j4

