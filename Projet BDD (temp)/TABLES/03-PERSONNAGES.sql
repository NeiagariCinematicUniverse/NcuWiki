USE NCU_BDD;

DROP TABLE Personnages;

CREATE TABLE  IF NOT EXISTS Personnages (
    id_personnage TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    prenom VARCHAR(25),
    prenom_s_supp VARCHAR(70),
    nom VARCHAR(40),
    ultime VARCHAR(40),
    age TINYINT NOT NULL, /*Age pour le personnage au 1er avril de sa Tuerie / à son entrée à l'école pour les figurants */
						/* attribut pour un age pour une date donnée ? Ou vue ? */
    genre VARCHAR(70) NOT NULL,
    date_naissance DATE, /*EX pour passer en DD/MM/YYYY : SELECT DATE_FORMAT(column_name, '%d/%m/%Y') FROM tablename*/
    promotion TINYINT UNSIGNED,
    nationalite VARCHAR(30),
    sexualite VARCHAR(40),
    romantisme VARCHAR(40),
    manuel BOOLEAN NOT NULL DEFAULT FALSE,
    religion VARCHAR(30),
    taille TINYINT UNSIGNED,
    polyamour ENUM('oui', 'non', 'questionning'),
    mort ENUM('oui', 'non', 'incertain')
);