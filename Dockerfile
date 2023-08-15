FROM httpd:2.4.57-alpine
COPY .  /var/www/html/
EXPOSE 80
