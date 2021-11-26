#!/bin/bash
source .env

if ! [ -x "$(command -v docker-compose)" ]; then
    echo 'Error: docker-compose is not installed.' >&2
    exit 1
fi

echo "Issue a let's encrypt for the next domain:";
read domain;

if [ -z "$domain" ]
then
    exit;
fi

rsa_key_size=4096
data_path="./data/certbot"
email=${LETSENCRYPT_EMAIL} # Adding a valid address is strongly recommended
staging=${LETSENCRYPT_STAGING} # Set to 1 if you're testing your setup to avoid hitting request limits

echo "### Starting nginx ..."
docker-compose up --force-recreate -d nginx
echo

echo "### Deleting dummy certificate for $domain ..."
docker-compose run --rm --entrypoint "\
    rm -Rf /etc/letsencrypt/live/$domain && \
    rm -Rf /etc/letsencrypt/archive/$domain && \
    rm -Rf /etc/letsencrypt/renewal/$domain.conf" certbot
echo


echo "### Requesting Let's Encrypt certificate for $domain ..."
#Join $domains to -d args
domain_args=" -d $domain"

# Select appropriate email arg
case "$email" in
    "") email_arg="--register-unsafely-without-email" ;;
    *) email_arg="--email $email" ;;
esac

# Enable staging mode if needed
if [ $staging != "0" ]; then staging_arg="--staging"; fi
echo "certbot certonly --webroot -w /var/www/certbot \
    $staging_arg \
    $email_arg \
    $domain_args \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --force-renewal"

docker-compose run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
    $staging_arg \
    $email_arg \
    $domain_args \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --force-renewal" certbot
echo
 
echo "### Reloading nginx ..."
docker-compose exec nginx nginx -s reload