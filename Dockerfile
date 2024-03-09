FROM ubuntu:latest

# Install common tools
RUN apt-get update && \
    apt-get install -y \
    clang \
    git \
    neovim \
    zsh \
    tmux \
    ripgrep \
    python3-pip \
    sudo \
    yadm
RUN apt-get clean

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
