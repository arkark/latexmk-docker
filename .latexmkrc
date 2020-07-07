#!/usr/bin/env perl
$latex            = "find . -type f -name '*.tex' -print0 | xargs -0 sed -i -e 's/、/，/g' -e 's/。/．/g' && uplatex %O -synctex=1 -halt-on-error -interaction=nonstopmode -shell-escape -file-line-error %S";
$latex_silent     = "find . -type f -name '*.tex' -print0 | xargs -0 sed -i -e 's/、/，/g' -e 's/。/．/g' && uplatex %O -synctex=1 -halt-on-error -interaction=batchmode -shell-escape -file-line-error %S";
$bibtex           = "upbibtex -kanji=utf8 %O %B";
$biber            = "biber %O --bblencoding=utf8 -u -U --output_safechars %B";
$dvipdf           = "dvipdfmx %O -o %D %S";
$makeindex        = "upmendex %O -o %D %S";
$max_repeat       = 5;
$dvips            = "dvips %O -z -f %S | convbkmk -u > %D";
$ps2pdf           = "ps2pdf %O %S %D";
$pdf_mode         = 3;
$pdf_previewer    = ":"; # do nothing
$out_dir          = "out";
$pvc_view_file_via_temporary = 0;
