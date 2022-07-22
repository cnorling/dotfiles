# this commented out script allows you to initialize this anywhere with github access
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/salineselin/dotfiles/master/setup.sh)"

# install brew then add it to PATH until .sharedrc.sh can do it
if ! [ -d /home/linuxbrew/.linuxbrew/bin ]
    then /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# always add brew to path, it cant hurt
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

# install jq
if ! [ -f /home/linuxbrew/.linuxbrew/bin/jq ]
    then brew install jq
fi

# install zsh
if ! [ -f /home/linuxbrew/.linuxbrew/bin/zsh ]
    then brew install zsh
fi

# install oh-my-zsh
if ! [ -f ~/.oh-my-zsh/oh-my-zsh.sh ]
    then /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install zsh autosuggestions 
# source: https://dev.to/pratik_kale/customise-your-terminal-using-zsh-powerlevel10k-1og5
if ! [ -d ~/.oh-my-zsh/zsh-autosuggestions ]
    then git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/zsh-autosuggestions
fi

# install zsh syntax highlighting
# source: https://dev.to/pratik_kale/customise-your-terminal-using-zsh-powerlevel10k-1og5
if ! [ -d ~/.oh-my-zsh/zsh-syntax-highlighting ]
    then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/zsh-syntax-highlighting
fi

# install powerlevel10k
if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]
    then git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# run sharedrc.sh for init
if ! [ -f ~/.sharedrc.sh ]
    then /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/salineselin/dotfiles/master/.sharedrc.sh)"
fi