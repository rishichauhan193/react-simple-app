# Use official Node.js base image
FROM node:18-alpine as build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy app files and build
COPY . .
RUN npm run build

# Use Nginx to serve static build
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose port and run
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
