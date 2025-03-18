# commands
1. Create volume:
    `docker volume create rmb-dkr-04-volume`
2. Run command:
3. `docker run --rm 
     -p 8891:80 
     -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf
     -v rbm-dkr-04-volume:/var/log/nginx/external
     --name rbm-dkr-04 -d  nginx:stable`