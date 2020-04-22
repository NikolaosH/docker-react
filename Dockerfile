#Tag this specific phase
#This means that anything after this command is tag under the builder phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
#Note that the volume section is not needed since we will never change our code in a Prod Env.
RUN npm run build

#by just putting a second FROM statement is terminating the previous phase
FROM nginx
COPY --from=builder /app/build  /usr/share/nginx/html
#By default the nginx starts itself so no need to do anyhthing else.