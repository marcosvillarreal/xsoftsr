********************************************************
*                                                      *            
*  Program: FTP_Test                                   *
*  Written By: Robert Abram                            *
*  Date: 9/98                                          *
*                                                      *
*  Reason: Because Programmers need all the help       *
*          they can get.                               *
*                                                      *
********************************************************

 * Test FTP Services
 * This is just a quick demonstration of the most used functions
 *    What you need is a ftp site to connect to, a file you can send up and 
 *    rights on the ftp server to create, read, write and delete files
 
 * **** Replace all the Function Parameters enclosed in #PARM# with valid information
 
 * Note: In this Demo, all output is to the Foxpro main window

  PUBLIC sz_ftp

   * Make it so Foxpro can find our FTP Class
	SET PROCEDURE TO ftp.prg ADDITIVE
   
   * Create a FTP Object
	sz_ftp = CREATEOBJECT('ftp_service')

   * Try to get a handle into the Internet and Connect Briefly with the FTP Site
   * Note: Insert your USER ID, PASSWORD, FTP ADDRESS, PORT # Here  
   * Note: ("21" is the Default Port)
   
	IF sz_ftp.OpenInternet("miusuario", "micontrasena", "ftp.miempresa.com", "21") 
	
		MessageBox("Successful Connection", 64, "FTP Message")
	
	   * Display the Inital Directory
		? "--- Inital Directory"
		ListDir()
		
	   * Create a Directory called "Dir_Test" on the FTP Server
		? "--- Creating Directory (Dir_Test)"
		IF !sz_ftp.CreateFtpDirectory('Dir_Test')
			?sz_ftp.GetErrorCode(.T.)
		ENDIF
		ListDir()
		
	   * Change to that directory
		? "--- Changing Directory to Dir_Test"
		IF !sz_ftp.ChangeFtpDirectory("Dir_Test")
			?sz_ftp.GetErrorCode(.T.)
		ENDIF
	    ListDir()
	
	   * Copy up a file to the server
	   * NOTE: If you get Error #2 Cant Find File.  It couldn't find this 
	   *       TESTFILE.TXT file.
		? "--- Sending File to FTP Server"		
		IF !sz_ftp.PutFtpFile("testfile.txt", "testfile.txt")
			?sz_ftp.GetErrorCode(.T.)
		ENDIF
		ListDir()

       * Delete the Files 
		? "--- Removing File Dir.txt to FTP Server"		
		IF !sz_ftp.DeleteFtpFile("testfile.txt")
			?sz_ftp.GetErrorCode(.T.)
		ENDIF
		ListDir()

       * Change back the Original Directory
		? "--- Changing Directory back on Level"
		IF !sz_ftp.ChangeFtpDirectory("..")
			?sz_ftp.GetErrorCode(.T.)
		ENDIF
		ListDir()

       * Remove the Directory From the Server
		? "--- Removing Directory Dir_Test"
		IF !sz_ftp.RemoveFtpDirectory("Dir_Test")
			?sz_ftp.GetErrorCode(.T.)
		ENDIF
		ListDir()
				
		sz_ftp.CloseInternet()
				
	  ELSE
	  	MessageBox("No Connection Made", 64, "FTP Message")
	  	sz_ftp.CloseInternet()
	  	?sz_ftp.GetErrorCode(.T.)
	  	
	 ENDIF

   RETURN

  ***************************************************
	PROCEDURE ListDir

		
		LOCAL lcOutput, lcDirName, laDirArray

      * Reset the variable to hold the file array.  
      * The Object redefines the variable to an array.
		laDirArray = ""
		
      * Get the Current Directory Name
		IF !sz_ftp.GetFtpDirectory(@lcDirName)
			sz_ftp.GetErrorCode(.T.)
			lcDirName = ''
		ENDIF
		
	  * Get the Files in the Current Directory
	  * This one always returns an Error.  When the API Function that gets the files
	  * can't find any more files, it return the Error 'ERROR_NO_MORE_FILES' 
		IF !sz_ftp.GetFtpDirectoryArray(@laDirArray, "*.*") 
		   * Error 18 always returns if the directory is empty
			IF !EMPTY(laDirArray) OR sz_ftp.GetErrorCode(.F.) != 18
		    	sz_ftp.GetErrorCode(.T.)
		    ENDIF
		ENDIF
		
	   * Output the Current Directory 
		? 
		? 'FTP Directory: ' + lcDirName 
		
	   * Interate through our array of files
		IF !EMPTY(laDirArray)  && If Empty, there were no files found in the current Directory.
			FOR x = 1 TO ALEN(laDirArray, 1)
			   
			  * Pad up a String with some file information.
			   lcOutput = '   ' + PADR(laDirArray[x, 1], 25) + PADL(STR(laDirArray[x, 3]), 12) + ;
			   				 ' ' + PADR(DTOC(laDirArray[x, 6]), 14) + laDirArray[x, 7]
			  * Output the File Information
			   ? lcOutput
				
			ENDFOR
		ENDIF
	
	  * Just move a line down.
		?
				
	RETURN