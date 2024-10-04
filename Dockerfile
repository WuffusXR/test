FROM httpd:alpine
WORKDIR /var/www/html
COPY /jenkins/otomai-web/ .
CMD ["httpd", "-D", "DAEMON"]