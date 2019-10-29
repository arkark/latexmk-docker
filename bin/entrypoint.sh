#!/bin/bash

set -eu

if ! [ -f main.tex ]; then
  echo -e "\x1b[31mCould not find file 'main.tex'\x1b[0m"
  exit 1
fi

USER_ID=$(ls -n main.tex | cut -d ' ' -f 3)
GROUP_ID=$(ls -n main.tex | cut -d ' ' -f 4)

echo "Starting with UID:GID = $USER_ID:$GROUP_ID"

if ! id -u user > /dev/null 2>&1; then
  useradd -u $USER_ID -o -m user
  groupmod -g $GROUP_ID user
  cp /tmp/latexmk/.latexmkrc /home/user/
fi

export HOME=/home/user

exec gosu user "$@"
