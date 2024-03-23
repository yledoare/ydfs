# About Ydfs

(Your Distro From Scratch) is a tool to build your own linux distribution 

# Fast Build (32 & 64 bits)

* cd 2.10
* docker-compose up -d

# Manual build

* sudo apt-get install -y vim ack wget openjdk-21-jdk-headless libncurses5-dev  rustc python3-mako cargo gcc-multilib g++-multilib ant libssl-dev libwrap0 gsoap meson libghc-sandi-dev libghc-regex-tdfa-dev libghc-base-dev libghc-sha-dev libbabeltrace-ctf1 xz-utils libxml-parser-perl patch libunwind8 libclc-dev ftjam locales syslinux-utils ghc libghc-random-dev libghc-zlib-dev libghc-entropy-dev libghc-utf8-string-dev ghc libghc-vector-dev libghc-network-dev libghc-hslogger-dev makeself iasl doxygen p7zip-full xutils-dev xmlto libelf-dev imagemagick bam fontforge ruby libboost-all-dev libboost-dev nasm libatomic-ops-dev unzip bc lynx cmake xfonts-utils xsltproc zlib1g-dev gperf bzr unicode-data gettext docbook-xsl make mtd-utils pciutils texinfo bzip2 subversion git gawk bison flex automake autoconf libtool-bin libtool cvs lzma g++ genisoimage libmpfr-dev locales apt-utils llvm-13 vim cpio curl rdfind rsync kmod cupinfo xorriso

* cd 2.10

# For fast option
* export BUILDYDFS=fast

* make iso

