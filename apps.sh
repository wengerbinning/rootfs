#!/bin/bash

awk_home="/usr/lib/apps"
test -f "install.awk" && awk_home="."

# usage: app_install <list> <src> <dst>
_app_install() {
    test -n $1 -a -n -$2 -a $3 || exit
    test -f $1 && awk -f ${awk_home}/install.awk -vsrc="$2" -vdst="$3" $1
}


# app_install <name> <mode> <dest>
app_install () {

    return
}
# app_package <name> <src> <list>
app_package() {
    _app_install $3 $2 $1/rootfs
    cp $3 $1/app-list
}

desc=(
    "app manger tools"
    "install <name> <destination>"
    "install <dst> <src> <list>"
    "package <name> <src> <list>"
)

main () {
    case ${1:-help} in
    install)
        raw=false
        test -f $2 || raw=true
        test -d $2 && raw=true
        if ${raw:-false}; then
            _app_install $4 $3 $2
        else
            app_install $2 $3
        fi
    ;;
    package)
        app_package $2 $3 $4
    ;;
    help|*)
        for each in "${desc[@]}"; do
            echo "$each"
        done
    esac
}
main "$@"

#./shell.sh install ../../0/ glibc-v2.39-x86_64/ app-list-glibc-include