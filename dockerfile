FROM node:12-alpine AS base
WORKDIR /usr/src/packages

COPY ./packages/common/package.json ./usr/src/packages
COPY ./packages/server/package.json ./usr/src/packages

RUN npm i

COPY packages /usr/packages

FROM node:12-alpine AS common
WORKDIR /usr/src/packages
COPY --from=base /usr/src/packages .
COPY --from=base /usr/packages/common/ ./packages/common/

FROM node:12-alpine AS server
WORKDIR /usr/src/packages
COPY --from=base /usr/src/packages .
COPY --from=base /usr/packages/server/ ./packages/server/
CMD [ "node", "." ]
