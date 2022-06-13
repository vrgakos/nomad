#!/usr/bin/env bash

cd /opt/gopath/src/github.com/hashicorp/nomad
git config --global --add safe.directory /opt/gopath/src/github.com/hashicorp/nomad
make bootstrap
