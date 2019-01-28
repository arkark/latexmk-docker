# Copyright (c) 2018-present Ark
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM paperist/alpine-texlive-ja

RUN apk --no-cache add sed ghostscript && \
    tlmgr install algorithms algorithmicx algorithm2e

RUN mkdir /home/user

COPY .latexmkrc /home/user/.latexmkrc

ENTRYPOINT \
    ([ -f main.tex ] || (echo -e "\x1b[31mCould not find file 'main.tex'\x1b[0m" && false)) && \
    HOME=/home/user latexmk -pvc main 2>&1 \
      | sed -uE -e '/^!/!bend;s/^.*$/\x1b[30;41m&\x1b[0m/;:loop;N;/(\nNo pages of output.)|(\nOutput written)/bend;s/\n([^\n]*$)/\n\x1b[31m\1\x1b[0m/;bloop;:end;P;D' \
      | sed -uE  -e '/(^LaTeX Warning:)|(^LaTeX Font Warning:)|(^Package babel Warning:)|(^Runaway argument\?)|(^Underfull \\hbox)|(^Overfull \\hbox)|(^Underfull \\vbox)|(^Overfull \\vbox)/s/^.*$/\x1b[33m&\x1b[0m/' \
      | sed -u  -e '/^Running /s/^.*$/\x1b[0m&\x1b[0m/' \
      | sed -uE -e '/^Latexmk: /!bend;s/^.*$/\x1b[0m&\x1b[0m/;:loop;N;/\n  [^\n]*$/s/\n([^\n]*$)/\n\x1b[34m\1\x1b[0m/;tloop;:end;P;D' \
      | sed -u  -e '/^[\x1b]/!s/^.*$/\x1b[90m&\x1b[0m/'
