
{ config, lib, pkgs, ... }:

{
   nix.binaryCaches = [
    "https://nixcache.reflex-frp.org"
    "https://all-hies.cachix.org"
  ];
   nix.trustedBinaryCaches = [
     "https://hydra.iohk.io"
     "https://cachix.cachix.org"
     "https://nixcache.reflex-frp.org"
     "https://all-hies.cachix.org"
   ];
  nix.binaryCachePublicKeys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
    "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
  ];
}
