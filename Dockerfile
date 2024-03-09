FROM ubuntu:latest

# Install common tools
RUN apt-get update && \
    apt-get install -y \
    clang \
    git \
    zsh \
    tmux \
    ripgrep \
    python3-pip \
    sudo \
    yadm
RUN apt-get clean

ADD https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz /nvim-linux64.tar.gz
RUN sudo tar -C /opt -xzf nvim-linux64.tar.gz && rm -rf /nvim-linux64.tar.gz

# Set up default user for myself
RUN useradd -mG sudo colbyhaskell

# Disable password prompt for sudo
RUN echo 'colbyhaskell ALL=(ALL) NOPASSWD:ALL' >> /etc/sudo.conf
RUN echo 'colbyhaskell ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to my user
USER colbyhaskell
WORKDIR /home/colbyhaskell

# Copy dotfiles
COPY . /home/colbyhaskell
