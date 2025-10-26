# Gunakan image dasar Flutter
FROM cirrusci/flutter:latest as build

WORKDIR /app
COPY . .

# Build Flutter Web
RUN flutter build web

# Gunakan Nginx untuk serve hasil build
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
