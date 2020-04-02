ARG NODE_IMAGE=node:12.16.1-alpine3.11

FROM ${NODE_IMAGE} as build

WORKDIR /app

COPY . ./

RUN yarn install --production && yarn build

##########################
# app image
##########################
FROM ${NODE_IMAGE} as app

WORKDIR /app

COPY --from=build /app/package.json /app/yarn.lock ./
RUN yarn install --pure-lockfile --production
COPY --from=build /app/.nuxt/dist/server ./server
COPY --from=build /app/.nuxt/dist/client ./client

CMD ["yarn", "start"]
