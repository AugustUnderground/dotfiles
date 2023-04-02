# Config Path
export ZSH_CFG="$HOME/.config/zsh"

# If you come from bash you might have to change your $PATH.
export PATH=/usr/X11R6/bin/startx:$PATH # OpenBSD
export PATH=$HOME/.local/bin:$PATH      # Local executables
export PATH=$HOME/scripts:$PATH         # My scripts
export PATH=$HOME/dots/scripts:$PATH    # My private scripts
export PATH=$HOME/perl5/bin:$PATH       # Perl
export PATH=$HOME/.cabal/bin:$PATH      # Haskell
export PATH=$HOME/.cargo/bin:$PATH      # Rust
export PATH=$HOME/go/bin:$PATH          # Go
export PATH=$HOME/.ghcup/bin:$PATH      # Haskell
export PATH=/usr/local/cuda/bin:$PATH   # CUDA
export PATH=$HOME/.luarocks/bin:$PATH   # Lua
export PATH=$HOME/.nimble/bin:$PATH     # nim

# History
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

# Language Environment
# export LANG=en_US.UTF-8

# Vi Mode
ZVM_VI_HIGHLIGHT_BACKGROUND=white      # Color name

# LATEX
if [ $(uname) = "Linux" ]; then
    TEXLIVEPATH="/opt/texlive/2020/bin/x86_64-linux"
    TEXLIVEMAN="/opt/texlive/2020/texmf-dist/doc/man"
    TEXLIVEINFO="/opt/texlive/2020/texmf-dist/doc/info"
    [ -d $TEXLIVEPATH ] && export PATH=$TEXLIVEPATH:$PATH
    [ -d $TEXLIVEMAN ] && export MANPATH=$TEXLIVEMAN:$MANPATH
    [ -d $TEXLIVEINFO ] && export INFOPATH=$TEXLIVEINFO:$INFOPATH
elif [ $(uname) = "FreeBSD" ];then
    TEXLIVEPATH="/usr/local/texlive/2021/bin/amd64-freebsd"
    TEXLIVEMAN="/usr/local/texlive/2021/texmf-dist/doc/man"
    TEXLIVEINFO="/usr/local/texlive/2021/texmf-dist/doc/info"
    [ -d $TEXLIVEPATH ] && export PATH=$TEXLIVEPATH:$PATH
    [ -d $TEXLIVEMAN ] && export MANPATH=$TEXLIVEMAN:$MANPATH
    [ -d $TEXLIVEINFO ] && export INFOPATH=$TEXLIVEINFO:$INFOPATH
fi

# Preferred Editor for Local and Remote Sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='nvim'
fi

# dmenu Theme
export DMENU_THEME="-fn 'GoMono Nerd Font:size=12' \
                    -nb '#060404' \
                    -nf '#FFF6F6' \
                    -sb '#222222' \
                    -sf '#FFF6F6' \
                    -nhb '#060404' \
                    -nhf '#8F0024' \
                    -shb '#222222' \
                    -shf '#8F0024' \
                    -bw 2 -l 5 -h 25 -x 390 -y 150 -w 600 -i"

# Preferred pager settings man pages
export LESS="--RAW-CONTROL-CHARS"
[[ -f ~/dotfiles/.LESS_TERMCAP ]] && . ~/dotfiles/.LESS_TERMCAP
#export PAGER="most"

# LF Icons
[[ -f ~/.config/lf/ICONS ]] && . ~/.config/lf/ICONS

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Variables
export _JAVA_AWT_WM_NONREPARENTING=1
export __GL_SYNC_DISPLAY_DEVICE='DP-2'

export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'
if [ -e /home/uhlmanny/.nix-profile/etc/profile.d/nix.sh ]; then . /home/uhlmanny/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
