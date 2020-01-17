cd \
cd "program files"
cd "microsoft sql*"
cd 120
cd tools
cd binn
rem SQLCMD.EXE -S SERVIDOR\SQL2014 -U sa -P Cf3485 -i "execute CambiarMapeoImp 5,1"
SQLCMD.EXE -S SERVIDOR\SQL2014 -U sa -P Cf3485 -i C:\aplicaciones\MapeoImpresora.sql
