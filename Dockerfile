FROM httpd:2.4.57-alpine
COPY .  /usr/local/apache2/htdocs/
EXPOSE 80
