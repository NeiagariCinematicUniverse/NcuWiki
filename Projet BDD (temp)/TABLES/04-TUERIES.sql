USE NCU_BDD;

DROP TABLE Tueries;

CREATE TABLE IF NOT EXISTS Tueries(
    id_tuerie SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(40) NOT NULL,
    code VARCHAR(6) NOT NULL, -- Ex : SS pour Sacrement Sépulcral
    annee INT(4) NOT NULL

);
