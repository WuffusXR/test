FROM httpd:alpine
WORKDIR /var/www/html
COPY ./game-data/ .
CMD ["httpd", "-D", "DAEMON"]