#!/usr/bin/env zsh

setopt promptsubst

autoload -U add-zsh-hook
autoload -U colors && colors

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo ' '
}

PROMPT='$(virtualenv_info)%{$fg[green]%}%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)$(git_prompt_status) %{$reset_color%}
%{$fg[red]%}%%%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✘%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%} ✹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[yellow]%} ➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%} ═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%} ✭%{$reset_color%}"
