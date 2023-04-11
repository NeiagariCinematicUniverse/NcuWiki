/*
NOTE :
Les tables principales ont une majuscule en début de nom,
les tables associatives ont une minuscule
*/
USE NCU_BDD;

-------------------------------
-- Informations personnelles --
-------------------------------
CREATE TABLE IF NOT EXISTS Pronoms (
    libelle VARCHAR(5) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Langues(
    code VARCHAR(5) PRIMARY KEY, /*EX : fr, en, de...*/ 
    libelle VARCHAR(30) /*EX : français, anglais...*/
);

CREATE TABLE  IF NOT EXISTS Personnages (
    id_personnage INT(4) AUTO_INCREMENT PRIMARY KEY,
    prenom VARCHAR(25),
    prenom_s_supp VARCHAR(70),
    nom VARCHAR(40),
    ultime VARCHAR(40),
    age INT NOT NULL, /*Age pour le personnage au 1er avril de sa Tuerie / à son entrée à l'école pour les figurants */
    /* attribut pour un age pour une date donnée ? Ou vue ? */
    genre VARCHAR(70) NOT NULL,
    date_naissance DATE,
    promotion INT(2),
    nationalite VARCHAR(30),
    sexualite VARCHAR(40),
    romantisme VARCHAR(40),
    manuel BOOLEAN NOT NULL DEFAULT FALSE,
    religion VARCHAR(30),
    taille INT(3),
    polyamour ENUM('oui', 'non', 'questionning'),
    mort ENUM('oui', 'non', 'incertain')
);

/*Table de lien entre Pronoms et Personnages*/
CREATE TABLE  IF NOT EXISTS repond(
    libelle VARCHAR(5),
        FOREIGN KEY (libelle) REFERENCES Pronoms(libelle),
    id_perso INT(4),
        FOREIGN KEY(id_perso) REFERENCES Personnages(id_personnage),
    PRIMARy KEY(libelle, id_perso)
);

/*Table de lien entre Langues et Personnages*/
CREATE TABLE  IF NOT EXISTS parle(
    code VARCHAR(5),
    FOREIGN KEY (code) REFERENCES Langues(code),
    id_perso INT(4),
    FOREIGN KEY(id_perso) REFERENCES Personnages(id_personnage),
    PRIMARY KEY(libelle, id_perso)
);

------------------------------------
-- Informations interpersonnelles --
------------------------------------

/*Relation fait le lien entre deux personnages (une relation peut être à soi-même)*/
CREATE TABLE  IF NOT EXISTS Relations(
    id_relation INT(6) PRIMARY KEY AUTO_INCREMENT,
    personnage1 INT(4) NOT NULL,
        FOREIGN KEY(personnage1) REFERENCES Personnages(id_personnage),
    personnage2 INT(4) NOT NULL,
        FOREIGN KEY(personnage2) REFERENCES Personnages(id_personnage),
    nature VARCHAR(20) NOT NULL DEFAULT 'neutre', /*EX : amour, amitié, détestation....*/
    canon BOOLEAN NOT NULL DEFAULT TRUE,
    ast BOOLEAN NOT NULL DEFAULT FALSE,
    prive BOOLEAN NOT NULL DEFAULT TRUE
);

-------------------------
-- Gestion des Tueries --
-------------------------

CREATE TABLE IF NOT EXISTS Tueries(
    id_tuerie TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(40) NOT NULL,
    annee INT(4) NOT NULL
);

CREATE TABLE IF NOT EXISTS Roles (
    id_role TINYINT UNSIGNED PRIMARY KEY NOT NULL,
    libelle ENUM('trickster', 'survivant', 'survivant', 'monokuma', 'organisateur', 'protagoniste', 'traître') NOT NULL,
    prive BOOLEAN NOT NULL DEFAULT TRUE
);

/*Relation ternaire entre Roles, Tueries et Personnages*/
CREATE TABLE  IF NOT EXISTS participe (
    personnage INT(4),
        FOREIGN KEY (personnage) REFERENCES Personnages(id_personnage),
    role_attribue INT(2),
        FOREIGN KEY(role_attribue) REFERENCES Roles(id_role),
    tuerie INT(3),
        FOREIGN KEY (tuerie) REFERENCES Tueries(id_tuerie),
    PRIMARY KEY(personnage, role_attribue, tuerie)
);

CREATE TABLE  IF NOT EXISTS Chapitres (
    id_chapitre INT(4) PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(50) NOT NULL,
    prologue BOOLEAN NOT NULL DEFAULT FALSE,
    dernier BOOLEAN NOT NULL DEFAULT FALSE,
    appartient_a INT(4) NOT NULL,
        FOREIGN KEY (appartient_a) REFERENCES Tueries(id_tuerie),
    prive BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE  IF NOT EXISTS meurtriers (
    chapitre INT(4),
        FOREIGN KEY (chapitre) REFERENCES Chapitres(id_chapitre),
    meurtrier INT(4),
        FOREIGN KEY (meurtrier) REFERENCES Personnages(id_personnage),
    PRIMARY KEY (meurtrier, chapitre)
);

CREATE TABLE  IF NOT EXISTS victimes (
    chapitre INT(4),
        FOREIGN KEY (chapitre) REFERENCES Chapitres(id_chapitre),
    victime INT(4),
        FOREIGN KEY (victime) REFERENCES Personnages(id_personnage),
    maniere VARCHAR(100),
    final_bullet BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (chapitre, victime)
);
