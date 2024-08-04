ARG IMAGE=node:21-alpine

#COMMON
FROM $IMAGE as builder
WORKDIR /app
COPY . .
RUN npm i

#DEVELOPMENT
FROM builder as dev
CMD [""]

#PROD MIDDLE STEP
FROM builder as prod-build
RUN npm run build
RUN npm prune --production

#PROD
FROM $IMAGE as prod
COPY --chown=node:node --from=prod-build /app/dist /app/dist
COPY --chown=node:node --from=prod-build /app/node_modules /app/node_modules
COPY --chown=node:node --from=prod-build /app/.env /app/dist/.env

ENV NODE_ENV=production
ENTRYPOINT ["node", "./main.js"]
WORKDIR /app/dist
CMD [""]

USER node

# FROM node:lts-alpine as build

# WORKDIR /usr/src/app

# COPY package.json yarn.lock ./

# RUN yarn

# COPY . .

# # Build
# RUN yarn build

# ### Build production image

# FROM node:lts-alpine as prod

# WORKDIR /usr/src/app

# COPY --from=build /usr/src/app/dist ./dist
# COPY --from=build /usr/src/app/package.json ./
# COPY --from=build /usr/src/app/yarn.lock ./

# EXPOSE 3000

# RUN yarn install --frozen-lockfile --production

# CMD ["node", "dist/main"]
