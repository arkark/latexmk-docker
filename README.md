# :whale:arkark/latexmk

## Install

```sh
$ docker pull arkark/latexmk
```

## Usage

1. Prepare `main.tex` and some files.
2. Move to the directory.
3. Execute:
```sh
$ docker run --rm -it -v $PWD:/workdir arkark/latexmk
```
4. Edit latex files and preview the output pdf while monitoring a latexmk's log.
