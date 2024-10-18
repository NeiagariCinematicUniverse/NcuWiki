USE NCU_BDD;

DELETE FROM Pronoms;

INSERT INTO Pronoms (libelle) VALUES
    ("il"),
    ("elle"),
    ("iel"),
    ("???"),
    ("tous"), --Transformer cela en une procédure qui génère un lien pour chaque pronom possible
    ("ael"),
    ("ul"),
    ("ol")
;