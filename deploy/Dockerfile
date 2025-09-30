FROM php:apache

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install mod security and other dependencies
RUN apt-get update && apt-get install -y libapache2-mod-security2 \
    git \
    ca-certificates

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable mod security
RUN a2enmod security2

# Copy Mod Security Configuration
COPY ./modsecurity/modsecurity.conf /etc/modsecurity/modsecurity.conf
COPY ./modsecurity/rules/ /etc/modsecurity/rules/

# Copy App Files
COPY ./www/ /var/www/html/

# Expose port 80
EXPOSE 80