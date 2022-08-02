#------------------------
#PERSONAL STUFF GOES HERE
#------------------------

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
alias cls='clear'
alias weather='curl http://wttr.in/slc'

# docker alises
# alias docker='podman'
alias dicker='docker'
alias digger='docker'
alias dogger='docker'
alias cuddle='kubectl'
alias tf='terraform'

# set ls to single line by default
alias ls='ls --color=auto -1'

# set kube editor to vscode
export KUBE_EDITOR="code -w"

# add a symlink to zshrc, bashrc, and bash_aliases
dotfiles=(
    .bashrc
    .zshrc
    .sharedrc.sh
    .p10k.zsh
    .tmux.conf
    .vimrc
)
for dotfile in ${dotfiles[@]}
do
    ln -fs ~/git/dotfiles/$dotfile ~/$dotfile
done

# add brew to path
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

# this function is used to open vscode in windows from linux.
# it also creates workspaces and initializes github repos how I like them.
function maintain {
    # check if there's a valid vscode workspace
    if ! [ -f "$HOME/git/$1.code-workspace" ]
        then echo "$1.code-workspace is missing, replacing"
        echo \{\"folders\"\:\ \[\{\"path\"\:\ \"$HOME/git/$1\"\}\]\} | jq . > "$HOME/git/$1.code-workspace"
    fi
    # check if repo already exists
    if ! [ -d "$HOME/git/$1/.git" ]
        then echo "$1 git repo is missing, checking if there's a valid url"
        if [[ $2 =~ ^git@github\.com:(.)*\.git$ ]]
            then echo "url is valid, cloning repo" 
            git clone $2 "$HOME/git/$1"
        fi
    fi
    # open the repo
    code "$HOME/git/$1.code-workspace"
}

function showpath {
    echo "${PATH//:/$'\n'}"
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cnorling/google-cloud-sdk/path.zsh.inc' ]; then . '/home/cnorling/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/cnorling/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/cnorling/google-cloud-sdk/completion.zsh.inc'; fi

# perform local only operations
if [ -f '/home/cnorling/.envrc' ]
    then . '/home/cnorling/.envrc'
fi