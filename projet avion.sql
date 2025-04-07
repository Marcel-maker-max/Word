-- SQLite
PRAGMA foreign_key= ON;

DROP TABLE IF EXISTS avion;
DROP TABLE IF EXISTS pilote;
DROP TABLE IF EXISTS vol;
DROP TABLE IF EXISTS avion_pilote_vol;


CREATE TABLE avion (
    numero_avion INTEGER PRIMARY KEY NOT NULL,
    nom_avion TEXT(12),
    capacite_avion INTEGER,
    ville TEXT(10)
);

CREATE TABLE pilote(
    numero_pilote TEXT(6) PRIMARY KEY NOT NULL ,
    nom_pilote TEXT(25),
    adresse TEXT(40)
);

CREATE TABLE vol(
    numero_vol INTEGER PRIMARY KEY NOT NULL,
    numero_avion INTEGER NOT NULL,
    numero_pilote INTEGER NOT NULL,
    ville_depart TEXT(10),
    ville_arivée TEXT(10),
    FOREIGN KEY (numero_avion) REFERENCES avion(numero_avion),
    FOREIGN KEY (numero_pilote) REFERENCES pilote(numero_pilote)
);

CREATE TABLE avion_pilote_vol(
    numero_avion INTGER NOT NULL,
    numero_pilote INTEGER NOT NULL,
    numero_vol INTEGER NOT NULL,
    FOREIGN KEY(numero_avion) REFERENCES avion(numero_avion),
    FOREIGN KEY(numero_pilote) REFERENCES pilote(numero_pilote),
    FOREIGN KEY(numero_vol) REFERENCES avion(numero_vol),
    PRIMARY KEY(numero_avion, numero_pilote, numero_vol),
    UNIQUE (numero_avion, numero_pilote, numero_vol)
);

INSERT INTO avion(numero_avion, nom_avion, capacite_avion, ville) VALUES
    (100, 'AIRBUS', 300, 'RABAT'),
    (101, 'B737', 250, 'CASA'),
    (102, 'B737', 220, 'RABAT');

INSERT INTO pilote(numero_pilote, nom_pilote, adresse) VALUES
    ( 552, 'jack sparrow' , 'jack@.fr'),
    (587,'dubois charles' , 'dubois@.com');

INSERT INTO vol(numero_vol, numero_avion, numero_pilote, ville_arivée, ville_depart) VALUES
    ('IT100', 100, 552, 'CASA'),
    ('IT104', 101, 587, 'RABAT');


SELECT *
FROM avion
ORDER BY nom_avion ASC;

SELECT nom_avion, capacite_avion
FROM avion;

SELECT DISTINCT ville
FROM avion;

SELECT *
FROM avion
WHERE ville = 'RABAT' OR 'CASA';

UPDATE avion
SET capacite_avion = 220
WHERE numero_avion= 101;

DELETE FROM avion 
WHERE capacite_avion < 200;

SELECT numero_avion,
    MAX(capacite_avion) AS max_capacite,
    MIN(capacite_avion) AS min_capacite,
    AVG(capacite_avion) AS moyenne_capacite
FROM avion
GROUP BY numero_avion;

SELECT *
FROM avion
ORDER BY capacite_avion ASC
LIMIT 1;

SELECT numero_avion,
    AVG(capacite_avion) 
FROM avion
WHERE capacite_avion > AVG(capacite_avion) 
GROUP BY numero_avion;

SELECT pilote.nom_pilote, pilote.adresse
FROM vol
INNER JOIN pilote ON vol.numero_pilote = pilote.numero_pilote;

SELECT numero_pilote
FROM pilote;

SELECT pilote.nom_pilote, pilote.adresse
FROM vol
INNER JOIN pilote ON vol.numero_pilote = pilote.numero_pilote
INNER JOIN avion ON vol.numero_avion = avion.numero_avion
WHERE avion.nom_avion = 'AIRBUS';


