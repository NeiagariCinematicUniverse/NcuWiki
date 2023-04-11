CREATE DATABASE IF NOT EXISTS NCU_BDD;
USE NCU_BDD;
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
