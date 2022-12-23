#!/bin/zsh

# Install dependencies for pyenv
sudo apt install -y \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev;

# Install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | zsh;

# Load pyenv
if ! command grep -qc 'export PYENV_ROOT="$HOME/.pyenv"' "$HOME/.zshrc"; then
    echo "=> Appending pyenv initialization string to ~/.zshrc";
    echo '' >> ~/.zshrc;
    echo '# Load pyenv when zsh starts' >> ~/.zshrc;
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

    source ~/.zshrc;
else
    echo "=> pyenv initialization string already in ~/.zshrc"
fi

# Install latest version of python
if [ "$(which python)" = "$PYENV_ROOT/shims/python" ]; then
    echo "python is already installed using pyenv";
else
    pyenv install 3.11;
    pyenv global 3.11;
    python -m pip install --upgrade pip setuptools;
fi

# Install poetry
curl -sSL https://install.python-poetry.org | python -;

# Add autocompletion
if [ ! -f "$HOME/.zfunc/_poetry" ]; then
    echo 'Installing autocompletion for poetry';
    if [ ! -d "$HOME/.zfunc" ]; then
        mkdir $HOME/.zfunc;
    fi
    poetry completions zsh > ~/.zfunc/_poetry;
else
    echo "Automcompletion for poetry is already installed";
fi

# Load the autocompletion
if ! command grep -qc 'fpath+=~/.zfunc' "$HOME/.zshrc"; then
    echo '';
    echo '# Autocompletion for poetry';
    echo 'fpath+=~/.zfunc' >> ~/.zshrc;
    echo 'autoload -Uz compinit && compinit' >> ~/.zshrc;
else
    echo 'Autocompletion for poetry has already been added to ~/.zshrc';
fi

# Add poetry to the PATH
if [[ :$PATH: == *:"$HOME/.local/bin":* ]] ; then
    echo "$HOME/.local/bin is already on the path";
else
    echo '';
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc;
fi

source ~/.zshrc;
