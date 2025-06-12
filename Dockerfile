# Use Node.js to serve the admin interface
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application files
COPY . .

# Expose port
EXPOSE 8080

# Start the server
CMD ["node", "server.js"] 