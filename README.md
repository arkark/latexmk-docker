# :whale: arkark/latexmk

Useful LaTeX environment on Docker.

- **One command** to LaTeX environment
- Colored latexmk output
- Automatic conversion from `、` `。` to `，` `．`

![](img/demo.png)

## Installation

```sh
$ docker pull arkark/latexmk
```

## Usage

1. Prepare `main.tex` and some necessary files (E.g. a `.bib` file).
2. Move to the directory.
3. Execute:
    ```sh
    $ docker run --rm -it -v $PWD:/workdir -u $(id -u):$(id -g) arkark/latexmk
    ```
4. Edit latex files and preview `out/main.pdf` while monitoring a latexmk's log.
5. Press `Ctrl+C` to exit.

#### Options

- It's recommended to use an alias of the above command.
- If you want to customize latexmk by yourself, add `.latexmkrc` file to the working directory.
