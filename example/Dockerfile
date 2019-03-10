FROM zfschuindt/knpm:latest

# Clear build files...
RUN rm /htdocs/*

COPY ./my_site /htdocs

CMD php-fpm7 && \
    nginx && \
    echo "Running..." && \
    tail -f /var/log/nginx/access.log
