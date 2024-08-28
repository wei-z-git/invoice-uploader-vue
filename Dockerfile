FROM node:20
COPY ./ /app
WORKDIR /app
RUN npm install && npm run build

FROM nginx:1.27
RUN mkdir /app
COPY --from=0 /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf