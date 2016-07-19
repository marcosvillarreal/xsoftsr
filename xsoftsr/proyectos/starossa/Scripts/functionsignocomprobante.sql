set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION f_signocomprobante ( @valorentrada numeric(1))
RETURNS numeric(2)
AS
BEGIN
DECLARE @nmulti numeric(2)
select @nmulti = 1
if @valorentrada=2
begin
	Select @nmulti = -1
end   
RETURN @nmulti
END
