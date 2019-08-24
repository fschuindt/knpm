#!/usr/bin/env sh

EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php7 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php7 -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php7 composer-setup.php --quiet --install-dir=/bin
RESULT=$?

rm composer-setup.php
mv /bin/composer.phar /usr/local/bin/composer

exit $RESULT
