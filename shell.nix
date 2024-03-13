let
  nixpkgs_rev = "51063ed4f2343a59fdeebb279bb81d87d453942b"; # nixos-23-11 on 2024-03-13
  fenix_rev = "df74cae97f59a868ad355af6a703e7845d0ae648"; # main on 2024-03-13
in

{ pkgs ? import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/${nixpkgs_rev}.tar.gz") { }
, fenix ? import (builtins.fetchTarball "https://github.com/nix-community/fenix/archive/${fenix_rev}.tar.gz") { }
}:

with pkgs;
mkShell {
  buildInputs = [
    # fenix.latest.toolchain
    fenix.complete.toolchain
    flip-link
  ];

  # build `core` standard library from source
  CARGO_UNSTABLE_BUILD_STD = [ "core" ];

  # prevent duplicate symbols error in dev build
  CARGO_PROFILE_DEV_LTO = "fat";
  CARGO_PROFILE_DEV_OVERFLOW_CHECKS = "false";
}
