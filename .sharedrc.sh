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
alias ggl='git log --oneline'

# add a few other alises
alias nsl='dig'
alias k='kubectl'
alias p='pulumi'
alias cls='clear'
alias weather='curl http://v2.wttr.in/slc'

# docker alises
alias dicker='docker'
alias digger='docker'
alias dogger='docker'
alias cuddle='kubectl'
alias tf='terraform'

# bind clip to widnows in wsl
alias clip='clip.exe'

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
for dotfile in ${dotfiles[@]}; do
    ln -fs ~/git/dotfiles/$dotfile ~/$dotfile
done

# add extra user paths
additionalPaths=(
    /usr/local/texlive/2022/bin/x86_64-linux
    /home/linuxbrew/.linuxbrew/bin
)
for additionalPath in ${additionalPaths[@]}; do
    export PATH="$PATH:$additionalPath"
done

# this function is used to open vscode in windows from linux.
# it also creates workspaces and initializes github repos how I like them.
function maintain {
    # check if the input is a repo name
    if ! [[ $1 =~ ^git@github\.com:(.)*\.git$ ]]; then
        echo "input is not a git repo, acting as if its a pre-existing workspace"
        repo="$1"
    fi

    # check if the input is a repo clone url
    if [[ $1 =~ ^git@github\.com:(.)*\.git$ ]]; then
        repo=$(echo $1 | sed -r 's/(.*\/)|(\.git)//g')
        echo "input is a git repo url, testing if $repo is a valid workspace"

        # check if the vscode workspace is already created
        if ! [ -f "$HOME/git/$repo.code-workspace" ]; then
            echo "$repo.code-workspace is missing, replacing"
            A='{"folders": [{"path": "'
            B="$HOME/git/$repo"
            C='"}]}'
            echo $A$B$C | jq >"$HOME/git/$repo.code-workspace"
        fi

        # check if the repo is already cloned down
        if ! [ -d "$HOME/git/$repo/.git" ]; then
            echo "$repo git repo is missing, checking if there's a valid url"
            git clone $1 "$HOME/git/$repo"
        fi
    fi
    # open the repo
    code "$HOME/git/$repo.code-workspace"
}

# this function just lists repos I have cloned down
function maintains {
    ls -d ~/git/*/ | sed -r 's/(\/home\/cnorling\/git\/)|(\/)//g'
}

# this function removes repos I've cloned down and initialized
function unmaintain {
    if [ -f "$HOME/git/$1.code-workspace" ]; then
        echo "$1.code-workspace exists, removing"
        rm -f "$HOME/git/$1.code-workspace"
    fi
    if [ -d "$HOME/git/$1" ]; then
        echo "$1 git directory exists, removing"
        rm -rfd "$HOME/git/$1"
    fi
}

# this function just prints my whole path in an easier to read format
function showpath {
    echo "${PATH//:/$'\n'}"
}

function asl {
    aws sso login --profile nonprod
}

function bgdc {
    echo '
,-\__\
|f-"Y\|
\()7L/
 cgD                             __ _
 |\(        _______________    .' Y '>,
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
if [ -f '/home/cnorling/.envrc.sh' ]; then
    . '/home/cnorling/.envrc.sh'
fi

bgdc
