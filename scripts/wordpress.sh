#!/usr/bin/env bash

# Credits:
# https://davidwinter.me/install-and-manage-wordpress-with-composer/

cd /vagrant
rm -rf www/*
mkdir www/public
cp composer.json www/composer.json
cd www
composer install
cp -R public/wp/{wp-content,index.php,wp-config-sample.php} public/
rm public/wp-content/plugins/hello.php

# In public/index.php, modify the following line:
# require( dirname( __FILE__ ) . '/wp-blog-header.php' );
# With:
# require( dirname( __FILE__ ) . '/wp/wp-blog-header.php' );

# Database
mysql -u root -proot -e "drop database if exists wordpress";
mysql -u root -proot -e "create database wordpress";

# WP CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# WP config
wp core config --allow-root --path="public/wp" --dbname=wordpress --dbuser=root --dbpass=root --locale=en_US --extra-php <<PHP
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_CONTENT_DIR', __DIR__ . '/wp-content');
define('WP_CONTENT_URL', 'http://192.168.22.53.xip.io/wp-content');
define('WP_SITEURL', 'http://192.168.22.53.xip.io/wp');
define('WP_HOME', 'http://192.168.22.53.xip.io/');
PHP

mv public/wp/wp-config.php public/wp-config.php
