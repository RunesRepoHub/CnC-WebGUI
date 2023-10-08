FROM node:14.17.0-alpine
WORKDIR /app
ADD package*.json ./
RUN npm install
RUN npm install express mysql mysql2 body-parser
ADD index.js ./
EXPOSE 3000
CMD [ "node", "index.js"]