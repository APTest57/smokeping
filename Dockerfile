FROM lscr.io/linuxserver/smokeping:latest
RUN apt-get update && \
    apt-get install -y --no-install-recommends rclone && \
    rm -rf /var/lib/apt/lists/*
# la conf apache n'est pas encore accessible -> creation d'un script qui fera la modif plus tard
RUN mkdir -p /custom-cont-init.d && \
    echo '#!/bin/with-contenv bash' > /custom-cont-init.d/change-port.sh && \
    echo 'sed -i "s/Listen 80/Listen 8080/g" /config/httpd.conf' >> /custom-cont-init.d/change-port.sh && \
    chmod +x /custom-cont-init.d/change-port.sh
COPY Targets /config/
COPY Probes /config/
COPY rclone-restore.sh /custom-cont-init.d/01-rclone-restore.sh
RUN chmod +x /custom-cont-init.d/01-rclone-restore.sh
COPY rclone-backup.sh /etc/periodic/15min/rclone-backup
RUN chmod +x /etc/periodic/15min/rclone-backup
# Set timezone and environment variables if needed
ENV TZ=UTC
ENV PUID=1000
ENV PGID=1000
# Expose the default Apache/CGI port
EXPOSE 8080
