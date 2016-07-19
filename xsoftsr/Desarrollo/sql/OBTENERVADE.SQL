/*
********************************************************************************
** Generado por eMans AC :13/05/06 08:30:17 AM
** www.emans.com
** Sevilla - España
** Powered by MS Visual FoxPro.
** Manifestando el apoyo a la comunidad de desarrolladores de MS Visual FoxPro. 
*********************************************************************************
**
*/
 
/* [L1-INI] LINEA BLOQUEADA ZONA DEL SISTEMA */

CREATE PROCEDURE [dbo].[obtenervade]

/* LINEA BLOQUEADA [L1-FIN] */
 
--  
-- Zona de Parámetros, para escritura de usuarios.
--
  

@lcCodOso char(3),
@RetCount int OUTPUT
/*
 (
  @parameter1 datatype = default value,
  @parameter2 datatype OUTPUT
 )
*/
 
/* [L2-INI] LINEA BLOQUEADA ZONA DEL SISTEMA */

-- WITH

/* LINEA BLOQUEADA [L2-FIN] */
 
AS

BEGIN
 set @retCount=0
    
    SELECT Vademecum.codoso FROM Vademecum WHERE codoso=@lcCodoso
    
 IF @@ROWCOUNT > 0    
    set @RetCount = 1
END
GO
