#!/bin/bash

set -eu

java -version

# VERSION required to build uaa with a version number
VERSION=$(cat uaa/version)

pushd uaa
tar xfz source.tar.gz
pushd cloudfoundry-uaa-*/

./gradlew clean assemble
mkdir artifacts
cp uaa/build/libs/cloudfoundry-identity-uaa*.war artifacts/

popd
popd

echo "v${VERSION}"                  > ${RELEASE_ROOT}/tag
echo "${RELEASE_NAME} v${VERSION}"  > ${RELEASE_ROOT}/name
mv uaa/cloudfoundry-uaa-*/artifacts   ${RELEASE_ROOT}/artifacts

cat > ${RELEASE_ROOT}/notes.md <<-MARKDOWN
See https://github.com/cloudfoundry/uaa/releases/tag/${VERSION}
MARKDOWN

cat > ${RELEASE_ROOT}/notification <<EOF
<!here> New ${RELEASE_NAME} v${VERSION} released!
EOF

