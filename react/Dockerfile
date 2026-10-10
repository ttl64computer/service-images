# syntax=docker/dockerfile:1
FROM node:24.21.0-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM ghcr.io/ttl64computer/nginx:1.31@sha256:84cf932f4fb208a58f20f8f6652495dc96028eed64121d3ea0991b633bf2ad75

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="React (Vite) starter for ttl64 clusters, served by the ttl64 nginx" \
      org.opencontainers.image.licenses="MIT"

COPY spa.conf /etc/nginx/conf.d/default.conf
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/dist /usr/share/nginx/html
