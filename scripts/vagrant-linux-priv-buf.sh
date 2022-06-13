#!/usr/bin/env bash

set -o errexit

ARCH=x86_64
if [ "$(dpkg --print-architecture)" == "arm64" ]
then
ARCH=aarch64
fi


# Make sure you grab the latest version
VERSION=1.5.0
DOWNLOAD=https://github.com/bufbuild/buf/releases/download/v${VERSION}/buf-Linux-${ARCH}

function install() {
  if command -v buf >/dev/null; then
    if [ "${VERSION}" = "$(buf  --version)" ] ; then
      return
    fi
  fi

  # Download
  curl -sSL --fail "$DOWNLOAD" -o /tmp/buf

  # make executable
  chmod +x /tmp/buf

  # Move buf to /usr/bin
  mv /tmp/buf /usr/bin/buf
}

install
