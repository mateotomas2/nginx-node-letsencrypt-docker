#!/bin/bash

# Reload nginx every 6 hours so let's encrypt renew the certificate
while :; 
do sleep 6h; 
    nginx -s reload; 
done & exec nginx -g "daemon off;"

# Start nginx in foreground
nginx
