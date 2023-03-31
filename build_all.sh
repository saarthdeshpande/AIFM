#!/bin/bash

# Requirements
apt install python3-pip
pip3 install cmake
apt install make gcc cmake pkg-config libnl-3-dev libnl-route-3-dev libnuma-dev uuid-dev libssl-dev libaio-dev libcunit1-dev libclang-dev libncurses-dev meson python3-pyelftools

# Caladan
cd caladan-arkose
make submodules
make clean && make
pushd ksched
make clean && make
popd
sudo ./scripts/setup_machine.sh
echo 1 | curl https://sh.rustup.rs -sSf | sh
cd ..

# Snappy
cd aifm
./build.sh || { echo 'Failed to build AIFM.'; exit 1; }
cd ..

# Caladan librt++.a
cd caladan-arkose/bindings/cc
./build.sh || { echo 'Failed to build Shenango.'; exit 1; }
cd ..
