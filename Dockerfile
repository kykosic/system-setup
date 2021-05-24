FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        bzip2 \
        ca-certificates \
        curl \
        git \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        wget \
        zsh \
    && apt-get clean

# User config setup
ENV HOME=/home/root
RUN usermod -s /usr/bin/zsh root \
    && mkdir -p ${HOME}

# Cargo/Rust
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.52.1
RUN set -eux; \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
        amd64) rustArch='x86_64-unknown-linux-gnu'; rustupSha256='fb3a7425e3f10d51f0480ac3cdb3e725977955b2ba21c9bdac35309563b115e8' ;; \
        armhf) rustArch='armv7-unknown-linux-gnueabihf'; rustupSha256='f263e170da938888601a8e0bc822f8b40664ab067b390cf6c4fdb1d7c2d844e7' ;; \
        arm64) rustArch='aarch64-unknown-linux-gnu'; rustupSha256='de1dddd8213644cba48803118c7c16387838b4d53b901059e01729387679dd2a' ;; \
        i386) rustArch='i686-unknown-linux-gnu'; rustupSha256='66c03055119cecdfc20828c95429212ae5051372513f148342758bb5d0130997' ;; \
        *) echo >&2 "unsupported architecture: ${dpkgArch}"; exit 1 ;; \
    esac; \
    url="https://static.rust-lang.org/rustup/archive/1.24.1/${rustArch}/rustup-init"; \
    wget "$url"; \
    echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION --default-host ${rustArch}; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
RUN cargo install ripgrep

# Conda/Python
ENV PATH /opt/conda/bin:$PATH
ARG CONDA_VERSION=py37_4.8.2
ARG CONDA_MD5=87e77f097f6ebb5127c77662dfc3165e
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh -O miniconda.sh \
    && mkdir -p /opt \
    && sh miniconda.sh -b -p /opt/conda \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && /opt/conda/bin/conda clean -afys

# Oh My Zsh and Powerlevel10k
ENV ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom \
    TERM=xterm-256color
RUN wget --quiet https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O ohmyzsh.sh \
    && sh ohmyzsh.sh \
    && rm ohmyzsh.sh \
    && git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k \
    && rm -rf $ZSH_CUSTOM/themes/powerlevel10k/.git* \
    && mkdir -p $HOME/.cache/gitstatus \
    && wget -O- -nv https://github.com/romkatv/gitstatus/releases/download/v1.3.1/gitstatusd-linux-x86_64.tar.gz \
        | tar -xz -C $HOME/.cache/gitstatus gitstatusd-linux-x86_64
COPY zsh/.p10k.zsh container/.zshrc $HOME/

# Install npm/yarn
RUN conda install -y nodejs yarn

# Neovim
RUN cd opt/ \
    && curl -fLo nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz \
    && tar xzf nvim-linux64.tar.gz \
    && ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim \
    && rm nvim-linux64.tar.gz \
    && pip install neovim

# Neovim settings
COPY neovim/init.vim neovim/coc-settings.json $HOME/.config/nvim/

# Vim-plug and Coc extensions
ARG COC_EXTS="coc-rust-analyzer coc-pyright coc-go coc-snippets"
RUN curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && cp $HOME/.config/nvim/init.vim /tmp/init.vim \
    && sed -i '/plug#end/q' $HOME/.config/nvim/init.vim \
    && nvim --headless +PlugInstall +qall \
    && cp /tmp/init.vim $HOME/.config/nvim/init.vim \
    && mkdir -p $HOME/.config/coc \
    && nvim --headless +"CocInstall -sync $COC_EXTS" +qall \
    && nvim --headless +CocUpdateSync +qall

WORKDIR $HOME
ENTRYPOINT []
CMD ["/bin/zsh"]
