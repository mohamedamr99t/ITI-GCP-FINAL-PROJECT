FROM node:21-alpine3.17 
# Create app directory
RUN apk add git
RUN git clone https://github.com/Mostafa-Yehia/simple-node-app.git /app
WORKDIR /app
# Install app dependencies
RUN npm i
# Expose the port the app will run on
EXPOSE 3000 
# Start Node.js application
ENTRYPOINT [ "node","index.js" ]
