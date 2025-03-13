#!/bin/bash

# List of URLs and corresponding MD5 sums
declare -A packages
packages=(
    ["acl"]="https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.xz 590765dee95907dbc3c856f7255bd669"
    ["attr"]="https://download.savannah.gnu.org/releases/attr/attr-2.5.2.tar.gz 227043ec2f6ca03c0948df5517f9c927"
    ["autoconf"]="https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz 1be79f7106ab6767f18391c5e22be701"
    ["automake"]="https://ftp.gnu.org/gnu/automake/automake-1.17.tar.xz 7ab3a02318fee6f5bd42adfc369abf10"
    ["bash"]="https://ftp.gnu.org/gnu/bash/bash-5.2.37.tar.gz 9c28f21ff65de72ca329c1779684a972"
    ["bc"]="https://github.com/gavinhoward/bc/releases/download/7.0.3/bc-7.0.3.tar.xz ad4db5a0eb4fdbb3f6813be4b6b3da74"
    ["binutils"]="https://sourceware.org/pub/binutils/releases/binutils-2.44.tar.xz 49912ce774666a30806141f106124294"
    ["bison"]="https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz"

)

DOWNLOAD_DIR="./downloads"

mkdir -p "$DOWNLOAD_DIR"

# Download and verify each package
for package in "${!packages[@]}"; do
    url="${packages[$package]%% *}"
    md5sum="${packages[$package]##* }"
    
    # Download the package
    echo "Downloading $package..."
    wget -q --show-progress -P "$DOWNLOAD_DIR" "$url"

    # Verify the MD5 sum
    echo "Verifying MD5 sum for $package..."
    echo "$md5sum  $DOWNLOAD_DIR/$(basename $url)" | md5sum -c --status
    if [ $? -eq 0 ]; then
        echo "$package downloaded and verified successfully."
    else
        echo "MD5 mismatch for $package! Please check the download."
    fi
done

echo "All downloads and verifications completed."

