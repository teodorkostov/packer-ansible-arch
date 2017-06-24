#!/bin/bash

set -e

rm -rf output
rm -rf temp
mkdir output
cp images/ovmf_x64.bin output/arch.bin

packer-io build arch.json
