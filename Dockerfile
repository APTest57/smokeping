FROM lsiobase/alpine:3.6

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages and configure
RUN \
 apk add --no-cache \
    apache2 \
    apache2-utils \
    curl \
    smokeping \
    ssmtp \
    sudo \
    ttf-dejavu && \
 echo "abc ALL=(ALL) NOPASSWD: /usr/bin/traceroute" >> /etc/sudoers.d/traceroute && \
 sed -i 's#src="/cropper/#/src="cropper/#' /etc/smokeping/basepage.html

# add local files

# ports and volumes
EXPOSE 80
VOLUME /config /data
