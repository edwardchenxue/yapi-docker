FROM node:12-alpine as builder

RUN apk add --no-cache git python3 make openssl tar gcc

RUN mkdir /yapi && cd /yapi && mkdir vendors && git clone https://github.com/YMFE/yapi.git  && mv yapi/* /yapi/vendors

RUN cd /yapi/vendors && rm package-lock.json &&  \
    npm install --production --registry https://registry.npm.taobao.org

FROM node:12-alpine

MAINTAINER Edward

ENV TZ="Asia/Shanghai" HOME="/yapi/vendors"

WORKDIR ${HOME}

COPY --from=builder /yapi/vendors /yapi/vendors

COPY --from=builder /yapi/vendors/config_example.json /yapi/config.json

COPY entrypoint.sh /bin

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
