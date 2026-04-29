# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.

# Dophin Bash Prompt, modified from Parrot & sexy Bash Prompt.

echo
echo "           🐬🐬 DOPHIN_THEME in use. 🐬🐬"
echo "🐬 Set 'DOLPHIN_THEME_FORCE_NO_COLORS=1' to disable colors. 🐬"
echo 

function prompt_command() {
  
    #GIT branch info, using __git_ps1 from git-prompt.sh 
    local GIT_PS1=`__git_ps1`
    if [ "$GIT_PS1" == "" ]; then 
        GIT_PS1="±(none) "
    else
        GIT_PS1="±${GIT_PS1:1} "
    fi

    # python virtual environment info
    local PY_VENV=""
    [ -z $VIRTUAL_ENV ] || PY_VENV="(`basename $VIRTUAL_ENV`) "
    
    local CURR_USER="\u"                

    if [ -n "$DOLPHIN_THEME_FORCE_NO_COLORS" ]; then
        ## $MSYSTEM is set in MSYS2 environments(GIT-BASH), but not in WSL.
        local INHOST="\h"
        if [ -n "$MSYSTEM" ]; then 
            INHOST="${MSYSTEM}(\h)"
        elif [ -z "$XDG_RUNTIME_DIR" ]; then  # must be here, because in Git-Bash, $SSH_CLIENT is not set, but in WSL, $SSH_CLIENT is set, and $XDG_RUNTIME_DIR is not set in both environments.
            CURR_USER="(su -\u)"
        elif [ -z "$SSH_CLIENT" ]; then
            INHOST="Local(\h)"
        fi

         PS1="┌🐬 ${CURR_USER} @ ${INHOST}: \w 🐬\n" # echo -e "\U0001F42C"
        PS1+="└─> ${GIT_PS1}${PY_VENV}$ "
    else
        local INHOST="\[\033[22;38;5;87m\]\h"
        ## $MSYSTEM is set in MSYS2 environments(GIT-BASH), but not in WSL.
        if [ -n "$MSYSTEM" ]; then 
            INHOST="\[\033[48;5;87m\]\[\033[22;38;5;208m\]${MSYSTEM}(\[\033[38;5;246m\]\h\[\033[22;38;5;208m\])\[\033[m\]"
        elif [ -z "$XDG_RUNTIME_DIR" ]; then 
            local CURR_USER="(su -\u)"
        elif [ -z "$SSH_CLIENT" ]; then
            INHOST="\[\033[48;5;87m\]\[\033[22;38;5;208m\]Local(\[\033[38;5;246m\]\h\[\033[22;38;5;208m\])\[\033[m\]"
        fi

         PS1="\[\033[22;38;5;87m\]┌🐬 \[\033[22;38;5;208m\]${CURR_USER}\[\033[1;37m\]@${INHOST}\[\033[1;37m\]:\[\033[22;38;5;227m\]\w \[\033[22;38;5;208m\]🐬\n" # echo -e "\U0001F42C"
        PS1+="└─> \[\033[22;38;5;87m\]${GIT_PS1}\[\033[22;38;5;227m\]${PY_VENV}\[\033[m\]$ "
    fi
 
}

safe_append_prompt_command prompt_command
