
:warning: WIP :warning:

## Usage

1. Build this Docker image as follows:
```sh
$ git clone https://github.com/ArkArk/latexmk-docker.git
$ cd latexmk-docker
$ docker build ./ -t arkark/latexmk
```
2. Prepare `main.tex` and some files; e.g. style files, bib files and inputted/included tex files.
    - [OPTION] Add `.latexmkrc` if you want to customize latexmk by yourself.
3. Move to the directory.
4. Execute:
```sh
$ docker run --rm -it -v $PWD:/workdir arkark/latexmk
```
5. Edit latex files and preview the output pdf while monitoring a latexmk's log.

## Future Work

- Make this more useful
- Push this to Docker Hub
