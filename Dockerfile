FROM lscr.io/linuxserver/smokeping:latest
RUN sed -i 's/listen 80/listen 8080/g' /etc/nginx/http.d/default.conf 2>/dev/null || sed -i 's/listen 80/listen 8080/g' /etc/nginx/nginx.conf
# Set timezone and environment variables if needed
ENV TZ=UTC
ENV PUID=1000
ENV PGID=1000
# Expose the default Apache/CGI port
EXPOSE 80
