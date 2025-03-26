# Construcción
FROM node:16-alpine as build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . ./
RUN npm run build

# Producción
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
# configuración personalizada de nginx por si las moscas
# COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]