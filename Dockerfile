FROM httpd:2.4.57-alpine
COPY index.html  /var/www/html/
EXPOSE 80
