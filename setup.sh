# install brew then add it to PATH until .sharedrc.sh can do it
if ! [ -d $HOME/linuxbrew/.linuxbrew/bin ]
    then /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
fi

# install jq
brew install jq

# install zsh
brew install zsh

# install oh-my-zsh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zsh autosuggestions 
# source: https://dev.to/pratik_kale/customise-your-terminal-using-zsh-powerlevel10k-1og5
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/zsh-autosuggestions

# install zsh syntax highlighting
# source: https://dev.to/pratik_kale/customise-your-terminal-using-zsh-powerlevel10k-1og5
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/zsh-syntax-highlighting

# install powerlevel10k
# maybe run this command after if you're setting up for the first time
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# run bash_aliases
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/salineselin/dotfiles/master/.bash_aliases)"
