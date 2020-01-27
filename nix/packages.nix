{ pkgs }:

with pkgs; let exe = haskell.lib.justStaticExecutables; in [
  coreutils

  # gitToolsEnv
  diffstat
  diffutils
  gist
  git-lfs
  gitRepo
  gitAndTools.git-crypt
  gitAndTools.git-hub
  gitAndTools.git-imerge
  gitAndTools.gitFull
  gitAndTools.gitflow
  gitAndTools.hub
  gitAndTools.tig
  gitAndTools.topGit
  (exe gitAndTools.git-annex)
  gitAndTools.git-annex-remote-rclone
  gitAndTools.git-secret
  gitstats
  patch
  patchutils
  sift
  travis

  # jsToolsEnv
  jq
  jo
  nodejs
  nodePackages.eslint
  nodePackages.csslint
  nodePackages.js-beautify

  # langToolsEnv
  direnv
  global
  gnumake
  htmlTidy
  m4
  idutils
  rtags
  sloccount
  valgrind
  wabt

  contacts
  dovecot
  dovecot_pigeonhole
  fetchmail
  imapfilter
  leafnode
  msmtp

  # networkToolsEnv
  aria2
  backblaze-b2
  bazaar
  cacert
  dnsutils
  go-jira
  httpie
  httrack
  iperf
  lftp
  mercurialFull
  mitmproxy
  mtr
  nmap
  openssh
  openssl
  openvpn
  pdnsd
  rclone
  rsync
  sipcalc
  socat2pre
  spiped
  w3m
  wget
  wireguard
  wireshark
  youtube-dl
  znc
  zncModules.push

  ditaa
  dot2tex
  doxygen
  ffmpeg
  figlet
  fontconfig
  graphviz-nox
  groff
  highlight
  hugo
  inkscape.out
  librsvg
  pandoc
  plantuml
  poppler_utils
  recoll
  qpdf
  perlPackages.ImageExifTool
  libxml2
  libxslt
  sdcv
  sourceHighlight
  svg2tikz
  taskjuggler
  texFull
  # texinfo
  xapian
  xdg_utils
  yuicompressor

  # pythonToolsEnv
  python27
  pythonDocs.pdf_letter.python27
  pythonDocs.html.python27
  python27Packages.setuptools
  python27Packages.pygments
  python27Packages.certifi
  python3

  # systemToolsEnv
  apg
  aspell
  aspellDicts.en
  bash-completion
  bashInteractive
  bat
  ctop
  cvc4
  direnv
  entr
  exiv2
  fd
  findutils
  fswatch
  fzf
  gawk
  gnugrep
  gnupg
  gnuplot
  gnused
  gnutar
  hammer
  htop
  imagemagickBig
  imgcat
  jdiskreport
  jdk8
  less
  lorri
  m-cli
  multitail
  nix-bash-completions
  nix-zsh-completions
  nix-diff
  nix-index
  nix-info
  paperkey
  parallel
  pass
  perl
  browserpass
  qrencode
  pinentry_mac
  procps
  pstree
  pv
  qemu
  renameutils
  ripgrep
  rlwrap
  ruby
  screen
  smartmontools
  sqlite
  squashfsTools
  srm
  stow
  terminal-notifier
  time
  tmux
  tree
  unrar
  unzip
  vim
  watch
  watchman
  xsv
  xz
  z3
  zbar
  zip
  zsh
  zsh-syntax-highlighting

  # x11ToolsEnv
  xquartz
  xorg.xhost
  xorg.xauth
  ratpoison
  prooftree

  # Applications
  # Anki
  # Docker
  # HandBrake
  # iTerm2
  # KeyboardMaestro
  # RipIt
]