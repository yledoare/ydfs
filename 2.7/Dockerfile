FROM debian:buster
MAINTAINER Yann Le Doaré <yann@linuxconsole.org>

# Locale
RUN apt-get update && apt-get install -y locales \
	&& localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8
ENV LANG fr_FR.utf8

# Timezone
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd linuxconsole2019 --create-home
COPY ./build-lc2019 /home/linuxconsole2019/build-lc2019

RUN apt-get update && apt-get install -y  apt-utils
# RUN apt-get update && apt-get install -y  default-jre-headless

RUN apt-get update && apt-get install -y  wget libncurses5-dev  rustc python-mako cargo gcc-multilib g++-multilib ant libssl-dev libwrap0 gsoap meson libghc-sandi-dev libghc-regex-tdfa-dev libghc-base-dev libghc-sha-dev libbabeltrace-ctf1 clang libclang-6.0-dev cython llvm-dev xz-utils libxml-parser-perl patch libunwind8 libclc-dev ftjam locales syslinux-utils ghc libghc-random-dev libghc-zlib-dev libghc-entropy-dev libghc-utf8-string-dev ghc libghc-vector-dev libghc-bytestring-show-dev libghc-network-dev libghc-hslogger-dev makeself iasl doxygen p7zip-full xutils-dev xmlto libelf-dev imagemagick bam fontforge ruby libboost-all-dev libboost-dev nasm libatomic-ops-dev unzip bc lynx cmake xfonts-utils xsltproc zlib1g-dev gperf bzr unicode-data llvm gettext docbook-xsl make mtd-utils pciutils texinfo bzip2 subversion git gawk bison flex automake-1.15 automake autoconf libtool-bin libtool cvs lzma g++ genisoimage libmpfr-dev
