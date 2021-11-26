# What's this?

A docker container to create a nodejs server with a nginx server and letsencrypt certificate.

# How to use

First of all create a .env file from the base sample and modify with your data. I recommend issue the certificate first with LETSENCRYPT_STAGING=1 and later change it to LETSENCRYPT_STAGING=0 to avoid hitting rate limits.

```
cp .env.example .env
```

Then issue a self signed certificate for the domain you need (Could be localhost)

```
./selfcertificate.sh
```

To issue a letsencrypt certificate you can use:

```
selfcertificate.sh
```

## Nodejs

Clone your project inside a nodejs folder.
You should run "npm install" by yourself. Recommended to do it from inside the container.
The container will run "npm start" at the begining.
You can access directly using the port 8080.
