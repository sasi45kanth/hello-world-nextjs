# Stage 1: Build the Next.js application
FROM node:14 as builder

WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application source code to the container
COPY . .

# Modify the package.json to prevent SSR issues (if not already done)
RUN sed -i 's/"next build": "next build",/"next build": "next build && touch .next/__build_finished__",/' package.json

# Build the Next.js application
RUN npm run build

# Stage 2: Create the final lightweight image for runtime
FROM node:14

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/package-lock.json ./package-lock.json
COPY --from=builder /app/node_modules ./node_modules

# Expose the port that the Next.js app will run on (if needed)
# EXPOSE 3000

# Start the Next.js application in production mode
CMD ["npm", "start"]
