# Use an official Node.js runtime as a parent image
FROM node:20.8-bookworm-slim

# Set the working directory within the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the entire project directory into the working directory
COPY . .

# Build the React application
RUN npm run build

# Expose the port the app will run on
EXPOSE 3000

# Define the command to start the application
CMD ["npm", "start"]