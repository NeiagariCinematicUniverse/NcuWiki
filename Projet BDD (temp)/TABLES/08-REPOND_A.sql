USE NCU_BDD;

DROP TABLE Repond_a;

/*Table de lien entre Pronoms et Personnages*/
CREATE TABLE  IF NOT EXISTS Repond_a (
    libelle VARCHAR(5),
    id_perso TINYINT UNSIGNED,
	
    CONSTRAINT FK_libelle FOREIGN KEY (libelle) REFERENCES Pronoms(libelle),
    CONSTRAINT FK_perso FOREIGN KEY(id_perso) REFERENCES Personnages(id_personnage),
    CONSTRAINT PK_Repond_a PRIMARY KEY(libelle, id_perso)
);