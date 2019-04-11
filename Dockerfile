# Copyright (c) 2018-present Ark
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM paperist/alpine-texlive-ja

RUN apk --no-cache add sed ghostscript && \
    tlmgr install algorithms algorithmicx algorithm2e

RUN mkdir /home/user

COPY .latexmkrc /home/user/

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
