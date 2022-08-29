FROM debian:bullseye
#FROM alpine:3.14
MAINTAINER Yann Le Doaré <yann@linuxconsole.org>

# Locale
#RUN apk add --no-cache --update musl musl-utils musl-locales tzdata
RUN apt-get update && apt-get install -y locales 
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

RUN apt-get install -y make g++ gcc
RUN apt-get install -y git

#RUN apk add --no-cache make g++ gcc 

RUN useradd ydfs3 --create-home
COPY ./build /home/ydfs3/build

USER ydfs3
CMD /home/ydfs3/build
