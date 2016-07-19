/*
********************************************************************************
** Generado por eMans AC :04/05/07 04:36:45 PM
** www.emans.com
** Sevilla - España
** Powered by MS Visual FoxPro.
** Manifestando el apoyo a la comunidad de desarrolladores de MS Visual FoxPro. 
*********************************************************************************
**
*/
 
/* [L1-INI] LINEA BLOQUEADA ZONA DEL SISTEMA */

CREATE PROCEDURE [dbo].[Devolverid]

/* LINEA BLOQUEADA [L1-FIN] */
 
--  
-- Zona de Parámetros, para escritura de usuarios.
--
  

@Lcalias varchar(20),
@RetValor int OUTPUT

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
 
 SELECT @Retvalor=SCOPE_IDENTITY() FROM dbo.producto
return
GO
