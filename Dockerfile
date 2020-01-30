FROM node:13.7
# Create app directory
WORKDIR /app

# Copy app source code
COPY . /app

# Install app dependencies
RUN npm install
RUN npm install -g newman

#Expose port and start application
EXPOSE 8080
