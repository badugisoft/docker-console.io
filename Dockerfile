ARG NODE_VERSION

FROM node:$NODE_VERSION

ARG CONSOLEIO_VERSION
ARG APP_PATH=/app

RUN apk add --no-cache git &&\
    git clone https://github.com/nkashyap/console.io.git $APP_PATH &&\
    cd $APP_PATH &&\
    git checkout tags/v$CONSOLEIO_VERSION &&\
    npm install --production -q &&\
    npm run express.io -q &&\
    npm run express -q &&\
    npm cache clean --force &&\
    rm -rf .git &&\
    apk del git

EXPOSE 8082

WORKDIR /app

CMD [ "node", "server/main.js" ]
