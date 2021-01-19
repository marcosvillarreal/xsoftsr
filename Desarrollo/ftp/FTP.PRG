**********************************************************
*  FTP Services for Visual Foxpro 5.0+                   *
*  Written by: Robert Abram                              *
*  Date: Sept 1998                                       *
*                                                        *
*  Revision 1.1a                                         *
*                                                        *
*  wininet.dll needs to be in the windows/system         *
*  directory.                                            *
*                                                        *
*  Updated 3/16/99 - Changed Date Usage to comply with   *
*                    Strict Date handling.               *
*														 *
*  Added 3/16/99 Functions - AutoDialInternet            *
*                            AutoDialHangUp              *
*                            DialInternet                *
*                            DialHangUp                  *
*                            GetConnectedState           *
*                            GoOnline                    *
**********************************************************

 	*
	* Internet API Returns
	*
    #define ERROR_SUCCESS							  0
    #define ERROR_FILE_NOT_FOUND             		  2
    #define ERROR_PATH_NOT_FOUND             		  3
    #define ERROR_ACCESS_DENIED              		  5
    #define ERROR_INVALID_HANDLE             		  6
    #define ERROR_NO_MORE_FILES						  18
    #define ERROR_FILE_EXISTS                		  80
    #define ERROR_INVALID_PARAMETER          		  87


	#define ERROR_INTERNET_BASE 					  12000

	#define ERROR_INTERNET_OUT_OF_HANDLES             (ERROR_INTERNET_BASE + 1)
	#define ERROR_INTERNET_TIMEOUT                    (ERROR_INTERNET_BASE + 2)
	#define ERROR_INTERNET_EXTENDED_ERROR             (ERROR_INTERNET_BASE + 3)
	#define ERROR_INTERNET_INTERNAL_ERROR             (ERROR_INTERNET_BASE + 4)
	#define ERROR_INTERNET_INVALID_URL                (ERROR_INTERNET_BASE + 5)
	#define ERROR_INTERNET_UNRECOGNIZED_SCHEME        (ERROR_INTERNET_BASE + 6)
	#define ERROR_INTERNET_NAME_NOT_RESOLVED          (ERROR_INTERNET_BASE + 7)
	#define ERROR_INTERNET_PROTOCOL_NOT_FOUND         (ERROR_INTERNET_BASE + 8)
	#define ERROR_INTERNET_INVALID_OPTION             (ERROR_INTERNET_BASE + 9)
	#define ERROR_INTERNET_BAD_OPTION_LENGTH          (ERROR_INTERNET_BASE + 10)
	#define ERROR_INTERNET_OPTION_NOT_SETTABLE        (ERROR_INTERNET_BASE + 11)
	#define ERROR_INTERNET_SHUTDOWN                   (ERROR_INTERNET_BASE + 12)
	#define ERROR_INTERNET_INCORRECT_USER_NAME        (ERROR_INTERNET_BASE + 13)
	#define ERROR_INTERNET_INCORRECT_PASSWORD         (ERROR_INTERNET_BASE + 14)
	#define ERROR_INTERNET_LOGIN_FAILURE              (ERROR_INTERNET_BASE + 15)
	#define ERROR_INTERNET_INVALID_OPERATION          (ERROR_INTERNET_BASE + 16)
	#define ERROR_INTERNET_OPERATION_CANCELLED        (ERROR_INTERNET_BASE + 17)
	#define ERROR_INTERNET_INCORRECT_HANDLE_TYPE      (ERROR_INTERNET_BASE + 18)
	#define ERROR_INTERNET_INCORRECT_HANDLE_STATE     (ERROR_INTERNET_BASE + 19)
	#define ERROR_INTERNET_NOT_PROXY_REQUEST          (ERROR_INTERNET_BASE + 20)
	#define ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND   (ERROR_INTERNET_BASE + 21)
	#define ERROR_INTERNET_BAD_REGISTRY_PARAMETER     (ERROR_INTERNET_BASE + 22)
	#define ERROR_INTERNET_NO_DIRECT_ACCESS           (ERROR_INTERNET_BASE + 23)
	#define ERROR_INTERNET_NO_CONTEXT                 (ERROR_INTERNET_BASE + 24)
	#define ERROR_INTERNET_NO_CALLBACK                (ERROR_INTERNET_BASE + 25)
	#define ERROR_INTERNET_REQUEST_PENDING            (ERROR_INTERNET_BASE + 26)
	#define ERROR_INTERNET_INCORRECT_FORMAT           (ERROR_INTERNET_BASE + 27)
	#define ERROR_INTERNET_ITEM_NOT_FOUND             (ERROR_INTERNET_BASE + 28)
	#define ERROR_INTERNET_CANNOT_CONNECT             (ERROR_INTERNET_BASE + 29)
	#define ERROR_INTERNET_CONNECTION_ABORTED         (ERROR_INTERNET_BASE + 30)
	#define ERROR_INTERNET_CONNECTION_RESET           (ERROR_INTERNET_BASE + 31)
	#define ERROR_INTERNET_FORCE_RETRY                (ERROR_INTERNET_BASE + 32)
	#define ERROR_INTERNET_INVALID_PROXY_REQUEST      (ERROR_INTERNET_BASE + 33)
	#define ERROR_INTERNET_NEED_UI                    (ERROR_INTERNET_BASE + 34)

	#define ERROR_INTERNET_HANDLE_EXISTS              (ERROR_INTERNET_BASE + 36)
	#define ERROR_INTERNET_SEC_CERT_DATE_INVALID      (ERROR_INTERNET_BASE + 37)
	#define ERROR_INTERNET_SEC_CERT_CN_INVALID        (ERROR_INTERNET_BASE + 38)
	#define ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR     (ERROR_INTERNET_BASE + 39)
	#define ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR     (ERROR_INTERNET_BASE + 40)
	#define ERROR_INTERNET_MIXED_SECURITY             (ERROR_INTERNET_BASE + 41)
	#define ERROR_INTERNET_CHG_POST_IS_NON_SECURE     (ERROR_INTERNET_BASE + 42)
	#define ERROR_INTERNET_POST_IS_NON_SECURE         (ERROR_INTERNET_BASE + 43)
	#define ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED    (ERROR_INTERNET_BASE + 44)
	#define ERROR_INTERNET_INVALID_CA                 (ERROR_INTERNET_BASE + 45)
	#define ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP      (ERROR_INTERNET_BASE + 46)
	#define ERROR_INTERNET_ASYNC_THREAD_FAILED        (ERROR_INTERNET_BASE + 47)
	#define ERROR_INTERNET_REDIRECT_SCHEME_CHANGE     (ERROR_INTERNET_BASE + 48)
	#define ERROR_INTERNET_DIALOG_PENDING             (ERROR_INTERNET_BASE + 49)
	#define ERROR_INTERNET_RETRY_DIALOG               (ERROR_INTERNET_BASE + 50)
	#define ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR    (ERROR_INTERNET_BASE + 52)
	#define ERROR_INTERNET_INSERT_CDROM               (ERROR_INTERNET_BASE + 53)


	*
	* FTP API errors
	*

	#define FTP_TRANSFER_IN_PROGRESS            	  (ERROR_INTERNET_BASE + 110)
	#define FTP_DROPPED                         	  (ERROR_INTERNET_BASE + 111)
	#define FTP_NO_PASSIVE_MODE                       (ERROR_INTERNET_BASE + 112)


	*
	* additional Internet API error codes
	*

	#define ERROR_INTERNET_SECURITY_CHANNEL_ERROR     (ERROR_INTERNET_BASE + 157)
	#define ERROR_INTERNET_UNABLE_TO_CACHE_FILE       (ERROR_INTERNET_BASE + 158)
	#define ERROR_INTERNET_TCPIP_NOT_INSTALLED        (ERROR_INTERNET_BASE + 159)
	#define ERROR_INTERNET_DISCONNECTED               (ERROR_INTERNET_BASE + 163)
	#define ERROR_INTERNET_SERVER_UNREACHABLE         (ERROR_INTERNET_BASE + 164)
	#define ERROR_INTERNET_PROXY_SERVER_UNREACHABLE   (ERROR_INTERNET_BASE + 165)

	#define ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT      (ERROR_INTERNET_BASE + 166)
	#define ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT  (ERROR_INTERNET_BASE + 167)
	#define ERROR_INTERNET_SEC_INVALID_CERT    		  (ERROR_INTERNET_BASE + 169)
	#define ERROR_INTERNET_SEC_CERT_REVOKED    		  (ERROR_INTERNET_BASE + 170)

	*
	* handle types
	*

	#define ERROR_INTERNET_HANDLE_TYPE_INTERNET              1
	#define ERROR_INTERNET_HANDLE_TYPE_CONNECT_FTP           2
	#define ERROR_INTERNET_HANDLE_TYPE_CONNECT_GOPHER        3
	#define ERROR_INTERNET_HANDLE_TYPE_CONNECT_HTTP          4
	#define ERROR_INTERNET_HANDLE_TYPE_FTP_FIND              5
	#define ERROR_INTERNET_HANDLE_TYPE_FTP_FIND_HTML         6
	#define ERROR_INTERNET_HANDLE_TYPE_FTP_FILE              7
	#define ERROR_INTERNET_HANDLE_TYPE_FTP_FILE_HTML         8
	#define ERROR_INTERNET_HANDLE_TYPE_GOPHER_FIND           9
	#define ERROR_INTERNET_HANDLE_TYPE_GOPHER_FIND_HTML      10
	#define ERROR_INTERNET_HANDLE_TYPE_GOPHER_FILE           11
	#define ERROR_INTERNET_HANDLE_TYPE_GOPHER_FILE_HTML      12
	#define ERROR_INTERNET_HANDLE_TYPE_HTTP_REQUEST          13

	
	
	#define BYTE_1											 1
	#define BYTE_2                                           256
	#define BYTE_3                                           65536
	#define BYTE_4                                           16777216
	#define MAXDWORD										 4294967295
	
	*
	* File Attributes
	*
	
	#define FILE_ATTRIBUTE_READONLY         				 1
	#define FILE_ATTRIBUTE_HIDDEN           				 2
	#define FILE_ATTRIBUTE_SYSTEM              				 4
	#define FILE_ATTRIBUTE_DIRECTORY        				 16  
	#define FILE_ATTRIBUTE_ARCHIVE          	   			 32  
	#define FILE_ATTRIBUTE_ENCRYPTED        				 64 
	#define FILE_ATTRIBUTE_NORMAL           				 128  
	#define FILE_ATTRIBUTE_TEMPORARY        				 256  
	#define FILE_ATTRIBUTE_SPARSE_FILE      				 512
	#define FILE_ATTRIBUTE_REPARSE_POINT    				 1024	
	#define FILE_ATTRIBUTE_COMPRESSED       				 2048  
	#define FILE_ATTRIBUTE_OFFLINE          				 4096
	
	
	#define BIT_ATTRIBUTE_READONLY         				 	 0
	#define BIT_ATTRIBUTE_HIDDEN           				 	 1
	#define BIT_ATTRIBUTE_SYSTEM              				 2
	#define BIT_ATTRIBUTE_DIRECTORY        				 	 4  
	#define BIT_ATTRIBUTE_ARCHIVE          	   			 	 5
	#define BIT_ATTRIBUTE_ENCRYPTED							 6  
	#define BIT_ATTRIBUTE_NORMAL           				 	 7  
	#define BIT_ATTRIBUTE_TEMPORARY        				 	 8
	#define BIT_ATTRIBUTE_SPARSE_FILE						 9
	#define BIT_ATTRIBUTE_REPARSE_POINT                      10  
	#define BIT_ATTRIBUTE_COMPRESSED       				 	 11  
	#define BIT_ATTRIBUTE_OFFLINE          				 	 12  
	
	
	* Flags for InternetAutodial
	#define INTERNET_AUTODIAL_FORCE_ONLINE          	     1
	#define INTERNET_AUTODIAL_FORCE_UNATTENDED      	     2
	#define INTERNET_AUTODIAL_FAILIFSECURITYCHECK   	     4
	
	*
	* FTP
	*TYPE

	#define FTP_TRANSFER_TYPE_UNKNOWN   			         0
	#define FTP_TRANSFER_TYPE_ASCII     			         1
	#define FTP_TRANSFER_TYPE_BINARY    			         2
	
	* Flags for InternetGetConnectedState
	#define INTERNET_CONNECTION_MODEM                        1
	#define INTERNET_CONNECTION_LAN                          2
	#define INTERNET_CONNECTION_PROXY                        4
	#define INTERNET_CONNECTION_MODEM_BUSY                   8


	#define FTP_TRANSFER_TYPE_MASK      			         3  && (FTP_TRANSFER_TYPE_ASCII | FTP_TRANSFER_TYPE_BINARY)

	*
	* Internet Variables
	
	#define INTERNET_DEFAULT FTP_PORT			   	         21
	#define INTERNET_SERVICE_FTP				             1
	#define INTERNET_OPEN_TYPE_DIRECT			             1
	#define INTERNET_CONNECT_FLAG_PASSIVE
	
	#define cNULL									         CHR(0)
	#define MAX_PATH 								         260
	


  ****************************************************
  * Class Ftp_Service                                *
  ****************************************************
	DEFINE CLASS ftp_Service AS custom
	
		
		cIPAddress 	        = ""
		cUserName           = ""
		cPassword           = ""
		cPort				= "21"     && Default FTP PORT
		
		nInet_Handle 		= 0
		nConnect_Handle 	= 0
		lDLL_Loaded 		= .F.
		nResult_Code		= 0
		nExtended_Result    = 0
		cExtended_Message   = ""
		cCurrentDir			= ""
		
		cAgent 				= "Visual FoxPro" + cNULL
		
				
	  ****************************************************
		PROCEDURE Init
			IF _DOS OR _UNIX OR _MAC
				RETURN .F.
			ENDIF
		ENDPROC	
	
	  ****************************************************
		PROCEDURE LoadAPIFuncs
		
		  * Variables need for defines
		   LOCAL lpcAgent, nAccessType, lpcProxyName, lpcProxyBypass, nFlags
		   LOCAL nInet_Handle, nConnect_Handle, lpcServer, nPort, lpcUserName
		   LOCAL lpcPassword, nService, nContext, nMax_Path
		   LOCAL lpcDirectory, lpcFileName, lpcSearchStr, lpcWIN32_FIND_DATA
		   LOCAL lpcRemoteFile, lpcNewFile, nFailIfExists, nAttributes
		   LOCAL nError, lpcBuffer, nHandle, lpcDialUp
		   
		   * Check to see if We have already declared functions and loaded the DLL
		   	IF THIS.lDLL_Loaded  
		   		RETURN ERROR_SUCCESS
		   	ENDIF
		   	
		   * Declare a Kernel32 Functions
		   	DECLARE Integer GetLastError IN Kernel32
		   	
		   	DECLARE Integer FileTimeToSystemTime IN Kernel32 ;
		   			String @lpcBuffer, String @lpcBuffer
		   
		   * Declare DLL functions used by Program
		   	DECLARE Integer InternetAutodial IN WinInet ;
		   			Integer nAccessType, Integer nHandle
		   		
		   	DECLARE Integer InternetAutodialHangup IN WinInet ;
		   			Integer nFlags
		   			
		   	DECLARE Integer InternetDial IN WinInet ;
		   			Integer nHandle, String @lpcDialUp, Integer nAccessType, Integer @nConnect_Handle, ;
		   			Integer nFlags
		   	
		   	DECLARE Integer InternetHangUp IN WinInet ;
		   			Integer nConnect_Handle, Integer nFlags
		   			
		   	DECLARE Integer InternetGetConnectedState IN WinInet ;
		   			Integer @nContext, Integer nFlags
		   			
		   	DECLARE Integer InternetGoOnline IN WinInet ;
		   			String @lpcURL, Integer nHandle, Integer nFlags
		   			
		   	DECLARE Integer InternetOpen IN WinInet ;
		   			String @lpcAgent, Integer nAccessType, String @lpcProxyName, ;
		   			String @lpcProxyBypass, Integer nFlags
		   			
		   	DECLARE Integer InternetConnect IN WinInet ;
		   			Integer nInet_Handle, String @lpcServer, Short nPort, String @lpcUserName, ;
		   			String @lpcPassword, Integer nService, Integer nFlags, Integer nContext

		   	DECLARE Integer InternetCloseHandle IN WinInet ;
		   			Integer nConnect_Handle
		   			
		   * FTP Functions
		   	DECLARE Integer FtpCreateDirectory IN WinInet ;
		   			Integer nConnect_Handle, String @lpcDirectory
		   			
		   	DECLARE Integer FtpDeleteFile IN WinInet ;
		   			Integer nConnect_Handle, String @lpcFileName
		   	
		   	DECLARE Integer FtpFindFirstFile IN WinInet ;
		   			Integer nConnect_Handle, String @lpcSearchStr, String @lpcWIN32_FIND_DATA, ;
		   			Integer nFlags, Integer nContext
		   			
		   	DECLARE Integer InternetFindNextFile IN WinInet ;
		   			Integer nConnect_Handle, String @lpcWIN32_FIND_DATA
		   			
		   	DECLARE Integer FtpGetCurrentDirectory IN WinInet ;
		   			Integer nConnect_Handle, String @lpcDirectory, Integer @nMax_Path
		   
		   	DECLARE Integer FtpGetFile IN WinInet ;
		   			Integer nConnect_Handle, String @lpcRemoteFile, String @lpcNewFile, ;
		   			Integer nFailIfExists, Integer nAttributes, Integer nFlags, ;
		   			Integer nContext
		   			
		   	DECLARE Integer FtpOpenFile IN WinInet ;
		   			Integer nConnect_Handle, String @lpcRemoteFile, Integer nAccessType, ;
		   			Integer nFlags, Integer nContext
		   			
		   	DECLARE Integer FtpPutFile IN WinInet ;
		   			Integer nConnect_Handle, String @lpcNewFile, String @lpcRemoteFile, ;
		   			Integer nFlags, Integer nContext
		   			
		   	DECLARE Integer FtpRemoveDirectory IN WinInet ;
		   			Integer nConnect_Handle, String @lpcDirectory
		   			
		   	DECLARE Integer FtpRenameFile IN WinInet ;
		   			Integer nConnect_Handle, String @lpcRemoteFile, String @lpcNewFile
		   			
		   	DECLARE Integer FtpSetCurrentDirectory IN WinInet ;
		   			Integer nConnect_Handle, String @lpcDirectory
		   			
		   	DECLARE Integer InternetGetLastResponseInfo IN WinInet ;
		   			Integer @nError, String @lpcBuffer, Integer @nMax_Path
		   			
		   	THIS.lDLL_Loaded = .T.
		   	
		   	RETURN ERROR_SUCCESS	
		   		
		ENDPROC
		
	  ****************************************************
	  	PROCEDURE AutoDialInternet
	  		LPARAMETERS lnType
	  		
	  		LOCAL lnHWNDHandle, fResult
	  		  	
	  	      IF THIS.LoadAPIFuncs() != ERROR_SUCCESS
		   		   RETURN .F.
		   	  ENDIF	
		   	  
		   	  IF TYPE(lnType) != "N" 
		   	  	   RETURN .F.
		   	  ENDIF
		   	  
	  		  lnHWNDHandle = 0	  		
	  		
	  		  fResult = InternetAutodial(lnType, lnHWNDHandle)
	  		  THIS.GetExtendedError()
	  		
	  		  IF fResult = 0 
	  		  	  RETURN .F.
	  		  ENDIF
	  		  	
	  		RETURN .T.
	  		  
	  	ENDPROC	
	  	
	  ****************************************************
	  	PROCEDURE AutoDialHangUp
	  	
	  		LOCAL fResult
	  		
	  		  IF THIS.LoadAPIFuncs() != ERROR_SUCCESS
		   		   RETURN .F.
		   	  ENDIF	
	  		
	  		  fResult = InternetAutoDialHangUp(0)
	  		  THIS.GetExtendedError()
	  		  
	  		  IF fResult = 0 
	  		  	  RETURN .F.
	  		  ENDIF
	  		  	
	  		RETURN .T.	  		  
	  	
	  	ENDPROC
	  		  
	  
  	  ****************************************************	
  	  	PROCEDURE DialInternet
  	  		LPARAMETERS lcDialUpName, lnFlag
  	  		
  	  		LOCAL fResult, lnConnectionID, lnHWNDHandle
  	  		
  	  		  IF THIS.LoadAPIFuncs() != ERROR_SUCCESS
		   		   RETURN -1
		   	  ENDIF
  	  		
  	  		  lnConnectionID = 0
  	  		  lnHWNDHandle = 0
  	  		    	  		    	  		  
  	  		  IF TYPE("lcDialUpName") != "C" OR ;
  	  		  	 TYPE("lnFlag") != "N"
  	  		  	  RETURN -1
  	  		  ENDIF
  	  		
  	  		  IF LEN(ALLTRIM(lcDialUpName)) = 0 
  	  		      RETURN -1
  	  		  ENDIF
  	  		  
  	  		  lcDialUpName = lcDialUpName + cNULL
  	  		  
  	  		  fResult = InternetDial(lnHWNDHandle, @lcDialUpName, lnFlag, @lnConnectionID, 0)
  	  		  THIS.GetExtendedError()
  	  		    	  		
  	  		RETURN lnConnectionID
  	  	ENDPROC  


	  ****************************************************
	    PROCEDURE DialHangUp
	        LPARAMETERS lnConnectionID
	      
	        LOCAL fResult
	        
	      	  IF THIS.LoadAPIFuncs() != ERROR_SUCCESS
		   		   RETURN -1
		   	  ENDIF
		   	  
		   	  IF TYPE("lnConnectionID") != "N"
		   	  		RETURN .F.
		   	  ENDIF
		   	  
		   	  fResult = InternetHangUp(@lnConnectionID, 0)
		   	  THIS.GetExtendedError()
		   	  
		   	  IF fResult = 0 
		   	  	  	RETURN .F.
		   	  	 ELSE
		   	  	 	RETURN .T.
		   	  ENDIF		   	  
	      
	    ENDPROC
	    
	    
	  ****************************************************
	  	PROCEDURE GetConnectedState
		
			LOCAL fResult, lnConnectionState
			
			  IF THIS.LoadAPIFuncs() != ERROR_SUCCESS
		   		   RETURN -1
		   	  ENDIF
			
			  lnConnectionState = 0
		
			  fResult = InternetGetConnectedState(@lnConnectionState, 0)
			  THIS.GetExtendedError()
			  
			  IF fResult = 0 
			  		RETURN -1
			  ENDIF

			RETURN lnConnectionState

		ENDPROC
		
			  
	  ****************************************************	
	  	PROCEDURE GoOnline
	  		LPARAMETERS lcURL
	  		
	  		LOCAL lnHWNDHandle, fResult
	  		
	  		  IF THIS.LoadAPIFuncs() != ERROR_SUCCESS
		   		   RETURN -1
		   	  ENDIF
		   	  
		   	  IF TYPE("lcURL") != "C"
		   	  	   RETURN .F.
		   	  ENDIF
	  			
	  		  lcURL = lcURL + cNULL
	  		  
	  		  lnHWNDHandle = 0
	  		  
	  		  fResult = InternetGoOnline(@lcURL, lnHWNDHandle, 0)
	  		  THIS.GetExtendedError()
		   	  
		   	  IF fResult = 0 
		   	  	  	RETURN .F.
		   	  	 ELSE
		   	  	 	RETURN .T.
		   	  ENDIF		
	  		
	  	ENDPROC	

		
	  ****************************************************
		PROCEDURE OpenInternet
		   LPARAMETERS lcUserName, lcPassword, lcIPAddress, lcPort
		 	
		   LOCAL lnPCount, fResult, lcTempDir, lnConnectHandle
		   
		   * Check Passed Parameters
		   	lnPCount = PARAMETERS()
		   		   
		   	IF lnPCount <> 4
		   		nResult_Code = ERROR_INTERNET_BAD_OPTION_LENGTH
		   		RETURN .F.
		   	ENDIF
		   	
		   * Make sure parameters are of the correct type
		   	IF (TYPE("lcUserName") != "C") OR ;
		   	   (TYPE("lcPassword") != "C") OR ;
		   	   (TYPE("lcIPAddress") != "C") OR ;
		   	   (TYPE("lcPort") != "C")
		   	   	 nResult_Code = ERROR_INVALID_PARAMETER
		   	   	 RETURN .F.
		   	ENDIF
		   	
		   	
		   	
   	       * Check Parameter Values
		   	IF EMPTY(lcUserName) OR EMPTY(lcPassword) OR EMPTY(lcIPAddress)
		   		nResult_Code = ERROR_INTERNET_BAD_OPTION_LENGTH            
		   		RETURN .F.
		   	ENDIF
		   	
		   	IF THIS.LoadAPIFuncs() != ERROR_SUCCESS
		   		RETURN .F.
		   	ENDIF
		   	
		   	
		   * Open Handle to Internet
		   * Set Parameters
		    		    		    
		    THIS.cUserName = lcUserName + cNULL           && Store FTP Connection information
		    THIS.cPassword = lcPassword + cNULL
		    THIS.cIPAddress = lcIPAddress + cNULL
		    THIS.cPort = lcPort
		    		    	   		    		   
		   	THIS.nInet_Handle = InternetOpen((THIS.cAgent), INTERNET_OPEN_TYPE_DIRECT, cNULL, cNULL, 0)
		   	THIS.GetExtendedError()
		   	
		   	
		   * Unable to Get a Connection into the Internet
		   	IF THIS.nInet_Handle = 0
		   		THIS.CloseFtp()
		   		RETURN .F.
		   	ENDIF
		   
	
		   * This Opens the FTP site and Gets the Current Directory.  The handle to the FTP site is opened
		   * and closed for each call to any function.	
		   * Open FTP Site 
		   	lnConnect_Handle = InternetConnect(THIS.nInet_Handle, (THIS.cIPAddress), VAL(lcPort), ;
		   							(THIS.cUserName), (THIS.cPassword), INTERNET_SERVICE_FTP, 0, 0)
		   	THIS.GetExtendedError()
		   	
		   	IF lnConnect_Handle != 0
		   		   	
		   		lcTempDir = SPACE(MAX_PATH)   	
		   		   	
		   		fResult = FtpGetCurrentDirectory(lnConnect_Handle, @lcTempDir, MAX_PATH)
		   		THIS.GetExtendedError()
		   			
		   		IF fResult != 0
		   			THIS.cCurrentDir = lcTempDir
		   			InternetCloseHandle(lnConnect_Handle)
		   		  ELSE
		   		  	RETURN .F.
		   		ENDIF
		   		
		   	  ELSE
		   	  	RETURN .F.
		   	
		   	ENDIF
		   		   			
			RETURN .T.
		
		ENDPROC
		
		
	  ****************************************************
	  	PROCEDURE OpenFtpConnection
	  	  
	  	  LOCAL nHandle, lnConnect_Handle, lcCurrentDir
	  	
	  	  * Open FTP Site 
		   	lnConnect_Handle = InternetConnect(THIS.nInet_Handle, (THIS.cIPAddress), VAL(THIS.cPort), ;
		   							(THIS.cUserName), (THIS.cPassword), INTERNET_SERVICE_FTP, 0, 0)
		   	THIS.GetExtendedError()
		   	
		   	lcCurrentDir = THIS.cCurrentDir
				   
			IF lnConnect_Handle != 0
			  	fResult = FtpSetCurrentDirectory(lnConnect_Handle, @lcCurrentDir)
			  	
			  	IF fResult = 1
			  		THIS.nConnect_Handle = lnConnect_Handle
			  		RETURN .T.
			  	  ELSE
			  	  	THIS.GetExtendedError()     && Only Get extended Error information when there is an error
			  	  	RETURN .F.
			  	ENDIF
			  ELSE
			  	RETURN .F.
			ENDIF
				   
		ENDPROC
		
	  ****************************************************
	    PROCEDURE CloseFtpConnection
	    	
	    	IF THIS.nConnect_Handle != 0
	    		InternetCloseHandle(THIS.nConnect_Handle)
	    	ENDIF
	    	
	    	THIS.nConnect_Handle = 0
	    	
	      RETURN
	    ENDPROC
	    
		
	  ****************************************************
		PROCEDURE CloseInternet
		
		  * Handles have a Hierarchy.  Closing the Top Handle will close all child handles also.
			IF THIS.nInet_Handle != 0
				InternetCloseHandle(THIS.nInet_Handle)
				THIS.nInet_Handle = 0
			ENDIF
												
		ENDPROC
		
		 
	  ****************************************************
	  	PROCEDURE GetFtpFile
	      LPARAMETERS lcRemoteFile, lcNewFile, llFailIfExists
	      
	  	  LOCAL fResult, lnFail
	  	  
	  	  	IF THIS.OpenFtpConnection()     && Open an FTP Handle
	  	  
		  	  	IF llFailIfExists
		  	  		lnFail = 1
		  	  	  ELSE
		  	  	  	lnFail = 0
		  	  	ENDIF	  	  	
		  	  	
		  	  	lcNewFile = lcNewFile + cNULL
		  	  	lcRemoteFile = lcRemoteFile + cNULL
		  	  
		  	  	fResult = FtpGetFile(THIS.nConnect_Handle, @lcRemoteFile, @lcNewFile, lnFail, ;
		  	  				FILE_ATTRIBUTE_NORMAL, FTP_TRANSFER_TYPE_BINARY, 0)
		  	  	THIS.GetExtendedError()
		  	  	
		  	  	THIS.CloseFtpConnection()   && Close FTP Handle
		  	  	
		  	  	IF fResult = 1
		  	  		RETURN .T.
		  	  	  ELSE
		  	  	  	RETURN .F.
		  	  	ENDIF
		  	  	
		  	ENDIF
	  	    	  	  	
	  	ENDPROC
	  	
	  ****************************************************
	  	PROCEDURE PutFtpFile
	      LPARAMETERS lcRemoteFile, lclocalFile
	      
	  	  LOCAL fResult
	  	  
	  	  	IF THIS.OpenFtpConnection()     && Open an FTP Handle
	  	  
		  	  	lcRemoteFile = lcRemoteFile + cNULL
		  	  	lcLocalFile = lcLocalFile + cNULL
		  	  	  	  	
		  	  	fResult = FtpPutFile(THIS.nConnect_Handle, @lcLocalFile, @lcRemoteFile, ;
		  	  				FTP_TRANSFER_TYPE_BINARY, 0)
		  	  	THIS.GetExtendedError()
		  	  	  	    	  	  
	  	    	THIS.CloseFtpConnection()
	  	    	
	  	    	IF fResult = 1
		  	  		RETURN .T.
		  	  	  ELSE
		  	  	  	RETURN .F.
		  	  	ENDIF
		  	  	
	  	    ENDIF
	  	    	
	  	ENDPROC
	  	
	  ****************************************************
	  	PROCEDURE DeleteFtpFile
	      LPARAMETERS lcRemoteFile
	      
	  	  LOCAL fResult
	  	  
	  	  	IF THIS.OpenFtpConnection()     && Open an FTP Handle
	  	  
		  	  	lcRemoteFile = lcRemoteFile + cNULL
		  	  		  	  	  	  	
		  	  	fResult = FtpDeleteFile(THIS.nConnect_Handle, @lcRemoteFile)
		  	  	THIS.GetExtendedError()
		  	  	
		  	  	THIS.CloseFtpConnection()
		  	  	
		  	  	IF fResult = 1
		  	  		RETURN .T.
		  	  	  ELSE
		  	  	  	RETURN .F.
		  	  	ENDIF
		  	  	
		  	ENDIF
	  	    	  	  	
	  	ENDPROC
		
		
	  ****************************************************
	  	PROCEDURE RenameFtpFile
	      LPARAMETERS lcOldFile, lcNewFile
	      
	  	  LOCAL fResult
	  	  	 
	  	  	IF THIS.OpenFtpConnection()     && Open an FTP Handle
	  	  	 	  	
		  	  	lcOldFile = lcOldFile + cNULL
		  	  	lcNewFile = lcNewFile + cNULL
		  	  	  	  	
		  	  	fResult = FtpRenameFile(THIS.nConnect_Handle, @lcOldFile, @lcNewFile)
		  	  	THIS.GetExtendedError()
		  	  	
		  	  	THIS.CloseFtpConnection()
		  	  	
		  	  	IF fResult = 1
		  	  		RETURN .T.
		  	  	  ELSE
		  	  	  	RETURN .F.
		  	  	ENDIF
		  	  	
		  	ENDIF
	  	    	  	  	
	  	ENDPROC
		
		
		
	  ****************************************************
	  	PROCEDURE CreateFtpDirectory
	  	 LPARAMETERS lcNewDir
	  	 
	  	 LOCAL fResult
	  	   	  	   		
	  	   	IF THIS.OpenFtpConnection()     && Open an FTP Handle  	   		
	  	   	  	   	
		  	   	lcNewDir = lcNewDir + cNULL
		  	   	  	   		  	   	 
		  	 	fResult = FtpCreateDirectory(THIS.nConnect_Handle, @lcNewDir)
		  	 	THIS.GetExtendedError()
		  	 	
		  	 	THIS.CloseFtpConnection()
		  	 	
		  	 	IF fResult = 1
		  	 		RETURN .T.
		  	 	  ELSE
		  	 	  	RETURN .F.
		  	 	ENDIF
		  	 	
		  	 ENDIF
	  	 		  	 
	  	ENDPROC
	  	
	  ****************************************************
	  	PROCEDURE RemoveFtpDirectory
	  	 LPARAMETERS lcNewDir
	  	 
	  	 LOCAL fResult
	  	   	  	   		  
	  	   	IF THIS.OpenFtpConnection()     && Open an FTP Handle  	   		  
	  	   	  	   		 	   	 
		  	   	lcNewDir = lcNewDir + cNULL
		  	   	  	   		  	   	 
		  	 	fResult = FtpRemoveDirectory(THIS.nConnect_Handle, @lcNewDir)
		  	 	THIS.GetExtendedError()
		  	
		  		THIS.CloseFtpConnection()
		  	 	
		  	 	IF fResult = 1
		  	 		RETURN .T.
		  	 	  ELSE
		  	 	  	RETURN .F.
		  	 	ENDIF
	  	 		  	 
	  	 	ENDIF
	  	 	
	  	ENDPROC
			 
	  ****************************************************
	  	PROCEDURE ChangeFtpDirectory
	  	 LPARAMETERS lcNewDir
	  	 
	  	 LOCAL fResult, lcTempDir, llResult
	  	   	  	   		  
	  	   	IF THIS.OpenFtpConnection()     && Open an FTP Handle 	   		  
	  	   	  	   		  	   	 
	  	   	  	llResult = .F.	 
	  	   	  	   		  	   
		  	   	lcNewDir = lcNewDir + cNULL  
		  	   	lcTempDir = SPACE(MAX_PATH)	   		  	   	
		  	   	  	   		  	   	 
		  	 	fResult = FtpSetCurrentDirectory(THIS.nConnect_Handle, @lcNewDir)
		  	 	THIS.GetExtendedError()
		  	 		  	 	
		  	 	IF fResult = 1
		  	 		fResult = FtpGetCurrentDirectory(THIS.nConnect_Handle, @lcTempDir, MAX_PATH)
		  	 		THIS.GetExtendedError()
		  	 		  	 		
		  	 		IF fResult = 1
		  	 			THIS.cCurrentDir = lcTempDir
		  	 			llResult = .T.
		  	 		ENDIF
		  	 		
		  	 	ENDIF
		  	 	
	  	 		THIS.CloseFtpConnection()
	  	 		
	  	 		RETURN llResult
	  	 	ENDIF	  	 
	  	 		  	 
	  	ENDPROC
	  	
	  ****************************************************
	  	PROCEDURE GetFtpDirectory
	      LPARAMETERS lcDirectory
	      
	  	  LOCAL fResult, lcTempDir
	  	  
	  	    IF THIS.OpenFtpConnection()     && Open an FTP Handle
	  	  
		  	  	lcTempDir = SPACE(MAX_PATH)
		  	  	
		  	  	fResult = FtpGetCurrentDirectory(THIS.nConnect_Handle, @lcTempDir, MAX_PATH)
		  	  	THIS.GetExtendedError()
		  	  	
		  	  	lcDirectory = LEFT(lcTempDir, AT(cNULL, lcTempDir) - 1)
		  	  	
		  	  	THIS.CloseFtpConnection()
		  	  	
		  	  	IF fResult = 1
		  	 		RETURN .T.
		  	 	  ELSE
		  	 	  	RETURN .F.
		  	 	ENDIF
		  	 	
		  	ENDIF
	  	    	  	  	
	  	ENDPROC
		
				
	  ****************************************************
	    PROCEDURE GetFtpDirectoryArray
	      LPARAMETERS laDirectory, lcMask
	      
	      LOCAL cStruct, llResult, lnCount, fResult, lffHandle
      	
	      	IF THIS.OpenFtpConnection()     && Open an FTP Handle
	      
		        lcMask = lcMask + cNULL
		      
		       * Dimension the array to store the directory
		       * [x, 1] = FileName
		       * [x, 2] = Alternate FileName
		       * [x, 3] = File Size
		       * [x, 4] = File Create Date
		       * [x, 5] = File Last Access Time
		       * [x, 6] = File Last Write Time
		       * [x, 7] = File Attributes
		        DIMENSION laDirectory [1, 7]
		        laDirectory [1, 1] = .F.
		    	      	
		       * This is for a FoxPro Quirk.
			      	        	
		      	lcStruct = SPACE(319)   && Allocate space for the returned structure
		      	
		       * Get the first file or find out if 
		      	lffHandle = FtpFindFirstFile(THIS.nConnect_Handle, @lcMask, @lcStruct, 0, 0)
		       	THIS.GetExtendedError()
		      	
		      	IF lffHandle = 0 OR THIS.nResult_Code = ERROR_NO_MORE_FILES
		      		THIS.CloseFtpConnection()
		      		RETURN .F.
		      	ENDIF
		      
		       * Parse out First File Information
		      	THIS.CrackFile(lcStruct, @laDirectory)
		      	
			      	llResult = 1
			      				    	    	
			    	DO WHILE THIS.nResult_Code != ERROR_NO_MORE_FILES AND llResult != 0
			    	
			    		lcStruct = SPACE(319)
			          * Get next files
			        	llResult = InternetFindNextFile(lffHandle, @lcStruct)
			    		THIS.GetExtendedError()
			    		
			    	  * If we got good information, go ahead and parse it
			    		IF THIS.nResult_Code != ERROR_NO_MORE_FILES AND llResult != 0
			       			THIS.CrackFile(lcStruct, @laDirectory)
			       		ENDIF
			    		
			      	ENDDO
			     
			     THIS.CloseFtpConnection()
			     
		      ELSE
		        RETURN .F.     && Unable to get FTP Connection	
		    ENDIF
	    
	    
	    	RETURN .T.
		ENDPROC
		
	  ****************************************************
	 	PROCEDURE GetErrorCode
	 	  LPARAMETERS llShowMessage

		  LOCAL lcMessage

			IF llShowMessage = .T.
			
			   * Build Error Message Here
				lcMessage = "Error (" + ALLTRIM(STR(THIS.nResult_Code)) + ")  -  " + ;
									THIS.GetErrorText(THIS.nResult_Code)
				IF !EMPTY(THIS.cExtended_Message)
					lcMessage = lcMessage + CHR(13) + CHR(13) + "Extended Error Info - (" + ;
								ALLTRIM(STR(THIS.nExtended_Result)) + ;
								") - " + THIS.cExtended_Message
				ENDIF
				
				MessageBox(lcMessage, 48, "FTP Error Message")
			ENDIF
	 			 		
	 		RETURN THIS.nResult_Code
	 	
	 	ENDPROC
	 	
	 	
	  ****************************************************
	    PROCEDURE GetExtendedErrorCode
	    
	 	
	 	  RETURN THIS.nExtended_Result
	 	ENDPROC
	 	
	 	
	  ****************************************************
	    PROCEDURE GetExtendedErrorMsg
	    
	 	
	 	  RETURN THIS.cExtended_Message
	 	ENDPROC
	 	
	 	
	  ****************************************************
	    PROCEDURE CrackFile
	      LPARAMETERS lcString, laDirectory
	      	
	      LOCAL lcFileName, lcAlterName, lnSizeHigh, lnSizeLow, lnFileSize, ;
	      		lcAttributes, lnArrayLen, lcTimeBuff, ;
	      		ldCreateDate, ldAccessDate, ldWriteDate, laNewArray, lnResult
	      	

			IF TYPE('laDirectory[1, 1]') = 'L'	&& Array Has Not Been Filed      
	           * Force Record size of 1
	        	DIMENSION laDirectory [1, 7]
	          ELSE	
	           * Expand Array
	            DIMENSION laDirectory [ALEN(laDirectory, 1) + 1, 7]
	        ENDIF
	        
       	   * Get new Array Position
      		lnArrayLen = ALEN(laDirectory, 1)
          		       	      
	      	lcFileName = SUBSTR(lcString, 45, MAX_PATH)
	      	lcAlterName = RIGHT(lcString, 14)
	      	
	      	lcFileName = LEFT(lcFileName, AT(cNull, lcFileName) - 1)  && Copy out just the File Name Text
	      	lcAlterName = LEFT(lcAlterName, AT(cNull, lcAlterName) - 1)
	      	
	       * Convert File Size DWORDs
	      	lnSizeHigh = (ASC(SUBSTR(lcString, 29, 1)) * BYTE_1) + ;
	      				 (ASC(SUBSTR(lcString, 30, 1)) * BYTE_2) + ;
	      				 (ASC(SUBSTR(lcString, 31, 1)) * BYTE_3) + ;
	      				 (ASC(SUBSTR(lcString, 32, 1)) * BYTE_4) 
	      				 
	      	lnSizeLow =  (ASC(SUBSTR(lcString, 33, 1)) * BYTE_1) + ;
	      				 (ASC(SUBSTR(lcString, 34, 1)) * BYTE_2) + ;
	      				 (ASC(SUBSTR(lcString, 35, 1)) * BYTE_3) + ;
	      				 (ASC(SUBSTR(lcString, 36, 1)) * BYTE_4) 
	      				 
	       * Build File Size
	      	lnFileSize = (lnSizeHigh * MAXDWORD) + lnSizeLow
	      	
	      * Convert File Date
	       
	       * Get File Create DateTime
	        lcTimeBuff = SUBSTR(lcString, 5, 8)
	        ldCreateDate = THIS.CrackDate(lcTimeBuff)
	        
	       * Get File Create DateTime
	        lcTimeBuff = SUBSTR(lcString, 13, 8)
	        ldAccessDate = THIS.CrackDate(lcTimeBuff)
	        
	       * Get File Create DateTime
	        lcTimeBuff = SUBSTR(lcString, 21, 8)
	        ldWriteDate = THIS.CrackDate(lcTimeBuff)
	        
	       * Get File Attributes
	        lcAttributes = THIS.CrackAttributes(LEFT(lcString, 4))
	        
	        laDirectory[lnArrayLen, 1] = ALLTRIM(lcFileName)
	        laDirectory[lnArrayLen, 2] = ALLTRIM(lcAlterName)
	        laDirectory[lnArrayLen, 3] = lnFileSize
	        laDirectory[lnArrayLen, 4] = ldCreateDate
	        laDirectory[lnArrayLen, 5] = ldAccessDate
	        laDirectory[lnArrayLen, 6] = ldWriteDate
	        laDirectory[lnArrayLen, 7] = lcAttributes
  	 
	      RETURN 
	       	
	    ENDPROC
	    
	  ****************************************************
		PROCEDURE CrackDate
		  LPARAMETERS lcOutBuffer
		  
		  LOCAL lcInBuffer, ldDateTime, fResult, lcBuild, ;
		  		lnDay, lnMonth, lnYear, lnHour, lnMinute, lnSecond
		
			lcInBuffer = SPACE(16)
		
			fResult = FileTimeToSystemTime(@lcOutBuffer, @lcInBuffer)
			THIS.GetExtendedError()
			
			IF fResult = 0   && Failed
				ldDateTime = {^1901/01/01 00:00:01}   && Default Time
				RETURN ldDateTime
			ENDIF
			
			lnYear = ASC(SUBSTR(lcInBuffer, 1, 1)) + (ASC(SUBSTR(lcInBuffer, 2, 1)) * BYTE_2)
			lnMonth = ASC(SUBSTR(lcInBuffer, 3, 1)) + (ASC(SUBSTR(lcInBuffer, 4, 1)) * BYTE_2)
			lnDay = ASC(SUBSTR(lcInBuffer, 7, 1)) + (ASC(SUBSTR(lcInBuffer, 8, 1)) * BYTE_2)
			lnHour = ASC(SUBSTR(lcInBuffer, 9, 1)) + (ASC(SUBSTR(lcInBuffer, 10, 1)) * BYTE_2)
			lnMinute = ASC(SUBSTR(lcInBuffer, 11, 1)) + (ASC(SUBSTR(lcInBuffer, 12, 1)) * BYTE_2)
			lnSecond = ASC(SUBSTR(lcInBuffer, 13, 1)) + (ASC(SUBSTR(lcInBuffer, 13, 1)) * BYTE_2)
			
			lcBuild = "^" + ALLTRIM(STR(lnYear)) + '/' + ALLTRIM(STR(lnMonth)) + '/' + ALLTRIM(STR(lnDay)) + ' ' + ;
					  ALLTRIM(STR(lnHour)) + ':' + ALLTRIM(STR(lnMinute)) + ':' + ALLTRIM(STR(lnSecond))
				      
			ldDateTime = {&lcBuild}
						  
		  RETURN ldDateTime
		   
	    ENDPROC
		  
	  ****************************************************
		PROCEDURE CrackAttributes
		  LPARAMETERS lcBuffer
	    
	      LOCAL lcAttributes, lnValue
	 		
	 		lcAttributes = ''
	 		 		
			lnValue = (ASC(SUBSTR(lcBuffer, 1, 1)) * BYTE_1) + ;
					  (ASC(SUBSTR(lcBuffer, 2, 1)) * BYTE_2) + ;
					  (ASC(SUBSTR(lcBuffer, 3, 1)) * BYTE_3) + ;
					  (ASC(SUBSTR(lcBuffer, 4, 1)) * BYTE_4) 
					  
			DO CASE
				CASE BITTEST(lnValue, BIT_ATTRIBUTE_READONLY) 
					lcAttributes = lcAttributes + 'R'
				CASE BITTEST(lnValue, BIT_ATTRIBUTE_HIDDEN) 
					lcAttributes = lcAttributes + 'H'
				CASE BITTEST(lnValue, BIT_ATTRIBUTE_SYSTEM) 
					lcAttributes = lcAttributes + 'S'
				CASE BITTEST(lnValue, BIT_ATTRIBUTE_DIRECTORY) 
					lcAttributes = lcAttributes + 'D'
				CASE BITTEST(lnValue, BIT_ATTRIBUTE_ARCHIVE) 
					lcAttributes = lcAttributes + 'A'
				CASE BITTEST(lnValue, BIT_ATTRIBUTE_NORMAL) 
					lcAttributes = lcAttributes + 'N'
				CASE BITTEST(lnValue, BIT_ATTRIBUTE_TEMPORARY) 
					lcAttributes = lcAttributes + 'T'
				CASE BITTEST(lnValue, BIT_ATTRIBUTE_COMPRESSED) 
					lcAttributes = lcAttributes + 'C'
				CASE BITTEST(lnValue, BIT_ATTRIBUTE_OFFLINE) 
					lcAttributes = lcAttributes + 'O'
			ENDCASE
						
	 	  RETURN lcAttributes
		ENDPROC
		
	  ****************************************************
	    PROCEDURE GetExtendedError
	    
	      LOCAL lcMessage, lnError, lcBuffer
	      
	        THIS.nResult_Code = GetLastError()
	        
	      	lnError = 0
	        lcBuffer = SPACE(MAX_PATH)
	        
	        InternetGetLastResponseInfo(lnError, @lcBuffer, MAX_PATH)
		    
		    THIS.nExtended_Result = lnError
		    THIS.cExtended_Message = LEFT(lcBuffer, AT(cNULL, lcBuffer) - 1)
		    		    		
		  RETURN 
		ENDPROC
				
	  ****************************************************
		PROCEDURE GetErrorText
		  LPARAMETERS lnError

		  LOCAL lcMessage
  
		  	DO CASE
		
	           CASE lnError =  ERROR_INTERNET_OUT_OF_HANDLES                
	            		lcMessage = "ERROR_INTERNET_OUT_OF_HANDLES"
		       CASE lnError =  ERROR_INTERNET_TIMEOUT                       
		        		lcMessage = "ERROR_INTERNET_TIMEOUT"
		       CASE lnError =  ERROR_INTERNET_EXTENDED_ERROR                
		        		lcMessage = "ERROR_INTERNET_EXTENDED_ERROR"
		       CASE lnError =  ERROR_INTERNET_INTERNAL_ERROR                
		        		lcMessage = "ERROR_INTERNET_INTERNAL_ERROR"
		       CASE lnError =  ERROR_INTERNET_INVALID_URL                   
		        		lcMessage = "ERROR_INTERNET_INVALID_URL"
		       CASE lnError =  ERROR_INTERNET_UNRECOGNIZED_SCHEME           
		        	    lcMessage = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"
		       CASE lnError =  ERROR_INTERNET_NAME_NOT_RESOLVED             
		                lcMessage = "ERROR_INTERNET_NAME_NOT_RESOLVED"
		       CASE lnError =  ERROR_INTERNET_PROTOCOL_NOT_FOUND            
		        	    lcMessage = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"
		       CASE lnError =  ERROR_INTERNET_INVALID_OPTION                
		        	    lcMessage = "ERROR_INTERNET_INVALID_OPTION"
		       CASE lnError =  ERROR_INTERNET_BAD_OPTION_LENGTH             
		                lcMessage = "ERROR_INTERNET_BAD_OPTION_LENGTH"    
		       CASE lnError =  ERROR_INTERNET_OPTION_NOT_SETTABLE           
    		            lcMessage = "ERROR_INTERNET_OPTION_NOT_SETTABLE"
		       CASE lnError =  ERROR_INTERNET_SHUTDOWN                      
		        	    lcMessage = "ERROR_INTERNET_SHUTDOWN"
		       CASE lnError =  ERROR_INTERNET_INCORRECT_USER_NAME           
		        	    lcMessage = "ERROR_INTERNET_INCORRECT_USER_NAME"
		       CASE lnError =  ERROR_INTERNET_INCORRECT_PASSWORD            
		        	    lcMessage = "ERROR_INTERNET_INCORRECT_PASSWORD"
		       CASE lnError =  ERROR_INTERNET_LOGIN_FAILURE                 
		        	    lcMessage = "ERROR_INTERNET_LOGIN_FAILURE"
		       CASE lnError =  ERROR_INTERNET_INVALID_OPERATION             
		        	    lcMessage = "ERROR_INTERNET_INVALID_OPERATION"
		       CASE lnError =  ERROR_INTERNET_OPERATION_CANCELLED           
		        	    lcMessage = "ERROR_INTERNET_OPERATION_CANCELLED"
		       CASE lnError =  ERROR_INTERNET_INCORRECT_HANDLE_TYPE         
		        	    lcMessage = "ERROR_INTERNET_INCORRECT_HANDLE_TYPE"
		       CASE lnError =  ERROR_INTERNET_INCORRECT_HANDLE_STATE        
		       	        lcMessage = "ERROR_INTERNET_INCORRECT_HANDLE_STATE"
		       CASE lnError =  ERROR_INTERNET_NOT_PROXY_REQUEST             
		                lcMessage = "ERROR_INTERNET_NOT_PROXY_REQUEST"
		       CASE lnError =  ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND      
		        	    lcMessage = "ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND"
		       CASE lnError =  ERROR_INTERNET_BAD_REGISTRY_PARAMETER        
		                lcMessage = "ERROR_INTERNET_BAD_REGISTRY_PARAMETER"
		       CASE lnError =  ERROR_INTERNET_NO_DIRECT_ACCESS              
		                lcMessage = "ERROR_INTERNET_NO_DIRECT_ACCESS"
		       CASE lnError =  ERROR_INTERNET_NO_CONTEXT                    
		         	    lcMessage = "ERROR_INTERNET_NO_CONTEXT"
		       CASE lnError =  ERROR_INTERNET_NO_CALLBACK                   
		                lcMessage = "ERROR_INTERNET_NO_CALLBACK"
		       CASE lnError =  ERROR_INTERNET_REQUEST_PENDING               
		                lcMessage = "ERROR_INTERNET_REQUEST_PENDING"
		       CASE lnError =  ERROR_INTERNET_INCORRECT_FORMAT              
		                lcMessage = "ERROR_INTERNET_INCORRECT_FORMAT"
		       CASE lnError =  ERROR_INTERNET_ITEM_NOT_FOUND                
		                lcMessage = "ERROR_INTERNET_ITEM_NOT_FOUND"
		       CASE lnError =  ERROR_INTERNET_CANNOT_CONNECT                
		                lcMessage = "ERROR_INTERNET_CANNOT_CONNECT"
		       CASE lnError =  ERROR_INTERNET_CONNECTION_ABORTED            
		                lcMessage = "ERROR_INTERNET_CONNECTION_ABORTED"
		       CASE lnError =  ERROR_INTERNET_CONNECTION_RESET              
		                lcMessage = "ERROR_INTERNET_CONNECTION_RESET"
		       CASE lnError =  ERROR_INTERNET_FORCE_RETRY                   
		                lcMessage = "ERROR_INTERNET_FORCE_RETRY"
		       CASE lnError =  ERROR_INTERNET_INVALID_PROXY_REQUEST         
		                lcMessage = "ERROR_INTERNET_INVALID_PROXY_REQUEST"
		       CASE lnError =  ERROR_INTERNET_NEED_UI                       
		         	    lcMessage = "ERROR_INTERNET_NEED_UI"
		       CASE lnError =  ERROR_INTERNET_HANDLE_EXISTS                 
		                lcMessage = "ERROR_INTERNET_HANDLE_EXISTS"
		       CASE lnError =  ERROR_INTERNET_SEC_CERT_DATE_INVALID         
		                lcMessage = "ERROR_INTERNET_SEC_CERT_DATE_INVALID"
		       CASE lnError =  ERROR_INTERNET_SEC_CERT_CN_INVALID           
		                lcMessage = "ERROR_INTERNET_SEC_CERT_CN_INVALID"
		       CASE lnError =  ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR        
		         	    lcMessage = "ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR"
		       CASE lnError =  ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR        
		                lcMessage = "ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR"
		       CASE lnError =  ERROR_INTERNET_MIXED_SECURITY                
		                lcMessage = "ERROR_INTERNET_MIXED_SECURITY"
		       CASE lnError =  ERROR_INTERNET_CHG_POST_IS_NON_SECURE        
		                lcMessage = "ERROR_INTERNET_CHG_POST_IS_NON_SECURE"
		       CASE lnError =  ERROR_INTERNET_POST_IS_NON_SECURE            
		                lcMessage = "ERROR_INTERNET_POST_IS_NON_SECURE"
		       CASE lnError =  ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED       
		                lcMessage = "ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED"
		       CASE lnError =  ERROR_INTERNET_INVALID_CA                    
		                lcMessage = "ERROR_INTERNET_INVALID_CA"
		       CASE lnError =  ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP         
		                lcMessage = "ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP"
		       CASE lnError =  ERROR_INTERNET_ASYNC_THREAD_FAILED           
		                lcMessage = "ERROR_INTERNET_ASYNC_THREAD_FAILED"
		       CASE lnError =  ERROR_INTERNET_REDIRECT_SCHEME_CHANGE        
		                lcMessage = "ERROR_INTERNET_REDIRECT_SCHEME_CHANGE"
		       CASE lnError =  ERROR_INTERNET_DIALOG_PENDING                
	  	                lcMessage = "ERROR_INTERNET_DIALOG_PENDING"
		       CASE lnError =  ERROR_INTERNET_RETRY_DIALOG                  
		                lcMessage = "ERROR_INTERNET_RETRY_DIALOG"
		       CASE lnError =  ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR       
		                lcMessage = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"
		       CASE lnError =  ERROR_INTERNET_INSERT_CDROM                  
		                lcMessage = "ERROR_INTERNET_INSERT_CDROM"
		       CASE lnError =  FTP_TRANSFER_IN_PROGRESS            	     
		                lcMessage = "FTP_TRANSFER_IN_PROGRESS"
		       CASE lnError =  FTP_DROPPED                         	     
		                lcMessage = "FTP_DROPPED"
		       CASE lnError =  FTP_NO_PASSIVE_MODE                          
		                lcMessage = "FTP_NO_PASSIVE_MODE"
		       CASE lnError =  ERROR_INTERNET_SECURITY_CHANNEL_ERROR        
		                lcMessage = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"
		       CASE lnError =  ERROR_INTERNET_UNABLE_TO_CACHE_FILE          
	     	            lcMessage = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"
		       CASE lnError =  ERROR_INTERNET_TCPIP_NOT_INSTALLED           
	    	            lcMessage = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"
		       CASE lnError =  ERROR_INTERNET_DISCONNECTED                  
    		            lcMessage = "ERROR_INTERNET_DISCONNECTED"
		       CASE lnError =  ERROR_INTERNET_SERVER_UNREACHABLE            
	    	            lcMessage = "ERROR_INTERNET_SERVER_UNREACHABLE"
		       CASE lnError =  ERROR_INTERNET_PROXY_SERVER_UNREACHABLE      
		                lcMessage = "ERROR_INTERNET_PROXY_SERVER_UNREACHABLE"
		       CASE lnError =  ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT         
		                lcMessage = "ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT"
		       CASE lnError =  ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT     
		         		lcMessage = "ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT"
		       CASE lnError =  ERROR_INTERNET_SEC_INVALID_CERT    		     
		        		lcMessage = "ERROR_INTERNET_SEC_INVALID_CERT"
		       CASE lnError =  ERROR_INTERNET_SEC_CERT_REVOKED    		     
		        		lcMessage = "ERROR_INTERNET_SEC_CERT_REVOKED"
		       CASE lnError =  ERROR_NO_MORE_FILES
		       			lcMessage = "ERROR_NO_MORE_FILES"
		       CASE lnError =  ERROR_INVALID_HANDLE
		       			lcMessage = "ERROR_INVALID_HANDLE"
		       CASE lnError =  ERROR_FILE_NOT_FOUND
		       			lcMessage = "ERROR_FILE_NOT_FOUND"
		       CASE lnError =  ERROR_PATH_NOT_FOUND
		       		    lcMessage = "ERROR_PATH_NOT_FOUND"
		       CASE lnError =  ERROR_ACCESS_DENIED
		       			lcMessage = "ERROR_ACCESS_DENIED"
		       CASE lnError =  ERROR_FILE_EXISTS
		       			lcMessage = "ERROR_FILE_EXISTS"
		       CASE lnError =  ERROR_INVALID_PARAMETER
		       			lcMessage = "ERROR_INVALID_PARAMETER"
		       OTHERWISE	
		       		lcMessage = "Unknown Error Message"
		  ENDCASE
		  
		  RETURN lcMessage
	    ENDPROC	
		
		
	
	ENDDEFINE     && End Class Define












