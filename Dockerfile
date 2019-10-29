# Copyright (c) 2018-present Ark
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM ubuntu:eoan

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes
ENV PATH="/usr/local/texlive/2019/bin/x86_64-linux:$PATH"

RUN apt-get update \
    && apt-get -y install \
        build-essential \
        wget \
        git \
        gosu \
        libfontconfig1-dev \
        libfreetype6-dev \
        ghostscript \
        perl \
        python3-pip \
        python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install pygments \
    && mkdir /tmp/install-tl-unx \
    && wget -O - ftp://tug.org/historic/systems/texlive/2019/install-tl-unx.tar.gz \
        | tar -xzv -C /tmp/install-tl-unx --strip-components=1 \
    && echo "selected_scheme scheme-basic" \
        > /tmp/install-tl-unx/texlive.profile \
    && /tmp/install-tl-unx/install-tl \
        --profile /tmp/install-tl-unx/texlive.profile \
    && rm -r /tmp/install-tl-unx \
    && tlmgr update --self \
    && tlmgr install \
        collection-bibtexextra \
        collection-fontsrecommended \
        collection-langenglish \
        collection-langjapanese \
        collection-latexextra \
        collection-latexrecommended \
        collection-luatex \
        collection-mathscience \
        collection-plaingeneric \
        collection-xetex \
        latexmk \
        latexdiff

RUN mkdir /tmp/latexmk

COPY .latexmkrc /tmp/latexmk/

COPY entrypoint.sh /usr/local/bin/

COPY latexmk-ext /usr/local/bin/

WORKDIR /workdir

ENTRYPOINT ["entrypoint.sh"]

CMD ["latexmk-ext"]
