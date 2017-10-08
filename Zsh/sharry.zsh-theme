if [ $UID -eq 0 ]; then
   NCOLOR="red";
else
  NCOLOR="green";
fi

# Setup prompt string
PROMPT='$fg[orange]$(getTerminalWidthChar)%{$reset_color%}
$fg[green]%n %{$reset_color%}$fg[032]in the %{$reset_color%}$fg[blue]%d %{$reset_color%} $(git_prompt_info) \

$fg[blue]> %{$reset_color%}'

function getTerminalWidthChar() {
    str=''
    termWidth=${COLUMNS}
    for i in {1..$termWidth}; do
        str="${str}="
    done

    echo $str
}

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}Git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[green]%}✗"