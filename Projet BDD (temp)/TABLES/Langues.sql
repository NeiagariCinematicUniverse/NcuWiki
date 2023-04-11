CREATE DATABASE IF NOT EXISTS NCU_BDD;
USE NCU_BDD;

DROP TABLE Langues;

CREATE TABLE IF NOT EXISTS Langues(
    code VARCHAR(5) PRIMARY KEY, /*EX : fr, en, de...*/ 
    libelle VARCHAR(30) /*EX : français, anglais...*/
);