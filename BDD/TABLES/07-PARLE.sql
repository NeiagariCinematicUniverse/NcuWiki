USE NCU_BDD;

DROP TABLE Parle;

/*Table de lien entre Langues et Personnages*/
CREATE TABLE  IF NOT EXISTS Parle(
    code VARCHAR(5),
    id_perso SMALLINT UNSIGNED,
    niveau ENUM("débutant, confirmé, expert, natif"),
    
    CONSTRAINT FK_code FOREIGN KEY(code) REFERENCES Langues(code) NOT NULL,
    CONSTRAINT FK_perso FOREIGN KEY(id_perso) REFERENCES Personnages(id_personnage) NOT NULL,
    CONSTRAINT PK_Parle PRIMARY KEY(code, id_perso)
);