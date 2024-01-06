FROM ubuntu:jammy
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

RUN useradd linuxconsole2023 --create-home
# COPY ./build-lc2023 /home/linuxconsole2023/build-lc2023
COPY ./build-lc2023 /build-lc2023

RUN apt-get update && apt-get install -y apt-utils
RUN apt-get update && apt-get install -y llvm-13 libclang-13-dev clang-13

RUN apt-get update && apt-get install -y vim ack wget openjdk-17-jdk-headless libncurses5-dev  rustc python3-mako cargo gcc-multilib g++-multilib ant libssl-dev libwrap0 gsoap meson libghc-sandi-dev libghc-regex-tdfa-dev libghc-base-dev libghc-sha-dev libbabeltrace-ctf1 xz-utils libxml-parser-perl patch libunwind8 libclc-dev ftjam locales syslinux-utils ghc libghc-random-dev libghc-zlib-dev libghc-entropy-dev libghc-utf8-string-dev ghc libghc-vector-dev libghc-network-dev libghc-hslogger-dev makeself iasl doxygen p7zip-full xutils-dev xmlto libelf-dev imagemagick bam fontforge ruby libboost-all-dev libboost-dev nasm libatomic-ops-dev unzip bc lynx cmake xfonts-utils xsltproc zlib1g-dev gperf bzr unicode-data gettext docbook-xsl make mtd-utils pciutils texinfo bzip2 subversion git gawk bison flex automake autoconf libtool-bin libtool cvs lzma g++ genisoimage libmpfr-dev

RUN apt-get install -y cpio kmod xorriso

# To build firefox
# RUN apt-get install lld-10
RUN apt-get install cbindgen
# Cross compile for raspbery 
RUN apt-get install lib32z1

#libclc
#RUN apt-get install -y clang-11

RUN apt-get install -y rsync
USER linuxconsole2023
#CMD /home/linuxconsole2023/build-lc2023
CMD /build-lc2023
