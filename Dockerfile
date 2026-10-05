FROM lscr.io/linuxserver/smokeping:latest
RUN mkdir -p /custom-cont-init.d && \
    echo '#!/bin/with-contenv bash' > /custom-cont-init.d/change-port.sh && \
    echo 'sed -i "s/Listen 80/Listen 8080/g" /config/httpd.conf' >> /custom-cont-init.d/change-port.sh && \
    chmod +x /custom-cont-init.d/change-port.sh
# Set timezone and environment variables if needed
ENV TZ=UTC
ENV PUID=1000
ENV PGID=1000
# Expose the default Apache/CGI port
EXPOSE 8080
