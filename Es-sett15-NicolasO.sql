IF DB_ID ('Gestionale_Polizia') IS NULL 
CREATE DATABASE Gestionale_Polizia

USE Gestionale_Polizia 

CREATE TABLE Anagrafica (
angrafica_id INT PRIMARY KEY,
Cognome NVARCHAR(50) NOT NULL,
Nome NVARCHAR(50) NOT NULL,
Indirizzo NVARCHAR(100) NOT NULL,
Città VARCHAR(50) NOT NULL,
CAP CHAR(5) NOT NULL,
Cod_Fisc CHAR(16) UNIQUE NOT NULL
);

CREATE TABLE Tipo_Violazione (
violazione_id INT PRIMARY KEY,
Descrizione VARCHAR(255) NOT NULL
);

CREATE TABLE Verbale (
verbale_id INT PRIMARY KEY,
DataViolazione DATE NOT NULL,
IndirizzoViolazione VARCHAR(100) NOT NULL,
Nominativo_Agente VARCHAR(100) NOT NULL,
DataTrascrizioneVerbale DATE NOT NULL,
Importo DECIMAL(10,2) NOT NULL,
DecurtamentoPunti INT NOT NULL,
anagrafica_id INT NOT NULL,
violazione_id INT NOT NULL,
CONSTRAINT FK_ID_ANAGRAFICA FOREIGN KEY (anagrafica_id) REFERENCES ANAGRAFICA(angrafica_id),
CONSTRAINT FK_ID_VIOLAZIONE FOREIGN KEY (violazione_id) REFERENCES TIPO_VIOLAZIONE(violazione_id)
);

INSERT INTO Anagrafica VALUES
(1, 'Rossi', 'Mario', 'Via Roma 1', 'Palermo', '90100', 'RSSMRA80A01H501H'),
(2, 'Bianchi', 'Luca', 'Via Milano 2', 'Milano', '20100', 'BCNLCA75B02F205K'),
(3, 'Verdi', 'Anna', 'Via Torino 3', 'Palermo', '90101', 'VRDNNN85C03L219T'),
(4, 'Esposito', 'Giulia', 'Corso Umberto 15', 'Napoli', '80100', 'SPSGLA90D45F839Z'),
(5, 'Romano', 'Francesco', 'Via Appia 7', 'Roma', '00100', 'RMNFRC70E12H501R'),
(6, 'Conti', 'Sara', 'Piazza Dante 22', 'Palermo', '90102', 'CNTSRA88M52G702S'),
(7, 'Russo', 'Marco', 'Viale Europa 18', 'Catania', '95100', 'RSSMRC85P08D969L'),
(8, 'Ferrari', 'Laura', 'Largo Colombo 5', 'Milano', '20121', 'FRRLRA78A41F205T');

INSERT INTO Tipo_Violazione VALUES
(1, 'Eccesso di velocità (oltre 20 km/h)'),
(2, 'Guida senza cintura di sicurezza'),
(3, 'Sosta vietata in zona ZTL'),
(4, 'Uso del telefono alla guida'),
(5, 'Guida in stato di ebbrezza')

INSERT INTO Verbale VALUES
(1, '2009-03-15', 'Via Palermo 10', 'Gianluca Fanti', '2009-03-20', 173.00, 5, 1, 1),
(2, '2009-05-20', 'Via Milano 5', 'Maria Lusardi', '2009-05-25', 87.50, 2, 2, 2),
(3, '2009-02-10', 'Via Roma 7', 'Gianluca Fanti', '2009-02-15', 420.00, 6, 1, 3),
(4, '2009-06-01', 'Via Torino 3', 'Laura Neri', '2009-06-05', 850.00, 10, 3, 5),
(5, '2010-08-12', 'Corso Vittorio Emanuele', 'Giovanni Riva', '2010-08-15', 210.00, 3, 4, 4),
(6, '2011-03-22', 'Via Etnea 45', 'Salvatore Marino', '2011-03-25', 550.00, 8, 7, 1),
(7, '2009-07-30', 'Piazza Castello', 'Luigi Colombo', '2009-08-02', 350.00, 4, 5, 1),
(8, '2012-11-15', 'Viale Regina Margherita', 'Anna Galli', '2012-11-18', 680.00, 12, 6, 5),
(9, '2009-04-18', 'Via Libertà 33', 'Gianluca Fanti', '2009-04-20', 170.00, 5, 8, 1),
(10, '2013-09-05', 'Corso Buenos Aires', 'Marta Brambilla', '2013-09-10', 93.00, 2, 2, 4);


select * from Tipo_Violazione

select * from Anagrafica

select * from Verbale

SELECT COUNT(*) AS TotaleVerbali FROM Verbale;

SELECT a.Cognome, a.Nome, COUNT(v.verbale_id) AS NumVerbali
FROM Anagrafica a
JOIN Verbale v ON a.angrafica_id = v.anagrafica_id
GROUP BY a.angrafica_id, a.Cognome, a.Nome;

SELECT tv.descrizione, COUNT(v.verbale_id) AS NumVerbali
FROM Tipo_Violazione tv
JOIN Verbale v ON tv.violazione_id = v.violazione_id
GROUP BY tv.violazione_id, tv.descrizione;

SELECT a.Cognome, a.Nome, SUM(v.DecurtamentoPunti) AS TotalePuntiDec
FROM Anagrafica a
JOIN Verbale v ON a.angrafica_id = v.anagrafica_id
GROUP BY a.angrafica_id, a.Cognome, a.Nome;

SELECT a.Cognome, a.Nome, v.DataViolazione, v.IndirizzoViolazione, v.Importo, v.DecurtamentoPunti
FROM Anagrafica a
JOIN Verbale v ON a.angrafica_id = v.anagrafica_id
WHERE a.Città = 'Palermo';

SELECT a.Cognome, a.Nome, a.Indirizzo, v.DataViolazione, v.Importo, v.DecurtamentoPunti
FROM Anagrafica a
JOIN Verbale v ON a.angrafica_id = v.anagrafica_id
WHERE v.DataViolazione BETWEEN '2009-02-01' AND '2009-07-31';

SELECT a.Cognome, a.Nome, SUM(v.Importo) AS TotaleImporto
FROM Anagrafica a
JOIN Verbale v ON a.angrafica_id = v.anagrafica_id
GROUP BY a.angrafica_id, a.Cognome, a.Nome;

SELECT Cognome, Nome, Indirizzo, Città, CAP
FROM Anagrafica
WHERE Città = 'Palermo';

SELECT DataViolazione, Importo, DecurtamentoPunti
FROM Verbale
WHERE DataViolazione = '2009-03-15';


