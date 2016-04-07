FROM ubuntu

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -q -y install libmysqlclient-dev nodejs-legacy nodejs-dev npm build-essential git curl software-properties-common python-software-properties

ENV LARAVEL_ENV="production" \
    NODE_ENV="production" \
    PHP_VERSION="5.6.19"

RUN bin/bash -c "LANG=C.UTF-8 add-apt-repository ppa:ondrej/php5-5.6" \
    && bin/bash -c "apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -q -y install php5 libapache2-mod-php5 php5-mcrypt php5-mysql php5-json php5-curl php5-cli" \
    && php5enmod mcrypt \
    && a2enmod rewrite
RUN mkdir -p /app
RUN echo "export DB_DEFAULT='mysql'" >> /etc/apache2/envvars \
    && echo "export DB_CONNECTION='mysql'" >> /etc/apache2/envvars \
    && echo "export DB_HOST='db'" >> /etc/apache2/envvars \
    && echo "export DB_DATABASE='app'" >> /etc/apache2/envvars \
    && echo "export DB_USERNAME='root'" >> /etc/apache2/envvars \
    && echo "export DB_PASSWORD='7UU9YKRj7n8mmEkXcRDtkQ'" >> /etc/apache2/envvars
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY . /app/
WORKDIR /app
RUN rm /etc/apache2/sites-available/000-default.conf \
    && touch /etc/apache2/sites-available/000-default.conf \
    && echo '      <VirtualHost *:80>\n          DocumentRoot /app/public\n          <Directory /app/public>\n              Options -Indexes +FollowSymLinks +MultiViews\n              AllowOverride All\n              Require all granted\n          </Directory>\n          ErrorLog ${APACHE_LOG_DIR}/error.log\n          LogLevel warn\n          CustomLog ${APACHE_LOG_DIR}/access.log combined\n      </VirtualHost>' > /etc/apache2/sites-available/000-default.conf
RUN npm install -g gulp && npm install gulp
RUN rm -rf ./node_modules \
    && npm install --production
RUN composer install --prefer-source --no-interaction --no-dev
RUN chown -R www-data:www-data /app

EXPOSE 80

