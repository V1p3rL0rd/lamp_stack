#!/bin/bash

# LAMP Stack Installation Script for Ubuntu 24.04
# This script installs Apache, MySQL, PHP, and optional phpMyAdmin

# Configuration variables
DOMAIN_NAME="example.com"
MYSQL_ROOT_PASSWORD="dbroot_12345"
INSTALL_PHPMYADMIN=true

# Function to check if script is run as root
check_root() {
    if [ "$EUID" -ne 0 ]; then 
        echo "Please run as root"
        exit 1
    fi
}

# Function to update system
update_system() {
    echo "Updating system packages..."
    apt update
    apt upgrade -y
}

# Function to install LAMP stack
install_lamp() {
    echo "Installing LAMP stack components..."
    apt install -y apache2 mysql-server php php-mysql libapache2-mod-php \
        php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc
}

# Function to configure Apache
configure_apache() {
    echo "Configuring Apache..."
    # Enable required modules
    a2enmod rewrite
    
    # Create Apache virtual host configuration
    cat > /etc/apache2/sites-available/$DOMAIN_NAME.conf << EOF
<VirtualHost *:80>
    ServerName $DOMAIN_NAME
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

    # Enable the new site and disable default
    a2ensite $DOMAIN_NAME.conf
    a2dissite 000-default.conf
    
    # Restart Apache
    systemctl restart apache2
}

# Function to secure MySQL
secure_mysql() {
    echo "Securing MySQL installation..."
    # Set root password
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    
    # Remove anonymous users
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.user WHERE User='';"
    
    # Remove test database
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "DROP DATABASE IF EXISTS test;"
    
    # Remove test database privileges
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"
    
    # Reload privileges
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
}

# Function to install phpMyAdmin
install_phpmyadmin() {
    if [ "$INSTALL_PHPMYADMIN" = true ]; then
        echo "Installing phpMyAdmin..."
        apt install -y phpmyadmin
    fi
}

# Main execution
echo "Starting LAMP stack installation..."
check_root
update_system
install_lamp
configure_apache
secure_mysql
install_phpmyadmin

echo "LAMP stack installation completed!"
echo "Please configure your domain name and MySQL root password in the script variables."
echo "Default values are:"
echo "Domain: $DOMAIN_NAME"
echo "MySQL root password: $MYSQL_ROOT_PASSWORD" 