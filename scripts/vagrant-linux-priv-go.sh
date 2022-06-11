#!/usr/bin/env bash

set -o errexit

function install_go() {
	local go_version="1.18.2"
	local download="https://storage.googleapis.com/golang/go${go_version}.linux-$(dpkg --print-architecture).tar.gz"

		if go version 2>&1 | grep -q "${go_version}"; then
		return
	fi

	# remove previous older version
	rm -rf /usr/local/go

	# retry downloading on spurious failure
	curl -sSL --fail -o /tmp/go.tar.gz \
		--retry 5 --retry-connrefused \
		"${download}"

	tar -C /tmp -xf /tmp/go.tar.gz
	sudo mv /tmp/go /usr/local
	sudo chown -R root:root /usr/local/go
}

install_go

# Ensure Go is on PATH
if [ ! -e /usr/bin/go ] ; then
	ln -s /go /usr/bin/go
fi
if [ ! -e /usr/bin/gofmt ] ; then
	ln -s /usr/local/go/bin/gofmt /usr/bin/gofmt
fi


# Ensure new sessions know about GOPATH
if [ ! -f /etc/profile.d/gopath.sh ] ; then
	cat <<EOT > /etc/profile.d/gopath.sh
if [ "\${HOME}" != "" ]
then
  mkdir -p "\${HOME}/go/bin"
  export PATH="\${PATH}:/usr/local/go/bin:\${HOME}/go/bin"
fi
EOT
	chmod 755 /etc/profile.d/gopath.sh
fi
