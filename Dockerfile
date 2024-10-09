# Use an official Node runtime as the base image
FROM node:20-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy project files into the docker image
COPY . .


EXPOSE 4173 

CMD ["npm", "run", "dev", "--host"]
