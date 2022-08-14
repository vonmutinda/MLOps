#!/usr/bin/env bash

# NB: set dockerpath and version in the Makefile
make build

make tag

make server

docker ps | grep 'mlops'
