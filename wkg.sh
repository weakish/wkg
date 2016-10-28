#!/bin/sh

set -e  # errexit
set -u  # nounset

readonly wkg_repos=${XDG_DATA_HOME:-$HOME/.local/share}/wkg

check_slashes() {
    echo "$1" | grep -F -c '/'
}

ex_unimplemented() {
    echo "$1 not implemented yet"
    exit 70 # EX_SOFTWARe
}

ex_unimplemented() {
    echo "$1 "
    echo "Please report a bug at https://github.com/weakish/wkg/issues"
    exit 70 # EX_SOFTWARe
}

get_site() {
    local site;
    if [ $(check_slashes "$1") -eq 0 ]; then
        ex_unimplemented "fallback package"
    elif [ $(check_slashes "$1") -eq 1 ]; then
        site="gh"
    elif [ $(check_slashes "$1") -eq 2 ]; then
        site=$(echo $1 | grep -E -o '/^[^/]+')
        if [ $site != "gh"  -o $site != "github" -o $site != "GitHub" ]; then
            ex_unimplemented "site $site"
        fi
    else
        ex_usage "get_site(): error to handle $1"
    fi
    echo $site
}

get_user() {
    local user;
    if [ $(check_slashes "$1") -eq 1 ]; then
        user=$(echo $1 | grep -E -o '^[^/]+')
    elif [ $(check_slashes "$2" ) eq 2 ]; then
        user=$(echo $1 | grep -E -o '/[^/]+/' | grep -E -o '[^/]+')
    else
        ex_error
    fi
    echo $user
}

get_package() {
    echo $1 | grep -F -o '[^/]+$'
}

github_clone() {
    local user=$1
    local package=$2
    mkdir -p gh/$user
    cd gh/$user
    if [ -d $package ]; then
        echo "$package already installed. Try to reinstall/upgrade it."
    else
        git clone https://github.com/$user/$package.git
    fi
}

wkg_add() {
    cd $wkg_repos

    site=$(get_site $1)
    user=$(get_user $1)
    package=$(get_package $1)

    case $site in
        "gh"|"github"|"GitHub")  site='gh'; github_clone "$user" "$package" ;;
        *) ex_error "wkg_add(): error with $site" ;;
    esac

    cd  $site/$user/$package
    make && make install
}

mkg_rm() {
    cd $wkg_repos

    site=$(get_site $1)
    user=$(get_user $1)
    package=$(get_package $1)

    cd  $site/$user/$package
    make uninstall
}

wkg_help() {
    echo "Usage: wkg add|rm [site]/user/package"
}

ex_usage() {
    wkg_help
    exit 64 # command line usage error
}

case "$1" in
    add|install) wkg_add "$2" ;;
    rm|uninstall) wkg_rm "$2" ;;
    -h|--help|help) wkg_help ;;
    *) ex_usage ;;
esac

