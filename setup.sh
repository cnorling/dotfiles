# this commented out script allows you to initialize this anywhere with github access
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/salineselin/dotfiles/master/setup.sh)"

# check if root github folder is there
if ! [ -d ~/git ]
    then echo "root git folder is missing, creating"
    mkdir ~/git
fi

# check if dotfiles repository is cloned
if ! [ -d ~/git/dotfiles ]
    then echo "dotfiles repository is missing, creating"
    git clone git@github.com:salineselin/dotfiles.git ~/git/dotfiles
fi

# install brew then add it to PATH until .sharedrc.sh can do it
if ! [ -d /home/linuxbrew/.linuxbrew/bin ]
    then echo "brew is missing, installing" 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# always add brew to path, it cant hurt
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

#---------------------------
# BREW BASED INSTALLERS LOOP
#---------------------------

brewinstallers=(
    jq
    zsh
    tfenv
    terraform-docs
    lefthook
    podman
)
for installer in ${brewinstallers[@]}
do
    # check if binary exists and install if its missing
    if ! [ -f /home/linuxbrew/.linuxbrew/bin/${installer} ]
        then echo "${installer} is missing, installing"
        brew install ${installer} --quiet
    fi
done

# install oh-my-zsh
if ! [ -f ~/.oh-my-zsh/oh-my-zsh.sh ]
    then echo "oh-my-zsh is missing, installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# install zsh autosuggestions 
# source: https://dev.to/pratik_kale/customise-your-terminal-using-zsh-powerlevel10k-1og5
if ! [ -d ~/.oh-my-zsh/zsh-autosuggestions ]
    then echo "zsh-autosuggestions is missing, installing"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/zsh-autosuggestions
fi

# install zsh syntax highlighting
# source: https://dev.to/pratik_kale/customise-your-terminal-using-zsh-powerlevel10k-1og5
if ! [ -d ~/.oh-my-zsh/zsh-syntax-highlighting ]
    then echo "zsh-syntax-highlighting is missing, installing"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/zsh-syntax-highlighting
fi

# install powerlevel10k
if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]
    then echo "powerlevel10k is missing, installing"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# run sharedrc.sh for init
if ! [ -f ~/.sharedrc.sh ]
    then echo ".sharedrc.sh has not yet been initialized, running"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/salineselin/dotfiles/master/.sharedrc.sh)"
fi

echo "profile is all setup, just run chsh"