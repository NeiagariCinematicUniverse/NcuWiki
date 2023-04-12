USE NCU_BDD;

DELETE FROM Langues;

INSERT INTO Langues (code, libelle) VALUES
    ("FR", "Français"),
    ("EN", "Englais"),
    ("DE", "Allemand"),
    ("LA", "Latin"),
    ("ES", "Espagnol"),
    ("", "Mandarin"),
    ("JA", "Japonais"),
    ("", "Coréen"),
    ("", "Esperanto"),
    ("", "Hongrois"),
    ("", "Polonais"),
    ("", "Portugais"),
    ("", "Suédois"),
    ("", "Afrikaans"),
    ("", "Zoulou"),
    ("", "Finlandais"),
    ("", "Russe"),
    ("", "Arabe"),
    ("", "Hindi"),
    ("", "Bengali"),
    ("", "Tégoulou"),
    ("", "Santali"),
    ("", "Indonésien"),
    ("", "Ukrainien"),
    ("","Tahitien"),
    ("IT", "Italien"),
    ("", "Breton"),
    ("", "Danois"),
    ("", "Cantonais"),
    ("", "Créole"),
    ("", "Lingala")
    -- TODO : ajouter les langues suivantes  + compléter les codes iso
;