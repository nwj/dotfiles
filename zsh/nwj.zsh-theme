# Colors
red="%F{red}"
green="%F{green}"
yellow="%F{yellow}"
blue="%F{blue}"
magenta="%F{magenta}"
cyan="%F{cyan}"
grey="%F{245}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$grey%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$red%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

function directory() {
	echo "%{$blue%}%~%{$reset_color%}"
}

function delimiter() {
	echo "%(?.%{$magenta%}❯%{$reset_color%}.%{$red%}❯%{$reset_color%})"
}

function continuation() {
	echo "%(?.%{$magenta%}\%{$reset_color%}.%{$red%}\%{$reset_color%})"
}

NEWLINE=$'\n'

PROMPT='$(directory) $(git_prompt_info) ${NEWLINE}$(delimiter) '
PROMPT2='$(continuation) '

# Newlines between (but not before) prompts
function theme_precmd() {
	$funcstack[1]() {
		echo
	}
}
autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd
