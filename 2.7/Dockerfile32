FROM i386/debian:10.2
MAINTAINER Yann Le Doaré <yann@linuxconsole.org>

# Locale
RUN apt-get update && apt-get install -y locales 
# RUN localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8 
RUN echo "fr_FR.UTF-8 UTF-8"> /etc/locale.gen
RUN echo "br_FR.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "de_DE.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "en_US.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "es_ES.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "fr_CA.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "fr_FR.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "pt_BR.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "ru_RU.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "zh_CN.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "cs_CZ.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "pl_PL.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "ar_TN.UTF-8 UTF-8">> /etc/locale.gen
RUN echo "ja_JP.UTF-8 UTF-8">> /etc/locale.gen
RUN locale-gen
ENV LANG fr_FR.utf8

# Timezone
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd linuxconsole2019 --create-home
COPY ./build-lc2019 /home/linuxconsole2019/build-lc2019

RUN apt-get update && apt-get install -y  apt-utils

RUN apt-get update && apt-get install -y vim ack  wget openjdk-11-jdk-headless libncurses5-dev  rustc python-mako cargo gcc-multilib g++-multilib ant libssl-dev libwrap0 gsoap meson libghc-sandi-dev libghc-regex-tdfa-dev libghc-base-dev libghc-sha-dev libbabeltrace-ctf1 clang cython libclang-7-dev llvm-dev xz-utils libxml-parser-perl patch libunwind8 libclc-dev ftjam locales syslinux-utils ghc libghc-random-dev libghc-zlib-dev libghc-entropy-dev libghc-utf8-string-dev ghc libghc-vector-dev libghc-bytestring-show-dev libghc-network-dev libghc-hslogger-dev makeself iasl doxygen p7zip-full xutils-dev xmlto libelf-dev imagemagick bam fontforge ruby libboost-all-dev libboost-dev nasm libatomic-ops-dev unzip bc lynx cmake xfonts-utils xsltproc zlib1g-dev gperf bzr unicode-data llvm gettext docbook-xsl make mtd-utils pciutils texinfo bzip2 subversion git gawk bison flex automake-1.15 automake autoconf libtool-bin libtool cvs lzma g++ genisoimage libmpfr-dev

RUN ln -s /usr/lib/i386-linux-gnu/libmpfr.so.6 /usr/lib/i386-linux-gnu/libmpfr.so.4
RUN apt-get install -y cpio kmod xorriso

# To build firefox
RUN apt-get install cbindgen
# To build chromium
RUN apt-get install lld-7

USER linuxconsole2019
CMD /home/linuxconsole2019/build-lc2019
