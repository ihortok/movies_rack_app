-- CREATE DATABASE movies_db;

CREATE TABLE movies (
  id serial PRIMARY KEY,
  title VARCHAR ( 100 ) NOT NULL,
  year INTEGER
);
