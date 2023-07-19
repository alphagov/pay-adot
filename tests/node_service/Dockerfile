FROM node:20-alpine

RUN apk add --no-cache tini

WORKDIR /app

COPY package*.json ./
RUN npm ci --no-progress --omit=dev

COPY ./index.mjs index.mjs

EXPOSE 3000

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["node", "index.mjs"]
