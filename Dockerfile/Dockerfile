
FROM php:7.1-apache
MAINTAINER Ivan Berezhnov <ivan.berezhnov@icloud.com>

RUN a2enmod rewrite

### Install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev curl vim
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr
RUN docker-php-ext-install gd mbstring opcache pdo pdo_mysql pdo_pgsql zip json
RUN pecl install xdebug
RUN docker-php-ext-enable json xdebug

### Set recommended PHP.ini settings
# See https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# Enable Remote xdebug.
RUN { \
		echo xdebug.remote_autostart=true; \
		echo xdebug.remote_mode=req; \
		echo xdebug.remote_handler=dbgp; \
		echo xdebug.remote_connect_back=1; \
		echo xdebug.remote_port=9000; \
		echo xdebug.idekey=PHPSTORM; \
		echo xdebug.remote_enable=1; \
		echo xdebug.profiler_append=0; \
		echo xdebug.profiler_enable=0; \
		echo xdebug.profiler_enable_trigger=1; \
		echo xdebug.profiler_enable_trigger=1; \
		echo xdebug.profiler_output_dir=/var/debug; \
		echo xdebug.profiler_output_name=cachegrind.out.%s.%u; \
		echo xdebug.var_display_max_data=-1; \
		echo xdebug.var_display_max_children=-1; \
		echo xdebug.var_display_max_depth=-1; \
    } > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Set work directory.
WORKDIR /var/www/symfony


#	&& chown -R www-data:www-data sites modules themes

# Install composer and init symfony project.
ADD provision.sh /provision.sh
ADD 000-default.conf /etc/apache2/sites-available/
RUN chmod +x /*.sh
RUN /provision.sh
