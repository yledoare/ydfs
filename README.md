# About Ydfs

(Your Distro From Scratch) is a tool to build your own linux distribution 

# Docker Full Build (64 bits)

* make

# Docker Fast kernel Build (64 bits)

* make fast-kernel64

# Docker Fast Build (64 bits) - TODO

* make fast

# Manual build (Ubuntu Noble / Mint Wilma 22)

* apt-get update 

* apt-get install -y ack ant apt-utils autoconf automake bam bc bison bzip2 bzr cargo cbindgen clang-18 cmake cpio cpuinfo curl cvs docbook-xsl doxygen flex fontforge g++ gawk gcc-multilib genisoimage gettext ghc git g++-multilib gperf gsoap iasl imagemagick kmod lib32z1 libatomic-ops-dev libbabeltrace-ctf1 libboost-all-dev libboost-dev libclc-18-dev libelf-dev libghc-base-dev libghc-entropy-dev libghc-hslogger-dev libghc-network-dev libghc-random-dev libghc-regex-tdfa-dev libghc-sandi-dev libghc-sha-dev libghc-utf8-string-dev libghc-vector-dev libghc-zlib-dev libmpfr-dev libncurses5-dev libssl-dev libtool libtool-bin libunwind8 libwrap0 libxml-parser-perl lld-18 llvm-18 locales lynx lzma make makeself meson mtd-utils nasm openjdk-21-jdk-headless p7zip-full patch pciutils python3-mako rdfind rsync ruby rustc subversion syslinux-utils texinfo unicode-data unzip vim wget xfonts-utils xmlto xorriso xsltproc xutils-dev xz-utils zlib1g-dev zstd libgtest-dev

* cd core
* make iso

# Fast Manual build - TODO

* cd core
* BUILDYDFS=fast make iso
