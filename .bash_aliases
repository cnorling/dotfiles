# add git aliases
alias ggs='git status'
alias ggf='git fetch'
alias ggb='git branch'
alias gga='git add'
alias ggaa='git add --all'
alias ggc='git commit -m'
alias ggca='git commit --amend --no-edit'
alias ggck='git checkout'
alias ggst='git stash'
alias ggstp='git stash pop'
alias ggp='git push'
alias ggpf='git push --force-with-lease'
alias ggpom='git pull origin master'

# add a few other alises
alias nsl='dig'
alias k='kubectl'
alias p='pulumi'
alias weather='curl http://wttr.in/slc'

# docker alises
alias dicker='docker'
alias digger='docker'
alias dogger='docker'
alias cuddle='kubectl'
alias canine='k9s'
alias tf='terraform'

# add a symlink to zshrc, bashrc, and bash_aliases
ln -fs ~/git/dotfiles/.bashrc ~/.bashrc
ln -fs ~/git/dotfiles/.zshrc ~/.zshrc
ln -fs ~/git/dotfiles/.bash_aliases ~/.bash_aliases
ln -fs ~/git/dotfiles/.p10k.zsh ~/.p10k.zsh
