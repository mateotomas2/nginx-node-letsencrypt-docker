# What's this?

A docker container to create a nodejs server with a nginx server and letsencrypt certificate.

# How to use

First of all create a .env file from the base sample and modify with your data

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
