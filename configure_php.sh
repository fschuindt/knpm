#!/usr/bin/env sh

sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.conf
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.conf
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.conf
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.conf
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.conf
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.conf

sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini
sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini
sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php7/php.ini
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini
sed -i "s|;*max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|i" /etc/php7/php.ini
sed -i "s|;*max_input_time =.*|max_input_time = ${PHP_MAX_INPUT_TIME}|i" /etc/php7/php.ini
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php7/php.ini

sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini
