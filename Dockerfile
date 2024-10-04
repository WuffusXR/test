FROM httpd:alpine
WORKDIR /var/www/html
COPY ./Otomai-web/ .
CMD ["httpd", "-D", "DAEMON"]