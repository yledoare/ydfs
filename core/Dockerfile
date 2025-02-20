FROM ubuntu:noble
MAINTAINER Yann Le Doaré <yann@linuxconsole.org>

# Locale
RUN apt-get update && apt-get install -y locales 
# RUN localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8 
RUN echo "ar_TN.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "br_FR.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "cs_CZ.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "de_DE.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "en_US.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "es_ES.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "fr_FR.UTF-8 UTF-8"> /etc/locale.gen
RUN echo "fr_CA.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "fr_FR.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "ja_JP.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "pt_BR.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "pl_PL.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "pt_PT.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "ru_RU.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "uk_UA.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "zh_CN.UTF-8 UTF-8">> /etc/locale.gen
RUN locale-gen
ENV LANG fr_FR.utf8

# Timezone
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update 
RUN useradd linuxconsole2025 --create-home

RUN apt-get install -y ack
RUN apt-get install -y ant 
RUN apt-get install -y apt-utils 
RUN apt-get install -y autoconf 
RUN apt-get install -y automake 
RUN apt-get install -y bam 
RUN apt-get install -y bc 
RUN apt-get install -y bison 
RUN apt-get install -y bzip2 
RUN apt-get install -y bzr 
RUN apt-get install -y cargo 
RUN apt-get install -y cbindgen 
RUN apt-get install -y clang-18 
RUN apt-get install -y cmake 
RUN apt-get install -y cpio 
RUN apt-get install -y cpuinfo 
RUN apt-get install -y curl 
RUN apt-get install -y cvs 
RUN apt-get install -y docbook-xsl 
RUN apt-get install -y doxygen 
RUN apt-get install -y flex 
RUN apt-get install -y fontforge 
RUN apt-get install -y g++ 
RUN apt-get install -y gawk 
RUN apt-get install -y gcc-multilib 
RUN apt-get install -y genisoimage 
RUN apt-get install -y gettext 
RUN apt-get install -y ghc 
RUN apt-get install -y git 
RUN apt-get install -y g++-multilib 
RUN apt-get install -y gperf 
RUN apt-get install -y gsoap 
RUN apt-get install -y iasl 
RUN apt-get install -y imagemagick 
RUN apt-get install -y kmod 
RUN apt-get install -y lib32z1 
RUN apt-get install -y libatomic-ops-dev 
RUN apt-get install -y libbabeltrace-ctf1 
RUN apt-get install -y libboost-all-dev 
RUN apt-get install -y libboost-dev 
RUN apt-get install -y libclc-18-dev 
RUN apt-get install -y libelf-dev 
RUN apt-get install -y libghc-base-dev 
RUN apt-get install -y libghc-entropy-dev 
RUN apt-get install -y libghc-hslogger-dev 
RUN apt-get install -y libghc-network-dev 
RUN apt-get install -y libghc-random-dev 
RUN apt-get install -y libghc-regex-tdfa-dev 
RUN apt-get install -y libghc-sandi-dev 
RUN apt-get install -y libghc-sha-dev 
RUN apt-get install -y libghc-utf8-string-dev 
RUN apt-get install -y libghc-vector-dev 
RUN apt-get install -y libghc-zlib-dev 
RUN apt-get install -y libmpfr-dev 
RUN apt-get install -y libncurses5-dev 
RUN apt-get install -y libssl-dev 
RUN apt-get install -y libtool 
RUN apt-get install -y libtool-bin 
RUN apt-get install -y libunwind8 
RUN apt-get install -y libwrap0 
RUN apt-get install -y libxml-parser-perl 
RUN apt-get install -y lld-18 
RUN apt-get install -y llvm-18 
RUN apt-get install -y locales 
RUN apt-get install -y lynx 
RUN apt-get install -y lzma 
RUN apt-get install -y make 
RUN apt-get install -y makeself 
RUN apt-get install -y meson 
RUN apt-get install -y mtd-utils 
RUN apt-get install -y nasm 
RUN apt-get install -y openjdk-21-jdk-headless 
RUN apt-get install -y p7zip-full 
RUN apt-get install -y patch 
RUN apt-get install -y pciutils 
RUN apt-get install -y python3-mako 
RUN apt-get install -y rdfind 
RUN apt-get install -y rsync 
RUN apt-get install -y ruby 
RUN apt-get install -y rustc 
RUN apt-get install -y subversion 
RUN apt-get install -y syslinux-utils 
RUN apt-get install -y texinfo 
RUN apt-get install -y unicode-data 
RUN apt-get install -y unzip 
RUN apt-get install -y vim 
RUN apt-get install -y wget 
RUN apt-get install -y xfonts-utils 
RUN apt-get install -y xmlto 
RUN apt-get install -y xorriso 
RUN apt-get install -y xsltproc 
RUN apt-get install -y xutils-dev 
RUN apt-get install -y xz-utils 
RUN apt-get install -y zlib1g-dev 
RUN apt-get install -y zstd 

RUN apt-get install -y libgtest-dev
RUN apt-get install -y google-mock
RUN apt-get install -y libgmock-dev
RUN apt-get install -y googletest
RUN apt-get install -y valac
RUN apt-get install -y gi-docgen
RUN apt-get install -y libclang-cpp-dev
RUN apt-get install -y libclang-18-dev
RUN apt-get install -y bindgen strace help2man

USER linuxconsole2025
#CMD /build-lc2025
