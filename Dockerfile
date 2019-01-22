# Copyright (c) 2018-present Ark
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM paperist/alpine-texlive-ja

RUN apk --no-cache add sed ghostscript && \
    tlmgr install algorithms algorithmicx algorithm2e

RUN echo -e '#!/usr/bin/env perl\n\
$latex            = "find . -type f -name '"'"'*.tex'"'"' -print0 | xargs -0 sed -i -e '"'"'s/、/，/g'"'"' -e '"'"'s/。/．/g'"'"' && uplatex -synctex=1 -interaction=nonstopmode -halt-on-error";\n\
$latex_silent     = "find . -type f -name '"'"'*.tex'"'"' -print0 | xargs -0 sed -i -e '"'"'s/、/，/g'"'"' -e '"'"'s/。/．/g'"'"' && uplatex -synctex=1 -interaction=batchmode -halt-on-error";\n\
$bibtex           = "upbibtex";\n\
$biber            = "biber --bblencoding=utf8 -u -U --output_safechars";\n\
$dvipdf           = "dvipdfmx %O -o %D %S";\n\
$makeindex        = "upmendex %O -o %D %S";\n\
$max_repeat       = 5;\n\
$pdf_mode         = 3;\n\
$pvc_view_file_via_temporary = 0;\n\
$pdf_previewer    = ":"; # do nothing\n\
$out_dir          = "out";\n\
' > $HOME/.latexmkrc

ENTRYPOINT \
    ([ -f main.tex ] || (echo -e "\x1b[31mCould not find file 'main.tex'\x1b[0m" && false)) && \
    mkdir -p out && \
    touch out/main.log && \
    (latexmk -pvc main > /dev/null 2>&1 &) && \
    tail -F -n +1 out/main.log \
      | sed -uE -e '/^!/!bend;s/^.*$/\x1b[30;41m&\x1b[0m/;:loop;N;/\nHere /bend;s/\n([^\n]*$)/\n\x1b[31m\1\x1b[0m/;bloop;:end;P;D' \
      | sed -uE  -e '/(^LaTeX Warning:)|(^LaTeX Font Warning:)|(^Package babel Warning:)|(^Runaway argument\?)|(^Underfull \\hbox)|(^Overfull \\hbox)/!bend;s/^.*$/\x1b[33m&\x1b[0m/;:loop;N;/\n$/bend;s/\n([^\n]*$)/\n\x1b[33m\1\x1b[0m/;bloop;:end;P;D' \
      | sed -u  -e '/^Running /s/^.*$/\x1b[0m&\x1b[0m/' \
      | sed -uE -e '/^Latexmk: /!bend;s/^.*$/\x1b[0m&\x1b[0m/;:loop;N;/\n  [^\n]*$/s/\n([^\n]*$)/\n\x1b[34m\1\x1b[0m/;tloop;:end;P;D' \
      | sed -u  -e '/^[\x1b]/!s/^.*$/\x1b[90m&\x1b[0m/'
