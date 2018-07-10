#!/bin/bash

set -eu

# VERSION required to build uaa with a version number
export VERSION=$(cat uaa-cli/version)


go version; echo; echo
TARGETS=${TARGETS:-linux/amd64 darwin/amd64}

echo "Install dep"
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
echo "Install gox"
go get github.com/mitchellh/gox

tar xfz uaa-cli/source.tar.gz

mkdir -p $GOPATH/src/code.cloudfoundry.org/uaa-cli
cp -r $PWD/cloudfoundry*/* $GOPATH/src/code.cloudfoundry.org/uaa-cli

if [[ -n ${STATIC_BINARY} && ${STATIC_BINARY} != "false" ]]; then
	export CGO_ENABLED=0
fi

REPO_ROOT=$GOPATH/src/code.cloudfoundry.org/uaa-cli
pushd $REPO_ROOT
dep ensure

# make build
# make install
# uaa version

mkdir artifacts
gox -osarch="${TARGETS}" --output="artifacts/${BINARY}-{{.OS}}-{{.Arch}}" -ldflags="-X code.cloudfoundry.org/uaa-cli/version.Version=${VERSION}" ./...
go build -o "${BINARY}" -ldflags="-X main.Version=${VERSION}" ${CMD_PKG:-.}
./${BINARY} version

popd

echo "v${VERSION}"                         > ${RELEASE_ROOT}/tag
echo "${RELEASE_NAME} v${VERSION}"         > ${RELEASE_ROOT}/name
mv ${REPO_ROOT}/artifacts                    ${RELEASE_ROOT}/artifacts

cat > ${RELEASE_ROOT}/notes.md <<-MARKDOWN
See https://github.com/cloudfoundry-incubator/uaa-cli/releases/tag/${VERSION}
MARKDOWN

cat > ${RELEASE_ROOT}/notification <<EOF
<!here> New ${RELEASE_NAME} v${VERSION} released!
EOF

