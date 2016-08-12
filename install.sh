#!/bin/bash
cur=`pwd`
home="$HOME"
function backup() {
    local profile=$1
    mv "$home/$profile" "$home/$profile.bak"
}

function link() {
    local profile=$1
    ln -s "$cur/$profile" "$home/$profile"
}

function proc() {
    backup $1
    link $1
}

proc ".zshrc"
proc ".vimrc"
proc ".tmux.conf"
proc ".gdbinit"
