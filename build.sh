#!/bin/bash

set -e

rm -rf output
rm -rf temp
mkdir output
cp images/ovmf_x64.bin output/ovmf_x64.bin

packer-io build arch.json
