#!/bin/bash

# LAMP Stack Installation Script for RHEL 9
# This script installs Apache (httpd), MySQL (MariaDB), PHP, and optional phpMyAdmin

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
    dnf update -y
}

# Function to install EPEL repository
install_epel() {
    echo "Installing EPEL repository..."
    sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y
}

# Function to install LAMP stack
install_lamp() {
    echo "Installing LAMP stack components..."
    dnf install -y httpd mariadb-server php php-mysqlnd php-cli php-curl \
        php-gd php-mbstring php-xml php-xmlrpc
}

# Function to configure Apache
configure_apache() {
    echo "Configuring Apache..."
    # Enable and start Apache
    systemctl enable --now httpd
    
    # Configure SELinux
    setsebool -P httpd_can_network_connect on
    
    # Create Apache virtual host configuration
    cat > /etc/httpd/conf.d/$DOMAIN_NAME.conf << EOF
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

    # Restart Apache
    systemctl restart httpd
}

# Function to secure MySQL
secure_mysql() {
    echo "Securing MySQL installation..."
    # Start and enable MariaDB
    systemctl enable --now mariadb
    
    # Secure MySQL installation
    mysql_secure_installation << EOF

y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
y
y
y
EOF
}

# Function to install phpMyAdmin
install_phpmyadmin() {
    if [ "$INSTALL_PHPMYADMIN" = true ]; then
        echo "Installing phpMyAdmin..."
        dnf install -y phpmyadmin
        
        # Configure phpMyAdmin
        cat > /etc/httpd/conf.d/phpMyAdmin.conf << EOF
Alias /phpMyAdmin /usr/share/phpMyAdmin
<Directory /usr/share/phpMyAdmin/>
    AddDefaultCharset UTF-8
    Require all granted
</Directory>
EOF
        
        # Restart Apache
        systemctl restart httpd
    fi
}

# Main execution
echo "Starting LAMP stack installation..."
check_root
update_system
install_epel
install_lamp
configure_apache
secure_mysql
install_phpmyadmin

echo "LAMP stack installation completed!"
echo "Please configure your domain name and MySQL root password in the script variables."
echo "Default values are:"
echo "Domain: $DOMAIN_NAME"
echo "MySQL root password: $MYSQL_ROOT_PASSWORD" 
