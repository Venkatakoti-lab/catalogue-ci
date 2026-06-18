FROM node:20-alpine3.22 AS builder
WORKDIR /opt/server
COPY package.json .
COPY *.js .
RUN npm install

FROM node:20-alpine3.22
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
WORKDIR /opt/server
# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
COPY --from=builder /opt/server /opt/server
RUN chown -R roboshop:roboshop /opt/server
ENV MONGO=true \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
USER roboshop
CMD ["node", "server.js"]