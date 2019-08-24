FROM alpine:3.9

ARG PUID=1000
ARG PGID=1000
ARG HOME="/htdocs"

ENV TIMEZONE="America/Sao_Paulo"
ENV PHP_FPM_USER="htdocs"
ENV PHP_FPM_GROUP="htdocs"
ENV PHP_FPM_LISTEN_MODE="0660"
ENV PHP_MEMORY_LIMIT="1024M"
ENV PHP_MAX_UPLOAD="512M"
ENV PHP_MAX_FILE_UPLOAD="20"
ENV PHP_MAX_POST="512M"
ENV PHP_MAX_EXECUTION_TIME="240"
ENV PHP_MAX_INPUT_TIME="240"
ENV PHP_DISPLAY_ERRORS="On"
ENV PHP_DISPLAY_STARTUP_ERRORS="On"
ENV PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
ENV PHP_CGI_FIX_PATHINFO="0"

RUN addgroup -g ${PGID} htdocs && \
    adduser -S -h ${HOME} -G htdocs -u ${PUID} htdocs

RUN apk update && \
    apk upgrade && \
    apk add --no-cache tzdata nginx bash msmtp

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone

RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp \
        php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip \
        php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql \
        php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-session \
        php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc \
        php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype \
        php7-phar php7-tokenizer php7-xmlwriter php7-simplexml \
        php7-mbstring php7-fileinfo

RUN chown -R htdocs:htdocs /var/lib/nginx
RUN chown -R htdocs:htdocs /var/tmp/nginx

COPY ./configure_php.sh /.
COPY ./install_composer.sh /.

RUN chmod +x ./configure_php.sh && \
    ./configure_php.sh

RUN chmod +x ./install_composer.sh && \
    ./install_composer.sh

COPY nginx.conf /etc/nginx/nginx.conf

COPY www.conf /etc/php7/php-fpm.d/www.conf

RUN mkdir /var/log/msmtp

COPY msmtp-sendmail.start /etc/local.d/msmtp-sendmail.start

RUN chmod +x /etc/local.d/msmtp-sendmail.start

COPY --chown=htdocs:htdocs ./htdocs/. /htdocs/.

EXPOSE 4080

CMD php-fpm7 && \
    nginx && \
    /etc/local.d/msmtp-sendmail.start && \
    echo "Running..." && \
    tail -f /var/log/nginx/access.log
