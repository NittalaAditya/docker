FROM node:16-alpine as builder

#Don't ovrride root diectory files when you build the container
WORKDIR '/app'

#Use this copy to ensure that we  run npm install again if changes are only made to index.js file
COPY ./package.json .

RUN npm install
COPY . .

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
