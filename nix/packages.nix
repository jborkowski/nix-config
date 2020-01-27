{ pkgs }:

with pkgs; let exe = haskell.lib.justStaticExecutables; in [


  contacts
  dovecot
  dovecot_pigeonhole
  fetchmail
  imapfilter
  leafnode
  msmtp

  # networkToolsEnv

#   # pythonToolsEnv
#   python27
#   pythonDocs.pdf_letter.python27
#   pythonDocs.html.python27
#   python27Packages.setuptools
#   python27Packages.pygments
#   python27Packages.certifi
#   python3

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