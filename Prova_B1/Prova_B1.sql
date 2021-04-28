


USE PRONTUARIO
GO



SELECT LEFT('abcdefg', 2)



CREATE TABLE CLINICA.SALES
(
	 TEMPID INT NOT NULL
	,SALESREASONID INT NOT NULL
	,CONSTRAINT PK_SALESREASONID PRIMARY KEY (SALESREASONID)
)
GO



ALTER TABLE CLINICA.SALES
	ADD 
		CONSTRAINT TEMPSALES_SALESREASON
		FOREIGN KEY (TEMPID)
		REFERENCES CLINICA.SALES(SALESREASONID)

		ON DELETE CASCADE
		ON UPDATE CASCADE
GO

