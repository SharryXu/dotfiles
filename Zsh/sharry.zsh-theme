function getTerminalWidthChar() {
    str=''
    termWidth=${COLUMNS}
    for i in {1..$termWidth}; do
        str="${str}="
    done

    echo $str
}

# Setup prompt string
PROMPT='$FG[237]$(getTerminalWidthChar)%{$reset_color%}
$fg_bold[blue]%~\
$(git_super_status) \

$fg[001]%(!.#.>)%{$reset_color%} '

# Git settings
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%} Git:(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[green]%}✗"
