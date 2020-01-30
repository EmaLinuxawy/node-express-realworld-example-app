FROM node:13.7
# Create app directory
WORKDIR /app

# Copy app source code
COPY --chown=node:node . /app

# Install app dependencies
RUN npm install
RUN npm install -g newman

EXPOSE 3000

CMD [ "node", "app.js" ]

