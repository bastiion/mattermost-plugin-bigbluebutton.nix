{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

with pkgs;
let
  vscodeExt = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions;
      [ bbenoist.nix eamodio.gitlens golang.go ]
      ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "emacs-mcx";
          publisher = "tuttieee";
          version = "0.31.0";
          sha256 = "sha256:McSWrOSYM3sMtZt48iStiUvfAXURGk16CHKfBHKj5Zk=";
        }
        {
          name = "vscode-go-autotest";
          publisher = "windmilleng";
          version = "1.6.0";
          sha256 = "sha256:8QWUDgsdqNdG/ELN24mwAsfa9uyqBS2vUifSMZRK5hM=";
        }
        {
          name = "vscode-go-test-adapter";
          publisher = "ethan-reesor";
          version = "0.1.5";
          sha256 = "sha256:M5SrAx0tCCdvut+LCR6BXqGQIU6+kGF6Wb1j3woDJdw=";
        }
        {
          name = "test-adapter-converter";
          publisher = "ms-vscode";
          version = "0.0.9";
          sha256 = "sha256:YOzYnlGWcCEwf2TKW8NBfO2gRgb6YQwqJmYEgHkNLPo=";
        }
        {
          name = "vscode-test-explorer";
          publisher = "hbenl";
          version = "2.20.2";
          sha256 = "sha256:vsPznnKHxEAH8FzGy11g7ZrYokOCUY5Jmmu+YXHm3qc=";
        }
      ];
  };
in
mkShell {
  nativeBuildInputs = [
    bashCompletion
    bashInteractive
    cacert
    emacs-nox
    git
    gnumake
    go
    gocode
    gocode-gomod
    gogetdoc
    golint
    golangci-lint
    gopls
    go-outline
    go-check
    go-tools
    nixpkgs-fmt
  ] ++ lib.optionals (hostPlatform.isLinux) [ typora vscodeExt ];

  buildInputs = [ ] ++ lib.optionals (hostPlatform.isLinux) [ glibcLocales ];

  LANG = "en_US.UTF-8";

  shellHook = ''
    export HOME=$(pwd)
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
  '';
}
