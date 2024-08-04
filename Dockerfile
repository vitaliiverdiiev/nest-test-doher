FROM node:lts-alpine as build

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn

COPY . .

# Build
RUN yarn build

### Build production image

FROM node:lts-alpine as prod

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/package.json ./
COPY --from=build /usr/src/app/yarn.lock ./

EXPOSE 3000

RUN yarn install --frozen-lockfile --production

CMD ["node", "dist/main"]
