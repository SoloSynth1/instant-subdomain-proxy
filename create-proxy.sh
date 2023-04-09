#!/bin/bash

SUBDOMAIN=$1
SERVICE_URI=$2
SITE_AVAIL=/etc/nginx/sites-available/$SUBDOMAIN
SITE_ENABLED=/etc/nginx/sites-enabled/$SUBDOMAIN

# install nginx and stop
sudo apt update && sudo apt install nginx -y && sudo service stop nginx;

# install snapd and core
sudo apt install snapd;
sudo snap install core && sudo snap refresh core;

# install letsencrypt certbot : (check here for other distros : https://certbot.eff.org/lets-encrypt/ubuntufocal-nginx)
sudo snap install --classic certbot;
sudo ln -s /snap/bin/certbot /usr/bin/certbot;

# create nginx conf
sudo touch $SITE_AVAIL;
sudo ln -s $SITE_AVAIL $SITE_ENABLED;
sudo cat reverse-proxy-template > $SITE_AVAIL;
sudo sed -i "s/{{subdomain}}/$SUBDOMAIN/g" $SITE_AVAIL;
sudo sed -i "s/{{service-uri}}/$SERVICE_URI/g" $SITE_AVAIL;

# certbot
sudo certbot --nginx -d $SUBDOMAIN;