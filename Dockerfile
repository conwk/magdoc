FROM alpine:3.13
RUN apk --update --no-cache add \
	nginx=1.18.0-r15 \
	shadow \
	curl \
	vim \
	git \
	tree \
	php7 \
	php7-bcmath \
	php7-cli \
	php7-ctype \
	php7-curl \
	php7-dom \
	php7-fpm \
	php7-gd \
	php7-iconv \
	php7-intl \
	php7-json \
	php7-mbstring \
	php7-mcrypt \
	php7-openssl \
	php7-pdo_mysql \
	php7-phar \
	php7-session \
	php7-simplexml \
	php7-soap \
	php7-tokenizer \
	php7-xml \
	php7-xmlwriter \
	php7-xsl \
	php7-zip \
	php7-zlib

RUN usermod -u 1001 nginx && \
	groupmod -g 1001 nginx

RUN usermod -u 1002 nobody && \
	groupmod -g 1002 nobody

RUN mkdir -p /var/www/html/pub
COPY code /var/www/html/pub

COPY conf/startup.sh /usr/local/bin/startup.sh

COPY conf/php.ini /etc/php7/php.ini
#COPY ./conf/php-www.conf /etc/php7/php-fpm.d/www.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/magento-2.conf /etc/nginx/conf.d/magento-2.conf

RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 80
WORKDIR /var/www/html
ENTRYPOINT [ "sh", "/usr/local/bin/startup.sh" ]
