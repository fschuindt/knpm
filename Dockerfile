FROM alpine:3.9

ARG PUID=1000
ARG PGID=1000
ARG HOME="/htdocs"

RUN addgroup -g ${PGID} htdocs && \
    adduser -S -h ${HOME} -G htdocs -u ${PUID} htdocs

RUN apk update && \
    apk upgrade && \
    apk add --no-cache tzdata nginx

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone

RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp \
        php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip \
        php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql \
        php7-bcmath php7-gd php7-odbc php7-pdo_mysql \
        php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc \
        php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype

RUN chown -R htdocs:htdocs /var/lib/nginx

COPY ./configure_php.sh /.

RUN chmod +x ./configure_php.sh && \
    ./configure_php.sh && \
    rm ./configure_php.sh

COPY nginx.conf /etc/nginx/nginx.conf

COPY --chown=htdocs:htdocs ./htdocs/. /htdocs/.

EXPOSE 4080

CMD php-fpm7 && \
    nginx && \
    echo "Running..." && \
    tail -f /var/log/nginx/access.log
