USE NCU_BDD;

DROP TABLE Victimes;
CREATE TABLE  IF NOT EXISTS Victimes (
    chapitre TINYINT UNSIGNED,
    victime SMALLINT UNSIGNED,
    maniere VARCHAR(100),
    final_bullet BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT FK_chapitre FOREIGN KEY (chapitre) REFERENCES Chapitres(id_chapitre),
    CONSTRAINT FK_victime FOREIGN KEY (victime) REFERENCES Personnages(id_personnage),
    CONSTRAINT PK_Victimes PRIMARY KEY (chapitre, victime)
);
