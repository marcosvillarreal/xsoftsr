/*
********************************************************************************
** Generado por eMans AC :04/05/07 04:39:14 PM
** www.emans.com
** Sevilla - España
** Powered by MS Visual FoxPro.
** Manifestando el apoyo a la comunidad de desarrolladores de MS Visual FoxPro. 
*********************************************************************************
**
*/
 
/* [L1-INI] LINEA BLOQUEADA ZONA DEL SISTEMA */

CREATE PROCEDURE [dbo].[NuevoIdsql]

/* LINEA BLOQUEADA [L1-FIN] */
 
--  
-- Zona de Parámetros, para escritura de usuarios.
--
  

@Lcalias varchar(20),
@RetValor int OUTPUT,
@Valsuma int output 
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

  SET NOCOUNT ON 
 
 set @retvalor=0
 
 SELECT Name FROM SysObjects WHERE Name='KEYSID' AND Type='U'
 
    IF @@ROWCOUNT < 1
       CREATE TABLE Keysid ( Tabla Char(20), RetValor Integer, ctipocomp char(3) )
    
    SELECT Nextid FROM Keysid WHERE Tabla=@Lcalias
    
 IF @@ROWCOUNT < 1    
    INSERT INTO Keysid VALUES (@Lcalias, 0, '' )     
    
         
   UPDATE Keysid          
          SET @RetValor = Nextid = NextId + @ValSuma WHERE Tabla=@Lcalias
         
 RETURN
GO
