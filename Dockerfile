FROM lsiobase/alpine:3.6
MAINTAINER LinuxServer.io <ironicbadger@linuxserver.io>, sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache \
	apache2 \
	apache2-utils \
	curl \
	smokeping \
	ssmtp \
	sudo \
	ttf-dejavu && \

# give abc sudo access to traceroute
 echo "abc ALL=(ALL) NOPASSWD: /usr/bin/traceroute" >> /etc/sudoers.d/traceroute && \

# fix path to cropper.js
 sed -i 's#src="/cropper/#/src="cropper/#' /etc/smokeping/basepage.html && \
 sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf && \
 sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-available/000-default.conf && \
 apt clean && \
 rm -rf /v ar/lib/apt/lists/*
# add local files
COPY root/ /

# ports and volumes
EXPOSE 8080
VOLUME /config /data
