#!/bin/bash
set -eu

if ! [ -f main.tex ]; then
  echo -e "\x1b[31mCould not find file 'main.tex'\x1b[0m"
  exit 1
fi

if ! [ -r main.tex ]; then
  echo -e "\x1b[31mCould not read file 'main.tex': Permission denied\x1b[0m"
  exit 1
fi

export HOME=/home/user

latexmk -pvc main 2>&1 \
  | sed -uE -e '/^!/!bend;s/^.*$/\x1b[30;41m&\x1b[0m/;:loop;N;/(\nNo pages of output.)|(\nOutput written)|(\n! )|(\nLatexmk:)/bend;s/\n([^\n]*$)/\n\x1b[31m\1\x1b[0m/;bloop;:end;P;D' \
  | sed -uE  -e '/(^LaTeX Warning:)|(^LaTeX Font Warning:)|(^Package babel Warning:)|(^Runaway argument\?)|(^Underfull \\hbox)|(^Overfull \\hbox)|(^Underfull \\vbox)|(^Overfull \\vbox)/s/^.*$/\x1b[33m&\x1b[0m/' \
  | sed -u  -e '/^Running /s/^.*$/\x1b[0m&\x1b[0m/' \
  | sed -uE -e '/^Latexmk: /!bend;s/^.*$/\x1b[0m&\x1b[0m/;:loop;N;/\n  [^\n]*$/s/\n([^\n]*$)/\n\x1b[34m\1\x1b[0m/;tloop;:end;P;D' \
  | sed -uE -e 's/(\.\/[^\) ]*)/\x1b[32;1m\1\x1b[90m/g' \
  | sed -u  -e '/^[\x1b]/!s/^.*$/\x1b[90m&\x1b[0m/'
