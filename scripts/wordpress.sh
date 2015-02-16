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
# Could it be deleted:
# mv public/wp-config-sample.php public/wp-config.php

# In public/index.php, modify the following line:
# require( dirname( __FILE__ ) . '/wp-blog-header.php' );
# With:
# require( dirname( __FILE__ ) . '/wp/wp-blog-header.php' );

# Now we need to set a few additional constants for the configuration.
# define('WP_CONTENT_DIR', __DIR__ . '/wp-content');
# define('WP_CONTENT_URL', 'http://' . $_SERVER['SERVER_NAME'] . '/wp-content');
# define('WP_SITEURL', 'http://' . $_SERVER['SERVER_NAME'] . '/wp');
# define('WP_HOME', 'http://' . $_SERVER['SERVER_NAME']);

# Database
mysql -u root -proot -e "drop database if exists wordpress";
mysql -u root -proot -e "create database wordpress";

# WP CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
