PATH=$PATH:/sbin:/usr/sbin
export LANG=en_US.UTF-8

psgrep () {
    test -n "$1" && ps aux | grep $1 | grep -v grep
}

extract () {
    # unpack a tar archive, decompressing as necessary.
    # this function is meant to isolate us from problems
    # with versions of tar that don't support .gz or .bz2.
    echo Extracting $1 ...
    case "$1" in
        *.tar)
            tar -xf "$1"
            ;;
        *.zip)
            unzip "$1"
            ;;
        *.tgz | *.tar.gz)
            gunzip -c "$1" | tar -xf -
            ;;
        *.tar.bz2)
            bunzip2 -c "$1" | tar -xf -
            ;;
        *)
            echo "Unable to unpack $1; extension not recognized."
            exit 1
    esac
    if [ $? -gt 0 ]
    then
        echo Usage: $0 tarball
    fi
}

alias x=extract
