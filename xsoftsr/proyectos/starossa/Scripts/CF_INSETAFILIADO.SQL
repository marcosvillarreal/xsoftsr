/*
********************************************************************************
** Generado por eMans AC :04/05/07 04:30:41 PM
** www.emans.com
** Sevilla - España
** Powered by MS Visual FoxPro.
** Manifestando el apoyo a la comunidad de desarrolladores de MS Visual FoxPro. 
*********************************************************************************
**
*/
 
/* [L1-INI] LINEA BLOQUEADA ZONA DEL SISTEMA */

CREATE PROCEDURE [dbo].[cf_insertafiliado]

/* LINEA BLOQUEADA [L1-FIN] */
 
--  
-- Zona de Parámetros, para escritura de usuarios.
--
  
@FileName varchar(100)

 
/* [L2-INI] LINEA BLOQUEADA ZONA DEL SISTEMA */

-- WITH

/* LINEA BLOQUEADA [L2-FIN] */
 
AS


SET QUOTED_IDENTIFIER OFF

CREATE TABLE TmpList (stnumero varchar (20), stnombre varchar (25))

DECLARE @SQL varchar(2000)
/*
SET @SQL = "BULK INSERT TmpList FROM '"+@FileName+"' WITH (FIELDTERMINATOR = ' ') "
*/
EXEC (@SQL)

INSERT Afiliado (numero,nombre)
SELECT stnumero,stnombre FROM tmpList

drop TABLE TmpList
GO
