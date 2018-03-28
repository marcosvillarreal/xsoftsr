SET LIBRARY TO (LOCFILE("vfpconnection.fll","FLL"))
*? FTPGet("ftp://ftp_santarossa:santarossa2839@chandonsvr.com.ar/prueba/myfile.zip", "C:\myfile.zip", "MyCommand()")
*? HTTPGet("http://www.mysite.com/mypage.htm", "C:\mypage.htm", "MyCommand()")
*? FILEGet("File://C:\MyFile.txt", "C:\MyFileCopy.txt", "MyCommand()")
? FTPPut("j:\COTNRO1.TXT", "ftp://ftp_santarossa:santarossa2839@chandonsvr.com.ar/prueba/ENVIAR.TXT", "MyCommand()")
*? HTTPPut("C:\mypage.htm", "http://www.mysite.com/mypage.htm", "MyCommand()")
*? FilePut("C:\myfile.zip", "File://C:\myfile.zip", "MyCommand()")

*m.lcString1 = FTPToStr("FTP://myusername:mypassword@mysite.com/mydir/myfile.txt", "MyCommand()")
*m.lcString2 = HTTPToStr("http://www.mysite.com/mypage.htm", "MyCommand()")
SET LIBRARY TO

FUNCTION MyCommand()
  ? nConnectTotalBytes
  ? nConnectBytesSoFar
ENDFUNC