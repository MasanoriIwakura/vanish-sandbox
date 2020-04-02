ARG NODE_IMAGE=node:12.16.1-alpine3.11

FROM ${NODE_IMAGE}

WORKDIR /app

COPY . ./

RUN yarn install --production && yarn build

CMD ["yarn", "start"]
