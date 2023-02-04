# Terminal Window Title
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "${PWD/#$HOME/\~}"'

# Documentation
# export MANPATH="/usr/local/man:$MANPATH"

# Plugins
function load_plugin()
{
    plug=$1
    [ -d "$ZSH_CFG/${plug%/*}" ] && source "$ZSH_CFG/$plug"
}

ZSH_PLUGINS=( "zsh-completions/zsh-completions.plugin.zsh"
              "zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
              "fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
              "zsh-vi-mode/zsh-vi-mode.plugin.zsh"
              "zsh-titles/titles.plugin.zsh"
              "zsh-thefuck/zsh-thefuck.plugin.zsh"
            )
              # "zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

for plugin in $ZSH_PLUGINS; do load_plugin $plugin; done

# Completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt nocaseglob
zstyle ':completion:*' menu select
zmodload zsh/complist

# Version Control
autoload -Uz add-zsh-hook vcs_info
#zstyle ':vcs_info:*+*:*' debug true
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-st git-untracked
zstyle ':vcs_info:*' unstagedstr    "%F{red}"
zstyle ':vcs_info:*' stagedstr      "%F{green}"
zstyle ':vcs_info:*' actionformats  "%a %F{red} %F{white}%u%c%b%F{white}:%f %m"
zstyle ':vcs_info:*' formats        "%F{red} %F{white}%u%c%b%F{white}:%f %m"

# Tetris
autoload -Uz tetriscurses

precmd () { vcs_info }

function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( "${ahead}" )
    (( $behind )) && gitstatus+=( "${behind}" )

    #hook_com[misc]+=${(j:|:)gitstatus}
    hook_com[misc]+="%F{white}${ahead} ${behind}"
}

function +vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[misc]+=" %F{white}ﱤ"
    else
        hook_com[misc]+=" %F{white}ﱣ"
    fi

}

# Prompt
setopt PROMPT_SUBST
PROMPT='%F{white}%T %B%F{red}⸸ %b%f'
RPROMPT='%(?..%F{red}⏎ ) ${vcs_info_msg_0_}%b%f %F{red}⛧ %f%F{white}%h'

# Functions

#function zvm_after_select_vi_mode() {
#  case $ZVM_MODE in
#    $ZVM_MODE_NORMAL)
#       PROMPT='%F{white}%T %B%F{magenta}⸸ %b%f'
#       RPROMPT='%(?..%F{red}⏎ ) %B%F{magenta}⛧ %b%F{white}%h%f'
#    ;;
#    $ZVM_MODE_INSERT)
#       PROMPT='%F{white}%T %B%F{red}⸸ %b%f'
#       RPROMPT='%(?..%F{red}⏎ ) %B%F{red}⛧ %b%F{white}%h%f'
#    ;;
#    $ZVM_MODE_VISUAL)
#       PROMPT='%F{white}%T %B%F{blue⸸ %b%f'
#       RPROMPT='%(?..%F{red}⏎ ) %B%F{blue}⛧ %b%F{white}%h%f'
#    ;;
#    $ZVM_MODE_VISUAL_LINE)
#       PROMPT='%F{white}%T %B%F{cyan}⸸ %b%f'
#       RPROMPT='%(?..%F{red}⏎ ) %B%F{cyan}⛧ %b%F{white}%h%f'
#    ;;
#    $ZVM_MODE_REPLACE)
#       PROMPT='%F{white}%T %B%F{yellow}⸸ %b%f'
#       RPROMPT='%(?..%F{red}⏎ ) %B%F{yellow}⛧ %b%F{white}%h%f'
#    ;;
#  esac
#}

expand-or-complete-with-dots() {
  echo -n "\e[31m...\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

function openpdf()
{
    [ ! -z $1 ] && [ -f $1 ] && pdftotext $1 - | less
}

function powerdown()
{
    [ "$(mount | grep gonzo)" ] && sudo umount -R ~/gonzo/HP_scan \
                                && sudo umount -R ~/gonzo/Opt \
                                && sudo umount -R ~/gonzo/public \
                                && sudo umount -R ~/gonzo/rbzHome
    [ "$(mount | grep media)" ] && sudo umount -R ~/media

    sudo poweroff
}

# Aliases

alias zshconfig="mate ~/.zshrc"

alias cd..="cd .."
alias zz="z .."

alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

alias quit="exit"

alias dmneu_exe="dmneu_run $DMENU_THEME -p 'Launch:'"

if command -v alacritty > /dev/null; then
    alias tmux="TERM=alacritty tmux"
fi

if command -v zoxide > /dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v fuck > /dev/null; then
    eval "$(thefuck --alias)"
fi

#if [ -d "$HOME/opt/z.lua" ]; then
#    eval "$(lua $HOME/opt/z.lua/z.lua --init zsh enhanced once fzf)"
#fi

if command -v fzy > /dev/null; then
    alias hst="history 1 | fzy"
elif command -v fzf > /dev/null; then
    alias hst="history 1 | fzf"
fi

alias p9='export PATH=/usr/local/plan9/bin:$PATH'

alias nvid="neovide"

if command -v exa > /dev/null; then
    alias la="exa -laghGH@ --color-scale --color=auto --icons"
    alias ll="exa -lg --color-scale --color=auto --icons"
elif command -v lsd > /dev/null; then
    alias la="lsd -lah --color=auto"
    alias ll="lsd -l --color=auto"
else
    alias la="ls -lah --color=auto"
    alias ll="ls -l --color=auto"
fi

if ! command -v sudo >/dev/null; then
    alias sudo="doas"
elif ! command -v doas >/dev/null; then
    alias doas="sudo"
fi

alias psync="rsync -raulvnP ~/workspace uhlmanny@piggy:/home/uhlmanny/archive/$(hostname)/"
alias sshgonzo="sshfs uhlmanny@gonzo.fh-reutlingen.de:/ ~/gonzo -o reconnect -o allow_other"
#alias mountgonzo="sudo mount -t cifs -o username=uhlmanny,uid=$UID,gid=$GID //gonzo.fh-reutlingen.de/ $HOME/gonzo/"
alias mounthome="mountshare //gonzo.fh-reutlingen.de/rbzHome/ $RBZHOME"
alias mountusb="sudo mount -o uid=$UID,gid=$GID"

case "$(uname)" in
    "Linux")
        alias vpnup="sudo sh -c 'openvpn --mktun --dev tun1 && ip link set tun1 up && openconnect --interface=tun1 --protocol=anyconnect vpn.reutlingen-university.de'"
        alias vpndn="sudo sh -c 'killall openconnect && ip link set tun1 down'"
        ;;
    "OpenBSD")
        alias vpnup="doas sh -c 'openconnect --protocol=anyconnect vpn.reutlingen-university.de'"
        alias vpndn="doas sh -c 'kill -9 $(pgrep openconnect) && sh /etc/netstart'"
        ;;
    "FreeBSD")
        alias vpnup="doas sh -c 'openconnect --protocol=anyconnect vpn.reutlingen-university.de'"
        alias vpndn="doas sh -c 'kill -9 $(pgrep openconnect) && sh /etc/netstart'"
        ;;
    "Darwin")
        alias vpnup="doas sh -c 'openconnect --protocol=anyconnect vpn.reutlingen-university.de'"
        alias vpndn="doas sh -c 'kill -9 $(pgrep openconnect) && sh /etc/netstart'"
        ;;
esac

alias pdf=openpdf

alias yt="straw-viewer"

alias woman="man"

alias fp="fontpreview-ueberzug -f '#d8dee9' -b '#2e3440'"

alias passpush="pass git add . && pass git commit -m 'Password Updates' && pass git push origin master"

# Vi Mode
bindkey -v
export KEYTIMEOUT=1

# Haskell

[ -f "/home/ynk/.ghcup/env" ] && source "/home/ynk/.ghcup/env" # ghcup-env

# Conda

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/uhlmanny/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/uhlmanny/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/uhlmanny/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/uhlmanny/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Perl

PATH="/home/ynk/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/ynk/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/ynk/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/ynk/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ynk/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
