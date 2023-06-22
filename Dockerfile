FROM node:14-alpine AS build-step

WORKDIR /app

COPY package.json /app/

RUN npm install

COPY . /app

RUN ls -la && npm run build

#-------------------------------------------
FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html

COPY --from=build-step /app/build/ ./

CMD ["nginx", "-g", "daemon off;"]
