# UAA CLI binaries

The fabulous new [`uaa` CLI](https://github.com/cloudfoundry-incubator/uaa-cli) project has started cutting releases, but does not produce its own pre-built binaries.

This project fills a temporary gap. Each upstream `uaa-cli` release becomes a pair of MacOS/Darwin and Linux binaries available at https://github.com/starkandwayne/uaa-cli-releases/releases.

These GitHub releases/binaries are then fed into another pipeline as Homebrew and Debian packages.

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

