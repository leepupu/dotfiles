# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/Users/leepupu/Desktop/adt-bundle-mac-x86_64-20140702/sdk/platform-tools:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin/"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function ida() {
    if [ $# = 0 ]; then
        echo 'no arg';
    else
        echo 'have arg';
        echo "$1";
        str=$(file "$1" | sed 's/.*:\ //')
        typ=$(echo "$str" | cut -d ' ' -f 1)
        arch=$(echo "$str" | cut -d ' ' -f 2)
        echo "type is $typ, arch is $arch";
        if [ "$typ" = "ELF" ]; then
            if [ $arch = "32-bit" ]; then
                wine "/Users/leepupu/Desktop/IDA 6.6/idaq.exe" $1 &>/dev/null &
            else
                wine "/Users/leepupu/Desktop/IDA 6.6/idaq64.exe" $1 &>/dev/null &
            fi
        else
            echo 'This is not ELF'
        fi
    fi
}

alias wwwww=cd\ /Library/WebServer/Documents
if [ "$(uname)" = "Linux" ]; then
    alias sharevm=cd\ /mnt/hgfs/Share_Local/
elif [ "$(uname)" = "Darwin" ]; then
    alias sharevm=cd\ ~/Dropbox/ShareVM
    export PATH="/Users/leepupu/Applications/Wine Devel.app/Contents/Resources/start/bin:/Users/leepupu/Applications/Wine Devel.app/Contents/Resources/wine/bin:$PATH"
    # alias ida=wine\ "~/Desktop/IDA\ 6.6/idaq.exe"
    export ttexp
fi
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


#PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%I:%M:%S]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)\
#%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '

PROMPT=$'%{$fg_bold[green]%}%n@%m %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)\
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""


# zsh
alias vim="stty stop '' -ixoff ; vim"
# `Frozing' tty, so after any command terminal settings will be restored
ttyctl -f

# bash
# No ttyctl, so we need to save and then restore terminal settings
vim()
{

    local os="`uname -a | cut -d ' ' -f 1`"
    # osx users, use stty -g
    if [ "$os" = "Darwin" ]; then
        local STTYOPTS="$(stty -g)"
    else
        local STTYOPTS="$(stty --save)"
    fi
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}


# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

# move word
bindkey "^[[D" backward-word
bindkey "^[[C" forward-word

if [ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]; then
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
    export WORKON_HOME=/home/leepupu/.virtualenvs
    export PIP_VIRTUALENV_BASE=/home/leepupu/.virtualenvs
fi
