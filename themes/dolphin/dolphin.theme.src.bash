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
        [[ "$USER" == "root" ]] && CURR_USER="**\u**"

        local INHOST="\h"
        if [ -n "$MSYSTEM" ]; then 
            INHOST=" ${MSYSTEM}(\h)"
            INHOST=" GIT-BASH(\h)"
        elif [ -n "$WSL_INTEROP" ]; then
            INHOST="**WSL**(\h)"
        fi

         PS1="┌🐬 ${CURR_USER} @ ${INHOST}: \w 🐬\n" # echo -e "\U0001F42C"
        PS1+="└─> ${GIT_PS1}${PY_VENV}$ "
    else
        [[ "$USER" == "root" ]] && CURR_USER="**\u**"

        local INHOST="${BLUE}\h"
        ## $MSYSTEM is set in MSYS2 environments(GIT-BASH), but not in WSL.
        if [ -n "$MSYSTEM" ]; then 
            INHOST="${BLUE_B}${BLACK}GIT-BASH(${GRAY}\h${BLACK})${RESET}"
        elif [ -n "$WSL_INTEROP" ]; then
            INHOST="${BLUE_B}${BLACK}WSL(${GRAY}\h${BLACK})${RESET}"
        fi

         PS1="${BLUE}┌🐬 ${ORANGE}${CURR_USER}${WHITE}@${INHOST}${WHITE}:${YELLOW}\w ${ORANGE}🐬\n" # echo -e "\U0001F42C"
        PS1+="└─> ${BLUE}${GIT_PS1}${YELLOW}${PY_VENV}${RESET}$ "
    fi
 
}

safe_append_prompt_command prompt_command
