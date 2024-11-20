# create the separate network for this application.
docker network create todo-network

# create the postgres container and pass the variable value.
docker run --name postgres --network todo-network -e POSTGRES_USER=todo -e POSTGRES_PASSWORD=todo123 -e POSTGRES_DB=mytodo -p 5432:5432 -d postgres

# login to the container
docker exec -it postgres bash

# execute the following commands inside the postgres container.
PGPASSWORD='todo123' psql -h 127.0.0.1 -U todo -d mytodo -c "

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    goal_name VARCHAR(255) NOT NULL
);
"
exit

# build docker image.
docker build . -t todo-app:v1

# create the todo app container and connect it to the postgres database.
docker run --name todoApp --network todo-network -e DB_USERNAME=todo -e DB_PASSWORD=todo123 -e DB_NAME=mytodo -e DB_HOST=postgres -e DB_PORT=5432 -p 8081:8080 -d todo-app:v1

