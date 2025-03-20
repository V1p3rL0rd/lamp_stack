# LAMP Stack Installation Scripts

Bash scripts for automated installation of LAMP (Linux, Apache, MySQL/MariaDB, PHP) stack on Ubuntu 24.04 and RHEL 9 systems. Supports both standard and SSL-enabled installations.

## Features

- 🚀 Automated LAMP stack installation
- 🔒 Optional SSL configuration with self-signed certificates
- 🌐 Support for Ubuntu 24.04 and RHEL 9
- 📊 Optional phpMyAdmin installation
- 🔐 Secure MySQL/MariaDB configuration
- 🌍 Apache virtual host setup
- 🛡️ SELinux configuration for RHEL

## Prerequisites

- Root or sudo access
- Ubuntu 24.04 or RHEL 9 system
- Internet connection for package installation

## Available Scripts

1. `install_lamp_ubuntu.sh` - Basic LAMP stack installation for Ubuntu 24.04
2. `install_lamp_rhel.sh` - Basic LAMP stack installation for RHEL 9
3. `install_lamp_ubuntu_ssl.sh` - LAMP stack installation with SSL for Ubuntu 24.04
4. `install_lamp_rhel_ssl.sh` - LAMP stack installation with SSL for RHEL 9

## Configuration

Before running the scripts, you can modify the following variables at the beginning of each script:

```bash
DOMAIN_NAME="example.com"           # Your website's domain name
MYSQL_ROOT_PASSWORD="dbroot_12345" # MySQL root password
INSTALL_PHPMYADMIN=true           # Whether to install phpMyAdmin
```

For SSL-enabled scripts, you can also configure:
```bash
SSL_CERT="/path/to/certificate.crt"  # SSL certificate path
SSL_KEY="/path/to/private.key"       # SSL private key path
```

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/V1p3rL0rd/lamp-stack-installer.git
cd lamp-stack-installer
```

2. Make the scripts executable:
```bash
chmod +x install_lamp_*.sh
```

3. Run the appropriate script with sudo:
```bash
# For Ubuntu without SSL
sudo ./install_lamp_ubuntu.sh

# For Ubuntu with SSL
sudo ./install_lamp_ubuntu_ssl.sh

# For RHEL without SSL
sudo ./install_lamp_rhel.sh

# For RHEL with SSL
sudo ./install_lamp_rhel_ssl.sh
```

## What Gets Installed

### Ubuntu 24.04
- Apache2
- MySQL Server
- PHP and common extensions:
  - php-mysql
  - php-cli
  - php-curl
  - php-gd
  - php-mbstring
  - php-xml
  - php-xmlrpc
- phpMyAdmin (optional)
- SSL certificates (SSL versions only)

### RHEL 9
- Apache (httpd)
- MariaDB Server
- PHP and common extensions:
  - php-mysqlnd
  - php-cli
  - php-curl
  - php-gd
  - php-mbstring
  - php-xml
  - php-xmlrpc
- phpMyAdmin (optional)
- SSL certificates (SSL versions only)
- EPEL repository

## Security Features

- 🔒 Self-signed SSL certificates for HTTPS
- 🔐 Secure MySQL/MariaDB configuration
- 🗑️ Removal of anonymous users and test databases
- 📁 Proper file permissions for SSL certificates
- 🔑 Secure root password setup

## Troubleshooting

### Common Issues

1. **Permission Denied**
   - Ensure you're running the script with sudo
   - Check file permissions: `chmod +x install_lamp_*.sh`

2. **Package Installation Fails**
   - Check internet connection
   - Update system packages first
   - For RHEL, ensure EPEL repository is available

3. **SSL Certificate Issues**
   - Verify domain name matches SSL certificate
   - Check certificate file permissions
   - Ensure Apache SSL module is enabled

### Logs

- Apache logs: `/var/log/apache2/` (Ubuntu) or `/var/log/httpd/` (RHEL)
- MySQL logs: `/var/log/mysql/` (Ubuntu) or `/var/log/mariadb/` (RHEL)
- PHP logs: `/var/log/php/` (if configured)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
