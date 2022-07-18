FROM node:16-alpine AS builder

WORKDIR /app

COPY . .
RUN yarn install --pure-lockfile
RUN yarn run build

FROM builder as development

WORKDIR /app

CMD [ "yarn", "run", "start:dev" ]

FROM node:16-alpine AS production

WORKDIR /app

COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/yarn.lock ./yarn.lock
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

RUN yarn install --production

CMD [ "yarn", "run", "start:prod" ]