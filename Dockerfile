FROM lscr.io/linuxserver/smokeping:latest
RUN sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/httpd.conf 
# Set timezone and environment variables if needed
ENV TZ=UTC
ENV PUID=1000
ENV PGID=1000
# Expose the default Apache/CGI port
EXPOSE 8080
