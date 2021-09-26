# Welcome to the golden go template

[![CI-linux](https://github.com/nokx5/golden-go/workflows/CI-linux/badge.svg)](https://github.com/nokx5/golden-go/actions/workflows/ci-linux.yml) [![CI-linux](https://github.com/nokx5/golden-go/workflows/CI-darwin/badge.svg)](https://github.com/nokx5/golden-go/actions/workflows/ci-darwin.yml) [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nokx5/golden-go/blob/master/LICENSE)

This is a skeleton template for a Go project. Please find all the documentation here <!-- ](https://nokx5.github.io/golden-go) --> and the source code [here](https://github.com/nokx5/golden-go).

> **NOTE:** you may require the experimental flakes commands `nix build` and `nix shell` in the following. If you do not, only classic nix commands `nix-build` and `nix-shell` will be available.

## My development tools are
- nix :snowflake: (packaging from hell :heart:)
- gofmt (formatter)
- vscode (IDE) with
  - golang.go
- go test (unit testing)
- go doc (documentation)


## Use the software

The [nokxpkgs](https://github.com/nokx5/nokxpkgs#add-nokxpkgs-to-your-nix-channel) channel and associate overlay can be imported with the `-I` command or by setting the `NIX_PATH` environment variable.

```bash
nix-shell -I nixpkgs=https://github.com/nokx5/nokxpkgs/archive/main.tar.gz -p golden-go --command golden-go
# or
nix shell github:nokx5/golden-go --command golden-go
nix shell github:nokx5/nokxpkgs#golden-go --command golden-go
```

## Develop the software (depreciated - new hash)

> Please note that all commands of this section creates new hashes which means that the evaluation may require additional downloads.

Start by cloning the [git repository](https://github.com/nokx5/golden-go) locally and enter it.

#### Option 1: Develop the software (minimal requirements)

You can develop or build the local software easily with the minimal requirements.

```bash
# option a: develop with a local shell (depreciated - new hash)
nix-shell --expr 'with import <nixpkgs> {}; callPackage ./derivation.nix {src = ./.; }'

# option b: build the local project (depreciated - new hash)
nix-build --expr 'with import <nixpkgs> {}; callPackage ./derivation.nix {src = ./.; }' --no-out-link
```

Note that you can write the nix expression directly to the `default.nix` file to avoid typing `--expr` each time.

 #### Option 2: Develop the software (supercharged :artificial_satellite:)

You can enter the supercharged environment for development.

```bash
nix-shell shell.nix
```

## Develop the software

> **NOTE:** This section requires the experimental `flake` and `nix-command` features. Please refer to the official documentation for nix flakes. The advantage of using nix flakes is that you avoid channel pinning issues.
> 
> After Nix was installed, update to the unstable feature with:
> 
> ```bash
> nix-env -f '<nixpkgs>' -iA nixUnstable
> ```
> 
> And enable experimental features with:
> 
> ```bash
> mkdir -p ~/.config/nix
> echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
> ```

Start by cloning the [git repository](https://github.com/nokx5/golden-go) locally and enter it.

#### Option 1: Develop the software

```bash
# option a: develop with a local shell
nix develop .#golden-go
# or
nix-shell . -A packages.x86_64-linux.golden-go

# option b: build the local project
nix build .#golden-go
# or
nix-build . -A packages.x86_64-linux.golden-go
```

#### Option 2: Develop the software (supercharged :artificial_satellite:)

You can enter the development supercharged environment.

```bash
nix develop
# or
nix-shell . -A devShell.x86_64-linux
```

## Code Snippets

Build links to derivation
```bash
nix-build . -A packages.x86_64-linux.golden-go --out-link result-golden-go
# nix-build . -A packages.x86_64-linux.golden-go.inputDerivation --out-link result-golden-go-dev
nix-build . -A devShell.x86_64-linux.inputDerivation --out-link result-golden-go-dev-full
```


One line code formatter for C/C++ projects

```bash
nixpkgs-fmt .

gofmt $(find -name "*.go")
```
