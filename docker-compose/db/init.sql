CREATE TABLE IF NOT EXISTS votes (
    id SERIAL PRIMARY KEY,
    flower_name VARCHAR(50),
    votes INT DEFAULT 0
);

INSERT INTO votes (flower_name, votes) VALUES ('Rose', 5), ('Tulip', 3);
