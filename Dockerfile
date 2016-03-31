FROM ubuntu

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -q -y install libmysqlclient-dev nodejs-legacy nodejs-dev npm build-essential git curl software-properties-common python-software-properties

ENV LARAVEL_ENV="production" \
    NODE_ENV="production" \
    PHP_VERSION="7.0.4"

RUN bin/bash -c "LANG=C.UTF-8 add-apt-repository ppa:ondrej/php" \
    && bin/bash -c "LANG=C.UTF-8 add-apt-repository ppa:ondrej/apache2" \
    && bin/bash -c "apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -q -y install php7.0 libapache2-mod-php7.0 apache2 php7.0-mcrypt php7.0-mysql php7.0-json php7.0-curl php7.0-cli php7.0-mbstring php7.0-dom php7.0-pdo-sqlite" \
    && a2enmod rewrite
RUN mkdir -p /app
RUN echo "export DB_DEFAULT='mysql'" >> /etc/apache2/envvars \
    && echo "export DB_CONNECTION='mysql'" >> /etc/apache2/envvars \
    && echo "export DB_HOST='db'" >> /etc/apache2/envvars \
    && echo "export DB_DATABASE='app'" >> /etc/apache2/envvars \
    && echo "export DB_USERNAME='root'" >> /etc/apache2/envvars \
    && echo "export DB_PASSWORD='zqme0HLJ40LqwJmzSqsllw'" >> /etc/apache2/envvars
COPY . /app/
WORKDIR /app
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN rm /etc/apache2/sites-available/000-default.conf \
    && touch /etc/apache2/sites-available/000-default.conf \
    && echo '      <VirtualHost *:80>\n          DocumentRoot /app/public\n          <Directory /app/public>\n              Options -Indexes +FollowSymLinks +MultiViews\n              AllowOverride All\n              Require all granted\n          </Directory>\n          ErrorLog ${APACHE_LOG_DIR}/error.log\n          LogLevel warn\n          CustomLog ${APACHE_LOG_DIR}/access.log combined\n      </VirtualHost>' > /etc/apache2/sites-available/000-default.conf
RUN npm install -g gulp && npm install gulp
RUN rm -rf ./node_modules \
    && npm install --production
RUN composer install --no-dev --prefer-source
RUN chown -R www-data:www-data /app

EXPOSE 80
