# Gunakan image web server ringan
FROM nginx:alpine

# Hapus default file nginx dan ganti dengan hasil build Flutter
RUN rm -rf /usr/share/nginx/html/*

# Copy hasil build Flutter Web ke direktori nginx
COPY build/web /usr/share/nginx/html

# Expose port 80 agar bisa diakses dari luar
EXPOSE 80

# Jalankan nginx
CMD ["nginx", "-g", "daemon off;"]
