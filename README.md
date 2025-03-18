# commands
get random number in terminal: `shuf -i 1-10 -n 1`

# run container:
`docker run -d --name rbm-dkr-$(shuf -i 1-10 -n 1)  nginx:stable`

# delete all containers
`docker rm $(docker ps -aq)`