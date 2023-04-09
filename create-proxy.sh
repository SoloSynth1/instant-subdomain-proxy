#!/bin/bash

SUBDOMAIN=$1
SERVICE_URI=$2
SITE_AVAIL=/etc/nginx/sites-available/$SUBDOMAIN
SITE_ENABLED=/etc/nginx/sites-enabled/$SUBDOMAIN

sudo su;

# install nginx and stop
apt update && apt install nginx -y && service stop nginx;

# install snapd and core
apt install snapd && snap install core && sudo snap refresh core;

# install letsencrypt certbot : (check here for other distros : https://certbot.eff.org/lets-encrypt/ubuntufocal-nginx)
snap install --classic certbot;
ln -s /snap/bin/certbot /usr/bin/certbot;

# create nginx conf
touch $SITE_AVAIL;
ln -s $SITE_AVAIL $SITE_ENABLED;
cat reverse-proxy-template > $SITE_AVAIL;
sed -i "s/{{subdomain}}/$SUBDOMAIN/g" $SITE_AVAIL;
sed -i "s/{{service-uri}}/$SERVICE_URI/g" $SITE_AVAIL;

# certbot
certbot --nginx -d $SUBDOMAIN;