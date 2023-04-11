CREATE DATABASE IF NOT EXISTS NCU_BDD;
USE NCU_BDD;

DROP TABLE Parle;

/*Table de lien entre Langues et Personnages*/
CREATE TABLE  IF NOT EXISTS Parle(
    code VARCHAR(5),
    id_perso TINYINT UNSIGNED,
    
    CONSTRAINT FK_code FOREIGN KEY(code) REFERENCES Langues(code),
    CONSTRAINT FK_perso FOREIGN KEY(id_perso) REFERENCES Personnages(id_personnage),
    CONSTRAINT PK_Parle PRIMARY KEY(code, id_perso)
);