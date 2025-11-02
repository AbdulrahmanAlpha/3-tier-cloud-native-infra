FROM postgres:15-alpine

ENV POSTGRES_DB=appdb
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin123

COPY init.sql /docker-entrypoint-initdb.d/
