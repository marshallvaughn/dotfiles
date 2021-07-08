#!/bin/zsh
#
# @marshallvaughn settings for zsh

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┠ basics ───────────────────────────────────────────────────────────────────┨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# basics go up here
PROMPT='%F{cyan}[%F{blue}%~%F{cyan}]%F{reset_color} '
HOME=$HOME

alias '..'='cd ..'
alias 'notes'="cd $NOTESPATH"
alias 'zshrc'='code ~/.zshrc'

if [[ $USER == 'mvaughn' ]]; then
    alias 'jq'="$HOME/bin/jq-osx-amd64"
fi

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┠ paths / completions ──────────────────────────────────────────────────────┨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# include binaries for custom scripts not at /usr level
export PATH=$HOME/bin:$PATH

# Make opt+del kill the last word
bindkey '^[^?' backward-kill-word

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┠ ls ───────────────────────────────────────────────────────────────────────┨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# List all files colorized in long format
alias l="ls -lF -G"

# List all files colorized in long format, including dot files
alias la="ls -laF -G"

# List only directories
alias lsd="ls -lF -G | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls -G"

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┠ grep ─────────────────────────────────────────────────────────────────────┨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Always enable colored `grep` output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┠ git ──────────────────────────────────────────────────────────────────────┨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

git config --global init.defaultBranch main

alias ga="git add ."

# Shortcut for git init
ginit() {
    git init;
    git add .;
    git commit -m 'hello world';
    git branch -M main;
}

# Change branch to main from default
alias gmain="git branch -M main"

# Shortcut for git status
alias gst="git status"

# Shortcut for git commit
gc() {
    git add .
    _msg="${@}"
    _date=$(date +%Y-%m-%d\ %H:%M)

    if (( # == 0 )); then
        _msg="$_date"
    fi
    git commit -m "$_msg"
    unset _msg
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┠ history search ───────────────────────────────────────────────────────────┨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Make the "search-y" function with the arrows work how you'd expect —
# including only results that begin with what you've already typed.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┠ sfdx ─────────────────────────────────────────────────────────────────────┨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# sfdx variables
SFDX_MDAPI_TEMP_DIR="$HOME/manifest"
SFDX_USE_GENERIC_UNIX_KEYCHAIN=true
SFDX_USE_PROGRESS_BAR=true
FORCE_SHOW_SPINNER=true

# Create an sfdx project, with my preferences
sf:proj() {
    _projname=${@}
    _projpath="${HOME}/dev/${_projname}"

    # Check if the directory already exists
    if [ -d "${_projpath}" ]
    then
        echo "Project ${_projname} already exists at ${_projpath}."
        return 1
    else
        cd ${HOME}/dev
        sfdx force:project:create \
            --projectname ${@} \
            --defaultpackagedir src \
            --manifest
    fi
}

sf:trail() {
    sfdx force:data:soql:query \
    -q "SELECT \
            Id, \
            CreatedDate, \
            CreatedBy.Username, \
            DelegateUser, \
            Action, \
            Display \
        FROM SetupAuditTrail \
        WHERE CreatedDate = LAST_N_DAYS:1 \
        ORDER BY CreatedDate ASC \
        LIMIT 500"
}

eval SFDX_AC_ZSH_SETUP_PATH=$HOME/Library/Caches/sfdx/autocomplete/zsh_setup \
    && test -f $SFDX_AC_ZSH_SETUP_PATH \
    && source $SFDX_AC_ZSH_SETUP_PATH; # sfdx autocomplete setup
