FROM lscr.io/linuxserver/smokeping:latest

# Set timezone and environment variables if needed
ENV TZ=UTC
ENV PUID=1000
ENV PGID=1000
ENV PORT=80
# Expose the default Apache/CGI port
EXPOSE 80
