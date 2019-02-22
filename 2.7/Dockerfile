FROM debian:buster
MAINTAINER Yann Le Doaré <yann@linuxconsole.org>

# Locale
RUN apt-get update && apt-get install -y locales && localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8 && localedef -i br_FR.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias br_FR.UTF-8 && localedef -i de_DE.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8 && localedef -i en_US.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && localedef -i es_ES.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias es_ES.UTF-8 && localedef -i fr_CA.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias fr_CA.UTF-8 && localedef -i fr_FR.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8 && localedef -i pt_BR.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8 && localedef -i ru_RU.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8 && localedef -i zh_CN.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8 && localedef -i cs_CZ.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias cs_CZ.UTF-8 && localedef -i pl_PL.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias pl_PL.UTF-8 && localedef -i ar_TN.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias ar_TN.UTF-8 && localedef -i ja_JP.UTF-8 -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 

ENV LANG fr_FR.utf8

# Timezone
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd linuxconsole2019 --create-home
# COPY ./build-lc2019 /home/linuxconsole2019/build-lc2019
RUN apt-get update && apt-get install -y  apt-utils

RUN apt-get update && apt-get install -y vim ack  wget libncurses5-dev  rustc python-mako cargo gcc-multilib g++-multilib ant libssl-dev libwrap0 gsoap meson libghc-sandi-dev libghc-regex-tdfa-dev libghc-base-dev libghc-sha-dev libbabeltrace-ctf1 clang libclang-6.0-dev cython llvm-dev xz-utils libxml-parser-perl patch libunwind8 libclc-dev ftjam locales syslinux-utils ghc libghc-random-dev libghc-zlib-dev libghc-entropy-dev libghc-utf8-string-dev ghc libghc-vector-dev libghc-bytestring-show-dev libghc-network-dev libghc-hslogger-dev makeself iasl doxygen p7zip-full xutils-dev xmlto libelf-dev imagemagick bam fontforge ruby libboost-all-dev libboost-dev nasm libatomic-ops-dev unzip bc lynx cmake xfonts-utils xsltproc zlib1g-dev gperf bzr unicode-data llvm gettext docbook-xsl make mtd-utils pciutils texinfo bzip2 subversion git gawk bison flex automake-1.15 automake autoconf libtool-bin libtool cvs lzma g++ genisoimage libmpfr-dev

USER linuxconsole2019
# CMD /home/linuxconsole2019/build-lc2019
CMD git clone https://bitbucket.org/yourdistrofromscratch/ydfs.git && cd 2.7 && make
