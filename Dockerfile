FROM ubuntu:20.04

RUN apt-get update -y

#Installing apache in non-interactive mode
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install apache2 -y

ARG PHP_VERSION=8.3

ARG TERM=linux

#Installing PHP
RUN apt-get update -y && apt-get -y install software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update -y && \
    apt-get -y install php$PHP_VERSION

#Install required PHP extensions
RUN apt-get install -y php$PHP_VERSION-bcmath php$PHP_VERSION-fpm php$PHP_VERSION-xml php$PHP_VERSION-mysql php$PHP_VERSION-zip php$PHP_VERSION-intl php$PHP_VERSION-ldap php$PHP_VERSION-gd php$PHP_VERSION-cli php$PHP_VERSION-bz2 php$PHP_VERSION-curl php$PHP_VERSION-mbstring php$PHP_VERSION-pgsql php$PHP_VERSION-opcache php$PHP_VERSION-soap php$PHP_VERSION-cgi

RUN apt install curl -y

WORKDIR /

RUN /bin/bash -c "$(curl -fsSL https://php.new/install/linux/8.4)"

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
