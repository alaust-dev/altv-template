FROM node:lts-bullseye as build

WORKDIR /server
COPY . .

RUN npm i && npm run update && npm run build

RUN chmod +x altv-server

FROM ubuntu:latest
USER root

COPY --from=build /server /server

WORKDIR /server
RUN apt update && apt install libatomic1
ENTRYPOINT ["/server/altv-server"]