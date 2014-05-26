#!/usr/bin/env zsh

setopt promptsubst

autoload -U add-zsh-hook
autoload -U colors && colors

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo ' '
}

PROMPT='$(virtualenv_info)%{$fg_bold[green]%}%m%{$reset_color%}%{$fg_bold[white]%}:%{$reset_color%}%{$fg_bold[cyan]%}%~%{$reset_color%} $(git_prompt_info)$(git_prompt_status) %{$reset_color%}
> '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}[%{$reset_color%}%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✔"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%} ✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[red]%} ✹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} ✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[yellow]%} ➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%} ═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%} ✭%{$reset_color%}"
