#!/bin/bash

set -eu


if ! test -z "${USER_ID:-}" && ! test -z "${GROUP_ID:-}"; then
  # Linux

  if ! id -u user > /dev/null 2>&1; then
    useradd -u $USER_ID -o -m user
    groupmod -g $GROUP_ID user
    cp /tmp/latexmk/.latexmkrc /home/user/
  fi

  export HOME=/home/user

  exec gosu user "$@"

elif test -z "${USER_ID:-}" && test -z "${GROUP_ID:-}"; then
  # Mac or Windows

  cp /tmp/latexmk/.latexmkrc /root/

  exec "$@"

else
  echo -e '\x1b[31mSet both `USER_ID` and `GROUP_ID`, or set neither.\x1b[0m'
  exit 1
fi
