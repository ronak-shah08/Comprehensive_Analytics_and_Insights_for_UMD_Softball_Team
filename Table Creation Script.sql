USE BUDT703_Project_0507_04 

DROP TABLE IF EXISTS Play
DROP TABLE IF EXISTS Record;
DROP TABLE IF EXISTS Score;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Date;
DROP TABLE IF EXISTS Opponent;

CREATE TABLE Opponent (
 oppId CHAR(5) NOT NULL,
 oppName VARCHAR(100),
 CONSTRAINT pk_Opponent_oppId PRIMARY KEY(oppId)
)

CREATE TABLE Date (
 dteId CHAR(5) NOT NULL,
 dteMatchDate Date,
 CONSTRAINT pk_Date_dteId PRIMARY KEY(dteId)
)

CREATE TABLE Location  (
 locId CHAR(5) NOT NULL,
 locCity VARCHAR(50),
 locState VARCHAR(50),
 CONSTRAINT pk_Location_locId PRIMARY KEY(locId)
)

CREATE TABLE Score (
 scrId CHAR(5) NOT NULL,
 scrUMD int,
 scrOpp int,
 CONSTRAINT pk_Score_scrId PRIMARY KEY(scrId)
)


CREATE TABLE Record (
 oppId CHAR(5) NOT NULL,
 dteId CHAR(5) NOT NULL,
 scrId CHAR(5) NOT NULL,
 CONSTRAINT pk_Record_oppId_dteId_scrId PRIMARY KEY(oppId, dteId,scrId),
 CONSTRAINT fk_Record_oppId FOREIGN KEY(oppId)
   REFERENCES [Opponent](oppId)
   ON DELETE NO ACTION ON UPDATE CASCADE,
 CONSTRAINT fk_Record_dteId FOREIGN KEY(dteId)
   REFERENCES[Date](dteId)
   ON DELETE NO ACTION ON UPDATE CASCADE,
 CONSTRAINT fk_Record_scrId FOREIGN KEY(scrId)
   REFERENCES [Score] (scrId)
   ON DELETE NO ACTION ON UPDATE CASCADE,
)

CREATE TABLE Play  (
 playId CHAR(5) NOT NULL,
 oppId CHAR(5) NOT NULL,
 locId CHAR(5) NOT NULL,
 ground VARCHAR(10),
 CONSTRAINT pk_Play_playId PRIMARY KEY(playId),
 CONSTRAINT fk_Play_oppId FOREIGN KEY(oppId)
   REFERENCES [Opponent](oppId)
   ON DELETE NO ACTION ON UPDATE CASCADE,
 CONSTRAINT fk_Play_locId FOREIGN KEY(locId)
   REFERENCES [Location](locId)
   ON DELETE NO ACTION ON UPDATE CASCADE
)

SELECT * FROM Opponent
SELECT * FROM Score
SELECT * FROM Record, DATE where Record.dteId = Date.dteId
SELECT * FROM Date
SELECT * FROM Play




