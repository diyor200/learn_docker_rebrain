# docker in docker 
1. historical: docker run --privileged -d docker:dind
2. safe: docker run -ti -v /var/run/docker.sock:/var/run/docker.sock docker sh