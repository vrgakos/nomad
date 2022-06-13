#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update and ensure we have apt-add-repository
apt-get update
apt-get install -y

# Install Core build utilities for Linux
apt-get install -y \
 	software-properties-common \
 	build-essential \
	git \
	libpcre3-dev \
	pkg-config \
	unzip \
	zip \
	curl \
	jq \
	tree \
	wget

# Install ARM build utilities
apt-get install -y \
	binutils-aarch64-linux-gnu \
	gcc-aarch64-linux-gnu \
	linux-libc-dev-arm64-cross \
	libc6-dev-arm64-cross \
	\
	binutils-arm-linux-gnueabihf \
	gcc-arm-linux-gnueabihf \
	gcc-multilib-arm-linux-gnueabihf \
	linux-libc-dev-armhf-cross \
	libc6-dev-armhf-cross \
	\
	binutils-x86-64-linux-gnu \
	gcc-x86-64-linux-gnu \
	gcc-multilib-x86-64-linux-gnu \
	linux-libc-dev-amd64-cross \
	libc6-dev-amd64-cross \
	\
	binutils-x86-64-linux-gnux32 \
	gcc-x86-64-linux-gnux32 \
	gcc-multilib-x86-64-linux-gnux32 \
	linux-libc-dev-x32-cross \
	libc6-dev-x32-cross \
	\
	binutils-mingw-w64 \
	gcc-mingw-w64

# Ensure everything is up to date
# apt-get upgrade -y

# Set hostname -> IP to make advertisement work as expected
ip=$(ip route get 1 | awk '{print $NF; exit}')
hostname=$(hostname)
sed -i -e "s/.*nomad.*/${ip} ${hostname}/" /etc/hosts

# Ensure we cd into the working directory on login
if ! grep "cd /opt/gopath/src/github.com/hashicorp/nomad" /home/vagrant/.profile ; then
	echo 'cd /opt/gopath/src/github.com/hashicorp/nomad' >> /home/vagrant/.profile
fi
