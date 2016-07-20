set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go
ALTER FUNCTION [dbo].[f_unidades]( @cantidad numeric(11,3),@univenta numeric(1),@unibulto numeric(11,3) )
RETURNS numeric(11,3)
AS
BEGIN
DECLARE @ntotalunidades numeric(11,3)
Select @ntotalunidades = @cantidad
if @univenta=2
begin
	Select @ntotalunidades = @cantidad * @unibulto
end   
RETURN @ntotalunidades
END
