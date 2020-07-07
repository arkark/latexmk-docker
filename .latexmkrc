#!/usr/bin/env perl
$latex            = "find . -type f -name '*.tex' -print0 | xargs -0 sed -i -e 's/、/，/g' -e 's/。/．/g' && uplatex -synctex=1 -interaction=nonstopmode -shell-escape -halt-on-error";
$latex_silent     = "find . -type f -name '*.tex' -print0 | xargs -0 sed -i -e 's/、/，/g' -e 's/。/．/g' && uplatex -synctex=1 -interaction=batchmode -shell-escape -halt-on-error";
$bibtex           = "upbibtex";
$biber            = "biber --bblencoding=utf8 -u -U --output_safechars";
$dvipdf           = "dvipdfmx %O -o %D %S";
$makeindex        = "upmendex %O -o %D %S";
$max_repeat       = 5;
$pdf_mode         = 3;
$pdf_previewer    = ":"; # do nothing
$out_dir          = "out";
$pvc_view_file_via_temporary = 0;
