FROM node:18.19-alpine
WORKDIR /app
ADD package*.json ./
RUN npm install
RUN npm install express body-parser pg
ADD index.js ./
EXPOSE 3000
CMD [ "node", "index.js"]