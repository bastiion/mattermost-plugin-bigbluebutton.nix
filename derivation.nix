{ stdenv, buildGoModule, src }:

buildGoModule rec {
  pname = "golden-go";
  version = "0.0.0";
  inherit src;

  vendorSha256 = "og9VXaxE/b4RVjuVmWLSJklVSgZSSXNNuKI8wL9bgUo=";
  runVend = true;
}
