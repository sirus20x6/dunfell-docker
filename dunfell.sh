#!/bash


docker-compose up --build
docker-compose up -d
docker exec -it docker-dunfell /bin/bash
