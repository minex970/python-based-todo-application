-- create the goals table.
CREATE TABLE IF NOT EXISTS goals (
    id SERIAL PRIMARY KEY,
    goal_name VARCHAR(255) NOT NULL
);

