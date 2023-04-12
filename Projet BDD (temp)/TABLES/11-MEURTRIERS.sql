USE NCU_BDD;

DROP TABLE Meurtriers;
CREATE TABLE  IF NOT EXISTS Meurtriers (
    chapitre TINYINT UNSIGNED,
    meurtrier TINYINT UNSIGNED,

    CONSTRAINT FK_chapitre FOREIGN KEY (chapitre) REFERENCES Chapitres(id_chapitre),
    CONSTRAINT FK_meurtrier FOREIGN KEY (meurtrier) REFERENCES Personnages(id_personnage),
    CONSTRAINT PK_participe PRIMARY KEY (meurtrier, chapitre)
);