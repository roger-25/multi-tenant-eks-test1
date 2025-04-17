# Use the official Nginx image as the base
FROM nginx:alpine

# Copy your index.html to the default Nginx directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]