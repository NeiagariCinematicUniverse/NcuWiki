USE NCU_BDD;

DROP TABLE Participe;
/*Relation ternaire entre Roles, Tueries et Personnages*/
CREATE TABLE  IF NOT EXISTS Participe (
    personnage SMALLINT UNSIGNED ,
    role_attribue TINYINT UNSIGNED ,
    tuerie TINYINT UNSIGNED,
    
    CONSTRAINT FK_personnage FOREIGN KEY (personnage) REFERENCES Personnages(id_personnage),
    CONSTRAINT FK_role_attribue FOREIGN KEY(role_attribue) REFERENCES Roles(id_role),
    CONSTRAINT FK_tuerie FOREIGN KEY (tuerie) REFERENCES Tueries(id_tuerie),
    CONSTRAINT PK_participe PRIMARY KEY(personnage, role_attribue, tuerie)
);