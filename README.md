# UAA CLI binaries

Currently the https://github.com/cloudfoundry-incubator/uaa-cli does cut releases but does not include pre-built binaries.

This project fills that temporary gap. Each `uaa-cli` release becomes a https://github.com/starkandwayne/uaa-cli-releases/releases release with MacOS/Darwin and Linux binaries.

These binaries are then made available via another pipeline as Homebrew and Debian packages.

## MacOS/Homebrew

```plain
brew install starkandwayne/cf/uaa-cli
```

## Debian/Ubuntu

Instructions also at http://apt.starkandwayne.com/

```plain
wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add -
echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list
apt-get update

apt-get install uaa-cli
```

