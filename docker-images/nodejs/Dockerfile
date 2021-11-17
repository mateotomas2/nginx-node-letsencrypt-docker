FROM node:12-alpine

WORKDIR /src/nodejs

RUN apk add --update \
    libc6-compat \
    git

RUN npm i -g npm@latest
RUN npm i -g typescript
RUN npm i -g ts-node
RUN npm i -g ts-node-dev

ENV NODE_ENV=production
CMD ["npm", "start"]
EXPOSE 80
