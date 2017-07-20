# This file is used to customize the Oh My Zash

# Grab the current date (%D) and time (%T) wrapped in {}: {%D %T}
SHARRY_CURRENT_TIME_="%{$fg[white]%}{%{$fg[yellow]%}%D %T%{$fg[white]%}}%{$reset_color%}"

# Grab the current machine name: muscato
SHARRY_CURRENT_MACH_="%{$fg[green]%}%m%{$fg[white]%}:%{$reset_color%}"

# Grab the current file path, use shortcuts: ~/Desktop
# Append the current git branch, if in a git repository: ~aw@master
SHARRY_CURRENT_LOCA_="%{$fg[cyan]%}%~\$(git_prompt_info)%{$reset_color%}\$(parse_git_dirty)"

# Grab the current username: dallas
SHARRY_CURRENT_USER_="%{$fg[red]%}%n%{$reset_color%}"

# Use a % for normal users and a # for privelaged (root) users.
SHARRY_PROMPT_CHAR_="%{$fg[white]%}%(!.#.%%)%{$reset_color%}"

#########################################################################
# Git configuration

# For the git prompt, use a white @ and blue text for the branch name
SHARRY_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}@%{$fg[blue]%}"

# Close it all off by resetting the color and styles.
SHARRY_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

# Do nothing if the branch is clean (no changes).
SHARRY_THEME_GIT_PROMPT_CLEAN=""

# Add 3 cyan ✗s if this branch is diiirrrty! Dirty branch!
SHARRY_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}✗✗✗"
#########################################################################

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

# Put it all together!
PROMPT="$SHARRY_CURRENT_TIME_$SHARRY_CURRENT_MACH_$SHARRY_CURRENT_LOCA_ $SHARRY_CURRENT_USER_$SHARRY_PROMPT_CHAR_ "

# End
