FROM node:18.18.1-alpine
WORKDIR /app
ADD package*.json ./
RUN npm install
RUN npm install pg-promise ssh2 body-parser express
ADD index.js ./
EXPOSE 3001
CMD [ "node", "index.js"]