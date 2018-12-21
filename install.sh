#!/usr/bin/env bash

set -eu
set -o pipefail

REPODIR="$(cd "$(dirname "$0")"; pwd -P)"
echo $REPODIR

HOME=/tmp/2

if [ ! -e "$HOME"/.dots ]; then
  mkdir "$HOME"/.dots
fi

cp -a $REPODIR/* "$HOME"/.dots/

for i in $(ls -1 "$HOME"/.dots/); do
  if [ -e "$HOME/.$i" ]; then
    printf "Found existing .$i in your \$HOME directory. Will create a backup at $HOME/.$i.bak\n"
  fi

  cp -f "$HOME/.$i" "$HOME/.$i.bak" 2>/dev/null || true
  ln -sf "$HOME/.dots/$i" "$HOME"/.$i;
done

printf "OK: Completed\n"
