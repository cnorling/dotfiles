# this commented out script allows you to initialize this anywhere with github access
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/salineselin/dotfiles/master/setup.sh)"

function logmissing {
    echo "$1 is missing, initializing"
}

# check if root github folder is there
if ! [ -d ~/git ]
    then logmissing "root git folder"
    mkdir ~/git
fi

# install brew then add it to PATH until .sharedrc.sh can do it
if ! [ -d /home/linuxbrew/.linuxbrew/bin ]
    then logmissing "brew" 
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
    neovim
    google-cloud-sdk
    doctl
    kubectl
    helm
    gitversion
    pulumi
)
for installer in ${brewinstallers[@]}
do
    # check if binary exists and install if its missing
    if ! [ -f /home/linuxbrew/.linuxbrew/bin/${installer} ]
        then logmissing $installer
        brew install ${installer} --quiet
    fi
done

# install podman
if ! [ -f /usr/bin/podman ]
    then logmissing "podman"
    sudo apt-get install podman
fi

# install minikube
if ! [ -f /usr/local/bin/minikube ]
    then logmissing "minikube"
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
fi

# install oh-my-zsh
if ! [ -f ~/.oh-my-zsh/oh-my-zsh.sh ]
    then logmissing "oh-my-zsh"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# install zsh autosuggestions 
# source: https://dev.to/pratik_kale/customise-your-terminal-using-zsh-powerlevel10k-1og5
if ! [ -d ~/.oh-my-zsh/zsh-autosuggestions ]
    then logmissing "zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/zsh-autosuggestions
fi

# install zsh syntax highlighting
# source: https://dev.to/pratik_kale/customise-your-terminal-using-zsh-powerlevel10k-1og5
if ! [ -d ~/.oh-my-zsh/zsh-syntax-highlighting ]
    then logmissing "zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/zsh-syntax-highlighting
fi

# install powerlevel10k
if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]
    then logmissing "powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# run sharedrc.sh for init
if ! [ -f ~/.sharedrc.sh ]
    then logmissing ".sharedrc.sh"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/salineselin/dotfiles/master/.sharedrc.sh)"
fi

echo "profile is all setup, just run chsh"
