# ----------------------------
# build from source
# ----------------------------
FROM node:22 AS build

WORKDIR /app

COPY package*.json .
RUN npm install
RUN npm install @angular-devkit/build-angular

COPY . .
RUN npm run build

# ----------------------------
# run with nginx
# ----------------------------
FROM nginx

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
COPY --from=build /app/dist/angular-test/browser /usr/share/nginx/html

EXPOSE 80