# copy the env sample
cp .env.sample .env

# update the env file with values.

# build docker image.
docker build . -t todo-app:v1

# execute the compose file.
docker-compose up -d

