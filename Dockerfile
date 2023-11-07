# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application source code to the container
COPY . .

# Build the Next.js application
RUN npm run build

# Expose the port that the Next.js app will run on
EXPOSE 3000

# Start the Next.js application
CMD ["npm", "start"]
