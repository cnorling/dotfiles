#------------------------
#PERSONAL STUFF GOES HERE
#------------------------

# git aliases
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

# kubernetes and container aliases
alias k='kubectl'
alias kc='kubectl config'
alias docker='podman'
alias dicker='podman'
alias digger='podman'
alias dogger='podman'
alias cuddle='kubectl'
export KUBE_EDITOR="code -w"

# cloud environment aliases
alias p='pulumi'
alias tf='terraform'
alias tfversion='tfenv'
alias tfver='tfenv'
alias tfv='tfenv'
alias asl='aws sso login'
alias gc='gcloud'

# common command aliases
alias nsl='dig'
alias cls='clear'
alias weather='curl http://v2.wttr.in/slc'              # get the weather
alias clip='clip.exe'                                   # bind clip to windows in wsl
alias ls='ls --color=auto -1'                           # set ls to single line by default
alias t='tmux'

# ide aliases
alias Install-Package='dotnet add package'
alias install-package='dotnet add package'
# alias ip='install-package' mistake

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
    /home/cnorling/go/bin
)
for additionalPath in ${additionalPaths[@]}; do
    export PATH="$PATH:$additionalPath"
done

# this function is used to open vscode in windows from linux.
# it also creates workspaces and initializes github repos how I like them.
function maintain {
    # check if the input is a repo name
    if ! [[ $1 =~ ^git@github\.com:(.)*\.git$ ]]; then
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

# this function generates n number of random garbage commits for git testing purposes
function spoof-commit {
    for (( i=1 ; i<=$1 ; i=$i+1 )); do
        message=$(echo $RANDOM | md5sum | head -c 10)
        echo $RANDOM  >/dev/null # for some reason removing this causes the script to only create one commit
        echo $message > $message
        git add $message
        git commit -m "$message"
    done
}

# this function just pulls a file from my windows machine to my current directory from the downloads folder
# I got sick of typing out the full path
function suck {
    cp /mnt/c/Users/Selin/Dropbox/Downloads/$1 ./
}

function kustomize-printbase {
echo "
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: ${1}
"
}

function kustomize-printoverlay {
echo "
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: ${1}

resources: 
    - ../../base
"
}

function kustomize-init {
    mkdir $1
    mkdir -p $1/base
    mkdir -p $1/overlays
    kustomize-printbase $1 | yq > $1/base/kustomization.yml
    overlays=(`echo $2`)
    for overlay in $overlays; do
        mkdir -p $1/overlays/$overlay
        kustomize-printoverlay $overlay > $1/overlays/$overlay/kustomization.yml
    done
}

function idempotent-ssh-agent {
        local timeout=${1:-10m}
        local ssh_agent_source_file=${2:-/home/$USER/.ssh/agent.sourceme}
        local pid=$(pgrep -u $USER '^ssh-agent')
        if [[ -z $pid ]]; then
                ssh-agent -t $timeout > "$ssh_agent_source_file"
        fi
        source "$ssh_agent_source_file"
}

# add this to .envrc.sh
# function addkeys {
#   idempotent-ssh-agent "$@"
#   ssh-add \
#     ~/.ssh/id_ed25519_default \
#     ~/.ssh/id_ed25519_gitlab
# }

# this function prints when my terminal is completely loaded
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
