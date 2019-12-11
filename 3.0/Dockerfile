FROM debian:10.2
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

RUN useradd ydfs3 --create-home
COPY ./build /home/ydfs3/build

RUN apt-get update && apt-get install -y  apt-utils

RUN apt-get update && apt-get install -y vim ack wget autopoint libncurses5-dev  rustc python-mako cargo ant libssl-dev libwrap0 gsoap meson libbabeltrace-ctf1 clang cython libclang-7-dev llvm-dev xz-utils libxml-parser-perl patch libunwind8 libclc-dev ftjam locales syslinux-utils makeself iasl p7zip-full xutils-dev xmlto libelf-dev imagemagick bam ruby libboost-all-dev libboost-dev nasm libatomic-ops-dev unzip bc cmake xfonts-utils xsltproc zlib1g-dev gperf unicode-data llvm gettext make mtd-utils pciutils texinfo bzip2 subversion git gawk bison flex automake-1.15 automake autoconf libtool-bin libtool lzma g++ genisoimage libmpfr-dev

RUN apt-get install -y cpio kmod xorriso
# Cross compile for raspbery 
RUN apt-get install lib32z1

# To build chromium
RUN apt-get install lld-7

USER ydfs3
CMD /home/ydfs3/build
