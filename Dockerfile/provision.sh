#!/usr/bin/env bash

curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin

cd /var/www/
mkdir -p /usr/local/bin
curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
chmod a+x /usr/local/bin/symfony
symfony new symfony 3.4.2 --no-interaction
a2ensite 000-default.conf
service apache2 restart
