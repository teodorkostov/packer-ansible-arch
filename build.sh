#!/bin/bash

set -e

# ansible-playbook arch-playbook.yaml --check
rm -rf output
packer-io build arch.json
