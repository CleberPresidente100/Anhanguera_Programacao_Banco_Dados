



-- COUNT(*) --> CONTA A QUANTIDADE DE REGISTROS/LINHAS.
-- COUNT(DISTINCT <FIELD>) --> CONTA A QUANTIDADE DE REGISTROS, SEM CONSIDERAR A DUPLICIDADE EM UM DETERMINADO CAMPO.
-- GROUP BY --> AGRUPA REGISTROS.
-- ORDER BY --> ORDER O RESULTADO DA CONSULTA.
-- INNER JOIN --> RETORNA O RESULTADO DA INTERSEÇÃO ENTRE DUAS TABELAS (REGISTROS IGUAIS - PK e FK).
-- LEFT JOIN --> RETORNA TODOS OS REGISTROS DA TABELA NA CLAUSULA FROM E A INTERSEÇÃO ENTRE A TABELA NA CLAUSUAL JOIN.





 SELECT * FROM PRONTUARIO.CLINICA.MEDICO
 SELECT * FROM PRONTUARIO.CLINICA.PACIENTE
 SELECT * FROM PRONTUARIO.CLINICA.CONSULTA
 SELECT * FROM PRONTUARIO.CLINICA.MEDICAMENTO
 SELECT * FROM PRONTUARIO.CLINICA.POSOLOGIA
 GO





 -------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------
 ----- PERGUNTA 1: QUANTOS PACIENTES FORAM ATENDIDOS NO MÊS DE MARÇO ? QUAIS OS SEUS NOMES ? -----
 -------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------

 SELECT COUNT(*) FROM PRONTUARIO.CLINICA.CONSULTA -- MOSTRA QUANTAS CONSULTAS FORAM REALIZADAS.
 SELECT COUNT(DISTINCT CODPACIENTE) FROM PRONTUARIO.CLINICA.CONSULTA -- MOSTRA QUANTOS PACIENTES DISTINTOS FORAM ATENDIDOS.
 SELECT COUNT(DISTINCT CODPACIENTE) FROM PRONTUARIO.CLINICA.CONSULTA WHERE LEFT(DTCONSULTA, 7) = '2021-03'-- MOSTRA QUANTOS PACIENTES DISTINTOS FORAM ATENDIDOS NO MÊS DE MARÇO.


 SELECT DISTINCT
	 P.CODIGO
	,P.NOME

 FROM PRONTUARIO.CLINICA.CONSULTA AS C
 INNER JOIN PRONTUARIO.CLINICA.PACIENTE AS P 
	ON C.CODPACIENTE = P.CODIGO


	-- OU --
	

 SELECT
	 P.CODIGO
	,P.NOME

 FROM PRONTUARIO.CLINICA.CONSULTA AS C
 INNER JOIN PRONTUARIO.CLINICA.PACIENTE AS P 
	ON C.CODPACIENTE = P.CODIGO
 GROUP BY P.CODIGO, P.NOME
	


	-- UTILIZANDO WHERE --



 SELECT DISTINCT
	 P.CODIGO
	,P.NOME

 FROM PRONTUARIO.CLINICA.CONSULTA AS C
 INNER JOIN PRONTUARIO.CLINICA.PACIENTE AS P 
	ON C.CODPACIENTE = P.CODIGO
 WHERE LEFT(DTCONSULTA, 7) = '2021-03'


	-- OU --
	

 SELECT
	 P.CODIGO
	,P.NOME

 FROM PRONTUARIO.CLINICA.CONSULTA AS C
 INNER JOIN PRONTUARIO.CLINICA.PACIENTE AS P 
	ON C.CODPACIENTE = P.CODIGO
 WHERE LEFT(DTCONSULTA, 7) = '2021-03'
 GROUP BY P.CODIGO, P.NOME







 ----------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------
 ----- PERGUNTA 2: QUAL O PACIENTE QUE MAIS SE CONSULTOU NO MÊS DE MARÇO ? QUANTAS CONSULTAS ELE REALIZOU ? -----
 ----------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------

 SELECT
	 P.NOME
	,COUNT(*) AS 'Nº CONSULTAS'

 FROM PRONTUARIO.CLINICA.PACIENTE AS P
 INNER JOIN PRONTUARIO.CLINICA.CONSULTA AS C
	ON P.CODIGO = C.CODPACIENTE

 WHERE LEFT(DTCONSULTA, 7) = '2021-03'
 GROUP BY P.NOME
 ORDER BY 'Nº CONSULTAS' DESC, P.NOME ASC
-- ORDER BY COUNT(*) DESC, P.NOME ASC
-- ORDER BY 2 DESC, 1 ASC (NÃO RECOMENDADO)



-- COMO QUER APENAS 1 PACIENTE (O QUE TEVE MAIS CONSULTAS) UTILIZAMOS O TOP 1 INVÉS DO ORDER BY

 SELECT TOP 1
	 P.NOME
	,COUNT(*) AS 'Nº CONSULTAS'

 FROM PRONTUARIO.CLINICA.PACIENTE AS P
 INNER JOIN PRONTUARIO.CLINICA.CONSULTA AS C
	ON P.CODIGO = C.CODPACIENTE

 WHERE LEFT(DTCONSULTA, 7) = '2021-03'
 GROUP BY P.NOME







 -----------------------------------------------------------------------------
 -----------------------------------------------------------------------------
 -----------------------------------------------------------------------------
 ----- PERGUNTA 3: QUANTOS MEDICAMENTOS EXISTEM CADASTRADOS NO SISTEMA ? -----
 -----------------------------------------------------------------------------
 -----------------------------------------------------------------------------
 -----------------------------------------------------------------------------

 SELECT COUNT(*) AS 'QTD_MEDICAMENTOS'
 FROM PRONTUARIO.CLINICA.MEDICAMENTO







 ----------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------
 ----- PERGUNTA 4: QUAIS PACIENTES NÃO PRECISARAM MEDICAÇÃO EM PELO MENOS 1 DE SUAS CONSULTAS ? -----
 ----------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------

 SELECT
	 PAC.NOME
	,CON.DTCONSULTA AS 'DATA CONSULTA'
	,POS.PRESCRICAO

 FROM PRONTUARIO.CLINICA.PACIENTE AS PAC
 INNER JOIN PRONTUARIO.CLINICA.CONSULTA AS CON
	ON PAC.CODIGO = CON.CODPACIENTE
 LEFT JOIN PRONTUARIO.CLINICA.POSOLOGIA AS POS
	ON POS.CODCONSULTA = CON.CODIGO

 WHERE POS.PRESCRICAO IS NULL
 ORDER BY PAC.NOME, CON.DTCONSULTA







 -----------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------
 ----- PERGUNTA 5: QUAL O MÉDICO QUE MAIS REALIZOU CONSULTAS NO MÊS DE MARÇO ? -----
 -----------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------

 SELECT
	 MED.NOME
	,COUNT(*) AS 'Nº CONSULTAS'

 FROM PRONTUARIO.CLINICA.MEDICO AS MED
 INNER JOIN PRONTUARIO.CLINICA.CONSULTA AS CON
	ON MED.CODIGO = CON.CODMEDICO

 WHERE LEFT(DTCONSULTA, 7) = '2021-03'
 GROUP BY MED.NOME
 ORDER BY 'Nº CONSULTAS' DESC, MED.NOME


-- COMO QUER APENAS 1 MÉDICO (O QUE TEVE MAIS CONSULTAS) UTILIZAMOS O TOP 1

 SELECT TOP 1
	 MED.NOME
	,COUNT(*) AS 'Nº CONSULTAS'

 FROM PRONTUARIO.CLINICA.MEDICO AS MED
 INNER JOIN PRONTUARIO.CLINICA.CONSULTA AS CON
	ON MED.CODIGO = CON.CODMEDICO

 WHERE LEFT(DTCONSULTA, 7) = '2021-03'
 GROUP BY MED.NOME







 ---------------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------------
 ----- PERGUNTA 6: QUANTOS PACIENTES CADASTRADOS NÃO PRECISARAM DE ATENDIMENTO MÉDICO NO MÊS DE MARÇO? QUAIS OS SEUS NOMES ? -----
 ---------------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------------

 -- ERRADO POIS NÃO LEVA EM CONSIDERAÇÃO A DATA
 /*
 SELECT
	 PAC.NOME
	,CON.DTCONSULTA AS 'DATA CONSULTA'
	,CON.CODPACIENTE

 FROM PRONTUARIO.CLINICA.PACIENTE AS PAC
 LEFT JOIN PRONTUARIO.CLINICA.CONSULTA AS CON
	ON PAC.CODIGO = CON.CODPACIENTE

 WHERE CON.CODPACIENTE IS NULL --AND LEFT(CON.DTCONSULTA, 7) = '2021-03'

 ORDER BY PAC.NOME
 */
 

 SELECT
	 PAC.NOME
	,CON.DTCONSULTA AS 'DATA CONSULTA'
	,CON.CODPACIENTE

 FROM PRONTUARIO.CLINICA.PACIENTE AS PAC
 LEFT JOIN 
	(
		SELECT * FROM PRONTUARIO.CLINICA.CONSULTA AS C
		WHERE LEFT(C.DTCONSULTA, 7) = '2021-12'
	) AS CON
	ON PAC.CODIGO = CON.CODPACIENTE

 WHERE CON.CODPACIENTE IS NULL

 ORDER BY PAC.NOME
 


-- QUANTIDADE DE PACIENTES

 SELECT
	COUNT(*) AS 'Nº PACIENTES'

 FROM PRONTUARIO.CLINICA.PACIENTE AS PAC
 LEFT JOIN 
	(
		SELECT * FROM PRONTUARIO.CLINICA.CONSULTA AS C
		WHERE LEFT(C.DTCONSULTA, 7) = '2021-12'
	) AS CON
	ON PAC.CODIGO = CON.CODPACIENTE

 WHERE CON.CODPACIENTE IS NULL






 -------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------------
 ----- PERGUNTA 7: QUAL O MEDICAMENTO MAIS RECEITADO NO MÊS DE MARÇO ? QUANTAS VEZES ELE FOI RECEITADO ? -----
 -------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------------

 SELECT
	 MED.NOME
	,COUNT(*) AS 'QTD RECEITADA'

 FROM PRONTUARIO.CLINICA.MEDICAMENTO AS MED
 INNER JOIN PRONTUARIO.CLINICA.POSOLOGIA AS POS
	ON MED.CODIGO = POS.CODMEDICAMENTO
 INNER JOIN PRONTUARIO.CLINICA.CONSULTA AS CON
	ON CON.CODIGO = POS.CODCONSULTA

 WHERE LEFT(CON.DTCONSULTA, 7) = '2021-03'
 GROUP BY MED.NOME
 ORDER BY 'QTD RECEITADA' DESC, MED.NOME











