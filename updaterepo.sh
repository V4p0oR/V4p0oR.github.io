#!/usr/bin/env bash
if [[ "$OSTYPE" == "linux"* ]]; then #
    cd "$(dirname "$0")" || exit
    
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    
    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2
    
    apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated!"
elif [[ "$(uname)" == Darwin ]] && [[ "$(uname -p)" == i386 ]]; then
    cd "$(dirname "$0")" || exit
    
    echo "Checking for Homebrew, wget, xz, & zstd..."
    if test ! "$(which brew)"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew list --verbose wget || brew install wget
    brew list --verbose xz || brew install xz
    brew list --verbose zstd || brew install zstd
    clear
    
    wget -q -nc https://apt.procurs.us/apt-ftparchive
    sudo chmod 751 ./apt-ftparchive
    
    rm {Packages{,.xz,.gz,.bz2,.zst},Release{,.gpg}} 2> /dev/null
    
    ./apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2
    
    ./apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated!"
elif [[ "$(uname -r)" == *Microsoft ]]; then
    cd "$(dirname "$0")" || exit
    
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    
    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2
    
    apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated!"
elif [[ "$(uname -r)" == *microsoft-standard ]]; then
    cd "$(dirname "$0")" || exit
    
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    
    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2
    
    apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated!"
elif [[ "$(uname)" == Darwin ]] && [[ "$(uname -p)" != i386 ]]; then
    cd "$(dirname "$0")" || exit
    echo "Checking for apt-ftparchive..."
    if test ! "$(apt-ftparchive)"; then
        apt update && apt install apt-utils -y
    fi

    rm {Packages{,.xz,.gz,.bz2,.zst},Release{,.gpg}} 2> /dev/null

    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2

    apt-ftparchive release -c ./assets/repo/repo.conf . > Release

    echo "Repository Updated!"
fi
