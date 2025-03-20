# deleting images
1. docker rmi — команда удаляет один или несколько образов
2. docker system prune — команда позволяет удалить в системе все неиспользуемые объекты: контейнеры, образы, Volumes и прочие сущности
3. Есть также отдельные команды для чистки только образов, контейнеров, томов или сетей, это:
   docker image prune, docker container prune, docker volume prune и docker network prune