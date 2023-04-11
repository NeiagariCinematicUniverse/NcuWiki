/*Les tables principales ont une majuscule en début de nom,
les tables associatives ont une minuscule*/

CREATE TABLE Pronoms IF NOT EXISTS{
    libelle VARCHAR(5) PRIMARY KEY
}

CREATE TABLE Langue IF NOT EXISTS{
    code VARCHAR(5) PRIMARY KEY, /*EX : fr, en, de...*/
    libelle VARCHAR(30) /*EX : français, anglais...*/
}

CREATE TABLE Personnages IF NOT EXISTS {
    id_personnage INT(4) AUTO_INCREMENT PRIMARY KEY,
    prenom VARCHAR(25),
    prenom_s_supp VARCHAR(70),
    nom VARCHAR(40),
    ultime VARCHAR(40),
    age INT NOT NULL, /*Age pour le personnage au 1er avril de sa Tuerie / à son entrée à l'école pour les figurants */
    /* attribut pour un age pour une date donnée ? Ou vue ? */
    genre VARCHAR(70) NOT NULL,
    date_naissance DATE,
    promotion INT(2),
    nationalite VARCHAR(30),
    sexualite VARCHAR(40),
    romantisme VARCHAR(40),
    manuel BOOLEAN NOT NULL DEFAULT FALSE,
    religion VARCHAR(30),
    taille INT(3),
    polyamour ENUM('oui', 'non', 'questionning'),
    mort ENUM('oui', 'non', 'incertain')
}

/*Table de lien entre Pronoms et Personnages*/
CREATE TABLE repond IF NOT EXISTS{
    libelle VARCHAR(5),
    FOREIGN KEY (libelle) REFERENCES Pronoms(libelle),
    id_perso INT(4),
    FOREIGN KEY(id_perso) REFERENCES Personnages(id_personnage),
    PRIMARy KEY(libelle, id_perso)
}

/*Table de lien entre Langues et Personnages*/
CREATE TABLE parle IF NOT EXISTS{
    code VARCHAR(5),
    FOREIGN KEY (code) REFERENCES Langues(code),
    id_perso INT(4),
    FOREIGN KEY(id_perso) REFERENCES Personnages(id_personnage),
    PRIMARY KEY(libelle, id_perso)
}

CREATE TABLE Relations IF NOT EXISTS{
    id_relation INT(6) PRIMARY KEY AUTO_INCREMENT,
    personnage1 INT(4) NOT NULL,
        FOREIGN KEY(personnage1) REFERENCES Personnages(id_personnage),
    personnage2 INT(4) NOT NULL,
        FOREIGN KEY(personnage2) REFERENCES Personnages(id_personnage),
    nature VARCHAR(20) NOT NULL DEFAULT 'neutre', /*EX : amour, amitié, détestation....*/
    canon BOOLEAN NOT NULL DEFAULT TRUE,
    ast BOOLEAN NOT NULL DEFAULT FALSE,
    prive BOOLEAN NOT NULL DEFAULT TRUE
}