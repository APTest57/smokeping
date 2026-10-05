FROM lscr.io/linuxserver/smokeping:latest
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf && sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/g' /etc/apache2/sites-available/000-default.conf
# Set timezone and environment variables if needed
ENV TZ=UTC
ENV PUID=1000
ENV PGID=1000
ENV PORT=80
# Expose the default Apache/CGI port
EXPOSE 80
