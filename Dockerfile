FROM mcr.microsoft.com/mssql/server:2019-latest
ENV SA_PASSWORD=yourStrong#Password
ENV ACCEPT_EULA=Y

USER root
COPY AdventureWorks2019.bak /var/opt/mssql/backup/
COPY restore-database.sh /usr/src/app/restore-database.sh
RUN chmod +x /usr/src/app/restore-database.sh

RUN apt-get update && apt-get install -y wget unzip \
    && wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz \
    && tar -xvzf ngrok-v3-stable-linux-amd64.tgz \
    && mv ngrok /usr/local/bin \
    && rm ngrok-v3-stable-linux-amd64.tgz \
    && apt-get clean

RUN mkdir -p /root/.ngrok2 \
    && echo "version: '2'\nauthtoken: <token>" > /root/.ngrok2/ngrok.yml

EXPOSE 1443 4040
COPY entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]