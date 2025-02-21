FROM ubuntu:noble
MAINTAINER Yann Le Doaré <yann@linuxconsole.org>
ARG DEBIAN_FRONTEND=noninteractive

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
ENV TERM=linux

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update 
RUN useradd linuxconsole2025 --create-home

RUN apt-get install -y ack ant apt-utils autoconf automake 
RUN apt-get install -y bam bc bison bzip2 bzr bindgen 
RUN apt-get install -y cargo cbindgen clang-18 cmake cpio cpuinfo curl cvs 
RUN apt-get install -y docbook-xsl doxygen 
RUN apt-get install -y flex 
RUN apt-get install -y fontforge 
RUN apt-get install -y g++ gawk gcc-multilib genisoimage gettext ghc git g++-multilib gperf gsoap google-mock googletest gi-docgen
RUN apt-get install -y help2man
RUN apt-get install -y iasl imagemagick 
RUN apt-get install -y kmod 
RUN apt-get install -y lib32z1 libatomic-ops-dev libbabeltrace-ctf1 libboost-all-dev libboost-dev libclc-18-dev libelf-dev libghc-base-dev libghc-entropy-dev libghc-hslogger-dev libghc-network-dev libghc-random-dev libghc-regex-tdfa-dev libghc-sandi-dev libghc-sha-dev libghc-utf8-string-dev libghc-vector-dev libghc-zlib-dev libmpfr-dev libncurses5-dev libssl-dev libtool libtool-bin libunwind8 libwrap0 libxml-parser-perl lld-18 llvm-18 locales lynx lzma libgtest-dev libgmock-dev libclang-cpp-dev libclang-18-dev
RUN apt-get install -y make makeself meson mtd-utils 
RUN apt-get install -y nasm 
RUN apt-get install -y openjdk-21-jdk-headless 
RUN apt-get install -y p7zip-full patch pciutils python3-mako 
RUN apt-get install -y rdfind rsync 
RUN apt-get install -y ruby 
RUN apt-get install -y rustc strace subversion syslinux-utils 
RUN apt-get install -y texinfo 
RUN apt-get install -y unicode-data unzip 
RUN apt-get install -y vim valac
RUN apt-get install -y wget 
RUN apt-get install -y xfonts-utils 
RUN apt-get install -y xmlto xorriso xsltproc xutils-dev xz-utils 
RUN apt-get install -y zlib1g-dev zstd 

USER linuxconsole2025
#CMD /build-lc2025
