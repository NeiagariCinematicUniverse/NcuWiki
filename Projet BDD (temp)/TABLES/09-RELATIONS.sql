USE NCU_BDD;

DROP TABLE Relations;


/*Relation fait le lien entre deux personnages (une relation peut être à soi-même)*/
CREATE TABLE  IF NOT EXISTS Relations(
    id_relation TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    personnage1 INT(4) NOT NULL,
    personnage2 INT(4) NOT NULL,
    nature VARCHAR(20) NOT NULL DEFAULT 'neutre', /*EX : amour, amitié, haine....*/
    canon BOOLEAN NOT NULL DEFAULT TRUE,
    ast BOOLEAN NOT NULL DEFAULT FALSE,
    prive BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT FK_personnage1 FOREIGN KEY(personnage1) REFERENCES Personnages(id_personnage),
    CONSTRAINT FK_personnage2 FOREIGN KEY(personnage2) REFERENCES Personnages(id_personnage)
);