USE NCU_BDD;

DROP TABLE Roles;


CREATE TABLE IF NOT EXISTS Roles (
    id_role TINYINT UNSIGNED PRIMARY KEY NOT NULL,
    libelle ENUM('trickster', 'survivant', 'survivant', 'monokuma', 'organisateur', 'protagoniste', 'traître') NOT NULL,
    prive BOOLEAN NOT NULL DEFAULT TRUE
);
