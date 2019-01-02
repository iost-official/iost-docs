---
id: Environment-Configuration
title: Environment & Configuration
sidebar_label: Environment & Configuration
---

## Prerequisites

* Go 1.9 or newer (Go 1.11 recommended)
* Git LFS (v2.5.2 recommended)
* [Docker CE 18.06 or newer](https://docs.docker.com/install/) (older versions are not tested)

Currently, below environments are tested:

* [Mac OS X](#mac-os-x)
* [Ubuntu/Linux](#ubuntu-linux)
* [Docker](#docker)

## Building and unit tests

- Install all the prerequisites.
   Please refer to its platform-specific installation doc.

   To install Git LFS:

```
# mac-os-x
brew install git-lfs

# ubuntu
sudo apt install -y git-lfs

# centos
yum --enablerepo=epel install -y git-lfs
```

- Install the Git command line extension. You only have to set up Git LFS once.

```
git lfs install
```

- Get repo.

```
git clone git@github.com:iost-official/go-iost.git
cd go-iost
```

- Build binaries

```
make vmlib
make build
```

- Run unit tests.

```
make test
```

- Run binaries.

```
target/iserver -f config/iserver.yml

target/iwalllet state
```
