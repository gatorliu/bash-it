# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.

# Dophin Bash Prompt, modified from Parrot & sexy Bash Prompt.


if [ -z "$DOLPHIN_THEME_FORCE_NO_COLORS" ]; then
    YELLOW="\[\033[22;38;5;227m\]"
    ORANGE="\[\033[22;38;5;208m\]"
    ORANGE_B="\[\033[48;5;208m\]"
    BLACK="\[\033[30m\]"    
    BLUE="\[\033[38;5;87m\]"
    BLUE_B="\[\033[48;5;87m\]"
    GRAY="\[\033[38;5;246m\]"
    GREEN="\[\033[22;38;5;16m\]"
    RED="\[\033[1;31m\]"
    WHITE="\[\033[1;37m\]"
    RESET="\[\033[m\]"
else
    YELLOW=""
    ORANGE=""
    ORANGE_B=""
    BLACK=""
    BLUE=""
    BLUE_B=""
    GRAY=""
    GREEN=""
    RED=""
    WHITE=""
    RESET=""
fi

echo "** DOPHIN_THEME in use **"
echo "** Set the \$DOLPHIN_THEME_FORCE_NO_COLORS to disable colors."

#env_prompt() {
#    echo -e "($(virtualenv_prompt)$(condaenv_prompt))"
#}

function prompt_command() {
    local CURR_USER="\u"                
    local INHOST="${BLUE}\h"
    ## $MSYSTEM is set in MSYS2 environments(GIT-BASH), but not in WSL.
    if [ -n "$MSYSTEM" ]; then 
        INHOST="${BLUE_B}${ORANGE}${MSYSTEM}(${GRAY}\h${ORANGE})$RESET"
    elif [ -z "$XDG_RUNTIME_DIR" ]; then 
        local CURR_USER="(su -\u)"
    elif [ -z "$SSH_CLIENT" ]; then
        INHOST="${BLUE_B}${ORANGE}Local(${GRAY}\h${ORANGE})$RESET"
    fi
    #
    local GIT_PS1=`__git_ps1`
    if [ "$GIT_PS1" == "" ]; then 
        GIT_PS1="${BLUE}±(none)"
    else
        GIT_PS1="${BLUE}±${GIT_PS1:1}"
    fi

    local PY_VENV=""
    [ -z $VIRTUAL_ENV ] || PY_VENV="${YELLOW}(`basename $VIRTUAL_ENV`)"

    PS1="${ORANGE}┌─${BLUE}🐬 ${ORANGE}${CURR_USER}${WHITE}@${INHOST}${WHITE}:${YELLOW}\w\n" # echo -e "\U0001F42C"
    PS1+="${BLUE}└─${ORANGE}🐬 ${BLUE}${GIT_PS1}${WHITE}${PY_VENV}${ORANGE} ${RESET}$ "
 
}

safe_append_prompt_command prompt_command
