# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install all project dependencies
RUN npm install

# Copy the rest of your application code to the container
COPY . .

# Build the Next.js application
RUN npm run build

# Expose the port that your Next.js application will run on
EXPOSE 3000

# Start your Next.js application
CMD ["npm", "start"]
