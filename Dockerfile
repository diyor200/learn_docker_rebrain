# not optizmed
FROM ubuntu:20.04

ENV testenv1=env1
# создадим пользователя
RUN groupadd --gid 2000 user && useradd --uid 2000 --gid 2000 --shell /bin/bash --create-home user

# посмотрим состояние кеша apt до установки nginx
RUN ls -lah /var/lib/apt/lists/
RUN apt-get update -y && apt-get install nginx -y && rm -rf /var/lib/apt/lists/*

# Повторно проверим состояние кеша apt
RUN ls -lah /var/lib/apt/lists

# Очистим кеш
RUN rm -rf /var/lib/apt/lists/*
RUN ls -lah /var/lib/apt/lists/

# Скопируем наш тестовый файл
COPY testfile .

# Сменим права
RUN chown user:user testfile
USER user

CMD ["sleep infinity"]

# optizmed(because every directive(command: RUN or COPY) creates new layer and this increase
