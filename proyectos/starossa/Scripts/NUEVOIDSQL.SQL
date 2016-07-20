CREATE PROCEDURE [dbo].[NuevoIdsql]
@Lcalias varchar(20),
@RetValor int OUTPUT,
@Valsuma int output  
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
