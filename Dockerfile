ARG from

FROM ${from}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gdb less \
    # tmux \ # Later
    build-essential gettext libtinfo-dev ca-certificates git libx11-dev libxt-dev \
    && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean -y --no-install-recommends && \
    apt-get autoclean -y --no-install-recommends

RUN mkdir -p /usr/src

RUN cd /usr/src && \
    git clone --branch=v8.2.0 --depth 1 https://github.com/vim/vim && cd vim && \
    ./configure --with-features=huge --with-x=yes --enable-fail-if-missing && \
    make -j$(nproc) && \
    make install && \
    rm -rf /usr/src/vim

COPY .vimrc /root/
# COPY .bash_aliases /root/
RUN  echo 'vimgdb () { vim  -c "TermdebugCommand $*" ; }' >> /root/.bash_aliases && \
     echo 'alias vimdbg="vimgdb"' >> /root/.bash_aliases && \
     echo "alias tmux='tmux -u'" >> /root/.bash_aliases && \
     echo ":packadd termdebug" >> /root/.vimrc && \
     echo "let g:termdebug_wide=1" >> /root/.vimrc
     

ENTRYPOINT ["/bin/bash"]
