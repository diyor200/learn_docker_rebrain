# logging

## json log driver
`docker run -d --name web --log-driver json-file -p 8080:80 nginx:stable`

change log driver to local(by default it will be json-log driver)
1. add following code to  /etc/docker/daemon.json:
   `"log-driver": "local",
   "log-opts": {,
   "max-size":"10m"
    }`
2. create first container with: `docker run -p 8892:80 --name rbm-dkr-06-local  nginx:stable`
3. 
