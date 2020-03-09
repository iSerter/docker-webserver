# the image below is built from ./../php/Dockerfile and it contains supervisor, composer, some img manipulation libs, etc.
# see ./../Dockerfile or github.com/iserter/docker-php for details.
FROM iserter/php-fpm:7.4

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils

# GIT
RUN apt-get install git -y

# Install Python - needed for AWS CLI
RUN apt-get install -y python

# AWS CLI
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN apt-get install unzip
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install nodejs -y

# Yarn
RUN apt-get install yarn -y

# Deployer
RUN curl -LO https://deployer.org/deployer.phar
RUN mv deployer.phar /usr/local/bin/deployer
RUN chmod +x /usr/local/bin/deployer

# Nginx
RUN apt-get install -y nginx
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# configure WWW
RUN useradd -u 1001 -G www-data -m project
RUN chown -R project:www-data /var/www/
RUN mkdir -p /var/log/supervisor /var/run/php
WORKDIR /var/www

# supervisor
COPY etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80

# Cleanup
RUN apt-get clean
RUN rm -rf /etc/nginx/sites-enabled

COPY etc/entrypoint.sh /etc/entrypoint.sh

ENTRYPOINT ["/etc/entrypoint.sh"]
#ENTRYPOINT ["/usr/bin/supervisord"]
