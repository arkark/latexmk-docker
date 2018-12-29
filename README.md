
:warning: WIP :warning:

## Usage

1. Build this Docker image as follows:
```sh
$ git clone https://github.com/ArkArk/latexmk-docker.git
$ cd latexmk-docker
$ docker build ./ -t arkark/latexmk
```
2. Prepare `main.tex` and some files (E.g. style files, bib files, and so on).
3. Move to the directory.
4. Execute:
```sh
$ docker run --rm -it -v $PWD:/workdir arkark/latexmk
```
5. Edit latex files and preview the output pdf while watching latexmk's log.

## Future Work

- Make this more useful
- Push this Docker image to Docker Hub
