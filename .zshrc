# History settings
HISTSIZE=3000000
HISTFILE=~/.zsh_history
SAVEHIST=2000000
EXTENDED_HISTORY=true
DIRSTACKSIZE=200

setopt EXTENDED_HISTORY
setopt EXTENDED_GLOB
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY
setopt appendhistory autocd extendedglob notify

# Keychain
# source ~/.keychain/evilive-sh
# source ~/dotemacs/.bash/gentoo.sh

setopt AUTO_MENU

# Autopushd :)
setopt autopushd pushdminus pushdsilent pushdtohome
bindkey -e

# Is there another editor?
export VISUAL=gvim
export EDITOR=gvim

zstyle :compinstall filename '/home/bergundy/.zshrc'

# completion -------------------------------------------------------------------

# start added lately, for very verbose completions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format $'%{\e[1;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*' group-name ''
# verbose stop

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# named dir completion on previously unused dirs fails
# this does not help
# zstyle ':completion:*:complete:cd:*' tag-order local-directories named-directories
# not does this
# zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
#       'local-directories path-directories directory-stack' 'named-directories'


# usage: user (before @) and host (after @) are completable
# for ssh, scp, ftp, and other command that take a host as as argument
local _myhosts;
_myhosts=( ${${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ }:#\!*}
${=${(f)"$(cat /etc/hosts(|)(N) <<EOF
(ypcat hosts 2>/dev/null))"}%%\#*} ); #" quote is here just for syntax highlighting!
zstyle ':completion:*' hosts $_myhosts;

autoload -U compinit
compinit -u

LS_COLOR="no=00:fi=00:di=00;34:ln=00;36:pi=40;35:so=00;35:bd=40;32;00:cd=40;31;00:ex=00;31:*~=05;31:*.mtxt=05;36:*.ndx=05;31:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;39:*.c=00;36:*.h=00;36:*.pl=00;31:*.pm=00;31:*.cgi=00;31:*.java=00;31:*.html=00;31:*.tar=00;36:*.tgz=00;36:*.gz=00;36:*.tgz=00;36:*.bz2=00;36:*.arj=00;36:*.taz=00;36:*.lzh=00;36:*.zip=00;36:*.z=00;36:*.Z=00;36:*.gz=00;36:*.jpg=00;35:*.jpeg=00;35:*.JPG=00;35:*.gif=00;35:*.GIF=00;35:*.bmp=00;35:*.BMP=00;35:*.xbm=00;35:*.ppm=00;35:*.xpm=00;35:*.tif=00;35:"
export ZLS_COLORS=$LS_COLORS

autoload -Uz compinit
autoload -U zmv # zmv '(*).lis' '$1.txt'
autoload -U zargs
compinit

# Make zsh treat words like bash does
# Especially useful to delete whole parts of a path, but no the entire path using M-<backspace>
autoload -U select-word-style
select-word-style bash

################################################################################

alias ls='ls --color'

if [ $UID -eq 0 ]; then
    export PROMPT=$'%{\e[1;31m%}%M %U%{\e[0;33m%}%~%{\e[0m%}%u %{\e[1;35m%}%?%{\e[1;34m%}$%{\e[0m%} '
else
    export PROMPT=$'%{\e[1;32m%}%n@%M %U%{\e[0;33m%}%~%{\e[0m%}%u %{\e[1;35m%}%?%{\e[1;34m%}$%{\e[0m%} '
fi

################################################################################

# Keybindings:
# Here's a way to make zsh interpret the HOME and END keys on your keyboard as equivalent to ^a and ^e. Insert the following in your .zshrc file:
#
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Make zsh behave like Emacs, so I'll feel right at home
bindkey "^Hk" describe-key-briefly
bindkey "^Hf" where-is
# bindkey "\C-w" kill-region
bindkey "\C-x?" which-com
bindkey "^[]" vi-match-bracket
bindkey "^X^D" vi-repeat-find
bindkey "^XD" vi-rev-repeat-find

# Since I like M-<backspace> to delete words in bash-style,
# I still want the ability to use zsh-style word-killing.
bindkey "^X^?" backward-delete-word

bindkey " " magic-space

autoload -U    edit-command-line
zle -N         edit-command-line
bindkey '^X^E' edit-command-line


RPROMPT=$'%{\e[0;32m%}%h%{\e[0m%}'

function p4mv() {
       p4 integrate $1 $2
       p4 delete $1
}

function emacspm() {
       emacsclient -n $(perldoc -l $1)
}


## Named directories
function named_dir(){ eval 'export $1="$2" && hash -d $1="$2"' }
# named_dir golan_asm_t "/home/yuval/p4/golan/TrafficShield/mng/scripts/packages/pure_perl_test/t"

alias vi=gvim
