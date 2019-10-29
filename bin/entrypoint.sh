#!/bin/bash

set -eu

if [ -z "${USER_ID:-}" ]; then
  echo -e "\x1b[31m'USER_ID' is undefined\x1b[0m"
  exit 1
fi

if [ -z "${GROUP_ID:-}" ]; then
  echo -e "\x1b[31m'GROUP_ID' is undefined\x1b[0m"
  exit 1
fi

if ! id -u user > /dev/null 2>&1; then
  useradd -u $USER_ID -o -m user
  groupmod -g $GROUP_ID user
  cp /tmp/latexmk/.latexmkrc /home/user/
fi

export HOME=/home/user

exec gosu user "$@"
