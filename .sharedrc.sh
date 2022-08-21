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
alias ggpl='git pull'
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

# alias tfenv
alias tfversion='tfenv'
alias tfver='tfenv'
alias tfv='tfenv'

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

# add extra user paths
additionalPaths=(
    /usr/local/texlive/2022/bin/x86_64-linux
    /home/linuxbrew/.linuxbrew/bin
)
for additionalPath in ${additionalPaths[@]}
do
    export PATH="$PATH:$additionalPath"
done

# this function is used to open vscode in windows from linux.
# it also creates workspaces and initializes github repos how I like them.
function maintain {
    # check if there's a valid vscode workspace
    if ! [ -f "$HOME/git/$1.code-workspace" ]
        then echo "$1.code-workspace is missing, replacing"
        echo '{"folders": [{"path": "$HOME/git/$1"}]}' | envsubst | jq
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

function maintains {
    ls -d ~/git/*/ | sed 's/\/home\/cnorling\/git\///g' | sed 's/\///g'
}

function showpath {
    echo "${PATH//:/$'\n'}"
}

function bgdc {
    echo '
,-\__\
|f-"Y\|
\()7L/
 cgD                             __ _
 |\(        _______________    .'  Y '>,
  \ \     /                 \ / _   _   \
   \\\   | BE GAY DO CRIMES | )(_) (_)(|}
    \\\   \_______________  / {  4A   } /
     \\\                  \|  \uLuJJ/\l
      \\\                     |3    p)/
       \\\___ __________      /nnm_n//
       c7___-__,__-)\,__)(".  \_>-<_/D
                     \_"-._.__G G_c__.-__<"/ ( \
                         <"-._>__-,G_.___)\   \7\
                        ("-.__.| \"<.__.-" )   \ \
                        |"-.__"\  |"-.__.-".\   \ \
                        ("-.__"". \"-.__.-".|    \_\
                        \"-.__""|!|"-.__.-".)     \ \
                         "-.__""\_|"-.__.-"./      \ l
                          ".__""">G>-.__.-">       .--,_
    '
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cnorling/google-cloud-sdk/path.zsh.inc' ]; then . '/home/cnorling/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/cnorling/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/cnorling/google-cloud-sdk/completion.zsh.inc'; fi

# perform local only operations
if [ -f '/home/cnorling/.envrc' ]
    then . '/home/cnorling/.envrc'
fi

bgdc