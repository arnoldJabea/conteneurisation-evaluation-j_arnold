-- Crée les bases de données si elles n'existent pas
CREATE DATABASE IF NOT EXISTS docker_doc;
CREATE DATABASE IF NOT EXISTS docker_doc_dev;

-- Structure de la table article dans les deux bases
USE docker_doc;

CREATE TABLE IF NOT EXISTS article (
    id BIGINT PRIMARY KEY,
    title VARCHAR(32),
    body TEXT
);

USE docker_doc_dev;

CREATE TABLE IF NOT EXISTS article (
    id BIGINT PRIMARY KEY,
    title VARCHAR(32),
    body TEXT
);

-- Insertion de données de test dans docker_doc_dev
INSERT INTO article (id, title, body) VALUES
(1, 'Docker overview', 'Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly'),
(2, 'What is a container?', 'Imagine you’re developing a killer web app that has three main components - a React frontend, a Python API, and a PostgreSQL database. If you wanted to work on this project, you’d have to install Node, Python, and PostgreSQL.');
