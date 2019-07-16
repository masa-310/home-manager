#!/bin/sh

if [ `whoami` = "root" ]; then
  echo Require user privillege.
  exit 1
fi

which home-manager > /dev/null 2>&1
if [ $? -eq  1 ]; then
  # https://github.com/rycee/home-manager

  # 1. Make sure you have a working Nix installation. If you are not using NixOS then you may here have to run
  # Do nothing

  # 2. Add the appropriate Home Manager channel. Typically this is
  nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
  nix-channel --update

  # 3. Install Home Manager and create the first Home Manager generation
  nix-shell '<home-manager>' -A install

  # 4. If you do not plan on having Home Manager manage your shell configuration then you must source the
  # Do nothing
fi


ln -s ${HOME}/home-manager/home.nix ${HOME}/.config/nixpkgs/home.nix  -f
ln -s ${HOME}/home-manager/.dotfiles/nvim/init.vim ${HOME}/.config/nvim/init.vim  -f
ln -s ${HOME}/home-manager/.dotfiles ${HOME}/.dotfiles -f

home-manager switch