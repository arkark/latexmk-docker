# :whale: arkark/latexmk

Useful LaTeX environment on Docker.

- One command to LaTeX environment
- Colorful latexmk output
- Automatic conversion from `、` `。` to `，` `．`

![](img/demo.png)

## Install

```sh
$ docker pull arkark/latexmk
```

## Usage

1. Prepare `main.tex` and some files.
2. Move to the directory.
3. Execute:
```sh
$ docker run --rm -it -v $PWD:/workdir -u $(id -u):$(id -g) arkark/latexmk
```
4. Edit latex files and preview `out/main.pdf` while monitoring a latexmk's log.
5. Press Ctrl+C to exit.

#### Option

- If you want to customize latexmk by yourself, add `.latexmkrc` file to the working directory.
