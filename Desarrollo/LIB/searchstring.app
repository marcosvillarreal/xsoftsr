���   [ Y �                    T�0 (   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                              WINDOWS _RYD1DIMZG 628711867      /  F      ]                          �      �                       WINDOWS _RYD1DIMZH 683568721�  �  �  �              �0                  :T                           WINDOWS _RYD1DIMZP 683568721�T  U  #U  4U  ?U  VU                                                           WINDOWS _RYD1DIMZS 641944878fV  uV  �V  �V  �V  �V      WY  6Z                                               WINDOWS _RYD1DIN0E 624212164�[      �[  �[  �[  \                                                           WINDOWS _RYD1DIN0G 629300272E\  W\  x\  �\  �\  �\      �\  4]                                               WINDOWS _RYD1DIN0I 624273770^      "^  0^  ?^  q^                                                           WINDOWS _RYD1DIN0J 629300272�^  �^  �^  �^  �^   _      H_  �_                                               WINDOWS _RYE19EYXP 624273770n`      |`  �`  �`  �`                                                           WINDOWS _RYE19EYXQ 629300272�`  	a  *a  9a  Fa  xa      �a  b                                               WINDOWS _S620ZA1XM 651592562�b  �b  c  !c  2c  Sc                                                           WINDOWS _S620ZA1XN 651592562�c  �c  d  d  ,d  Md      e  Me                                               WINDOWS _S620ZA1XW 683568603'f  ?f  `f  uf  �f  �f      Ag  �g                                               WINDOWS _S620ZA1XX 651592562�h  �h  �h  �h  �h  i      �i  k                                               WINDOWS _RYD1DIMZG 641944847�l      �l  �l  �l   m                                                           WINDOWS _RYD1DIN0M 641944847�m      �m  �m  �m  �m                                                           WINDOWS _RYD1DIN0O 641944847an  yn  �n  �n  �n  �n                                                           WINDOWS _RYD1DIN0Q 641944847�o  �o  �o  �o  �o  p      �p  �r                                               WINDOWS _RYD1DIN0R 641944847Tu  lu  �u  �u  �u  �u                                                           WINDOWS _RYD1DIN0T 641944847tv  �v  �v  �v  �v  �v                                                           WINDOWS _RYD1DIN0V 641944847�w  �w  �w  �w  �w  x                                                           WINDOWS _RYD1DIN0X 641944847�x  �x  �x  �x  y  $y                                                           WINDOWS _RYD1DIN0Z 641944847�y  �y  z  z   z  Az                                                           WINDOWS _RYD1DIN12 641944847�z  �z  {  ,{  ?{  `{                                                           WINDOWS _RYD1DIMZH 641944847�{  |  9|  I|  Y|  z|      "}  �~                                               WINDOWS _RYD1DIMZK 641944847��  ـ  ��  �  �  ?�                                                           WINDOWS _RYD1DIMZN 641944847��  ��  �  *�  <�  ]�                                                           WINDOWS _RYD1DIMZP 641944847��  �  5�  E�  Z�  {�                                                           WINDOWS _S270KQHZG 641944847�      ,�  9�  G�  h�                                                           WINDOWS _S270KQHZH 641959591�  ��  �  /�  J�  k�                                                           WINDOWS _S270KQHZI 641959591�  5�  W�  g�  ��  ��                                                           WINDOWS _S270KQHZJ 641959591U�  m�  ��  ��  ��  ׇ                                                           WINDOWS _0470T51MV 683568304}�  ��  ��  ǈ  ۈ  ��                                                           WINDOWS _S1Y0JTAZC 641959591a�  y�  ��  ��  ��  ��      ��  �                                               WINDOWS _RYD1DIN1E 683567356��      ��  ��  č  ۍ                                                           WINDOWS _RYD1DIMZG 683567356[�  p�  ��  ��  ��  ˎ                                                           WINDOWS _0470TIH5L 683568582�  '�  H�  U�  f�  }�                                                           WINDOWS _0470TNC7O 683568701�  �  '�  7�  J�  a�                                                           COMMENT RESERVED                                ��                                                            ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      dataenvironment      dataenvironment      Dataenvironment      JLeft = 1
Top = 220
Width = 520
Height = 200
Name = "Dataenvironment"
      1      2      macform      ..\common\vcx\macbase.vcx      form      frmSearchString      �DataSession = 2
Height = 345
Width = 558
DoCreate = .T.
AutoCenter = .T.
Caption = "Search String"
KeyPreview = .T.
registryapp = Software\EMSOFT\SearchString\1.0\
rememberposition = .T.
registryname = frmSearchString
Name = "frmSearchString"
     ,�PROCEDURE search
WAIT WINDOW "Searching..." NOWAIT

lcSearchString = ALLTRIM(THISFORM.cboStrings.DisplayValue)

lcProject = THISFORM.cboProjects.Value

lcOldSetDeleted = SET('DELETE')
SET DELETED ON

SELE Targets
lcOldSetSafe = SET('Safe')
SET SAFE OFF
ZAP
SET SAFE &lcOldSetSafe

opf = THISFORM.pf1.Page2
llCaseSensitive = opf.ChkCaseSensitive.Value
llSearchClassLibs = opf.chkClassLibs.Value
llSearchPrograms = opf.chkPrograms.Value
llSearchForms = opf.chkForms.Value
llSearchMenus = opf.chkMenus.Value
llSearchDataBases = opf.chkDatabases.Value

FoundCount = 0

IF EMPTY(lcSearchString) 
	MESSAGEBOX('No search String Specified',0,'SearchString')
	RETURN .F.
ENDIF

IF EMPTY(lcProject) OR TYPE('lcProject') <> "C"
	MESSAGEBOX('No Project Specified',0,'SearchString')
	RETURN .F.
ENDIF

IF !FILE(lcProject)
	IF !FILE(lcProject) OR !('.pjx'$LOWER(lcProject))
		MESSAGEBOX("You have not specified a valid project file to search. Can't finish.",0,'SearchString')
		RETURN .F.
	ENDIF
ENDIF

lcOldCurDir = SYS(5) + CURDIR()
THISFORM.CurrentProject= lcProject


oProject = _VFP.Projects(THISFORM.CurrentProject)

lnSearchFileCount = 0

FOR EACH oFile IN oProject.Files
	lnSearchfileCount = lnSearchFileCount + 1
	lcSearchFileName = oFile.Name
	WAIT WINDOW "Searching- " + lcSearchFileName + CHR(13) + ;
				"Files Searched: " + ALLTRIM(STR(lnSearchfileCount)) NOWAIT TIMEOUT 3

	THISFORM.Searchfile = lcSearchFileName
	THISFORM.FileAccessDenied = .F.


	DO CASE
		CASE llSearchPrograms AND INLIST(LOWER(JUSTEXT(lcSearchFileName)),"prg","spr","mpr","txt")
			THISFORM.SearchPRG(lcSearchFileName, lcSearchString)
		CASE llSearchForms AND LOWER(JUSTEXT(lcSearchfileName)) = "scx"
			THISFORM.SearchSCX(lcSearchFileName, lcSearchString)

		CASE llSearchClasslibs AND LOWER(JUSTEXT(lcSearchfileName)) = "vcx"
			THISFORM.SearchVCX(lcSearchFileName, lcSearchString)

		CASE LOWER(JUSTEXT(lcSearchfileName)) = "frx"			
*			THISFORM.SearchPRG(lcSearchFileName)
			* Add code to Search reports...
		CASE LOWER(JUSTEXT(lcSearchfileName)) = "mnx"
			THISFORM.SearchMNX(lcSearchFileName, lcSearchString)

		CASE LOWER(JUSTEXT(lcSearchfileName)) = "dbc"
			THISFORM.SearchDBC(lcSearchfileName, lcSearchString)
		
		OTHERWISE 
			* if it is none of these file types, subtract the increment that we added at the beginning of the loop
			lnSearchFileCount = lnSearchfileCount -1
	ENDCASE
ENDFOR

SELE * FROM Targets INTO CURSOR tmp
IF _TALLY = 0
	MESSAGEBOX('Your search produced no results.',64,THISFORM.Caption)
ELSE
	GO TOP IN Targets
ENDIF
USE IN tmp

SET DELETED &lcOldSetDeleted 
CD (lcOldCurDir)

THISFORM.Refresh()

ENDPROC
PROCEDURE searchtarget
LPARA tcSearchString, tcTargetString
IF THISFORM.Pf1.PAge2.chkCaseSensitive.Value
	IF tcSearchString$tcTargetString
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF
ELSE
	IF LOWER(tcSearchString)$LOWER(tcTargetString)
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF
ENDIF
ENDPROC
PROCEDURE sendout
LPARA tcFile,tcObject,tcType

m.FileLoc = tcFile
IF !EMPTY(tcObject)
	m.item = tcObject
ENDIF

IF !EMPTY(tcType)
	m.Descrip = tcType
ENDIF

INSERT INTO Targets FROM MEMVAR

THISFORM.pf1.Page1.grdFiles.Refresh()
THISFORM.pf1.Page1.txtMatches.Refresh()

ENDPROC
PROCEDURE openfile
LPARA lcFile, tcClass

DO CASE
	CASE EMPTY(lcFile)
	CASE ".scx"$LOWER(lcFile)
		MODIFY FORM (lcFile) NOWAIT
	CASE ".vcx"$LOWER(lcFile)
		MODIFY CLASS &tcClass OF (lcFile) NOWAIT
	CASE ".mnx"$LOWER(lcFile)
		MODIFY MENU (lcFile) NOWAIT
	CASE ".prg"$LOWER(lcFile)
		MODIFY COMMAND (lcFile) NOWAIT
	CASE ".spr"$LOWER(lcFile)
		MODIFY COMMAND (lcFile) NOWAIT
	CASE ".qpr"$LOWER(lcFile)
		MODIFY COMMAND (lcFile) NOWAIT
	CASE ".dbc"$LOWER(lcFile)
		MODIFY DATABASE (lcFile) NOWAIT
ENDCASE




ENDPROC
PROCEDURE searchprg
LPARA tcSearchFileName, tcSearchString
IF TYPE('tcSearchFileName') <> "C" OR EMPTY(tcSearchFileName)
	RETURN .F.
ELSE
	lcSearchFileName = tcSearchFileName
	lcSearchString = tcSearchString
ENDIF


IF FILE(lcSearchFileName)
	lnTargetFileTag = FOPEN(lcSearchFileName)
	IF lnTargetFileTag < 0
		* if I could not open the file, cause an error and let the erro method handle it.
		ERROR 1705
		RETURN
	ENDIF
	SET COMPATIBLE ON
	lnFileSize = FSIZE(lcSearchFileName)
	SET COMPATIBLE OFF
	lcWholeFileString = FREAD(lnTargetFileTag, lnFileSize)
	IF THISFORM.SearchTarget(lcSearchString, lcWholeFileString)
		THISFORM.Sendout(lcSearchFilename)
	ENDIF
	FCLOSE(lnTargetFileTag)
ELSE
ENDIF			
ENDPROC
PROCEDURE searchscx
LPARA tcSearchFileName, tcSearchString
IF TYPE('tcSearchFileName') <> "C" OR EMPTY(tcSearchFileName)
	RETURN .F.
ELSE
	lcSearchFileName = tcSearchFileName
	lcSearchString = tcSearchString
ENDIF

opf = THISFORM.Pf1.Page2


llSearchMethods = opf.chkMethods.Value
llSearchProperties = opf.chkProperties.Value
llSearchClasses = opf.chkClasses.Value
llSearchObjectNames = opf.chkObjectNames.Value
llSearchPEMDescrips = opf.chkPEM.Value

IF FILE(lcSearchFileName)
	USE (lcSearchFileName) ALIAS TargetFile IN 0
	IF THISFORM.FileAccessDenied
		RETURN
	ENDIF

	SELE TargetFile

	SCAN
		IF llSearchMethods and THISFORM.SearchTarget(lcSearchString, TargetFile.Methods)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName),"Method")
		ENDIF
		IF llSearchProperties and THISFORM.SearchTarget(lcSearchString, TargetFile.Properties)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName),"Property")
		ENDIF
		IF llSearchClasses and THISFORM.SearchTarget(lcSearchString, TargetFile.Class)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName),"Class")
		ENDIF
		IF llSearchObjectNames and THISFORM.SearchTarget(lcSearchString, TargetFile.ObjName)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName))
		ENDIF
		IF llSearchPEMDescrips and THISFORM.SearchTarget(lcSearchString, TargetFile.Reserved3)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName),"PEM Descrip")
		ENDIF
	ENDSCAN
	USE IN TargetFile
ELSE
ENDIF
ENDPROC
PROCEDURE searchvcx
LPARA tcSearchFileName, tcSearchString
IF TYPE('tcSearchFileName') <> "C" OR EMPTY(tcSearchFileName)
	RETURN .F.
ELSE
	lcSearchFileName = tcSearchFileName
	lcSearchString = tcSearchString
ENDIF

IF FILE(lcSearchFileName)
	USE (lcSearchFileName) ALIAS TargetFile IN 0
	IF THISFORM.FileAccessDenied
		RETURN
	ENDIF

	SELE TargetFile

	SCAN
		IF THISFORM.SearchTarget(lcSearchString, TargetFile.Methods)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName),"Method")
		ENDIF
		IF THISFORM.SearchTarget(lcSearchString, TargetFile.Properties)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName),"Property")
		ENDIF
		IF THISFORM.SearchTarget(lcSearchString, TargetFile.Class)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName),"Class")
		ENDIF
		IF THISFORM.SearchTarget(lcSearchString, TargetFile.ObjName)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName))
		ENDIF
		IF THISFORM.SearchTarget(lcSearchString, TargetFile.Reserved3)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.ObjName),"PEM Descrip")
		ENDIF
	ENDSCAN
	USE IN TargetFile
ELSE
ENDIF
ENDPROC
PROCEDURE searchmnx
LPARA tcSearchFileName, tcSearchString
IF TYPE('tcSearchFileName') <> "C" OR EMPTY(tcSearchFileName)
	RETURN .F.
ELSE
	lcSearchFileName = tcSearchFileName
	lcSearchString = tcSearchString
ENDIF

opf = THISFORM.Pf1.Page2

llSearchBarNames = opf.chkBarNames.Value
llSearchPrompts = opf.chkPrompts.Value
llSearchMenuProcedures = opf.chkProcedures.Value

IF FILE(lcSearchFileName)
	USE (lcSearchFileName) ALIAS TargetFile IN 0
	IF THISFORM.FileAccessDenied
		RETURN
	ENDIF
	SELE TargetFile
	SCAN
		IF llSearchBarNames and THISFORM.SearchTarget(lcSearchString, TargetFile.Name)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.Name),"Bar Name")
		ENDIF
		IF llSearchPrompts and THISFORM.SearchTarget(lcSearchString, TargetFile.Prompt)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.Name),"Bar Prompt")
		ENDIF
		IF llSearchMenuProcedures and THISFORM.SearchTarget(lcSearchString, TargetFile.Procedure)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ALLTRIM(Targetfile.Name),"Procedure")
		ENDIF
	ENDSCAN
	USE IN TargetFile
ELSE
ENDIF
ENDPROC
PROCEDURE searchdbc
LPARA tcSearchFileName, tcSearchString
IF TYPE('tcSearchFileName') <> "C" OR EMPTY(tcSearchFileName)
	RETURN .F.
ELSE
	lcSearchFileName = tcSearchFileName
	lcSearchString = tcSearchString
ENDIF

* Reset
WITH THISFORM.Pf1.Page2
	llSearchStoredProcedures = .chkStoredProcedures.Value
	llSearchfieldIndexNames = .chkFieldIndexNames.Value
	llSearchDBProcedures = .chkDBProcedures.Value
ENDWITH

IF FILE(lcSearchFileName)
	USE (lcSearchFileName) AGAIN ALIAS TargetFile IN 0

	IF THISFORM.FileAccessDenied
		RETURN
	ENDIF
	USE (lcSearchFileName) AGAIN ALIAS LookupCsr IN 0
	
	SELE TargetFile

	SCAN
		IF llSearchFieldIndexNames AND ALLTRIM(ObjectName) == LOWER(ALLTRIM(lcSearchString))
			lnParentid = targetFile.Parentid
			SELE LookupCsr
			LOCATE FOR Objectid = lnParentId
			lcParent = LookupCsr.ObjectName
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), lcParent, TargetFile.ObjectType)
		ENDIF
		IF llSearchDBProcedures AND THISFORM.SearchTarget(lcSearchString, Code)
			THISFORM.Sendout(ALLTRIM(lcSearchFilename), ObjectName, TargetFile.ObjectType)
		ENDIF
	ENDSCAN
	
	SELE TargetFile
	LOCATE FOR ObjectName = "StoredProceduresSource"
	lcTargetString = TargetFile.Code
	IF llSearchStoredProcedures AND THISFORM.SearchTarget(lcSearchString, lcTargetString)
		THISFORM.Sendout(ALLTRIM(lcSearchFilename), "", "Stored procedures")
	ENDIF
	USE IN TargetFile
	USE IN LookupCsr
ELSE
ENDIF
ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine

IF INLIST(nError, 1705, 3) &&and LOWER(cMethod) = "openfile"
	THISFORM.FileAccessDenied = .T.
	MESSAGEBOX("Can't search the file '" + THISFORM.SearchFile + "' because someone else has it open.",64,"Search String")
	RETURN
ELSE
	MESSAGEBOX("Error " + ALLTRIM(STR(nError)) + CHR(13) + ;
					"Message: " + MESSAGE() + CHR(13) + ;
					"Method: " + cMethod + CHR(13) + ;
					"Line: " + ALLTRIM(STR(nLine)) + CHR(13) + ;		
					"Code: " + MESSAGE(1),48,"SearchString")	
	CANCEL
ENDIF



ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR Targets (fileloc C(80), item C(30), descrip C(15))

IF UPPER(VERSION()) <> "VISUAL FOXPRO 06"
	THIS.VFPVersion = "5"
ELSE
	THIS.VFPVersion = "6"
ENDIF

SET MULTILOCKS ON
SET LIBRARY TO HOME() + 'foxtools.fll'
SET EXCLUSIVE OFF

ENDPROC
PROCEDURE Init
*THISFORM.RememberSettings()

WITH THISFORM.cboProjects
	FOR EACH oProject IN _VFP.Projects
		lcProject = oProject.Name
		llItemFound = .F.
		FOR i = 1 TO .ListCount
			IF lcProject == ALLTRIM(.ListItem(i))
				llitemFound = .T.
				EXIT
			ENDIF
		ENDFOR
		IF !llItemFound
			.AddItem(lcProject)
		ENDIF
	ENDFOR
	IF TYPE("_VFP.ActiveProject") = "O"
		.DisplayValue = _VFP.ActiveProject.Name
	ENDIF
ENDWITH

	
ENDPROC
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl
IF nKeyCode = 27
	THISFORM.Release()
	NODEFAULT	
ENDIF
ENDPROC
     #{���    b#  b#                        �   %   �      Y"  N  �          �  U  e R,:�� Searching...�� T�  �C� � � ��� T� �� � � �� T� �C� DELETEv�� G � F� � T�	 �C� Safev�� G.� S� SET SAFE &lcOldSetSafe
 T�
 �� � � �� T� ��
 � � �� T� ��
 � � �� T� ��
 � � �� T� ��
 � � �� T� ��
 � � �� T� ��
 � � �� T� �� �� %�C�  ���x�8 ��C� No search String Specified� � SearchString�x�� B�-�� �& %�C� �� C�	 lcProjectb� C����2 ��C� No Project Specified� � SearchString�x�� B�-�� � %�C� 0
���# %�C� 0
� � .pjxC� @
��{�b ��C�D You have not specified a valid project file to search. Can't finish.� � SearchString�x�� B�-�� � � T� �C�]C��� T� � �� �� T� �C� � �C� �� T� �� �� �� � �  ��� T� �� ��� T�! �� �" ��B R,:������ Searching- �! C� � Files Searched: CC� Z��� T� �# ��! �� T� �$ �-�� H�h���3 �� �# CCC�! ��@� prg� spr� mpr� txt�	���� ��C �!  �  � �% ��  �� � CC�! ��@� scx	���� ��C �!  �  � �& ��  �� � CC�! ��@� vcx	��� ��C �!  �  � �' �� �CC�! ��@� frx��3� �CC�! ��@� mnx��a� ��C �!  �  � �( �� �CC�! ��@� dbc���� ��C �!  �  � �) �� 2��� T� �� ��� � �� o� TargetsǼ�� tmp� %�� � ���5 ��C�  Your search produced no results.�@� �+ �x�� ��	 #� )� � Q�* �! SET DELETED &lcOldSetDeleted 

 ��� �� ��C� �, �� U-  LCSEARCHSTRING THISFORM
 CBOSTRINGS DISPLAYVALUE	 LCPROJECT CBOPROJECTS VALUE LCOLDSETDELETED TARGETS LCOLDSETSAFE OPF PF1 PAGE2 LLCASESENSITIVE CHKCASESENSITIVE LLSEARCHCLASSLIBS CHKCLASSLIBS LLSEARCHPROGRAMS CHKPROGRAMS LLSEARCHFORMS CHKFORMS LLSEARCHMENUS CHKMENUS LLSEARCHDATABASES CHKDATABASES
 FOUNDCOUNT LCOLDCURDIR CURRENTPROJECT OPROJECT PROJECTS LNSEARCHFILECOUNT OFILE FILES LCSEARCHFILENAME NAME
 SEARCHFILE FILEACCESSDENIED	 SEARCHPRG	 SEARCHSCX	 SEARCHVCX	 SEARCHMNX	 SEARCHDBC TMP CAPTION REFRESH�  ��  � � %�� � � � � ��O � %��  � ��< � B�a�� �K � B�-�� � �� � %�C�  @C� @��s � B�a�� �� � B�-�� � � U  TCSEARCHSTRING TCTARGETSTRING THISFORM PF1 PAGE2 CHKCASESENSITIVE VALUE�  ��  � � � T�� ��  �� %�C� �
��= � T�� �� �� � %�C� �
��` � T�� �� �� � r�� Targets�� ��C� � � �	 �
 �� ��C� � � � �
 �� U  TCFILE TCOBJECT TCTYPE FILELOC ITEM DESCRIP THISFORM PF1 PAGE1 GRDFILES REFRESH
 TXTMATCHESC ��  � � H� �<� �C�  ���' � �� .scxC�  @��J � /&��  �:� �� .vcxC�  @��� �, MODIFY CLASS &tcClass OF (lcFile) NOWAIT
 �� .mnxC�  @��� � /��  �:� �� .prgC�  @��� � /���  �:� �� .sprC�  @��� � /���  �:� �� .qprC�  @��� /���  �:� �� .dbcC�  @��<� /���  �:� � U  LCFILE TCCLASS ��  � �- %�C� tcSearchFileNameb� C� C�  ���? � B�-�� �a � T� ��  �� T� �� �� � %�C� 0��� T� �C� ��� %�� � ��� �
 ������ B� � GA � T� �C� ��� GA� T� �C� � ��� %�C �  � � � ��� � ��C � � �	 �� � ��C� ��� �� � U
  TCSEARCHFILENAME TCSEARCHSTRING LCSEARCHFILENAME LCSEARCHSTRING LNTARGETFILETAG
 LNFILESIZE LCWHOLEFILESTRING THISFORM SEARCHTARGET SENDOUT� ��  � �- %�C� tcSearchFileNameb� C� C�  ���? � B�-�� �a � T� ��  �� T� �� �� � T� �� � � �� T� �� �	 �
 �� T� �� � �
 �� T� �� � �
 �� T� �� � �
 �� T� �� � �
 �� %�C� 0���� Q�  �� �� � %�� � ��� B� � F� � ~���" %�� � C � � � � � 	��e�# ��CC� �C� � �� Method� � �� �" %�� � C � � � � � 	����% ��CC� �C� � �� Property� � �� �" %�� � C � � � � � 	����" ��CC� �C� � �� Class� � �� �" %�� � C � � � � � 	��8� ��CC� �C� � �� � �� �" %�� � C � � � � � 	����( ��CC� �C� � �� PEM Descrip� � �� � � Q� � ��� � U  TCSEARCHFILENAME TCSEARCHSTRING LCSEARCHFILENAME LCSEARCHSTRING OPF THISFORM PF1 PAGE2 LLSEARCHMETHODS
 CHKMETHODS VALUE LLSEARCHPROPERTIES CHKPROPERTIES LLSEARCHCLASSES
 CHKCLASSES LLSEARCHOBJECTNAMES CHKOBJECTNAMES LLSEARCHPEMDESCRIPS CHKPEM
 TARGETFILE FILEACCESSDENIED SEARCHTARGET METHODS SENDOUT OBJNAME
 PROPERTIES CLASS	 RESERVED3 ��  � �- %�C� tcSearchFileNameb� C� C�  ���? � B�-�� �a � T� ��  �� T� �� �� � %�C� 0��� Q�  �� �� � %�� � ��� � B� � F� � ~��� %�C � � � � � ��� �# ��CC� �C� �
 �� Method� �	 �� � %�C � � � � � ��0�% ��CC� �C� �
 �� Property� �	 �� � %�C � � � � � ��q�" ��CC� �C� �
 �� Class� �	 �� � %�C � � �
 � � ���� ��CC� �C� �
 �� �	 �� � %�C � � � � � ����( ��CC� �C� �
 �� PEM Descrip� �	 �� � � Q� � �	� � U  TCSEARCHFILENAME TCSEARCHSTRING LCSEARCHFILENAME LCSEARCHSTRING
 TARGETFILE THISFORM FILEACCESSDENIED SEARCHTARGET METHODS SENDOUT OBJNAME
 PROPERTIES CLASS	 RESERVED3� ��  � �- %�C� tcSearchFileNameb� C� C�  ���? � B�-�� �a � T� ��  �� T� �� �� � T� �� � � �� T� �� �	 �
 �� T� �� � �
 �� T� �� � �
 �� %�C� 0���� Q�  �� �� � %�� � ��� � B� � F� � ~���" %�� � C � � � � � 	��A�% ��CC� �C� � �� Bar Name� � �� �" %�� � C � � � � � 	����' ��CC� �C� � ��
 Bar Prompt� � �� �" %�� � C � � � � � 	����& ��CC� �C� � ��	 Procedure� � �� � � Q� � ��� � U  TCSEARCHFILENAME TCSEARCHSTRING LCSEARCHFILENAME LCSEARCHSTRING OPF THISFORM PF1 PAGE2 LLSEARCHBARNAMES CHKBARNAMES VALUE LLSEARCHPROMPTS
 CHKPROMPTS LLSEARCHMENUPROCEDURES CHKPROCEDURES
 TARGETFILE FILEACCESSDENIED SEARCHTARGET NAME SENDOUT PROMPT	 PROCEDUREk ��  � �- %�C� tcSearchFileNameb� C� C�  ���? � B�-�� �a � T� ��  �� T� �� �� � ��� � � ��� � T� ��� �	 �� T�
 ��� �	 �� T� ��� �	 �� �� %�C� 0��\� Q�  �� ��� � %�� � ��� � B� � Q�  �� ��� � F� � ~��� %��
 � C� �CC� �@	��|� T� �� � �� F� � -�� � �� T� �� � �� ��CC� � � � � � � �� �  %�� � C �  � � � 	���� ��CC� � � � � � � �� � � F� �$ -�� � StoredProceduresSource�� T� �� � ��  %�� � C �  � � � 	��H�) ��CC� ��  � Stored procedures� � �� � Q� � Q� � �d� � U  TCSEARCHFILENAME TCSEARCHSTRING LCSEARCHFILENAME LCSEARCHSTRING THISFORM PF1 PAGE2 LLSEARCHSTOREDPROCEDURES CHKSTOREDPROCEDURES VALUE LLSEARCHFIELDINDEXNAMES CHKFIELDINDEXNAMES LLSEARCHDBPROCEDURES CHKDBPROCEDURES
 TARGETFILE FILEACCESSDENIED	 LOOKUPCSR
 OBJECTNAME
 LNPARENTID PARENTID OBJECTID LCPARENT SENDOUT
 OBJECTTYPE SEARCHTARGET CODE LCTARGETSTRING4 ��  � � � %�C�  ������� � T� � �a��d ��C� Can't search the file '� � �# ' because someone else has it open.�@� Search String�x�� B� �-�� ��C� Error CC�  Z�C� �	 Message: CEC� � Method: � C� � Line: CC� Z�C� � Code: C�E�0� SearchString�x�� � � U  NERROR CMETHOD NLINE THISFORM FILEACCESSDENIED
 SEARCHFILE� 	 ��C���= h�� Targets� � C��P�� � C���� � C����" %�CChf� VISUAL FOXPRO 06��y � T� � �� 5�� �� � T� � �� 6�� � G_ � Gb(�C�Q� foxtools.fll�� G� U  TARGETS FILELOC ITEM DESCRIP THIS
 VFPVERSION�  ���  � ��� � �� �C� �� � T� �� � �� T� �-�� �� ���(��� ��� � %�� CC � ��	 ���| � T� �a�� !� � �� %�� 
��� � ��C � ��
 �� � ��& %�C� _VFP.ActiveProjectb� O��� � T�� ��C� � �� � �� U  THISFORM CBOPROJECTS OPROJECT PROJECTS	 LCPROJECT NAME LLITEMFOUND I	 LISTCOUNT LISTITEM ADDITEM DISPLAYVALUE ACTIVEPROJECT4  ��  � � %��  ���- � ��C� � �� �� � U  NKEYCODE NSHIFTALTCTRL THISFORM RELEASE search,     �� searchtarget�    �� sendout�    �� openfile�	    ��	 searchprg     ��	 searchscx�    ��	 searchvcx�    ��	 searchmnx�    ��	 searchdbc�    �� Error�    �� Load    �� Init�    �� KeyPresst    ��1 qR2Ra r 1a A �2111111� � �q A b!q A 1!q A A "c� ""� � 1QQQ��Q�Q� A A �Q� � A � � � 3 � �q � q A � Qq � q A A 2 � � � A � A ba3 � � � q� q�q� q� q� q� q� A 6 � �q � � � A � � � A A a � a !�A � � A 2 � �q � � � A 231111� 1A A r � !1A !QA !!A !�A !�A A � � A 2 � �q � � � A � 1A A r � �1A �QA �!A ��A ��A A � � A 2 � �q � � � A 2211� 1A A q � !QA !qA !aA A � � A 2 � �q � � � A 3A � AA A Ar � �q � �A �A A r A�A � � � A 2 � b� AA � eA A 5 � �"� A b �a 3 � ��� A A A � � A A a1A A 4 � � A A 1                       �
     F   �
  �  d   U   �  �  t   a   �  �  �   t     �  �   �   �    �   �   '  �  �   �   �  7!    �   W!  �&  4     '  )  f  *  9)  D*  y  5  _*  ,  �  H  ,,  �,  �   )   b#                        �currentproject
vfpversion
fileaccessdenied
searchfile
*search 
*searchtarget 
*sendout 
*openfile 
*searchprg 
*searchscx 
*searchvcx 
*searchmnx 
*searchdbc 
      macpageframe      ..\common\vcx\macbase.vcx      	pageframe      pf1      frmSearchString     ErasePage = .T.
PageCount = 2
Top = 60
Left = 12
Width = 540
Height = 276
TabIndex = 6
resizewithbottom = .T.
resizewithright = .T.
Name = "pf1"
Page1.Caption = "File List"
Page1.Name = "Page1"
Page2.Caption = "Search \<Options"
Page2.Name = "Page2"
      macgrid      ..\common\vcx\macbase.vcx      grid      grdfiles      frmSearchString.pf1.Page1     |ColumnCount = 3
DeleteMark = .F.
GridLines = 0
Height = 192
Left = 11
Panel = 1
ReadOnly = .T.
RecordMark = .F.
RecordSource = "Targets"
ScrollBars = 2
Top = 8
Width = 516
resizewithbottom = .T.
resizewithright = .T.
highlightcolor = 16760767
resizecolumns = .T.
Name = "grdfiles"
Column1.ControlSource = "targets.fileloc"
Column1.Width = 272
Column1.ReadOnly = .T.
Column1.Name = "Column1"
Column2.ControlSource = "targets.item"
Column2.Width = 136
Column2.ReadOnly = .T.
Column2.Name = "Column2"
Column3.ControlSource = "targets.descrip"
Column3.Width = 86
Column3.ReadOnly = .T.
Column3.Name = "Column3"
      �PROCEDURE DblClick
THISFORM.OpenFile(targets.fileloc, Targets.Item)

ENDPROC
PROCEDURE createindextags
SELE Targets
INDEX ON FileLoc TAG FileLoc
INDEX ON Descrip TAG Descrip
INDEX ON item TAG item
ENDPROC
     ~���    e  e                        ^�   %   �            �           �  U    ��C� � � � �  � �� U  THISFORM OPENFILE TARGETS FILELOC ITEM4  F�  � & �� ��� � & �� ��� � & �� ��� � U  TARGETS FILELOC DESCRIP ITEM DblClick,     �� createindextagsx     ��1 �3 q � � � 1                       F         l   �       )   e                        header      header      Header1      *frmSearchString.pf1.Page1.grdfiles.Column1      $Caption = "File"
Name = "Header1"
      
mactextbox      ..\common\vcx\macbase.vcx      textbox      Text1      *frmSearchString.pf1.Page1.grdfiles.Column1       ReadOnly = .T.
Name = "Text1"
      >PROCEDURE DblClick
THIS.Parent.Parent.DblClick()

ENDPROC
      ����    �   �                         �   %   ^       v      p           �  U    ��C�  � � � �� U  THIS PARENT DBLCLICK DblClick,     ��1 12                       3       )   �                         header      header      Header1      *frmSearchString.pf1.Page1.grdfiles.Column2      &Caption = "Object"
Name = "Header1"
      
mactextbox      ..\common\vcx\macbase.vcx      textbox      Text1      *frmSearchString.pf1.Page1.grdfiles.Column2       ReadOnly = .T.
Name = "Text1"
      >PROCEDURE DblClick
THIS.PArent.Parent.DblClick()

ENDPROC
      ����    �   �                         �   %   ^       v      p           �  U    ��C�  � � � �� U  THIS PARENT DBLCLICK DblClick,     ��1 12                       3       )   �                         header      header      Header1      *frmSearchString.pf1.Page1.grdfiles.Column3      $Caption = "Type"
Name = "Header1"
      
mactextbox      ..\common\vcx\macbase.vcx      textbox      Text1      *frmSearchString.pf1.Page1.grdfiles.Column3      =BorderStyle = 0
Margin = 0
ReadOnly = .T.
Name = "Text1"
      >PROCEDURE DblClick
THIS.PArent.Parent.DblClick()

ENDPROC
      ����    �   �                         �   %   ^       v      p           �  U    ��C�  � � � �� U  THIS PARENT DBLCLICK DblClick,     ��1 12                       3       )   �                         maclabel      ..\common\vcx\macbase.vcx      label      	Maclabel1      frmSearchString.pf1.Page1      }AutoSize = .F.
Caption = "Matches:"
Height = 15
Left = 11
Top = 200
Width = 50
locktobottom = .T.
Name = "Maclabel1"
      
mactextbox      ..\common\vcx\macbase.vcx      textbox      
txtmatches      frmSearchString.pf1.Page1      �Alignment = 3
BorderStyle = 0
Value = 0
Height = 12
Left = 71
Margin = 0
ReadOnly = .T.
Top = 200
Width = 34
locktobottom = .T.
locktoright = .F.
Name = "txtmatches"
      >PROCEDURE Refresh
THIS.Value = RECCOUNT('Targets')
ENDPROC
      ����    �   �                         k�   %   Y       p      j           �  U    T�  � �C� TargetsN�� U  THIS VALUE Refresh,     ��1 �1                       3       )   �                         maccommandbutton      ..\common\vcx\macbase.vcx      commandbutton      	cmdsearch      frmSearchString.pf1.Page1      �Top = 212
Left = 215
Width = 84
Caption = "\<Search!"
Default = .F.
TabIndex = 7
locktobottom = .T.
locktoright = .T.
Name = "cmdsearch"
      LPROCEDURE Click
THISFORM.pf1.ActivePage = 1
THISFORM.Search()

ENDPROC
      ����    �   �                         Ё   %   v       �      �           �  U  #  T�  � � ���� ��C�  � �� U  THISFORM PF1
 ACTIVEPAGE SEARCH Click,     ��1 1� 2                       A       )   �                         maccommandbutton      ..\common\vcx\macbase.vcx      commandbutton      Maccommandbutton1      frmSearchString.pf1.Page1      �Top = 212
Left = 347
Height = 23
Width = 180
Caption = "Sa\<ve List as..."
locktobottom = .T.
locktoright = .T.
Name = "Maccommandbutton1"
     QPROCEDURE Refresh
THIS.Enabled = RECCOUNT('Targets') > 0


ENDPROC
PROCEDURE Click
SELE targets
lcSaveFile = PROPER(PUTFILE("Save as","SearchResults.dbf","dbf"))
IF !EMPTY(lcSaveFile)
	COPY TO (lcSaveFile)
	MESSAGEBOX(ALLTRIM(STR(RECCOUNT('Target'))) + " records saved to " + lcSaveFile,48,THISFORM.Caption)
ENDIF

ENDPROC
     ����    �  �                        ��   %   !      U  
   A          �  U     T�  � �C� TargetsN� �� U  THIS ENABLED�  F�  �2 T� �CC� Save as� SearchResults.dbf� dbf¼�� %�C� �
��� � (�� ��; ��CCCC� TargetNZ��  records saved to � �0� � �x�� � U  TARGETS
 LCSAVEFILE THISFORM CAPTION Refresh,     �� Click_     ��1 �4 q !� �A 2                       =         Y   F      )   �                        shape      shape      Shape2      frmSearchString.pf1.Page2      tTop = 92
Left = 191
Height = 88
Width = 144
BorderStyle = 1
SpecialEffect = 0
ZOrderSet = 0
Name = "Shape2"
      shape      shape      Shape1      frmSearchString.pf1.Page2      tTop = 44
Left = 11
Height = 136
Width = 169
BorderStyle = 1
SpecialEffect = 0
ZOrderSet = 1
Name = "Shape1"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkcasesensitive      frmSearchString.pf1.Page2      �Top = 12
Left = 23
Height = 17
Width = 102
AutoSize = .F.
Caption = "Case Sensitive"
Value = .F.
TabIndex = 1
ZOrderSet = 2
Name = "chkcasesensitive"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkforms      frmSearchString.pf1.Page2      �Top = 36
Left = 23
Height = 17
Width = 55
AutoSize = .F.
BackStyle = 1
Caption = "Forms"
Value = .T.
TabIndex = 2
ZOrderSet = 3
Name = "chkforms"
     !PROCEDURE InteractiveChange
DODEFAULT()
IF THIS.Value
	THIS.Parent.chkMethods.Enabled = .T.
	THIS.Parent.chkProperties.Enabled = .T.
	THIS.Parent.chkClasses.Enabled = .T.
	THIS.Parent.chkObjectNames.Enabled = .T.
	THIS.Parent.chkPEM.Enabled = .T.
ELSE
	THIS.Parent.chkMethods.Enabled = .F.
	THIS.Parent.chkProperties.Enabled = .F.
	THIS.Parent.chkClasses.Enabled = .F.
	THIS.Parent.chkObjectNames.Enabled = .F.
	THIS.Parent.chkPEM.Enabled = .F.
ENDIF
	
ENDPROC
PROCEDURE ProgrammaticChange
THIS.InteractiveChange()

ENDPROC
     w���    ^  ^                        �   %   �           �          �  U  � 	 ��C��� %��  � ��} � T�  � � � �a�� T�  � � � �a�� T�  � � � �a�� T�  � � � �a�� T�  � � � �a�� �� � T�  � � � �-�� T�  � � � �-�� T�  � � � �-�� T�  � � � �-�� T�  � � � �-�� � U	  THIS VALUE PARENT
 CHKMETHODS ENABLED CHKPROPERTIES
 CHKCLASSES CHKOBJECTNAMES CHKPEM  ��C�  � �� U  THIS INTERACTIVECHANGE InteractiveChange,     �� ProgrammaticChange}    ��1 � AAAAA� AAAAAA 3 � 2                       �        �        )   ^                        registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkproperties      frmSearchString.pf1.Page2      �Top = 60
Left = 35
Height = 17
Width = 76
AutoSize = .F.
Caption = "Properties"
Value = .T.
TabIndex = 3
ZOrderSet = 4
Name = "chkproperties"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      
chkmethods      frmSearchString.pf1.Page2      �Top = 84
Left = 35
Height = 17
Width = 66
AutoSize = .F.
Caption = "Methods"
Value = .T.
TabIndex = 4
ZOrderSet = 5
Name = "chkmethods"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      
chkclasses      frmSearchString.pf1.Page2      �Top = 108
Left = 35
Height = 17
Width = 66
AutoSize = .F.
Caption = "Classes"
Value = .T.
TabIndex = 5
ZOrderSet = 6
Name = "chkclasses"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkobjectnames      frmSearchString.pf1.Page2      �Top = 132
Left = 35
Height = 17
Width = 98
AutoSize = .F.
Caption = "Object Names"
Value = .T.
TabIndex = 6
ZOrderSet = 7
Name = "chkobjectnames"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkPEM      frmSearchString.pf1.Page2      �Top = 156
Left = 35
Height = 17
Width = 117
AutoSize = .F.
Caption = "PEM Descriptions"
Value = .T.
TabIndex = 7
ZOrderSet = 8
Name = "chkPEM"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkprograms      frmSearchString.pf1.Page2      �Top = 60
Left = 203
Height = 17
Width = 74
AutoSize = .F.
Caption = "Programs"
Value = .T.
TabIndex = 10
ZOrderSet = 10
Name = "chkprograms"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkmenus      frmSearchString.pf1.Page2      �Top = 84
Left = 203
Height = 17
Width = 56
AutoSize = .F.
BackStyle = 1
Caption = "Menus"
Value = .T.
TabIndex = 11
ZOrderSet = 11
Name = "chkmenus"
     �PROCEDURE InteractiveChange
DODEFAULT()
IF THIS.Value
	THIS.Parent.chkBarNames.Enabled = .T.
	THIS.Parent.chkPrompts.Enabled = .T.
	THIS.Parent.chkProcedures.Enabled = .T.
ELSE
	THIS.Parent.chkBarNames.Enabled = .F.
	THIS.Parent.chkPrompts.Enabled = .F.
	THIS.Parent.chkProcedures.Enabled = .F.
ENDIF
	
ENDPROC
PROCEDURE ProgrammaticChange
THIS.InteractiveChange()

ENDPROC
     ���    �  �                        a   %   C      �     z          �  U  � 	 ��C��� %��  � ��U � T�  � � � �a�� T�  � � � �a�� T�  � � � �a�� �� � T�  � � � �-�� T�  � � � �-�� T�  � � � �-�� � U  THIS VALUE PARENT CHKBARNAMES ENABLED
 CHKPROMPTS CHKPROCEDURES  ��C�  � �� U  THIS INTERACTIVECHANGE InteractiveChange,     �� ProgrammaticChange    ��1 � AAA� AAAA 3 � 2                       9        b  |      )   �                        registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkbarnames      frmSearchString.pf1.Page2      �Top = 108
Left = 215
Height = 17
Width = 84
AutoSize = .F.
Caption = "Bar Names"
Value = .T.
TabIndex = 12
ZOrderSet = 12
Name = "chkbarnames"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      
chkprompts      frmSearchString.pf1.Page2      �Top = 132
Left = 215
Height = 17
Width = 66
AutoSize = .F.
Caption = "Prompts"
Value = .T.
TabIndex = 13
ZOrderSet = 13
Name = "chkprompts"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkprocedures      frmSearchString.pf1.Page2      �Top = 156
Left = 215
Height = 17
Width = 83
AutoSize = .F.
Caption = "Procedures"
Value = .T.
TabIndex = 14
ZOrderSet = 14
Name = "chkprocedures"
      shape      shape      Shape3      frmSearchString.pf1.Page2      uTop = 91
Left = 365
Height = 88
Width = 162
BorderStyle = 1
SpecialEffect = 0
ZOrderSet = 15
Name = "Shape3"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkStoredProcedures      frmSearchString.pf1.Page2      �Top = 107
Left = 389
Height = 17
Width = 126
AutoSize = .F.
Caption = "Stored Procedures"
Value = .T.
TabIndex = 12
ZOrderSet = 16
Name = "chkStoredProcedures"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkFieldIndexNames      frmSearchString.pf1.Page2      �Top = 131
Left = 389
Height = 17
Width = 126
AutoSize = .F.
Caption = "Field/ Index  Names"
Value = .T.
TabIndex = 13
ZOrderSet = 17
Name = "chkFieldIndexNames"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkDBProcedures      frmSearchString.pf1.Page2      �Top = 155
Left = 389
Height = 17
Width = 83
AutoSize = .F.
Caption = "Procedures"
Value = .T.
TabIndex = 14
ZOrderSet = 18
Name = "chkDBProcedures"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkClasslibs      frmSearchString.pf1.Page2      ]Top = 37
Left = 203
Height = 16
Width = 96
Caption = "Classlibs"
Name = "chkClasslibs"
      registrycheckbox      ..\common\vcx\registry.vcx      checkbox      chkdatabases      frmSearchString.pf1.Page2      �Top = 83
Left = 376
Height = 17
Width = 84
AutoSize = .F.
BackStyle = 1
Caption = "Databases"
Value = .T.
TabIndex = 8
ZOrderSet = 19
Name = "chkdatabases"
     SPROCEDURE anychange
IF THIS.Value
	THIS.Parent.chkStoredProcedures.Enabled = .T.
	THIS.Parent.chkFieldIndexNames.Enabled = .T.
	THIS.Parent.chkDBProcedures.Enabled = .T.
ELSE
	THIS.Parent.chkStoredProcedures.Enabled = .F.
	THIS.Parent.chkFieldIndexNames.Enabled = .F.
	THIS.Parent.chkDBProcedures.Enabled = .F.
ENDIF
	
ENDPROC
     ����    �  �                        .   %         H     2          �  U  �  %��  � ��L � T�  � � � �a�� T�  � � � �a�� T�  � � � �a�� �� � T�  � � � �-�� T�  � � � �-�� T�  � � � �-�� � U  THIS VALUE PARENT CHKSTOREDPROCEDURES ENABLED CHKFIELDINDEXNAMES CHKDBPROCEDURES	 anychange,     ��1 AAA� AAAA 2                       H      )   �                        label      label      Label1      frmSearchString      xAutoSize = .F.
Caption = "S\<earch for:"
Height = 14
Left = 12
Top = 10
Width = 60
TabIndex = 1
Name = "Label1"
      registrycombo      ..\common\vcx\registry.vcx      combobox      
cboStrings      frmSearchString      DHeight = 23
Left = 12
Top = 24
Width = 216
Name = "cboStrings"
      maclabel      ..\common\vcx\macbase.vcx      label      	Maclabel1      frmSearchString      nCaption = "Search in:"
Height = 15
Left = 312
Top = 12
Width = 72
locktoright = .T.
Name = "Maclabel1"
      maccombobox      ..\common\vcx\macbase.vcx      combobox      cboProjects      frmSearchString      FHeight = 23
Left = 312
Top = 24
Width = 240
Name = "cboProjects"
      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
    %                       Jp�(    �+ ( �  k:\searchstring\searchstring.scx� U  K0 ^   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _REK10GEBH 558532626a
      �  J
      �                      ~
  u
              �
               COMMENT RESERVED                        �
      �
                                                           WINDOWS _REK10GYF0 558532641"      �        �                      <  3              I               COMMENT RESERVED                        W                                                                   WINDOWS _REK10HAYS 558532650p      %  ^      A                      �                �               COMMENT RESERVED                        �                                                                   WINDOWS _REK10HQ1S 558532659�      `  �      �                      �  �              �               COMMENT RESERVED                        �                                                                   WINDOWS _REK10JPCJ 558532709E      �  5                              R              O               COMMENT RESERVED                        ]                                                                   WINDOWS _REK10L899 558532748      `        -                        �              �               COMMENT RESERVED                        �                                                                   WINDOWS _REK10NC44 558532800�      @  �                             4                               COMMENT RESERVED                        �                                                                   WINDOWS _REK10PWPJ 558532864%      �  6      J                                                     COMMENT RESERVED                        �                                                                   WINDOWS _REK10IXYN 596672854�      �  w      �      �.  ,~         [  m  |                           WINDOWS _REK10IXZ8 586046580p      d  �  �  $                                          �               COMMENT RESERVED                        n      N                                                           WINDOWS _RN015PCDO 627728484�=  >  �=  �=      0M      ��  m�         �+  m  �          9)               COMMENT RESERVED                        �=                                                                   WINDOWS _REK10M8D6 629238448�E      �E  �E      �G                      �E                D               COMMENT RESERVED                        pE      �C                                                           WINDOWS _REK10KUWU 629625420      �  �      9K      W  *a               =          F               COMMENT RESERVED                        �                                                                   WINDOWS _S4R0Y1UB9 648707719P  v  #  �      E      �{  �1         E    �          x               COMMENT RESERVED                        b                                                                   WINDOWS _REK10RRJ7 651586222�I      �I  PE      SB      S6 E�         �C  �(  tf          �I               COMMENT RESERVED                        �B                                                                   WINDOWS _REK10Q9B8 651975254�D      Y  ?(      �                      $E  V,              l,               COMMENT RESERVED                        �(                                                                   WINDOWS _REK10LP20 651983097E      �I  8      �L      OX  �k          ;-  T-  M�          �I               COMMENT RESERVED                        �=      dG                                                           WINDOWS _REK10MQ2R 652038645�(      &)  )      KQ      �  �          ](  �  �          �'               COMMENT RESERVED                        n'      E'                                                           WINDOWS _RSY0N8DC4 654076494%K  ?  �C  �.      �+      ��  �            	*  �?          =  ;N           WINDOWS _RSY0N8DCO 648370213g$  )<  �)  ,  bE  �5      �L  �G                                               WINDOWS _RSY0N8DDI 654076494�C  T$  OG  �9  DJ  �E      �]  7\                                               WINDOWS _RSY0N8DE2 654076494d=  |=  J  �=  �>  �F      he  �U                                               WINDOWS _RSY0N8DEM 648370213<  �  ~F  $  :  �      �A  #@                                               COMMENT RESERVED                        K      Z?                                                           WINDOWS _S810QSPDT 656499653o.      -(        �<              ��  T  b  <              1               COMMENT RESERVED                        �                                                                   WINDOWS _S7A0W0YSQ 656888686�,  �  &  �,       ,      ��  x          ]-  W  u+          �:               WINDOWS _S7A0WGOC0 656888307  @  S  }    �      _  �:                                               WINDOWS _S7A0WGOD4 656888307�    -  �  R  �      v  �4                                               WINDOWS _REK10GEBH 654670204  a  t  �  ?  �$        j-                                               WINDOWS _S7A0WGOEI 654670204�  �  �  �  �  �'      t  *                                               WINDOWS _S7A0WGOFC 654670205U  �  �    %  j(        �                                               WINDOWS _S7A0WGOFW 654670205 '  (  (  z,  �,  &:      �)  �"                                               COMMENT RESERVED                        �=      -                                                           WINDOWS _REK10RE5O 658211396~      �  �      L<      +�  Z          q  �  �          �               COMMENT RESERVED                        h                                                                   WINDOWS _RLP0S2HI4 660374966�&  �&  �&  �&      RJ  Z&  s� '�         �&  �  ��          �&  �&  H&       COMMENT RESERVED                        8&                                                                 WINDOWS _REK10QM46 661211890      '  &&      .9      �K  q6          �    ��          {               COMMENT RESERVED                        i      �,                                                           WINDOWS _REK10R18K 662197878w      G,  �      �;      {�  J,         a  n  �g          S               COMMENT RESERVED                        A                                                                 WINDOWS _SA40OGYO0 662786356Z  7  H-  J      D      � Q�          �I  )%  �n          BE               COMMENT RESERVED                        �E      �I                                                           WINDOWS _S870R210X 663585273�B  aC  SC  �B      :C      ]�  S          �B  �  C          �B               COMMENT RESERVED                        �B                                                                   WINDOWS _0060XAJLE 673612353�9  �8  �  9      �H                      �9  �              �9               COMMENT RESERVED                        :                                                                   WINDOWS _S6Q0QWFIW 675506499,  &  
  �      �9      �� �E         C  7  ��            �
           COMMENT RESERVED                                                                                           WINDOWS _REK10FWTE 675827917�C      J  'G      �#      փ  �N          8'  �
  �^          	               COMMENT RESERVED                        �<      ?                                                           WINDOWS _S4B0IY5NQ 6760212961E  �>  tC  �C      [c      K� ��          �C  �           E               COMMENT RESERVED                        |I                                                                   WINDOWS _REK0OX25H 678067803?G      <<  1J      C>      �  ʝ          _,  l+  D�          O(               COMMENT RESERVED                        G?      �A                                                           WINDOWS _REK0OQAMQ 678067814�      '  �      �*      ��  �r          A  =  ?�          �               COMMENT RESERVED                        �      l                                                           WINDOWS _S0F0UNRKO 679236465�%      �%  �%      18      �� �          �%  �%  ��          �%               COMMENT RESERVED                        �%                                                                   WINDOWS _S870R74MP 679248897�  u%  �  �      W%      id            �  �  2%          o               COMMENT RESERVED                        �                                                                   WINDOWS _SA50YDFGP 681069907�  �,  7  �,      E.      �� �           �  �          f               COMMENT RESERVED                        �                                                                  *WINDOWS _REK10JCLT 681210694�5      "9  �8      
�      �U ��         b.  :  F�         &              *COMMENT RESERVED                        �%      >                                                           WINDOWS _REK10I3SN 683037091�$      �)  �)      �M      6� �          �  �  g         �               COMMENT RESERVED                        �)      Y)                                                           WINDOWS _REK10OU73 683037101�      G)  �       A      ��  �  � �  �  �  k          �               COMMENT RESERVED                        �                                                                   WINDOWS _REK10IKD2 683245647�               �      p4 c�         �  �  �         �               COMMENT RESERVED                        �      �                                                          *WINDOWS _REK10JCLT 683247364i�     ^ Z�     *^     �_ U�         ~� u� U�         ��             *COMMENT RESERVED                        ��     ��                                                          WINDOWS _REK10JCLT 683566601�     ݺ �     ��     �� ��         � � �         �              COMMENT RESERVED                        �     �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           VERSION =   3.00      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      
mactextbox      Pixels      Class      1      textbox      
mactextbox      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      macform      Pixels      Class      1      form      macform      form       
 registry.h��ō\'      macbase.vcx      grdchild      macgrid      
macspinner      Pixels      macolecontrol      Pixels      Class      1      
olecontrol      Pixels      1      1      macbase.vcx      
maclistbox      oleie      	container      1      macbase.vcx      listbox      Class      Pixels      lstFrom      Class      SHeight = 120
Left = 0
MultiSelect = .F.
Top = 0
Width = 144
Name = "lstFrom"
      image      ,Height = 68
Width = 68
Name = "macimage"
      macimage      image      1      Class      mactimer      Pixels      Pixels      SHeight = 120
Left = 228
MultiSelect = .F.
Top = 0
Width = 144
Name = "lstTo"
      
maclistbox      macbase.vcx      1      ctrmover      listbox      1      Class      ctrmover      setting      Class      timer      mactimer      "itraceinterval
iregularinterval
      timer      1      macolecontrol      1      1      1      1      maccommandbutton      cmdtop      1      Class      	maccustom      macbase.vcx      commandbutton      asynchtimer      mactimer      asynchtimer      1      setting      lstTo      timer      
bondchunks      Class      cusapp      Pixels      	maccustom      1      Pixels      +OLEObject = C:\WINNT\System32\SHDOCVW.DLL
      cmdMoverAllTo      maccommandbutton      commandgroup      macseperator     fButtonCount = 2
Value = 1
Height = 58
Width = 81
Name = "maccommandgroup"
Command1.Top = 5
Command1.Left = 5
Command1.Height = 23
Command1.Width = 71
Command1.Caption = "Command1"
Command1.Name = "Command1"
Command2.Top = 30
Command2.Left = 5
Command2.Height = 23
Command2.Width = 71
Command2.Caption = "Command2"
Command2.Name = "Command2"
      maccommandgroup      commandgroup      1      Class      Pixels      maccommandgroup      !Arial, 0, 9, 5, 13, 11, 11, 2, 0
      Base application object      1      Pixels      Class      1      	separator      macseperator      .Height = 0
Width = 0
Name = "macseperator"
      	separator      OLEClass = WordPad Document
      	container      Class      2Width = 200
Height = 200
Name = "maccontainer"
      maccontainer      	container      1      Class      Pixels      maccontainer      �resizetobottom
resizetoright
locktobottom
locktoright
heightdifference
widthdifference
disttoformbottom
disttoformright
*reposition 
      Class      Pixels      1      control      Class      Name = "maccontrol"
      
maccontrol      control      1      Class      Pixels      
maccontrol      macoleboundcontrol      oleboundcontrol      macoleboundcontrol      8Height = 100
Width = 100
Name = "macoleboundcontrol"
      oleboundcontrol      7      custom      
macformset      Name = "maccustom"
      	maccustom      custom      1      Class      Pixels      	maccustom      maclabel      Class      1      label      custom      Pixels      ctrmover      Pixels      macimage      2      5PROCEDURE DblClick
THIS.Parent.MoveFrom()
ENDPROC
      macbase.vcx      commandbutton      maclabel      	cmdMoveTo      cusapp      custom      5PROCEDURE Click
THIS.Parent.MoveAllTo()

ENDPROC
      maccommandbutton      1      macbase.vcx      macbase.vcx      1      �Top = 1
Left = 169
Height = 23
Width = 56
Picture = ..\bmp\bottom.bmp
Caption = ""
ToolTipText = "Go to last record"
Name = "cmdbottom"
      Pixels      macvcr      shape      Pixels      2PROCEDURE Click
THIS.Parent.MoveTo()

ENDPROC
      ctrmover      oleie      1      formset      macbase.vcx      macline      4PROCEDURE Click
THIS.Parent.MoveFrom()

ENDPROC
      Class      !Arial, 0, 9, 5, 15, 12, 21, 3, 0
      
macformset      
macformset      Form1      maccheckbox      1      commandbutton      Pixels      checkbox      Pixels      Class      line      macline      +Height = 68
Width = 68
Name = "macline"
      line      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      maccheckbox      Class      	maccustom      setting
oldvalue
      label      Pixels      label      Pixels      Class      8DoCreate = .T.
Caption = "MACFORMSET"
Name = "Form1"
      form      form      >*buildde 
*buildreport 
*preview 
*printit 
*sendreport 
      Name = "macformset"
      formset      ����    �   �                         k�   %   [       p      j           �  U    ��C�  � � �� U  THIS PARENT MOVEFROM Click,     ��1 2                       )       )   �                         1      ,Height = 68
Width = 68
Name = "macshape"
      cmdMoveFrom      spinner      checkbox      custom      Name = "setting"
      5PROCEDURE DblClick
THIS.Parent.MoveTo()

ENDPROC
      �DataSession = 2
Height = 295
Width = 565
ShowWindow = 1
DoCreate = .T.
ShowTips = .T.
BufferMode = 2
AutoCenter = .T.
Caption = ""
stretchable = .T.
registryapp = Software\MAC\TMR\1.0\
autoedit = .T.
Name = "macform"
     v���    ]  ]                        ��   %   �      �     �          �  U  _  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  �	 �� � U
  THIS LOCKTOBOTTOM TOP THISFORM HEIGHT DISTTOFORMBOTTOM LOCKTORIGHT LEFT WIDTH DISTTOFORMRIGHT_  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  � �� � U  THIS RESIZETOBOTTOM HEIGHT THISFORM HEIGHTDIFFERENCE RESIZETORIGHT WIDTH WIDTHDIFFERENCEk  T�  � �� � �  � �� T�  � �� � �  � �� T�  � �� � �  � �� T�  � �� � �  �	 �� U
  THIS HEIGHTDIFFERENCE THISFORM HEIGHT WIDTHDIFFERENCE WIDTH DISTTOFORMBOTTOM TOP DISTTOFORMRIGHT LEFT
 reposition,     �� Resize�     �� Init�    ��1 �A �A 3 �A �A 3 ����2                       �         �     
      �  n      )   ]                       ����    �  �                        xF   %         G  
   3          �  U  >  ��  � � T� � ��  �� T� � �� �� T� � ��d�� U  TOCALLER TCMETHOD THIS OCALLER METHOD INTERVALJ  T�  � �� ��) ��C� THIS.oCaller� .�  � � ()��� T�  � ���� U  THIS INTERVAL METHOD OCALLER domethod,     �� Timer�     ��1 � 3 �� 2                       t         �   �       )   �                       )���                               &   %   �      �  6             �  U  �  T�  �� � �� %��  � � ��Q � %�� � ��A � T� ���� �M � B� � �j � T� ��  ��� � T� � �� �� U  LNCURRENTPAGEORDER THIS
 ACTIVEPAGE	 PAGECOUNT FIRSTAFTERLAST LNSEEKORDER[  ��  � ��  � � �H � %��  � � � ��D � T� � ��  �� !� � �� B�� � �� U  LOPAGE THIS PAGES	 PAGEORDER
 ACTIVEPAGE CURRENTPAGE�  %��  � ��2 �" T�  � �� � �  � �  � �� � %��  � ��h �" T�  � �� � �  � �  �	 �� � ��
 �  � �� � �� �
 � �� �  %�C� �
 Reposition��h��� � ��C� � �� � %�C� � Resize��h��� � ��C� � �� � �� �� U  THIS RESIZEWITHBOTTOM HEIGHT THISFORM DISTANCETOFORMBOTTOM TOP RESIZEWITHRIGHT WIDTH DISTANCETOFORMRIGHT LEFT OPAGE PAGES OCONTROL CONTROLS
 REPOSITION RESIZEG " T�  � �� � �  � �  � ��" T�  � �� � �  � �  � �� U  THIS DISTANCETOFORMBOTTOM THISFORM HEIGHT TOP DISTANCETOFORMRIGHT WIDTH LEFT�  T�  �� � �� %��  ���Q � %�� � ��A � T� �� � �� �M � B� � �j � T� ��  ��� � T� � �� �� U  LNCURRENTPAGEORDER THIS
 ACTIVEPAGE FIRSTAFTERLAST LNSEEKORDER	 PAGECOUNT
 gonextpage,     �� currentpage_access�     �� Resize�    �� InitB    �� gopreviouspage�    ��1 B� � A A � A 4 r "qA A A � 3 !A !A "!� A �� A A A 3 !!3 � A A � A 3                               8          /  �      '     �  5   *   �  �  :    )                           ����    �   �                         ��   %   ^       s      m           �  U    ��C�  � � �� U  THIS PARENT MOVEALLFROM Click,     ��1 2                       ,       )   �                         uHeight = 23
Width = 71
Caption = "Command1"
disttoformbottom = 0
disttoformright = 0
Name = "maccommandbutton"
      macbase.vcx      maccommandbutton      	cmdbottom      editbox      rTop = 24
Left = 168
Height = 24
Width = 36
Picture = ..\bmp\bottom.bmp
Caption = ""
Name = "cmdMoverAllTo"
      ctrmover      1      ocaller
method
*domethod 
      Name = "asynchtimer"
      macbase.vcx      macpageframe      Pixels      Class      1      	pageframe      macpageframe      	pageframe      macgrid      macbase.vcx      Pixels      
macspinner      registry      
registry.h      2getkeyhandle
checkresult
readvalue
writevalue
      Pixels      Used for registry access      Class      	maccustom      registry      custom      macbase.vcx      spinner      maccommandbutton      Class      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      macoptiongroup      Pixels      kTop = 0
Left = 168
Height = 24
Width = 36
Picture = ..\bmp\next.bmp
Caption = ""
Name = "cmdMoveTo"
      macbase.vcx      commandbutton      
olecontrol      macshape      Pixels      Class      rTop = 72
Left = 168
Height = 24
Width = 36
Picture = ..\bmp\previous.bmp
Caption = ""
Name = "cmdMoveFrom"
      macshape      1      optiongroup      macoptiongroup      optiongroup      Pixels      
olecontrol      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      
maceditbox      
maceditbox      editbox      commandbutton      7PROCEDURE Click
THIS.Parent.MoveAllFrom()

ENDPROC
      5      ����    �   �                         �e   %   Y       n      h           �  U    ��C�  � � �� U  THIS PARENT MOVETO Click,     ��1 2                       '       )   �                         zHeight = 16
Width = 55
BackStyle = 0
Caption = "Check1"
Value = .F.
DisabledForeColor = 0,0,1
Name = "maccheckbox"
      1      2*moveto 
*movefrom 
*moveallto 
*moveallfrom 
      Class      <Width = 226
Height = 25
BorderWidth = 0
Name = "macvcr"
      ?Width = 375
Height = 122
BorderWidth = 0
Name = "ctrmover"
      textbox      1      Class      Pixels      cmdMoveAllFrom      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      
bondchunks      macbase.vcx      ctrmover      ctrmover      maccontainer      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      Class      grid      1      Class      ����    �   �                         Ҥ   %   \       q      k           �  U    ��C�  � � �� U  THIS PARENT	 MOVEALLTO Click,     ��1 2                       *       )   �                         Name = "bondchunks"
      Class      
olecontrol      macvcr     `PROCEDURE buildde
********************************************
LOCAL lnCnt, loObj, lcDBC
LOCAL ARRAY laList[1]

*** Get Object Members of DE
=AMEMBERS( laList, ThisForm.DataEnvironment, 2 )
IF EMPTY(laList[1])
     *** Nothing in DE
     RETURN
ENDIF

*** Loop through them
FOR lnCnt = 1 TO ALEN( laList,1 )
     loObj =  EVAL("ThisForm.DataEnvironment."+lalist[lnCnt])
     IF LOWER( loObj.BaseClass ) = 'cursor'
           IF ! EMPTY( loObj.Database )
                *** Bound Table
               lcDBC = SUBSTR( loObj.Database, RAT( '\', loObj.Database ) )
               loObj.Database = pcDataPath + lcDBC
          ELSE
                        *** Free Table
                            lcDBC = SUBSTR( loObj.CursorSource, RAT( '\',loObj.CursorSource ) )
               loObj.CursorSource = pcDataPath + lcDBC
          ENDIF
     ENDIF
NEXT

*** Now Open any tables with their new paths
ThisForm.DataEnvironment.OpenTables()

RETURN  
*******************************************************

ENDPROC
PROCEDURE buildreport
PARA lcOutput
ENDPROC
PROCEDURE preview
THISFORM.BuildReport('preview')
ENDPROC
PROCEDURE printit
THISFORM.BuildReport('printer')
ENDPROC
PROCEDURE sendreport
PARAMETERS m.lcReportName, m.lcOutput

DO CASE 
  CASE UPPER(m.lcOutput) = "PREVIEW"
    
    _SCREEN.Visible = .T.
    REPO FORM &lcReportName NEXT 1 NOCO &lcOutput
    _SCREEN.Visible = .F.
    
  CASE UPPER(m.lcOutput) = "PRINTER"
    REPO FORM &lcReportName NEXT 1 NOCO TO &lcOutput  
    
  OTHERWISE
    WAIT WIND "There is no output for that option"
    
ENDCASE  
ENDPROC
      ����    �   �                         ��   %   [       s      m           �  U    ��C�  � � �� U  THIS PARENT MOVEFROM DblClick,     ��1 1                       *       )   �                         grid      �Top = 1
Left = 1
Height = 23
Width = 56
Picture = ..\bmp\top.bmp
Caption = ""
ToolTipText = "Go to first record"
Name = "cmdtop"
     ����    �  �                        ��   %   �       4  
              �  U    ��C�  � �� U  THIS	 ANYCHANGE[  ��C�  � �� %�C�  � �
��T �# %�C� � DBFieldChange��h��P � ��C� � �� � � U  THIS	 ANYCHANGE CONTROLSOURCE THISFORM DBFIELDCHANGE ProgrammaticChange,     �� InteractiveChangeQ     ��1 � 3 � 11� A A 2                       0         X   �       )   �                        
maclistbox      �ErasePage = .T.
PageCount = 2
Width = 241
Height = 169
Name = "macpageframe"
Page1.Caption = "Page1"
Page1.Name = "Page1"
Page2.Caption = "Page2"
Page2.Name = "Page2"
      macgrid      macbase.vcx      lblinstructions      grid      _Height = 22
KeyboardLowValue = 0
SpinnerLowValue =   0.00
Width = 120
Name = "macspinner"
      *Height = 23
Width = 30
Name = "cusapp"
      cmdprev      maclabel      Class      Pixels      lblinstructions      macvcr      pTop = 96
Left = 168
Height = 24
Width = 36
Picture = ..\bmp\top.bmp
Caption = ""
Name = "cmdMoveAllFrom"
      Pixels      ����    �   �                         Ҥ   %   Y       q      k           �  U    ��C�  � � �� U  THIS PARENT MOVETO DblClick,     ��1 2                       *       )   �                         �FontSize = 9
Format = "k"
Height = 23
Width = 106
requiredbackcolor = 65535
invalidbackcolor = 8454143
Name = "mactextbox"
      maccommandbutton      macbase.vcx      combobox      VHeight = 23
Width = 23
itraceinterval = 0
iregularinterval = 0
Name = "mactimer"
      maccommandbutton      FTop = 24
Left = 24
Height = 156
Width = 168
Name = "Olecontrol1"
      Ldisttoformbottom
disttoformright
locktobottom
locktoright
*reposition 
      maccommandbutton      macbase.vcx      cmdnext      
maclistbox      ctrmover      shellexecute      	maccustom      shellexecute      custom      macbase.vcx      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      �FontSize = 9
Height = 23
Style = 2
Width = 100
DisabledForeColor = 0,0,1
picklisteditor = Edit_Picklist
requiredbackcolor = 65535
Name = "maccombobox"
      macbase.vcx      macvcr      macbase.vcx      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      maccombobox      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      �activetable Stores the name of the table to navigate through
*enablebuttons Toggles the buttons' enabled properties based on record pointer position.
      ����    �   �                         F:   %   |       �      �           �  U  "  #��  � � �6� ��  � � � U  THIS PARENT ACTIVETABLE ENABLEBUTTONS Click,     ��1 !� 2                       T       )   �                         �Height = 100
Width = 100
locktobottom = 0
heightdifference = 0
widthdifference = 0
disttoformbottom = 0
disttoformright = 0
Name = "macolecontrol"
      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      _PROCEDURE Click
GO BOTTOM IN (this.parent.activetable)
this.parent.enablebuttons

ENDPROC
      VCaption = "Toolbar1"
Left = 0
Top = 0
rememberposition = .T.
Name = "mactoolbar"
      
mactoolbar      maccom      Pixels      Class      	maccustom      maccom      'tally
otimer
*domethod 
*runquery 
      Name = "maccom"
      custom      macbase.vcx      custom      mapi      Class      	container      maccommandbutton      commandbutton      Class      !Arial, 0, 9, 5, 15, 12, 21, 3, 0
      Pixels      �genericconfirmitem = 
specificconfirmitem = 
lconfirmdelete = .T.
parentidexpr = THISFORM.CurrentID
distancetoformbottom = 0
distancetoformright = 0
originalheight = 0
originalwidth = 0
Name = "grdchild"
      shape      listbox      Pixels      Class      	maccustom      Pixels      
mactoolbar      macvcr      macoptionbutton      Class      optionbutton      macoptionbutton      optionbutton      grdchild      �Top = 1
Left = 57
Height = 23
Width = 56
Picture = ..\bmp\previous.bmp
Caption = ""
ToolTipText = "Go to previous record"
Name = "cmdprev"
      commandbutton      �Top = 1
Left = 113
Height = 23
Width = 56
Picture = ..\bmp\next.bmp
Caption = ""
ToolTipText = "Go to next record"
Name = "cmdnext"
      maccommandbutton      combobox      commandbutton      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      WAlignment = 0
Caption = "Option1"
Height = 18
Width = 55
Name = "macoptionbutton"
      ����    �   �                         F:   %   |       �      �           �  U  "  #��  � � �)� ��  � � � U  THIS PARENT ACTIVETABLE ENABLEBUTTONS Click,     ��1 !� 2                       Q       )   �                         �FontBold = .T.
WordWrap = .T.
Caption = "Instructions go here"
Height = 33
Width = 396
ForeColor = 0,0,255
Name = "lblinstructions"
      mapi      toolbar      Pixels      toolbar      Pixels      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      Class      listbox      commandbutton      commandbutton      maccombobox      macvcr      �Height = 19
Width = 29
nlasterror = 0
hkeycurrent = 0
hkey_classes_root = -2147483648
hkey_current_user = -2147483647
hkey_local_machine = -2147483646
hkey_users = -2147483645
Name = "registry"
      maccontainer      _FontBold = .F.
BackStyle = 0
Caption = "Label1"
Height = 15
Width = 34
Name = "maclabel"
      �PROCEDURE ProgrammaticChange
THIS.AnyChange()

ENDPROC
PROCEDURE InteractiveChange
THIS.AnyChange()
IF !EMPTY(THIS.ControlSource) 
	IF PEMSTATUS(THISFORM, 'DBFieldChange',5)
		THISFORM.DBFieldchange()
	ENDIF
ENDIF

ENDPROC
      0Height = 170
Width = 100
Name = "maclistbox"
      \PROCEDURE Click
GO TOP IN (this.parent.activetable)
this.parent.enablebuttons

ENDPROC
      �mcdocapp = 
mcoperation = Open
mcdefaultdir = 
mnshowcommand = 1
mcparameters = 
value = 0
mlquiet = .F.
Name = "shellexecute"
      tHeight = 47
Width = 100
resizetoright = .F.
widthdifference = 0
requiredbackcolor = 65535
Name = "maceditbox"
      ?Standard VCR Buttons. Uses form.maintable property if available     ����    �  �                        wJ   %   �      ?     !          �  U  _  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  �	 �� � U
  THIS LOCKTOBOTTOM TOP THISFORM HEIGHT DISTTOFORMBOTTOM LOCKTORIGHT LEFT WIDTH DISTTOFORMRIGHT  U  }  T�  � �� � �  � �� T�  � �� � �  � ��4 %�C� � AutoEdit��h�	 � � -	� �  �	 	��v � T�  �
 �-�� � U  THIS DISTTOFORMBOTTOM THISFORM HEIGHT TOP DISTTOFORMRIGHT WIDTH LEFT AUTOEDIT EDITMODEENABLED ENABLED
 reposition,     �� Click�     �� Init�     ��1 �A �A 3 3 ��B� A 2                       �         �   �   
   	   �   t      )   �                       �ButtonCount = 2
BackStyle = 0
Value = 1
Height = 53
Width = 145
Name = "macoptiongroup"
Option1.FontSize = 9
Option1.Alignment = 0
Option1.Caption = "Option1"
Option1.Value = 1
Option1.Height = 20
Option1.Left = 5
Option1.Top = 5
Option1.Width = 127
Option1.Name = "Option1"
Option2.FontSize = 9
Option2.Caption = "Option2"
Option2.Height = 18
Option2.Left = 5
Option2.Top = 22
Option2.Width = 103
Option2.Name = "Option2"
     ����    g  g                        �S   %   �      �     �          �  U  @  ��  � T� � �C� AsynchTimer�N�� ��C �  �  � � � �� U  TCMETHOD THIS OTIMER DOMETHOD�  G� G2� GZ� %�C� issuer�
��8 � Q�	 H:\issuer� � %�C� Overlap�
��d � Q�
 h:\overlap� �= o�	 h:\issuer�
 h:\overlap���� � � � ���� Whatever� T� � �� �� Q� � U  H ISSUER ID OVERLAP ISSUERID WHATEVER THIS TALLY  ��C�	� ]�� U   domethod,     �� runquery�     �� Init�    ��1 q ��4 a a a bA qA �� � 3 � 1                       w         �   �        �  �      )   g                       b���    I  I                        d   %   �             �           �  U  �  %�C�  � � +��) � ��C�  � � �� B� � H��  � � ����� %�C�  � � +��j � #��  � � �6� � ��C�  � � �� U  THIS PARENT ACTIVETABLE ENABLEBUTTONS Click,     ��1 QA A bR!A 2                       �       )   I                       EPROCEDURE reposition
IF THIS.LockToBottom
	THIS.Top = THISFORM.Height - THIS.DistToFormBottom
ENDIF
IF THIS.LockToRight
	THIS.Left = THISFORM.Width - THIS.DistToFormRight
ENDIF

ENDPROC
PROCEDURE Init
THIS.DistToFormBottom = THISFORM.Height - THIS.Top
THIS.DistToFormRight = THISFORM.Width - THIS.Left

ENDPROC
     �PROCEDURE ProgrammaticChange
THIS.Anychange()

ENDPROC
PROCEDURE InteractiveChange
THIS.AnyChange()
IF !EMPTY(THIS.ControlSource) 
	IF PEMSTATUS(THISFORM, 'DBFieldChange',5)
		THISFORM.DBFieldchange()
	ENDIF
ENDIF

ENDPROC
PROCEDURE GotFocus
this.initialvalue = this.value

ENDPROC
PROCEDURE Init
IF THIS.AlwaysReadOnly
	THIS.Enabled = .F.
ENDIF
IF THIS.AlwaysEditable 
	THIS.Enabled = .T.
ENDIF
ENDPROC
     +���                              ��   %   ~      �     �          �  U    T�  � ��  � �� U  THIS IREGULARINTERVAL INTERVAL� O %�C� trace�� C� debugger��
 C� call�� C� watch�� C� locals���� � %��  � �  � ��� � T�  � ��  � �� T�  � ��  � �� � �� � %��  � �  � ��� � T�  � ��  � �� � T�  � ��  � �� � U  THIS INTERVAL ITRACEINTERVAL IREGULARINTERVAL Init,     �� Timerh     ��1 12 �r11A � r1A 1B 2                       5         Q         )                          c���    J  J                        �P   %   �            �           �  U  �  %�C�  � � ��) � ��C�  � � �� B� � H��  � � ������� %�C�  � � ��k � #��  � � �)� � ��C�  � � �� U  THIS PARENT ACTIVETABLE ENABLEBUTTONS Click,     ��1 QA A rR!A 2                       �       )   J                       PROCEDURE Click
IF BOF(this.parent.activetable)
	this.parent.enablebuttons()
	RETURN
ENDIF

SKIP -1 IN (this.parent.activetable)

IF BOF(THIS.Parent.ActiveTable)
	GO TOP IN (THIS.Parent.ActiveTable)
ENDIF

THIS.Parent.EnableButtons()

ENDPROC
     vcddim IF gllCDDIM = .T.  AND THIS = .T. THEN MAKE BUTTON DISABLED AND INVISIBLE
disttoformbottom Set in init. used by the button Float method.
disttoformright Set in init. used by the button Float method.
locktobottom Set to .T. if thebutton should 'float' along with the bottom edge of the form when the form is resized.
locktoright Set to .T. if thebutton should 'float' along with the right edge of the form when the form is resized.
editmodeenabled .T. if the button should only be enabled when the form is in editmode.
editmodedisabled .T. if the button should be disabled when the form is in edit mode.
*reposition 
     )���                              ��   %         �     �          �  U  _  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  �	 �� � U
  THIS LOCKTOBOTTOM TOP THISFORM HEIGHT DISTTOFORMBOTTOM LOCKTORIGHT LEFT WIDTH DISTTOFORMRIGHT7  T�  � �� � �  � �� T�  � �� � �  � �� U  THIS DISTTOFORMBOTTOM THISFORM HEIGHT TOP DISTTOFORMRIGHT WIDTH LEFT
 reposition,     �� Init�     ��1 �A �A 3 ��2                       �         �   :  
    )                          Height = 23
Width = 30
osession = 
omessage = 
cbodytext = 
csubject = 
nrecipcount = 0
nccrecipcount = 0
nbccrecipcount = 0
nattachcount = 0
nmessagecount = 0
csendername = 
nfilteredtotal = 0
cmessagefromdate = 
cmessagetodate = 
Name = "mapi"
      �PROCEDURE domethod
LPARA toCaller, tcMethod
THIS.oCaller = toCaller
THIS.Method = tcMethod
THIS.Interval = 100

ENDPROC
PROCEDURE Timer
THIS.Interval = 0
=EVAL("THIS.oCaller" + "." + THIS.Method + "()")
THIS.oCaller = .NULL.

ENDPROC
     PROCEDURE Click
IF EOF(this.parent.activetable)
	this.parent.enablebuttons()
	RETURN
ENDIF

SKIP 1 IN (this.parent.activetable)

IF EOF(THIS.Parent.ActiveTable)
	GO BOTTOM IN (THIS.Parent.ActiveTable)
ENDIF

this.parent.enablebuttons()

ENDPROC
     -rememberposition
registryname Holds name to store this forms settings under in the windows registry. If Registry name is empty when the form instanciates, Registryname is set to this.name
*readpos 
*writepos 
*writedockstatus Used Internally to write the toolbar's docked status to the registry.
     Brequiredfield This is .T. if this field is required to have a value on the form.
initialvalue Holds value of a control when it gets focus. Use to compare value when leaving the control
disttoformbottom used for repositioning with form.resize
disttoformright
locktobottom .T. if the control should float with the bottom of the form when the form is stretched
locktoright .T. if the control should float with the right of the form when the form is stretched
alwaysreadonly If .T., causes the Form.EnableAllControls to skip over this control.
alwayseditable If .T., causes Form.DisableAllControls to skip over this control
requiredbackcolor The color that the textbox should turn if it is a required field
invalidbackcolor Color that the textbox should turn when it contains an illegal value.
friendlyname User friendly name of field to be used in tooltips and messages.
*anychange called from both interactivechange and programmaticchange.
*reposition 
*validate Called from the valid event; should return .T. or .F. depending on if the value of the control meets requirements.
     ����    �  �                        �q   %   �           �          �  U    ��C�  � �� U  THIS	 ANYCHANGE[  ��C�  � �� %�C�  � �
��T �# %�C� � DBFieldChange��h��P � ��C� � �� � � U  THIS	 ANYCHANGE CONTROLSOURCE THISFORM DBFIELDCHANGE  T�  � ��  � �� U  THIS INITIALVALUE VALUEG  %��  � �� � T�  � �-�� � %��  � ��@ � T�  � �a�� � U  THIS ALWAYSREADONLY ENABLED ALWAYSEDITABLE ProgrammaticChange,     �� InteractiveChangeQ     �� GotFocus�     �� Init    ��1 � 3 � 11� A A 3 13 � A � A 1                       0         X   �      
               ;  �      )   �                       3genericconfirmitem Used for user messaging. If this grid displays a list of Line items, this property should contain "Line Items".
specificconfirmitem User for user messaging. Should contain the epxression in the controlsource that should be used when referring to the entities in the grid. "lvInvoice.InvoiceItem.
addeditform The name of the form used in add and edit operations for this grid. the form should be a subclass of frmAddEdit.
lconfirmdelete Set to .T. if the DeleteChild method should ask for user confirmation before deleting.
parentidexpr Contains an expression that should evaluate to the primary key value of the parent of the records contined in the grid. For example if this grid contains invoice lineitems this property might contain "Invoice.ID". 
*addchild 
*afteraddchild Hook method that runs after the AddChild operation
*editchild 
*afteredit Hook method thatruns after the ditChild operation
*confirmdelete 
*beforedeletechild Hook method that must return .T. for the DeleteChildOperation to complete
*afterdeletechild 
*deletechild 
     3���                              !   %   �      �  (   1          �  U  _  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  �	 �� � U
  THIS LOCKTOBOTTOM TOP THISFORM HEIGHT DISTTOFORMBOTTOM LOCKTORIGHT LEFT WIDTH DISTTOFORMRIGHTL  ��  � %�C� vNewValb� L��3 � T� � ��  
�� � T� � ���  �� U  VNEWVAL THIS ENABLED READONLY  T�  � ��  � �� U  THIS INITIALVALUE VALUE[  ��C�  � �� %�C�  � �
��T �# %�C� � DBFieldChange��h��P � ��C� � �� � � U  THIS	 ANYCHANGE CONTROLSOURCE THISFORM DBFIELDCHANGE  ��C�  � �� U  THIS	 ANYCHANGE�  T�  � �� � �  � �� T�  � �� � �  � �� %�C�  � �
��� � %��  �	 ��e � T�  �
 �a�� � %��  � ��� � T�  �
 �-�� �� � %�� � -��� � T�  �
 �a�� � � � U  THIS DISTTOFORMBOTTOM THISFORM HEIGHT TOP DISTTOFORMRIGHT WIDTH LEFT CONTROLSOURCE ALWAYSREADONLY READONLY ALWAYSEDITABLE AUTOEDIT
 reposition,     �� readonly_assign�     �� GotFocusi    �� InteractiveChange�    �� ProgrammaticChange6    �� Init[    ��1 �A �A 3 q �C "3 13 � 11� A A 3 � 3 ��1� A � � !� A A A 3                       �         �   �  
      �          =  �        �    "        c  &    )                          ����    q  q                        �c   %   �      �     �          �  U  o  T�  �� � � ��  ��CC ��  � � � � � � ��# T� � � �C� � �	 � � � �� ��C ��  � � �
 �� U  CLSTIDX THIS LSTFROM	 LISTINDEX LSTTO ADDITEM LIST
 LISTITEMID INDEXTOITEMID	 LISTCOUNT
 REMOVEITEML  T�  �� � � ��  ��CC ��  � � � � � � �� ��C ��  � � � �� U  CLSTIDX THIS LSTTO	 LISTINDEX LSTFROM ADDLISTITEM LIST
 REMOVEITEMB  ��  ���(�� � � ��; � ��CC �  � � � � � � �� �� U  I THIS LSTFROM	 LISTCOUNT LSTTO ADDITEM LISTITEM? $ ��  �� � � �(����������8 � ��C �  � � � �� �� U  I THIS LSTTO	 LISTCOUNT
 REMOVEITEM moveto,     �� movefrom
    ��	 moveallto�    �� moveallfrom     ��1 ;2a3 6f3 ��A 3 AAA 2                       7        V  �     
     i  '      �  �  -    )   q                       @PROCEDURE Destroy
lcSetting = THIS.Setting
luvalue = THIS.Oldvalue

DO CASE
	CASE INLIST(lcSetting, "DELE", "ANSI", "SAFE", "EXAC", "CENT", "TALK", "CURS")
		SET &lcSetting &luValue
	CASE INLIST(lcSetting, "DECI", "DEFA", "FILT", "PATH", "PROC", "CLAS", "ORDE", "REPR")
		SET &lcSetting TO &luValue
	CASE lcSetting = "SELE"
		SELECT (luValue)
	OTHERWISE 
		RETURN .F.
ENDCASE


ENDPROC
PROCEDURE Init
LPARA tcSetting, tuvalue

IF TYPE("tcSetting") <> "C" OR TYPE('tuValue') = "L"
	RETURN .F.
ENDIF

tcSetting = LEFT(UPPER(tcSetting), 4)

THIS.Setting = tcSetting

DO CASE
	CASE INLIST(tcSetting, "DELE", "ANSI", "SAFE", "EXAC", "CENT", "TALK", "CURS")
		IF !INLIST(UPPER(tuValue), "ON", "OFF")
			RETURN .F.
		ENDIF
		THIS.OldValue = SET(tcSetting)
		SET &tcSetting &tuValue
	CASE INLIST(tcSetting, "DECI", "DEFA", "FILT", "PATH", "PROC", "CLAS", "ORDE", "REPR")
		THIS.OldValue = SET(tcSetting)
		SET &tcSetting TO &tuValue
	CASE tcSetting = "SELE"
		THIS.OldValue = SELECT()
		SELECT (tuValue)
	OTHERWISE 
		RETURN .F.

ENDCASE


ENDPROC
     ����    �  �                        �e   %   �      j  %              �  U  � ��  � � � %�C� � ��	 C� � +��I � ��C� Enabled-� � �� B� � T�  �C� � O�� #�� � �)� T� �C� � O�� #�� � �6� T� �C� � O�� #�� � ���  �� H�� ��� ��  � ��� T� � � �-�� T� � � �-�� T� �	 � �a�� T� �
 � �a�� ��  � ��k� T� � � �a�� T� � � �a�� T� �	 � �-�� T� �
 � �-�� 2��� ��C� Enableda� � �� � ��C� � �� U  NREC NTOP NBOTTOM THIS ACTIVETABLE SETALL CMDTOP ENABLED CMDPREV CMDNEXT	 CMDBOTTOM THISFORM REFRESH�  %�C�  � ���l �, %�C� �	 maintable��h�
 C� � �
	��Q � T�  � �� � �� �h � T�  � �CW�� � � ��C�  � �� U  THIS ACTIVETABLE THISFORM	 MAINTABLE ENABLEBUTTONS enablebuttons,     �� Init@    ��1 � ��A A "� !� !1� � �A � 5 !�1� � A A � 3                       �          �  #    )   �                       PROCEDURE reposition
IF THIS.LockToBottom
	THIS.Top = THISFORM.Height - THIS.DistToFormBottom
ENDIF
IF THIS.LockToRight
	THIS.Left = THISFORM.Width - THIS.DistToFormRight
ENDIF

ENDPROC
PROCEDURE Click
*
ENDPROC
PROCEDURE Init
*!*	IF TYPE('gloutside') <> "U" then
*!*		IF THIS.CDDIM = .T. AND glOutside = .T.
*!*		  THIS.VISIBLE = .F.
*!*		  THIS.ENABLED = .F.
*!*		ENDIF
*!*	endif

THIS.DistToFormBottom = THISFORM.Height - THIS.Top
THIS.DistToFormRight = THISFORM.Width - THIS.Left

IF PEMSTATUS(THISFORM, "AutoEdit", 5) AND THISFORM.AutoEdit = .F. AND THIS.EditModeEnabled
	THIS.Enabled = .F.
ENDIF

ENDPROC
     �PROCEDURE domethod
LPARA tcMethod
THIS.oTimer = CREATEOBJECT("AsynchTimer")
THIS.oTimer.DoMethod(THIS, tcMethod)


ENDPROC
PROCEDURE runquery
SET EXCLUSIVE OFF
SET TALK OFF
SET NOTIFY OFF

IF !USED("issuer")
	USE H:\issuer
ENDIF
IF !USED("Overlap")
	USE h:\overlap
ENDIF

sele * from h:\issuer, h:\overlap where issuer.id = overlap.issuerid INTO CURSOR Whatever

THIS.Tally = _TALLY

USE IN Whatever

ENDPROC
PROCEDURE Init
SYS(2335, 0)
ENDPROC
     �initialvalue Holds the value that the control had when it got focus. Used for comparing changes when leaving the field.
locktobottom
locktoright
disttoformbottom
disttoformright
alwayseditable If .T., causes Form.DisableAllControls to skip over this control
alwaysreadonly If .T., causes the Form.EnableAllControls to skip over this control.
*anychange Called from both the interactivechange and the programmaticchange methods
*reposition 
*readonly_assign 
     ddisttoformbottom
disttoformright
locktobottom
locktoright
alwayseditable If .T., causes Form.DisableAllControls to skip over this control
alwaysreadonly If .T., causes the Form.EnableAllControls to skip over this control.
readonly
*anychange Called from both the interactivechange and the programmaticchange events
*reposition 
*readonly_assign 
     uinitialvalue Holds the value of the control when it initally receives focus. Use to compare changes when leaving the field
alwayseditable If .T., causes Form.DisableAllControls to skip over this control
alwaysreadonly If .T., causes the Form.EnableAllControls to skip over this control.
*anychange Called from both the interactivechange and the progrmmatichange events
     
����    �
  �
                        �j   %   �      �	  P   ,	          �  U  _  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  � �� � U  THIS RESIZETOBOTTOM HEIGHT THISFORM HEIGHTDIFFERENCE RESIZETORIGHT WIDTH WIDTHDIFFERENCE� %�C�  � �
����% R,:�� Starting Spell Checker... ��. %�C� THISFORM.oWordb� O�	 C� � ���� �2 ��C� oWord�
 olecontrol� word.document� � �� T� � � �� �� T� � � �� �� � T� ��  � �� ��� � ��M� ��C� �� �� T��	 �
 �� �� ��C�� �� ��C��	 � � � �� T� ���	 � � � �� ��C��	 � � �� R� �� ��C� oWord� � �� T�  � �� ��% ��C� Spellcheck is complete�@�x�� ��� � U  THIS VALUE THISFORM OWORD	 ADDOBJECT WIDTH HEIGHT LCCHECKTEXT DOVERB OBJECT CONTENT CHECKSPELLING APPLICATION	 SELECTION
 WHOLESTORY LCRESULTTEXT TEXT QUIT REMOVEOBJECT_  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  �	 �� � U
  THIS LOCKTOBOTTOM TOP THISFORM HEIGHT DISTTOFORMBOTTOM LOCKTORIGHT LEFT WIDTH DISTTOFORMRIGHT  ��C�  � �� U  THIS	 ANYCHANGE[  ��C�  � �� %�C�  � �
��T �# %�C� � DBFieldChange��h��P � ��C� � �� � � U  THIS	 ANYCHANGE CONTROLSOURCE THISFORM DBFIELDCHANGE  T�  � ��  � �� U  THIS INITIALVALUE VALUE� ��  � � � T�  �� �� T� �� � � � C��� T� �� � � � C��� s�� �C���C��W� s����� "�� Cut�� s����� "�� Copy�� s����� "�� Paste�� s����� "�� Clear�� s����� "�� \-��3 1������ �! SYS(1500, '_MED_CUT',   '_MEDIT')�3 1������ �! SYS(1500, '_MED_COPY',  '_MEDIT')�3 1������ �! SYS(1500, '_MED_PASTE', '_MEDIT')�3 1������ �! SYS(1500, '_MED_CLEAR', '_MEDIT')� t�� � U  LOOBJECT LNROW LNCOL THIS THISFORM TOP LEFT SHORTCUT�  T�  � �� � �  � �� T�  � �� � �  � �� T�  � �� � �  � �� T�  � �� � �  �	 �� %��  �
 ��� � T�  � �a�� � %��  � ��� � T�  � �-�� �� � %�� � -��� � T�  � �a�� � � U  THIS HEIGHTDIFFERENCE THISFORM HEIGHT WIDTHDIFFERENCE WIDTH DISTTOFORMBOTTOM TOP DISTTOFORMRIGHT LEFT ALWAYSREADONLY READONLY ALWAYSEDITABLE AUTOEDIT resize,     ��
 spellcheck�     ��
 repositionW    �� ProgrammaticChange"    �� InteractiveChangeG    �� GotFocus�    ��
 RightClick    �� Init    ��1 �A �A 3 1R�!11A � � AqQ A RR� B 2 �A �A 3 � 3 � 11� A A 3 13 � � ��4q���a1111� 3 ����� A � � !� A A 3                       �         �   �  
      �  {  *   &   �  �  3   (   �  g  7   /   �  �  @   1   �  �  D   A   �  F
  [    )   �
                       yPROCEDURE reposition
IF THIS.LockToBottom
	THIS.Top = THISFORM.Height - THIS.DistToFormBottom
ENDIF
IF THIS.LockToRight
	THIS.Left = THISFORM.Width - THIS.DistToFormRight
ENDIF

ENDPROC
PROCEDURE Resize
IF THIS.ResizeToBottom
	THIS.Height = THISFORM.Height - THIS.HeightDifference
ENDIF
IF THIS.ResizeToRight
	THIS.Width = THISFORM.Width - THIS.WidthDifference
ENDIF

ENDPROC
PROCEDURE Init
THIS.Heightdifference = THISFORM.Height - THIS.Height
THIS.Widthdifference = THISFORM.Width - THIS.Width

THIS.DistToFormBottom = THISFORM.Height - THIS.Top
THIS.DistToFormRight = THISFORM.Width - THIS.Left

ENDPROC
     PROCEDURE Init
THIS.iRegularInterval = THIS.Interval
ENDPROC
PROCEDURE Timer
IF WVISIBLE("trace") OR  ;
   WVISIBLE("debugger") OR ;
   WVISIBLE("call") OR ;
   WVISIBLE("watch") OR ;
   WVISIBLE("locals") 
   
   IF THIS.Interval # THIS.iTraceInterval
      THIS.iRegularInterval = THIS.Interval
      THIS.Interval = THIS.iTraceInterval      
   ENDIF

ELSE

   IF THIS.Interval = THIS.iTraceInterval
      THIS.Interval = THIS.iRegularInterval
   ENDIF
   THIS.iRegularInterval = THIS.Interval

ENDIF

ENDPROC
     uinitialvalue Holds the value that the control had when it got focus. Used for comparing changes when leaving the field.
alwayseditable If .T., causes Form.DisableAllControls to skip over this control
alwaysreadonly If .T., causes the Form.EnableAllControls to skip over this control.
*anychange called from both the interactivechange and the programmaticchange events,
     8���                              0�   %   M      f  9   �          �  U  _  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  �	 �� � U
  THIS LOCKTOBOTTOM TOP THISFORM HEIGHT DISTTOFORMBOTTOM LOCKTORIGHT LEFT WIDTH DISTTOFORMRIGHTL  ��  � %�C� vNewValb� L��3 � T� � ��  
�� � T� � ���  �� U  VNEWVAL THIS ENABLED READONLYM  %�C�  � 
��% � T�  � ��  � �� �F � ��C�	 BackColor�  � �� � U  THIS VALIDATE	 BACKCOLOR INVALIDBACKCOLOR RESETTODEFAULT  ��C�  � �� U  THIS	 ANYCHANGE[  ��C�  � �� %�C�  � �
��T �# %�C� � DBFieldChange��h��P � ��C� � �� � � U  THIS	 ANYCHANGE CONTROLSOURCE THISFORM DBFIELDCHANGE� $ %��  � a� C�  � ���	��� � T� �C� .�  � �� %�� � ��d � T� �C�  � � �=�� �| � T� ��  � �� � ��  � ���C� &�� ��C�  � �� � U  THIS ENABLEEDITLIST ROWSOURCETYPE ATDOT	 ROWSOURCE TABLETOEDIT PICKLISTEDITOR REQUERY  T�  � ��  � �� U  THIS INITIALVALUE DISPLAYVALUE�  T�  � �� � �  � �� T�  � �� � �  � �� %�C�  � �
��� � %��  �	 ��e � T�  �
 �a�� � %��  � ��� � T�  �
 �-�� �� � %�� � -��� � T�  �
 �a�� � � � U  THIS DISTTOFORMBOTTOM THISFORM HEIGHT TOP DISTTOFORMRIGHT WIDTH LEFT CONTROLSOURCE ALWAYSREADONLY READONLY ALWAYSEDITABLE AUTOEDIT
 reposition,     �� readonly_assign�     �� Validi    �� ProgrammaticChange�    �� InteractiveChange    ��
 RightClick�    �� GotFocus�    �� Init�    ��1 �A �A 3 q �A "3 !1� �A 3 � 3 � 11� A A 3 Aa�� A a� A 3 13 ��1� A � � !� A A A 1                       �         �   |  
      �          /  A        i  �          4  (   (   S  y  5   *   �  �  9    )                          �DeleteMark = .F.
GridLines = 0
Height = 200
HighlightRow = .T.
RecordMark = .F.
ScrollBars = 2
Width = 320
highlightentirerow = .T.
grdcurrow = 1
highlightcolor = 8454143
defaultheaderclass = MacHeader
defaultheaderclassdefinition = macbase.prg
builder = Macgrid Builder
sortedbackcolor = 65535
highlightforecolor = 0
registryname = 
registryapp = 
Name = "macgrid"
     nPROCEDURE reposition
IF THIS.LockToBottom
	THIS.Top = THISFORM.Height - THIS.DistToFormBottom
ENDIF
IF THIS.LockToRight
	THIS.Left = THISFORM.Width - THIS.DistToFormRight
ENDIF

ENDPROC
PROCEDURE readonly_assign
LPARAMETERS vNewVal
IF TYPE("vNewVal") = "L"
	THIS.Enabled = !vNewVal
* vvvvv Didn't work
*	THIS.BackColor = IIF(vNewVal, RGB(192,192,192), RGB(255,255,255))
ENDIF
*To do: Modify this routine for the Assign method
THIS.ReadOnly = m.vNewVal

ENDPROC
PROCEDURE GotFocus
this.initialvalue = this.value

ENDPROC
PROCEDURE InteractiveChange
THIS.AnyChange()
IF !EMPTY(THIS.ControlSource) 
	IF PEMSTATUS(THISFORM, 'DBFieldChange',5)
		THISFORM.DBFieldchange()
	ENDIF
ENDIF

ENDPROC
PROCEDURE ProgrammaticChange
THIS.AnyChange()

ENDPROC
PROCEDURE Init
THIS.DistToFormBottom = THISFORM.Height - THIS.Top
THIS.DistToFormRight = THISFORM.Width - THIS.Left
IF !EMPTY(THIS.ControlSource)
	IF THIS.AlwaysReadOnly
		THIS.ReadOnly = .T.
	ENDIF
	IF THIS.AlwaysEditable 
		THIS.ReadOnly = .F.
	ELSE
		IF THISFORM.AutoEdit = .F. 
			THIS.ReadOnly = .T.
		ENDIF
	ENDIF
ENDIF


ENDPROC
     �bondcardid
*conditions 
*insagent 
*opentables Programmatically opens the tables and views associated with the data environment.
*coupondates 
*setpointers 
*conditionsmats 
*countieslist 
*compcalendar 
*fa 
*negcalendar 
*agapproval 
*underwriters 
*bondcounsel 
*proceeds 
*compsales 
*ticniceir 
*salesmats 
*calldates 
*elections 
*documents 
*disclosure 
*tickler 
*printinsagent 
*printproceeds 
*printunderwriters 
*printfa 
*printbondcounsel 
*redemption 
*matevents 
     >PROCEDURE reposition
IF THIS.LockToBottom
	THIS.Top = THISFORM.Height - THIS.DistToFormBottom
ENDIF
IF THIS.LockToRight
	THIS.Left = THISFORM.Width - THIS.DistToFormRight
ENDIF

ENDPROC
PROCEDURE InteractiveChange
THIS.AnyChange()
IF !EMPTY(THIS.ControlSource) 
	IF PEMSTATUS(THISFORM, 'DBFieldChange',5)
		THISFORM.DBFieldchange()
	ENDIF
ENDIF

ENDPROC
PROCEDURE ProgrammaticChange
THIS.AnyChange()

ENDPROC
PROCEDURE Init
THIS.DistToFormBottom = THISFORM.Height - THIS.Top
THIS.DistToFormRight = THISFORM.Width - THIS.Left


IF THIS.AlwaysReadOnly
	THIS.Enabled = .F.
ENDIF
IF THIS.AlwaysEditable 
	THIS.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE readonly_assign
LPARAMETERS vNewVal
THIS.Enabled = !vNewVal
*To do: Modify this routine for the Assign method
THIS.readonly = m.vNewVal

ENDPROC
     ����    ~  ~                        AT   %   �      �  B   a          �  U  �  ��  � �(� ��C�  � ��� %�C� lnNewIDb� L��� � T� �C�  � ��� ��C�  � ��� T� �CW�� F��  � �� -�� � ��
 F�� �� ��C�  � �� ��C�  �	 �� ��C�  �
 �� � U  THIS ADDEDITFORM PARENTIDEXPR LNNEWID LNID RECORDSOURCE LNSELECT ID REFRESH SETFOCUS AFTERADDCHILD�   %�C�  � +
�
 C�  � 
	��� � T� �C�  � �� .id��% ��  � �(� ��C�  � ���C� ��� %�C� lnNewIDb� L��� � T� �C�  � ��� ��C�  � ��� T� �CW�� F��  � �� -�� � ��
 F�� �� ��C�  �	 �� ��C�  �
 �� ��C�  � �� � � U  THIS RECORDSOURCE LCCHILDALIASPK ADDEDITFORM PARENTIDEXPR LNNEWID LNID LNSELECT ID REFRESH SETFOCUS	 AFTEREDIT6 H� �� � �CC�  � ��
��_ �= T� ��  Are you sure you want to delete CC�  � Λ� ?�� �CC�  � ��
��� �@ T� ��% Are you sure you want to delete this C�  � �� ?�� 2�� �9 T� ��, Are you sure you want to delete this record?�� �  %�C� �$� Delete�x��� � B�a�� �/� B�-�� � U  THIS SPECIFICCONFIRMITEM CMESSAGE GENERICCONFIRMITEM� * %�C�  � +
� �  � 
� C�  � 	��� � ��  � �� %�C�  � � � ��� � H��  � ����� %�C�  � +��� � #��  � �6� � ��C�  � �� ��C�  � �� ��C�  � �� B�a�� �� � B�-�� � � B�-�� U	  THIS RECORDSOURCE LCONFIRMDELETE CONFIRMDELETE THISFORM UPDATETABLE AFTERDELETECHILD REFRESH SETFOCUS 	 ��C��� ��Ca�  � �� U  THIS SETREADONLY  ��C�  � �� U  THIS	 EDITCHILD addchild,     ��	 editchildV    �� confirmdelete�    �� deletechildD    �� Init�    �� commoncontroldblclick�    ��1 ��!� � � � � � � � A 3 �Q�!� � � � � � � � A A 2 � Q�Q� �A q � q A 3 �� q1!� A � � � q � q A A r 3 � � 3 � 1                       Q        q  B        f  6  "   ,   X  :  3   =   U  y  G   @   �  �  L    )   ~                       L���    3  3                        ��   %   �      �     n          �  U  _  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  �	 �� � U
  THIS LOCKTOBOTTOM TOP THISFORM HEIGHT DISTTOFORMBOTTOM LOCKTORIGHT LEFT WIDTH DISTTOFORMRIGHT[  ��C�  � �� %�C�  � �
��T �# %�C� � DBFieldChange��h��P � ��C� � �� � � U  THIS	 ANYCHANGE CONTROLSOURCE THISFORM DBFIELDCHANGE  ��C�  � �� U  THIS	 ANYCHANGE{  T�  � �� � �  � �� T�  � �� � �  � �� %��  � ��R � T�  �	 �-�� � %��  �
 ��t � T�  �	 �a�� � U  THIS DISTTOFORMBOTTOM THISFORM HEIGHT TOP DISTTOFORMRIGHT WIDTH LEFT ALWAYSREADONLY ENABLED ALWAYSEDITABLE-  ��  � T� � ��  
�� T� � ���  �� U  VNEWVAL THIS ENABLED READONLY
 reposition,     �� InteractiveChange�     �� ProgrammaticChange�    �� Init�    �� readonly_assign�    ��1 �A �A 3 � 11� A A 3 � 3 ��� A � A 2 q "2                       �         �   i  
      �  �        �  �        �  3  #    )   3                       �initialvalue Holds the value that the control had when it got focus. Used for comparing changes when leaving the field.
enableeditlist Set to .T. if the user can edit the underlying rowsource list in a separate form by rightclicking.
disttoformbottom
disttoformright
locktobottom
locktoright
alwayseditable
alwaysreadonly If .T., causes the Form.EnableAllControls to skip over this control.
picklisteditor Name of the form that can receive the rowsource's table name as a parameter and edit the picklist
requiredfield Set to .T. if this field must have a value before saving.
requiredbackcolor Color for the background if this field is required.
friendlyname User friendly field name to be used in tooltips and messages.
*anychange Called from both the interactivechange and the programmaticchange events
*reposition 
*readonly_assign 
*validate Called from the valid method, should return .F. if the contents of the control are illegal.
     �mcdocapp String specifying the file to open. This can be a file with an extension with a valid file association, or it can be the name of the .EXE to run.
mcoperation A string specifying the operation to perform. This string can be "open" or "print".
mcdefaultdir String specifying the default directory where the app will run. It defaults to the current directory.
mnshowcommand Specifies whether the application window is to be shown when the application is opened. This parameter can be one of the valid ShowWindow() constants
mcparameters String specifying parameters passed to the application when the mcDocApp property specifies an executable file. If mcDocApp points to a string specifying a document file, this property is a null string ""
value The return value is the instance handle of the application that was opened or printed, if the function is successful. (This handle could also be the handle of a DDE server application.) A return value less than or equal to 32 specifies an error.
mlquiet Quiet flag prevents the Execute() method from starting a MessageBox dialog under error conditions.
*execute Performs the ShellExecute API call.  The return value is returned as well as loaded into the Value property.
     	�registryapp The name that the current application should use when saving settings to the registry.
screencaption Initial Caption for screen when the app starts.
screenbackcolor BackColor for the screen.
screenpicture Picture to be used as wallpaper for the screen.
menufile Holds the name of the menu file to be run when the app starts
formsmanagerclass The name of a class to be used as a forms manager
securityclass The name of a class to be used as a Security class for this app.
loginform The name of a modal form that should be used for user login
oldscreencaption Stores the original screen caption
oldscreenpicture Stores the original screen picture
oldscreenbackcolor Stores the original screen.backcolor
initialform Holds the name of a form to be called after the app is initialized.
oldscreenvisible Stores whether the _screen was visible when app was initialized. Mostly to preserve development environment.
screenicon The icon file to be used as the appication's icon.
oldscreenicon
datapath Holds the path to this application's database. 
appname The name of the application to be used for messaging.
*releasevfptoolbars Stores names and positions of VFP toolbars, and hides them
*restorevfptoolbars Restores any VFP toolbars that were present beofre the app was initialized.
*setscreenprops Set _SCREEN properties to those specified in this objects properties (THIS.ScreenCaption etc.)
*restorescreenprops Restores _screen properties to their state before the app was initialized.
*showmenu Runs the menu program specified in THIS.MenuFile
*userlogin Calls the user login form specified in THIS.LoginForm. If this method returns .F., the app object will not initialize.
*beforereadevents Hook method- must return true beforethe app object issues a READ EVENTS
*createsecurityobject Instanciates the Security object if THIS.SecurityClass is filled out.
*createformsmanager Instanciates the forms manager class if THIS.formsManagerClass is filled out.
*getusersetting Receives a setting name as a parameter and returns the value of the setting as it the registry reads.
*setusersetting Receives a setting name and a value and stores that setting to the registry.
^avfptoolbars[20,2] Stores names of and visible status of all VFP toolbars.
*cleanup 
*showinitialform Calls the form specified in THIS.InitialForm, if any.
*readevents 
*checkallrequirements Must Return .T. before the application will launch.
     KPROCEDURE reposition
IF THIS.LockToBottom
	THIS.Top = THISFORM.Height - THIS.DistToFormBottom
ENDIF
IF THIS.LockToRight
	THIS.Left = THISFORM.Width - THIS.DistToFormRight
ENDIF

ENDPROC
PROCEDURE GotFocus
THIS.InitialValue = THIS.Value
IF "k"$THIS.Format AND TYPE("THIS.Value") = "N"
	DODEFAULT()
ENDIF

ENDPROC
PROCEDURE InteractiveChange
THIS.AnyChange()
IF !EMPTY(THIS.ControlSource) 
	IF PEMSTATUS(THISFORM, 'DBFieldChange',5) 
		THISFORM.DBFieldchange()
	ENDIF
ENDIF

ENDPROC
PROCEDURE ProgrammaticChange
THIS.AnyChange()

ENDPROC
PROCEDURE Init
THIS.DistToFormBottom = THISFORM.Height - THIS.Top
THIS.DistToFormRight = THISFORM.Width - THIS.Left

IF !EMPTY(THIS.ControlSource) 
	IF THIS.AlwaysReadOnly
		THIS.ReadOnly = .T.
	ENDIF
	IF THIS.AlwaysEditable 
		THIS.ReadOnly = .F.
	ELSE
		IF PEMSTATUS(THISFORM, "AutoEdit", 5) AND THISFORM.AutoEdit = .F. 
			THIS.ReadOnly = .T.
		ENDIF
	ENDIF
ENDIF


ENDPROC
PROCEDURE Valid
IF !THIS.Validate()
	THIS.BackColor = THIS.InvalidBackcolor
ELSE
	THIS.ResetToDefault("BackColor")
ENDIF

ENDPROC
     'nlasterror Last error code returned
hkeycurrent Currently open key handle
hkey_classes_root key handle for HKEY_CLASSES_ROOT
hkey_current_user key handle for HKEY_CURRENT_USER
hkey_local_machine key handle for HKEY_LOCAL_MACHINE
hkey_users key handle for HKEY_USERS
*getkeyhandle Returns a registry key handle
*checkresult Validate the result of each API call
*createkey Create a new registry key
*deletekey Delete a registry key (must be empty)
*closekey Close the current registry key
*openkey Open a registry key
*deletevalue Delete a registry value
*readvalue Read a value from the current key
*writevalue Write a value to the current key
*getstringvalue Open, get a string value from, and close a key all in one method
*getnumvalue Open, get a numeric value from, and close a key all in one method
*getbooleanvalue Open, get a boolean value from, and close a key all in one method
*setbooleanvalue Open, write or create, and close a boolean value
*setnumvalue Open, write or create, and close a numeric value
*setstringvalue Open, write or create, and close a string value
*readbooleanvalue Read a boolean value from the currently open key
*readstringvalue Read a string value from the currently open key
*readnumvalue Read a numeric value from the currently open key
*writebooleanvalue Write a boolean value to the current key
*writenumvalue Write a numeric value to the current key
*writestringvalue Write a string value to the current key
*valexists Determine if a value exists
*release Releases a FormSet or Form from memory.
*zreadme 
     �PROCEDURE enablebuttons
LOCAL nRec, nTop, nBottom
IF EMPTY(THIS.Activetable) OR EOF(THIS.ActiveTable) && Table empty or no records match a filter
	THIS.SetAll("Enabled", .F.)
	RETURN
ENDIF

nRec = RECNO(THIS.Activetable)
GO TOP IN (THIS.Activetable)
nTop = RECNO(THIS.Activetable)
GO BOTTOM IN (THIS.Activetable)
nBottom = RECNO(THIS.Activetable)
GO nRec IN (THIS.Activetable)

DO CASE
	CASE nRec = nTop
		THIS.cmdTop.Enabled = .F.
		THIS.cmdPrev.Enabled = .F.
		THIS.cmdNext.Enabled = .T.
		THIS.cmdBottom.Enabled = .T.
	CASE nRec = nBottom
		THIS.cmdTop.Enabled = .T.
		THIS.cmdPrev.Enabled = .T.
		THIS.cmdNext.Enabled = .F.
		THIS.cmdBottom.Enabled = .F.
	OTHERWISE
		THIS.SetAll("Enabled", .T.)
ENDCASE

THISFORM.Refresh()



ENDPROC
PROCEDURE Init
IF EMPTY(THIS.ActiveTable)
	IF PEMSTATUS(THISFORM,'maintable',5) AND !EMPTY(THISFORM.maintable)
		THIS.ActiveTable = THISFORM.MainTable
	ELSE
		THIS.ActiveTable = SELECT()
	ENDIF
ENDIF

THIS.EnableButtons()


ENDPROC
     �resizewithright
distancetoformbottom
distancetoformright
resizewithbottom
refreshflag
firstafterlast Determines if GoNextPage should return to the first page if the last page is active.
currentpage
*gonextpage Activates the next page in the frame (by pageorder). If the last page is active, looks at the value of this.FirstAfterLast to determine if it should return to the first page.
*currentpage_access 
*gopreviouspage 
     �PROCEDURE moveto
*!*	FOR i = 1 TO THIS.lstFrom.ListCount
*!*		IF THIS.lstFrom.Selected(i)
*!*			THIS.lstFrom.ListItem(i) = "\" + THIS.lstFrom.ListItem(i) 
*!*			THIS.lstTo.AddItem(THIS.LstFrom.ListItem(i))
*!*	*		THIS.lstFrom.RemoveItem(i) 
*!*		ENDIF
*!*	ENDFOR


*********************
cLstIdx = this.lstFrom.ListIndex

* Add item to Selections listbox
this.lstTo.AddItem(this.lstFrom.List[m.cLstIdx])
* Set hilited item to last item in list
this.lstTo.ListItemID = this.lstTo.IndexToItemID[this.lstTo.ListCount]
this.lstFrom.RemoveItem(m.cLstIdx)

ENDPROC
PROCEDURE movefrom
*!*		THIS.lstFrom.AddItem(THIS.LstTo.ListItem(i))
*!*		THIS.lstTo.RemoveItem(i)

*!*		*********************************************

cLstIdx = this.lstTo.ListIndex

* Add item to From list
this.lstFrom.AddListItem(this.lstTo.List[m.cLstIdx])


*!*	this.lstFrom.ListItemID = this.lstFrom.IndexToItemID[this.lstFrom.ListCount]

* Remove item from list on right
this.lstTo.RemoveItem(m.cLstIdx)

ENDPROC
PROCEDURE moveallto
FOR i = 1 TO THIS.lstFrom.ListCount
	THIS.lstTo.AddItem(THIS.lstFrom.ListItem(i))
ENDFOR

ENDPROC
PROCEDURE moveallfrom
FOR i = THIS.lstTo.ListCount TO 1 STEP -1
	THIS.lstTo.RemoveItem(i)
ENDFOR

ENDPROC
     WPROCEDURE execute
if ( ! empty( this.mcDocApp ) )
   if ( ! ".EXE" $ upper( this.mcDocApp ) )
      * the API says this must be empty if not starting an exe
      this.mcParameters = ""
   endif
endif

declare long ShellExecute in "shell32.dll" long hwnd, string lpszOp, ;
                    string lpszFile, string lpszParams, ;
                    string lpszDir, long nShowCmd

declare long GetDesktopWindow in "win32api" 

local hDCScreen
 
hDCScreen = GetDesktopWindow()

this.Value = ShellExecute( hDCScreen, ;
                           this.mcOperation, ;
                           this.mcDocApp, ;
                           this.mcParameters, ;
                           this.mcDefaultDir, ;
                           this.mnShowCommand )

if ( this.Value <= 32 )
 *  this.ShowError()
endif

return this.Value

ENDPROC
PROCEDURE Init
lparameter lcDocApp, lcOperation, lcParameters, lcDefaultDir, lnShowCommand

if ( ! empty( m.lcDocApp ) )
   this.mcDocApp = m.lcDocApp
endif

if ( ! empty( m.lcOperation ) )
   this.mcOperation = m.lcOperation
endif

if ( ! empty( m.lcParameters ) )
   this.mcParameters = m.lcParameters
endif

if ( ! empty( m.lcDefaultDir ) )
   this.mcDefaultDir = m.lcDefaultDir
endif

if ( ! empty( m.lnShowCommand ) )
   this.mnShowCommand = m.lnShowCommand
endif

ENDPROC
     �PROCEDURE reposition
IF THIS.LockToBottom
	THIS.Top = THISFORM.Height - THIS.DistToFormBottom
ENDIF
IF THIS.LockToRight
	THIS.Left = THISFORM.Width - THIS.DistToFormRight
ENDIF

ENDPROC
PROCEDURE readonly_assign
LPARAMETERS vNewVal
IF TYPE("vNewVal") = "L"
	THIS.Enabled = !vNewVal
ENDIF
*To do: Modify this routine for the Assign method
THIS.ReadOnly = m.vNewVal

ENDPROC
PROCEDURE Valid
IF !THIS.Validate()
	THIS.BackColor = THIS.InvalidBackcolor
ELSE
	THIS.ResetToDefault("BackColor")
ENDIF

ENDPROC
PROCEDURE ProgrammaticChange
THIS.AnyChange()

ENDPROC
PROCEDURE InteractiveChange
THIS.AnyChange()
IF !EMPTY(THIS.ControlSource) 
	IF PEMSTATUS(THISFORM, 'DBFieldChange',5)
		THISFORM.DBFieldchange()
	ENDIF
ENDIF

ENDPROC
PROCEDURE RightClick
if this.EnableEditList = .T. and inlist(this.rowsourcetype, 2,6)
	atdot = at(".", this.rowsource)
	if atdot > 0
		tabletoedit = LEFT(this.rowsource, atdot - 1)
	else
		tabletoedit = this.rowsource
	endif
	do form (THIS.PickListEditor) with DBF(tabletoedit)
	this.requery()
endif

ENDPROC
PROCEDURE GotFocus
this.initialvalue = this.displayvalue
ENDPROC
PROCEDURE Init
THIS.DistToFormBottom = THISFORM.Height - THIS.Top
THIS.DistToFormRight = THISFORM.Width - THIS.Left
IF !EMPTY(THIS.ControlSource)
	IF THIS.AlwaysReadOnly
		THIS.ReadOnly = .T.
	ENDIF
	IF THIS.AlwaysEditable 
		THIS.ReadOnly = .F.
	ELSE
		IF THISFORM.AutoEdit = .F. 
			THIS.ReadOnly = .T.
		ENDIF
	ENDIF
ENDIF
ENDPROC
     
 ��ࡱ�                >  ��	                               ����        ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������                                ������   @       O l e O b j e c t D a t a                                            ����                                        �        A c c e s s O b j S i t e D a t a                             &  ������������                                       8        C h a n g e d P r o p s                                         ������������                                                 ��������   ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������a�V�
4��k �O��L   ]                             L           8                              8                                 �                                                               ��W s5��i +.b       L        �      F�                                                                                                                                                                                                                                                                                   j���    Q  Q                        �S   %   E      �  �   �          �  U  8+ ��  � � � � � � � � �	 � �� � � � � ��
 � � � J�� �(� � � � � � %�C� ���� � T� �� ���+ ��C� No Subject Specified� � Error�x�� � %�C� ���� T� �� ���- ��C� No Body Text Specified� � Error�x�� � %�� � ��#�	 B�� �� � %�C�  ���C� T�  ��  �� � %�C� ���c� T� ��  �� �, T� � �� C� C� CC�� ���X�� T� � �C� ��� %�CC�� �
��P� ��
 ���(�C�� ����L� %�CC �
 � 0
��H�L ��C�& Attachment File is Missing or Invalid:C� C �
 � � � Error�x�� T� �� ��� � �� � %�� � ��n�	 B�� �� � T� �C �   � � � �� %�� � ����
 B������ �( T� � �C� MSMAPI.MAPIMessages.1�N�� ��� � ��(� T�� �� �� ��C�� �� T�� ������ T�� �� � �� T�� �� � �� T�� �� �� T�� �C�� �� ��
 ���(�C�� ������ T�� ��� �� T�� �C �
 � �� �� %�CC�� �
���� ��
 ���(�C�� ������ T�� ��� �� T�� �C �
 � �� T�� ���� �� � %�CC�� �
��]� ��
 ���(�C�� ����Y� T�� ��� �� T�� �C �
 � �� T�� ���� �� �! T� �C� � >C�� ����� %�CC�� �
��� T��  �� �� T��! �C�� �� ��
 ���(�C�� ����� T��" ���# �� T� �� ��� T��  �� �� T��! �C �
 � �� �� � ��Ca��$ �� ��	 B�� �� U% 
 LCUSERNAME
 LCPASSWORD LARECIPIENTS LACCRECIPIENTS LABCCRECIPIENTS	 LCSUBJECT
 LCBODYTEXT LAATTACHMENTFILES	 LLRECEIPT LLSHOWOUTLOOK LNLOOP LNERRORS LCTEMP THIS NRECIPCOUNT NATTACHCOUNT	 CBODYTEXT CSUBJECT LNSESSIONID CREATESESSION OMESSAGE	 SESSIONID COMPOSE MSGINDEX MSGNOTETEXT
 MSGSUBJECT MSGRECEIPTREQUESTED RECIPDISPLAYNAME
 RECIPINDEX
 RECIPCOUNT	 RECIPTYPE LNATTACHPOS ATTACHMENTPOSITION ATTACHMENTPATHNAME ATTACHMENTINDEX ATTACHMENTCOUNT SEND ��  � � T� �C�]C��]��! %�C� THIS.oSessionb� O��� �( %�� � � �  � � � � � 	��y � B�� � � �� �� � ��C� � � �� � �' T� � �C� MSMAPI.MAPISession.1�N�� T� � � ��  �� T� � � �� �� ��C� � �	 �� G(�� �� B�� � � �� U
 
 LCUSERNAME
 LCPASSWORD LCOLDFOLDER THIS OSESSION USERNAME PASSWORD	 SESSIONID SIGNOFF SIGNON�+ ��  ���� ���� ���� ���� �� � � � � �	 �
 �( J�� �(� � � � � �
 � � � %�C� � �
��� � T�
 ��
 ��� � %�C� � �
��� � T�
 ��
 ��� � %�C� � �
��� � T�
 ��
 ��� � %�C� � �
��� T�
 ��
 ��� � ��� � ���� �� ���(��� ���� T�� �� ��� T�	 �� ��D %�C� � �
�. C� � @C�� @� C� � @CC�� @� smtp:�	���� T�	 ��	 ��� �& %�C� � �
� C� � @C�� @	���� T�	 ��	 ��� �' %�C� � �
� C�� �
=� � 	��%� T�	 ��	 ��� �' %�C� � �
� C�� �
=� � 	��a� T�	 ��	 ��� � %��	 �
 ���� T� � �� � ��� � � �� � �� T� � �� � ���� �� � �� �� B�� � �� U 
 LAFROMDATE LATODATE	 LASUBJECT LASENDER
 LNFROMDATE LNTODATE	 LNSUBJECT LNSENDER LNLOOP LNFILTERMATCH LNFILTERCOUNT THIS NFILTEREDTOTAL CSENDERNAME CSUBJECT CMESSAGEFROMDATE CMESSAGETODATE OMESSAGE MSGCOUNT MSGINDEX MSGORIGDISPLAYNAME MSGORIGADDRESS
 MSGSUBJECT MSGDATERECEIVED AMESSAGENUMBERS  B�������� @�� U  8 ! %�C� THIS.oSessionb� O��1 � ��C�  � � �� � U  THIS OSESSION SIGNOFF sendmail,     �� createsessionG    �� filtermessages�    �� version�    �� Destroy�    ��1 �B� �� �A � �A � A � � A � � A �"C�Q�A A A � A �� A �� � � � !�� 1A C�� 1� A A B�� 1� A A A� !�� � 1A A � A � 3 � b�� � A A q11� � 3 ���3A 1A 1A 1A �!� BA aA qA qA q1�A A A � 3 @2 A 3                       �     Q   �    |   a   �    �   �   ,  �  �   �   �       )   Q                       �initialvalue Holds the value that the control had when it got focus. Used for comparing changes when leaving the field.
resizetobottom
resizetoright
heightdifference
widthdifference
disttoformbottom
disttoformright
locktobottom
locktoright
alwayseditable If .T., causes Form.DisableAllControls to skip over this control
alwaysreadonly If .T., causes the Form.EnableAllControls to skip over this control.
requiredfield Set  to .T. if this field should have a value before saving
requiredbackcolor
*resize Occurs when an object is resized.
*anychange Called from both the interactivechange and the programmaticChange events
*spellcheck 
*reposition 
     �osession MAPI Session Object
omessage MAPI Message Object
cbodytext Message body text
csubject Subject of current message
nrecipcount Total number of recipients
nccrecipcount Total number of CC recipients
nbccrecipcount Total number of BCC recipients
nattachcount Total number of attachment files
nmessagecount Total number of messages
csendername Originator of message
nfilteredtotal Total number of messages that match the specified filter.
cmessagefromdate Filter date to start at
cmessagetodate Filter date to end at
*sendmail Sends email
*createsession Creates a session and returns ID
^aattachmentfiles[1,0] Array of attachment file names
^accrecipients[1,0] Array of CC recipients
^abccrecipients[1,0] Array of BCC recipients
^arecipients[1,0] Array of recipient names
^amessagenumbers[1,0] Contains message index numbers of message that match filter.
*filtermessages Selects filtered messages.
*version Returns version number and holds version information.
     �PROCEDURE addchild
DO FORM (THIS.AddEditForm) WITH EVAL(THIS.ParentIDExpr) TO lnNewID
IF TYPE("lnNewID") <> "L"
	lnid = EVAL(THIS.ParentIDExpr)
	REQUERY(THIS.RecordSource)
	lnSelect = SELECT()
	SELE (THIS.RecordSource)
	LOCATE FOR id = lnNewID
	SELECT (lnSelect)
	THIS.Refresh()
	THIS.SetFocus()
	THIS.AfterAddChild()
ENDIF

ENDPROC
PROCEDURE editchild
IF !EOF(THIS.RecordSource) AND !BOF(THIS.RecordSource)
	lcChildAliasPK = ALLTRIM(THIS.RecordSource) + ".id"
	DO FORM (THIS.AddEditForm) WITH EVAL(THIS.ParentIDExpr), EVAL(lcChildAliasPK) TO lnNewID

	IF TYPE("lnNewID") <> "L"
		lnid = EVAL(THIS.ParentIDExpr) 
		REQUERY(THIS.RecordSource)
		lnSelect = SELECT()
		SELE (THIS.RecordSource)
		LOCATE FOR id = lnNewID
		SELECT (lnSelect)
		THIS.Refresh()
		THIS.SetFocus()
		THIS.AfterEdit()
	ENDIF
ENDIF
ENDPROC
PROCEDURE confirmdelete
DO CASE
	CASE !EMPTY(ALLTRIM(THIS.SpecificConfirmItem))
		cMessage = 'Are you sure you want to delete ' + ALLTRIM(EVAL(THIS.SpecificConfirmItem)) + '?'
	CASE !EMPTY(ALLTRIM(THIS.GenericConfirmItem))
		cMessage = 'Are you sure you want to delete this ' + ALLTRIM(THIS.GenericConfirmItem) + '?'
	OTHERWISE
		cMessage = 'Are you sure you want to delete this record?'
ENDCASE

IF MESSAGEBOX(cMessage,4+32,"Delete") = 6
	RETURN .T.
ELSE
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE deletechild
IF !EOF(THIS.RecordSource) AND (!THIS.lConfirmDelete OR THIS.ConfirmDelete())
	DELETE IN (THIS.RecordSource)
	IF THISFORM.UpdateTable(THIS.RecordSource)
		SKIP 1 IN (THIS.RecordSource)
		IF EOF(THIS.RecordSource)
			GO BOTTOM IN (THIS.RecordSource)
		ENDIF
		THIS.AfterDeleteChild()
		THIS.REFRESH()
		THIS.SETFOCUS() && To update grid's pointer and dynamic properties
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF
ENDIF

RETURN .F. && If any of the above conditions fail

ENDPROC
PROCEDURE Init
DODEFAULT()
THIS.SetReadOnly(.T.)

ENDPROC
PROCEDURE commoncontroldblclick
THIS.EditChild()
ENDPROC
     �stretchable Evaluated at run time to set the borderstyle so borderstyle can be left to 'sizeable' at design time.
rememberposition Set to .T. if this form should use registry settings to record and remember its position
registryname Holds name to store this forms settings under in the windows registry. If Registry name is empty when the form instanciates, Registryname is set to this.name
registryapp String used as the path in HKEY_CURRENT_USER for storing form settings. To be changed for different projects.
remembersize Set to .T. if this form should use registry settings to record and remember its size
confirmreleaseonclose Set to .T. if the form should check for dirty buffers and ask the user to save changes before closing
genericconfirmitem Word or phrase to be used by form when asking to save changes. Form.GenericConfirmItem = "Member" causes the message: "Do you want to save the changes you made to this member?"
specificconfirmitem Expression to be used when asking if the user want to save changes: Form.SpecificConfirmItem = "Member.Fname" gives the message "Do you want to save the changes you made to Erik?"
reportfile Holds the name of a report file associated with the print button on this form
autoedit If .T., fields on form are always editable, and changing one causes the form to go into edit mode. When .F., fields are readonly until the Edit method is called.
currentid Holds the primary key of the current record in the main alias.
mainalias Holds the alias for the main table or view.
sendcurrentidtolookup Specifies if the lookup form looks for the current id.
datapath Holds the path to the application data. Normally acquired fromthe application object.
*printit Prints the form's report. Calls BuildReport() method. NOTE: Code is in the MACForm Class.
*preview Previews the form's report. Calls the BuildReport() method. NOTE: Code is in the MACForm Class.
*buildreport Builds the report. Requires a parameter for the type of output (i.e. to printer, preview). Usually calls the SendReport() method.  There is NO CODE in the parent class (MACForm).
*sendreport Sends the report to the desired output. Requires two parameters; the report name and the type of output NOTE: Code is in the MACForm Class.
^adelist[1,0] An array that holds the members of objects in the DataEnviornment. Updated to hold the name of the cursor object in the second column.
*setenvironment used to set datasession specific settings.
*saveall Loopes through all cursors and sends them to 'updatetable'
*updatetable Wrapper around a TABLEUPDATE(). failures are handled by THIS.HandleConflict()
*revertall Loops through all buffered cursors in DE and issues a TABLEREVERT
*getissuerid Wrapper around call to modal issuer lookup form. Returns issuerid or .F. if user closed form without choosing.
*handleconflicts Error method to handle any errors returned by this.updatetable
*writepos Writes the form's current position to the registry.
*readpos Reads and restores the form's last recorded position from the registry.
*dbfieldchange Called when the user changes data in a databound control on the form.
*runall Runs a specified method for each control in the form.
*isbufferclean Checks the buffer for all cursors in the DE, and returns .T. if there are no pending changes
*builddelist Populate the form's aDEList array with the tables in the DE.
*changedatapath Change the database property of the cursors in the DE to the specified path.
*confirmrelease 
*printreport Prints the report specified in Form.ReportFile
*edit Called from the edit button, or from any databound control that should cause the form to go into "Edit" mode. Enables all databound controls whose "AlwaysReadonly" property is not .T.
*enableallcontrols Causes all databound controls on the form whose "AlwaysReadOnly" property is .F. to become enabled.
*disableallcontrols Causes all databound controls whose AlwaysEditable property is not set to .T. to become disabled or Readonly
*undo Reverts all pending changes to tables in the form and, depending on THIS.AutoEdit, disables all controls on the form.
*save 
*beforesave Called from the save method: must return true before the save method finishes.
*aftersave Called from the save method after data has been saved.
*beforeundo Called from the undo method. Must return true before Undo finishes.
*lookup Calls the form specifid in THIS.LookupForm, sets THIS.CurrentID to the return value, and calls THIS.RequeryViews.
*beforeedit Occurs before the form goes into edit mode.
*delete Deletes the current record from the alias specified in thisform.MainAlias
*confirmdelete Asks the user to confirm before deleting the current record.
*add Adds a record to the form's main alias.
*beforeadd Called from add before a blank record is added to the main alias. If flase is returned fromn this method, the add operation is cancelled.
*afteradd Called after the blank record is added to the current table. Default values should be populated here. If this method returns .F., the new record is reverted and the form cancels out of add mode.
*firstfieldsetfocus Sets the focus to the field on the form with TabOrder = 1
*requeryviews hook method to be used to requery views in the form.
^childaliases[1,0] An array that holds the names of any child views that should be queried when the main view is requeried.
*afterrequeryviews Hook method called after all the code in reuqeryviews runs.
*validateallcontrols 
*adjusttop 
*printform 
     ����    �  �                        �   %   #      �  +   �          �  U  _  %��  � ��* � T�  � �� � �  � �� � %��  � ��X � T�  � �� � �  �	 �� � U
  THIS LOCKTOBOTTOM TOP THISFORM HEIGHT DISTTOFORMBOTTOM LOCKTORIGHT LEFT WIDTH DISTTOFORMRIGHTP  T�  � ��  � ��- %�� k�  � � C�
 THIS.Valueb� N	��I �	 ��C��� � U  THIS INITIALVALUE VALUE FORMAT[  ��C�  � �� %�C�  � �
��T �# %�C� � DBFieldChange��h��P � ��C� � �� � � U  THIS	 ANYCHANGE CONTROLSOURCE THISFORM DBFIELDCHANGE  ��C�  � �� U  THIS	 ANYCHANGE�  T�  � �� � �  � �� T�  � �� � �  � �� %�C�  � �
��� � %��  �	 ��e � T�  �
 �a�� � %��  � ��� � T�  �
 �-�� �� �* %�C� � AutoEdit��h�	 � � -	��� � T�  �
 �a�� � � � U  THIS DISTTOFORMBOTTOM THISFORM HEIGHT TOP DISTTOFORMRIGHT WIDTH LEFT CONTROLSOURCE ALWAYSREADONLY READONLY ALWAYSEDITABLE AUTOEDITM  %�C�  � 
��% � T�  � ��  � �� �F � ��C�	 BackColor�  � �� � U  THIS VALIDATE	 BACKCOLOR INVALIDBACKCOLOR RESETTODEFAULT
 reposition,     �� GotFocus�     �� InteractiveChangen    �� ProgrammaticChange    �� Init+    �� Valid�    ��1 �A �A 3 1�� A 3 � 11� A A 3 � 3 ��2� A � � �� A A A 4 !1� �A 2                       �         �   =  
      e  �          *        E  �     %   �  @  1    )   �                       T���    ;  ;                        y<   %   y      �  %   �          �  U  " T�  �� � �� T� �� � �� H�- ��@ �C�  � DELE� ANSI� SAFE� EXAC� CENT� TALK� CURS���� � SET &lcSetting &luValue
G �C�  � DECI� DEFA� FILT� PATH� PROC� CLAS� ORDE� REPR���� � SET &lcSetting TO &luValue
 ��  � SELE���
 F�� �� 2�� B�-�� � U 	 LCSETTING THIS SETTING LUVALUE OLDVALUE� ��  � �2 %�C�	 tcSettingb� C� C� tuValueb� L��D � B�-�� � T�  �CC�  f�=�� T� � ��  �� H�y ���@ �C�  � DELE� ANSI� SAFE� EXAC� CENT� TALK� CURS���� %�CC� f� ON� OFF�
��� � B�-�� � T� � �C�  v�� SET &tcSetting &tuValue
G �C�  � DECI� DEFA� FILT� PATH� PROC� CLAS� ORDE� REPR����� T� � �C�  v�� SET &tcSetting TO &tuValue
 ��  � SELE���� T� � �CW��
 F�� �� 2��� B�-�� � U 	 TCSETTING TUVALUE THIS SETTING OLDVALUE Destroy,     �� Init    ��1 � �q�Q� � q A 4 � "q A B� �q A !�q!�Q� � � q B 3                       �        �  5      )   ;                       7PROCEDURE readpos
lcCompanyName = "MAC"
lcApplicationName = "TMR"
lcVersion = "1.0"

lcRegistryLocation = "Software\" + lcCompanyName + "\" + lcApplicationName + "\" + lcVersion + "\Toolbars\"

IF TYPE('THIS.Registry1.Name') <> "C"
	SET CLASSLIB TO macbase.vcx ADDI
	THIS.AddObject('Registry1','Registry')
ENDIF

lnTop = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation+ ALLTRIM(THIS.RegistryName), "Top", -1)
lnLeft = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Left", -1)
lnHeight = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Height", -1)
lnWidth = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Width", -1)
llDocked = THIS.Registry1.GetBooleanValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Docked", .F.)
lnDockPosition = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "DockPosition", -2)

IF TYPE('llDocked') = "L" AND llDocked = .T. AND TYPE('lnDockPosition') = "N" AND lnDockPosition <> -2
	THIS.Dock(lnDockPosition)
	RETURN .T. && If this toolbar is docked, we don't need to read any more coordinates
ENDIF	

IF TYPE('lnTop') = "N" and lnTop <> -1
	THIS.Top = lnTop
ENDIF

IF TYPE('lnLeft') = "N" and lnLeft <> -1
	THIS.Left = lnLeft
ENDIF	

IF TYPE('lnHeight') = "N" and lnHeight <> -1
	THIS.Height = lnHeight
ENDIF

IF TYPE('lnWidth') = "N" and lnWidth <> -1
	THIS.Width = lnWidth
ENDIF	


ENDPROC
PROCEDURE writepos
IF TYPE('THIS.Registry1.Name') <> "C"
	RETURN .F.
ENDIF


lcCompanyName = "MAC"
lcApplicationName = "TMR"
lcVersion = "1.0"

lcRegistryLocation = "Software\" + lcCompanyName + "\" + lcApplicationName + "\" + lcVersion + "\Toolbars\"

llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.Name), "Top", THIS.Top)
llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.Name), "Left", THIS.Left)
llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.Name), "Height", THIS.Height)
llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.Name), "Width", THIS.Width)
*!*	llSuccess = THIS.Registry1.SetBooleanValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.Name), "Docked", THIS.Docked)
*!*	llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.Name), "DockPosition", THIS.DockPosition)



ENDPROC
PROCEDURE writedockstatus
LPARA tlDocked
lnDockPosition = IIF(tlDocked, THIS.DockPosition, -1)

IF THIS.RememberPosition
	IF TYPE('THIS.Registry1.Name') <> "C"
		RETURN .F.
	ENDIF
	lcCompanyName = "MAC"
	lcApplicationName = "TMR"
	lcVersion = "1.0"
	lcRegistryLocation = "Software\" + lcCompanyName + "\" + lcApplicationName + "\" + lcVersion + "\Toolbars\"
	llSuccess = THIS.Registry1.SetBooleanValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.Name), "Docked", tlDocked)
	llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.Name), "DockPosition", lnDockPosition)
ENDIF



ENDPROC
PROCEDURE UnDock
IF THIS.RememberPosition
	THIS.WriteDockStatus(.F.)
ENDIF

ENDPROC
PROCEDURE Destroy
IF THIS.RememberPosition
	THIS.WritePos()
ENDIF

ENDPROC
PROCEDURE Init
IF EMPTY(THIS.RegistryName)
	THIS.RegistryName = THIS.Name
ENDIF

IF THIS.RememberPosition
	THIS.ReadPos()
ENDIF

ENDPROC
PROCEDURE AfterDock
IF THIS.RememberPosition
	THIS.WriteDockStatus(.T.)
ENDIF

ENDPROC
     b���    I  I                        Bb   %   �      0  �              �  U  f �  � �������' �� � �C�  � ����C�  � ����& T� �������� Form Designer��! T� �������� Standard�� T� �������� Layout��' T� �������� Query Designer��& T� �������� View Designer��& T� �������� Color Palette��& T� �������� Form Controls��* T� �������� Database Designer��( T� ��	������ Report Designer��( T� ��
������ Report Controls��& T� �������� Print Preview�� �� ���(�C�� ����H�# T� �� �����CC � �� ��� %�C � �� ��D� �,�C � �� �� � �� ��C�� �  � ��� B� U  THIS AVFPTOOLBARS	 LNTOOLBAR LAVFPTOOLBARSc  ��  � ��  ���(�C� � ����X � %�C �  �� � ��T � �,�C �  �� � �� � �� B� U 	 LNTOOLBAR THIS AVFPTOOLBARS T�  � ��9� �� T�  � ��9� �� T�  � ��9� �� T�  � ��9� �� T�  �	 ��9�
 �� %�C�  � �
�� � T�9�
 ��  � �� � %�C�  � �
��� � T�9� ��  � �� � %�C�  � �
��� � T�9� ��  � �� � %�C�  � �
��� � T�9� ��  � �� � T�9� ���� T�9� �a�� U  THIS OLDSCREENCAPTION CAPTION OLDSCREENBACKCOLOR	 BACKCOLOR OLDSCREENPICTURE PICTURE OLDSCREENVISIBLE VISIBLE OLDSCREENICON ICON
 SCREENICON SCREENCAPTION SCREENBACKCOLOR WINDOWSTATE�  %�C�  � �
��% � T�9� ��  � �� � %�C�  � �
��N � T�9� ��  � �� � %�C�  � �
��w � T�9� ��  � �� � T�9� ��  � �� T�9�	 ��  �
 �� U  THIS OLDSCREENCAPTION CAPTION OLDSCREENBACKCOLOR	 BACKCOLOR OLDSCREENPICTURE PICTURE ICON OLDSCREENICON VISIBLE OLDSCREENVISIBLE'  %�C�  � �
��  � ��  � �� � U  THIS MENUFILE5  %�C�  � �
��. � ��  � �(� �	 B�� �� � U  THIS	 LOGINFORM LLLOGINSUCCESSx  %�C�  � �
��q � 7� � T� �C�  � �N��# %�C� oSecurity.Nameb� C
��^ � <� � B�-�� �m � B�a�� � � U  THIS SECURITYCLASS	 OSECURITYu  %�C�  � �
��n � 7� � T� �C�  � �N��  %�C� oForms.Nameb� C
��[ � <� � B�-�� �j � B�a�� � � U  THIS FORMSMANAGERCLASS OFORMS
  ��  � U 	 TCSETTING�  ��  �  ��  ��9� �(����������� � T� �C �  �9� �� %�C�
 oForm.Nameb� C��� � %�C� � f� TOOLBAR��� � %�C� � ��� � ��C� � �� �� � B�-�� � � � �� T�9� �-�� ��C� �	 �� ��C� �
 �� {�  � GY(� <� � <� � U  I	 FORMCOUNT OFORM FORMS	 BASECLASS QUERYUNLOAD RELEASE VISIBLE THIS RESTORESCREENPROPS RESTOREVFPTOOLBARS
 GOSECURITY GOFORMS(  %�C�  � �
��! � ��  � �� � U  THIS INITIALFORM�  %�C�  � 
�� �f ��C� The application object for �  � �+  does not have enough information to start.�0�  � �x�� B�-�� � +�a��� � 9�� %�C�  � ��� � !� � � U  THIS CHECKALLREQUIREMENTS APPNAME CLEANUP�  %�C�  � ���� �C T� �C� c:\�! Where is the database folder for �  � � ?�3�� %�C� �
��u � T�  � �� �� �� � B�-�� � � U  THIS DATAPATH LCDATADIRECTORY APPNAMEv  ��  � ��C� � �� ��C� � �� ��C� � �� ��C� � �� ��C� � �� ��C� � �� %��  ��o � ��C� � �� � U	  TLSTARTONCREATE THIS RELEASEVFPTOOLBARS SETSCREENPROPS SHOWMENU CREATEFORMSMANAGER CREATESECURITYOBJECT SHOWINITIALFORM
 READEVENTS releasevfptoolbars,     �� restorevfptoolbars�    �� setscreenpropsJ    �� restorescreenprops/    �� showmenu`    ��	 userlogin�    �� createsecurityobject�    �� createformsmanager�    �� getusersetting+    �� cleanupD    �� showinitialform�	    ��
 readevents

    �� checkallrequirements�
    �� Init�    ��1 crc�qaaa���a�1Q1A A 2B 3 q ��aA A A 2 !!!!!3!A 2!A 2!A 2!A � � 3 1!A 2!A 2!A "!3 1� A 2 1!� A 2 1q 11q q � q A A 2 1q 1q q � q A A 2 q 3 q A��� � q A A A A � � � � q q q 3 1� A 3 !aq A � R A A A 3 !1� q A A 3 q � � � � � � � � A 2                       �        �  �  (      �  -  3   3   V  �	  O   ?   �	  �	  `   C   
  
  e   H   �
  t  k   S   �  c  w   ^   �  �  �   `   �  \  �   u   �  �  �   y   �  �  �   �   �  �  �   �   �  �  �    )   I                       +�PROCEDURE sethighlightrow
IF THIS.highlightentirerow
	THIS.SETALL("DynamicBackColor","IIF(this.grdcurrow = RECNO(this.recordsource), this.highlightcolor, this.backcolor)","Column")
	IF !EMPTY(THIS.HighlightForeColor)
		oColumn.DynamicForeColor = "IIF(this.grdcurrow = RECNO(this.recordsource), THIS.HighlightForeColor, THIS.ForeColor)"
	ENDIF

	FOR EACH oColumn IN THIS.COLUMNS

		FOR EACH oControl IN oColumn.Controls
			* Check to see if that control has a BackColor property, and if it does, change it to match the grid's highlight color.
			IF UPPER(oControl.BaseClass) <> "HEADER"
				IF PEMSTATUS(oControl, "BackColor", 5)
					oControl.BACKCOLOR = THIS.HighlightColor
				ENDIF
				IF PEMSTATUS(oControl, "ForeColor", 5)
					oControl.FORECOLOR = THIS.HighlightForeColor
				ENDIF
			ENDIF
		ENDFOR
	ENDFOR
ENDIF

ENDPROC
PROCEDURE setwidth
TotalColWidth = 0

FOR i = 1 TO THIS.COLUMNCOUNT
	TotalColWidth = TotalColWidth + THIS.COLUMNS(i).WIDTH
ENDFOR

DeleteMarkWidth = IIF(THIS.DELETEMARK, 8,0)
RecordMarkWidth = IIF(THIS.RECORDMARK, 10, 0)
ScrollBarWidth = IIF(THIS.SCROLLBARS > 1, SYSMETRIC(7), 0)
TotalGridLineWidth = THIS.COLUMNCOUNT * THIS.GRIDLINEWIDTH
NewGridWidth = TotalColWidth + DeleteMarkWidth + RecordMarkWidth + ScrollBarWidth + TotalGridLineWidth + 2

IF NewGridWidth < THIS.originalwidth
	THIS.WIDTH = NewGridWidth
	IF THIS.SCROLLBARS > 0
		THIS.ScrollBars = 2     && If columns don't go beyond grid size, we don't need a horizontal scrollbar
	ENDIF
ENDIF

ENDPROC
PROCEDURE copyprop
LPARA o1, o2

* Copy all property values from one object to another
IF TYPE('o1.Name') <> "C" OR TYPE('o2.Name') <> "C"
	RETURN .F.
ENDIF

lnPropertyCount = AMEMBERS(aProps, o1)

FOR i = 1 TO lnPropertyCount
	IF !ALLTRIM(UPPER(aProps(i)))$"CLASS:PARENTCLASS:BASECLASS:NAME"
		uVal = GETPEM(o1,aProps(i)) && Value of property in source
		IF PEMSTATUS(o2,aProps(i),5) && Does property exist in the second object?
			IF !PEMSTATUS(o2,aProps(i),1) && Is the property readonly?
				IF !PEMSTATUS(o2,aProps(i),2) && Is the property protected?
					o2.WriteExpression(aProps(i), uVal)
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDFOR

ENDPROC
PROCEDURE commonheaderclick
LPARA toHeader

ENDPROC
PROCEDURE commonheaderdblclick
LPARA toHeader

ENDPROC
PROCEDURE setsorttags
IF !EMPTY(THIS.RecordSource) AND THIS.RecordSourceType = 1 && Alias
	lnSelect = SELECT()
	SELECT (THIS.RecordSource)
	lcTag = TAG()
	lnBufferMode = CURSORGETPROP("Buffering")
	CURSORSETPROP("Buffering", 3)
	* CreateIndexTags is an empty method. It can be filled out at the instance level to 
	* create indexes to be used for grid sorting.
	THIS.CreateIndexTags()
	CURSORSETPROP("Buffering", lnBufferMode)
	SET ORDER TO lcTAG
	* Create an array and fill it with the names of all tags on the
	* recordsource table or view, and all the index expressions
	IF TAGCOUNT() > 0
		DIMENSION latags(TAGCOUNT(),2)
		FOR i = 1 TO TAGCOUNT()
			* Store the name of the tag
			laTags[i,1] = LOWER(TAG(i))
			* Store the expression
			laTags[i,2] = UPPER(SYS(14, i))
		ENDFOR
	ENDIF


		FOR EACH oColumn IN THIS.Columns
			* We can only do this if the column has a control source, and there are 
			* one or more indexes on the grid's recordsource
			IF !EMPTY(oColumn.ControlSource) AND TYPE('laTags[1,1]') = "C"
				* If the alias is included in the controlsource, parse out the field name
				* otherwise just use the controlsource
				IF "."$oColumn.ControlSource
					lcSourceField = LOWER(RIGHT(oColumn.ControlSource, LEN(oColumn.ControlSource) - RAT(".",oColumn.ControlSource)))
				ELSE
					lcSourceField = LOWER(oColumn.ControlSource)
				ENDIF

				* Search the tags array for a tag with the same name as the controlsource for this column
				* If there is one, set the header's SortTag property to that tag.
				IF ASCAN(laTags, ALLTRIM(lcSourceField), 1) > 0
					oColumn.header1.SetSortTag(lcSourceField)
*					oColumn.Header1.FontBold = .T.
				ENDIF

			ENDIF
		ENDFOR
	
	SELE (lnSelect)
ENDIF


ENDPROC
PROCEDURE setbackgroundcolor
LPARA tnBackGroundColor
IF !EMPTY(tnBackGroundColor)
	lnNewBackColor = tnBackGroundColor
ELSE
	lnNewBackColor = GETCOLOR()
ENDIF

IF TYPE("lnNewBackColor") = "N"
	THIS.BackColor = lnNewBackColor
ENDIF

ENDPROC
PROCEDURE sethighlightcolor
lnNewHighlightColor = GETCOLOR()
IF TYPE("lnNewHighlightColor") = "N"
	THIS.HighlightColor = lnNewHighlightColor
ENDIF

THIS.SethighlightRow()

ENDPROC
PROCEDURE restorecolumnwidths
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase ADDI
	THISFORM.AddObject("Registry1","Registry")
ELSE
	oRegistry = THISFORM.Registry1
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF

IF EMPTY(THIS.RegistryName)
	THIS.RegistryName = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name + "\" + THIS.RegistryName + "\" + "ColumnWidths"

DIMENSION laColumnsWidths(THIS.ColumnCount)
FOR i = 1 TO THIS.ColumnCount
	lnWidth = THISFORM.Registry1.GetNumValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , ALLTRIM(STR(i)), -1)
	IF lnWidth > 0 	
		THIS.Columns(i).Width = lnWidth
	ENDIF
ENDFOR

ENDPROC
PROCEDURE savecolumnwidths
IF TYPE('THISFORM.Registry1.Name') = "C"
	oRegistry = THISFORM.Registry1
ELSE
	SET CLASSLIB TO MacBase
	oRegistry = CREATEOBJECT("Registry")
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name + "\" + THIS.RegistryName + "\" + "ColumnWidths"

DIMENSION laColumnsWidths(THIS.ColumnCount)
FOR i = 1 TO THIS.ColumnCount
	oRegistry.SetNumValue(oRegistry.hkey_current_user, lcRegistryLocation , ALLTRIM(STR(i)), THIS.Columns(i).Width)
ENDFOR
ENDPROC
PROCEDURE commonheaderrightclick
LPARA toHeader

ENDPROC
PROCEDURE installcustomheader
IF !EMPTY(THIS.DefaultHeaderClass)
	IF !EMPTY(THIS.DefaultHeaderClassDefinition) 
		SET PROCEDURE TO (THIS.DefaultHeaderClassDefinition) ADDITIVE
	ENDIF
	FOR EACH oColumn IN THIS.Columns
		lcHeaderCaption = oColumn.Header1.Caption
		lcHeaderForeColor = oColumn.Header1.ForeColor
		* Remove the default header object, and replace it with one from
		* the class specified in the grid's properties.
		oColumn.RemoveObject('Header1')
		oColumn.AddObject('Header1',THIS.DefaultHeaderClass)
		oColumn.Header1.Caption = lcHeaderCaption
		oColumn.Header1.ForeColor = lcHeaderForeColor
	ENDFOR
ENDIF


ENDPROC
PROCEDURE setreadonly
LPARA tlReadOnly

THIS.ReadOnly = tlReadOnly

* If we are setting Readonly, set all columns to readonly.
* If we are enabling columns, only enable the ones that were 
* enabled when the grid ws instanciated.
IF tlReadOnly
	THIS.SetAll("ReadOnly",.T.,"Column")
ELSE
	FOR i = 1 TO THIS.ColumnCount
		IF !THIS.aColReadOnly[i]
			THIS.Columns[i].ReadOnly = .F.
		ENDIF
	ENDFOR
ENDIF

ENDPROC
PROCEDURE currentcolumn_access
LOCAL loColumn

FOR EACH loColumn IN THIS.Columns
	IF loColumn.ColumnOrder = THIS.ActiveColumn
		THIS.CurrentColumn = loColumn
		EXIT
	ENDIF
ENDFOR

RETURN THIS.CurrentColumn

ENDPROC
PROCEDURE RightClick
DEFINE POPUP Gridoptions SHORTCUT RELATIVE FROM MROW(),MCOL()
DEFINE BAR 1 OF Gridoptions PROMPT "Set background color"
DEFINE BAR 2 OF Gridoptions PROMPT "Set Highlight color"
ON SELECTION BAR 1 OF Gridoptions _SCREEN.ActiveForm.ActiveControl.SetBackGroundColor()
ON SELECTION BAR 2 OF Gridoptions _SCREEN.ActiveForm.ActiveControl.SetHighlightColor()
ACTIVATE POPUP GridOptions

ENDPROC
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex
IF !EMPTY(THIS.RecordSource)
	THIS.grdCurRow = RECNO(THIS.RecordSource)
ENDIF
THIS.Refresh()

ENDPROC
PROCEDURE Init
THIS.OriginalHeight = THIS.Height
THIS.OriginalWidth = THIS.Width

THIS.DistancetoFormBottom = THISFORM.Height - (THIS.Top + THIS.Height)
THIS.DistancetoFormRight = THISFORM.Width - (THIS.Left + THIS.Width)

*****************************************************
IF THIS.ReadOnly
	THIS.SETALL('readonly', .T.,"Column")
ENDIF
THIS.SetHighlightRow()
THIS.InstallCustomHeader()
THIS.SetSortTags()

* The shape object sits behind the grid to make the "see through" grid properties invisible
* This is an attempt to make a grid that should not highlight it's rows more aesthetic
THIS.Parent.Addobject("shp" + THIS.Name, "Shape")
oShape = EVAL("THIS.Parent.shp" + THIS.Name)
oShape.top = THIS.Top
oShape.Left = THIS.Left
oShape.height = THIS.Height
oShape.Width = THIS.Width
oShape.FillStyle = 0 && Solid
oShape.BorderStyle = 0
oShape.FillColor = THIS.HighlightColor
oShape.ZOrder(1)
oShape.Visible = .T.

IF THIS.ColumnCount > 0
	* Store the original column widths in a grid property, so their proportionality can be used later
	* to resize the columns when the grid is resized.
	DIMENSION THIS.aColumnWidths(THIS.ColumnCount)
	FOR i = 1 TO THIS.ColumnCount
		THIS.aColumnWidths[i] = THIS.Columns(i).Width
	ENDFOR

	* Store the initial value of each column's ReadOnly property to be used when 
	* Setting or removing the grid's readonly status
	DIMENSION THIS.aColReadOnly(THIS.ColumnCount)
	FOR i = 1 TO THIS.ColumnCount
		THIS.aColReadOnly[i] = THIS.Columns(i).ReadOnly
	ENDFOR
ENDIF


IF THIS.RememberColumnWidths
	THIS.RestoreColumnWidths()
ENDIF

IF .F.
	* fool the compiler to have the header definition file included with the project
	DO macbase.prg
ENDIF

ENDPROC
PROCEDURE Refresh
THIS.AfterRowColChange()

ENDPROC
PROCEDURE Resize
IF THIS.ResizeWithBottom
	THIS.Height = THISFORM.Height - (THIS.DistanceToFormBottom + THIS.Top)
ENDIF

IF THIS.ResizeWithRight
	THIS.Width = THISFORM.Width - (THIS.DistanceToFormRight + THIS.Left)
ENDIF

IF THIS.ResizeColumns = .T.
	FOR i = 1 TO THIS.ColumnCount
			* How wide was the column originally in proportion to the whole grid?
			lnOriginalProportion = THIS.aColumnWidths[i] / THIS.OriginalWidth
			* Resize the column to the same proportion
			THIS.Columns(i).Width = lnOriginalProportion * THIS.Width
	ENDFOR
ENDIF

IF TYPE("THIS.Parent.shp" + THIS.Name) = "O" 
	oShape = EVAL("THIS.Parent.shp" + THIS.Name)
	IF !ISNULL(oShape)
		oShape.Width = THIS.Width
		oShape.Height = THIS.Height
	ENDIF
ENDIF

ENDPROC
PROCEDURE Destroy
IF THIS.RememberColumnWidths
	THIS.SaveColumnWidths()
ENDIF

ENDPROC
PROCEDURE BeforeRowColChange
LPARAMETERS nColIndex

WITH THIS
	IF MDOWN()
		lnBottom		= .TOP+.HEADERHEIGHT+.RELATIVEROW * .ROWHEIGHT
		lnTop		= lnBottom - THIS.ROWHEIGHT
		lnMouseRowPos	= MROW(WONTOP(),3)
		lnMouseColPos	= MCOL(WONTOP(),3)
		llChangingRow	= !(BETWEEN(lnMouseRowPos,lnTop, lnBottom) ;
			AND BETWEEN(lnMouseColPos,.LEFT,.LEFT+.WIDTH))
	ELSE
		llChangingRow	= INLIST(LASTKEY(),24,5,18,3,145,148)
	ENDIF
ENDWITH


IF llChangingRow
	THIS.BeforeRowChange()
ELSE
	THIS.BeforeColChange()
ENDIF

ENDPROC
     �PROCEDURE gonextpage
lnCurrentPageOrder = THIS.ActivePage

IF lnCurrentPageOrder = THIS.PageCount && Last page
	IF THIS.FirstAfterLast
		lnSeekOrder = 1
	ELSE
		RETURN
	ENDIF
ELSE
	lnSeekOrder = lnCurrentPageOrder + 1
ENDIF

THIS.ActivePage = lnSeekOrder


ENDPROC
PROCEDURE currentpage_access
*To do: Modify this routine for the Access method
LOCAL loPage

FOR EACH loPage IN THIS.Pages
	IF loPage.PageOrder = THIS.ActivePage
		THIS.CurrentPage = loPage
		EXIT
	ENDIF
ENDFOR

RETURN THIS.CurrentPage

ENDPROC
PROCEDURE Resize
IF THIS.ResizeWithBottom
	THIS.Height = THISFORM.Height - (THIS.DistanceToFormBottom + THIS.Top)
ENDIF

IF THIS.ResizeWithRight
	THIS.Width = THISFORM.Width - (THIS.DistanceToFormRight + THIS.Left)
ENDIF

FOR EACH oPage IN THIS.Pages
	FOR EACH oControl IN oPage.Controls
		IF PEMSTATUS(oControl, 'Reposition',5)
			oControl.Reposition()
		ENDIF
		IF PEMSTATUS(oControl, 'Resize',5)
			oControl.Resize()	
		ENDIF
	ENDFOR
ENDFOR

ENDPROC
PROCEDURE Init
THIS.DistancetoFormBottom = THISFORM.Height - (THIS.Top + THIS.Height)
THIS.DistancetoFormRight = THISFORM.Width - (THIS.Left + THIS.Width)

ENDPROC
PROCEDURE gopreviouspage
lnCurrentPageOrder = THIS.ActivePage

IF lnCurrentPageOrder = 1
	IF THIS.FirstAfterLast
		lnSeekOrder = THIS.PageCount
	ELSE
		RETURN
	ENDIF
ELSE
	lnSeekOrder = lnCurrentPageOrder - 1
ENDIF

THIS.ActivePage = lnSeekOrder


ENDPROC
      ���                              e&   %   F
      ^  M   �
          �  U  e T�  �� MAC�� T� �� TMR�� T� �� 1.0��: T� ��	 Software\�  � \� � \� �
 \Toolbars\��' %�C� THIS.Registry1.Nameb� C��� � G~(� macbase.vcx�$ ��C�	 Registry1� Registry� � �� �3 T� �C� �	 � � C� � �� Top���� �	 �
 ��4 T� �C� �	 � � C� � �� Left���� �	 �
 ��6 T� �C� �	 � � C� � �� Height���� �	 �
 ��5 T� �C� �	 � � C� � �� Width���� �	 �
 ��3 T� �C� �	 � � C� � �� Docked-� �	 � ��< T� �C� �	 � � C� � �� DockPosition���� �	 �
 ��M %�C� llDockedb� L� � a	� C� lnDockPositionb� N	�	 � ���	��t� ��C � � � �� B�a�� �% %�C� lnTopb� N�	 � ���	���� T� � �� �� �& %�C� lnLeftb� N�	 � ���	���� T� � �� �� �( %�C� lnHeightb� N�	 � ���	��#� T� � �� �� �' %�C� lnWidthb� N�	 � ���	��^� T� � �� �� � U  LCCOMPANYNAME LCAPPLICATIONNAME	 LCVERSION LCREGISTRYLOCATION MACBASE VCX THIS	 ADDOBJECT LNTOP	 REGISTRY1 GETNUMVALUE HKEY_CURRENT_USER REGISTRYNAME LNLEFT LNHEIGHT LNWIDTH LLDOCKED GETBOOLEANVALUE LNDOCKPOSITION DOCK TOP LEFT HEIGHT WIDTHy' %�C� THIS.Registry1.Nameb� C��. � B�-�� � T�  �� MAC�� T� �� TMR�� T� �� 1.0��: T� ��	 Software\�  � \� � \� �
 \Toolbars\��5 T� �C� � � � C� �	 �� Top� �
 � � � ��6 T� �C� � � � C� �	 �� Left� � � � � ��8 T� �C� � � � C� �	 �� Height� � � � � ��7 T� �C� � � � C� �	 �� Width� � � � � �� U  LCCOMPANYNAME LCAPPLICATIONNAME	 LCVERSION LCREGISTRYLOCATION	 LLSUCCESS THIS	 REGISTRY1 SETNUMVALUE HKEY_CURRENT_USER NAME TOP LEFT HEIGHT WIDTHK ��  � T� �C�  �	 � � � ���6�� %�� � ��D�' %�C� THIS.Registry1.Nameb� C��d � B�-�� � T� �� MAC�� T� �� TMR�� T� �� 1.0��: T� ��	 Software\� � \� � \� �
 \Toolbars\��6 T�	 �C� �
 � � C� � �� Docked �  � �
 � ��< T�	 �C� �
 � � C� � �� DockPosition � � �
 � �� � U  TLDOCKED LNDOCKPOSITION THIS DOCKPOSITION REMEMBERPOSITION LCCOMPANYNAME LCAPPLICATIONNAME	 LCVERSION LCREGISTRYLOCATION	 LLSUCCESS	 REGISTRY1 SETBOOLEANVALUE HKEY_CURRENT_USER NAME SETNUMVALUE%  %��  � �� � ��C-�  � �� � U  THIS REMEMBERPOSITION WRITEDOCKSTATUS$  %��  � �� � ��C�  � �� � U  THIS REMEMBERPOSITION WRITEPOSM  %�C�  � ���% � T�  � ��  � �� � %��  � ��F � ��C�  � �� � U  THIS REGISTRYNAME NAME REMEMBERPOSITION READPOS%  %��  � �� � ��Ca�  � �� � U  THIS REMEMBERPOSITION WRITEDOCKSTATUS readpos,     �� writepos�    �� writedockstatus�    �� UnDock�    �� Destroy$	    �� Initn	    ��	 AfterDock�	    ��1 �rQAA 2AaQ1��q A RA bA �A rA 4 qq A �Ra�q7 q �qq A �a�A 5 � A 3 � A 3 !1A � A 3 � A 2                       �         �  �
  +   ,     �  A   :   �  �  T   >   	  <  Z   B   W  �  `   I   �  ,  j    )                          ����    �  �                        -^   %   -      �      L          �  U   %�C�  � �
��D � %�� .EXEC�  � f
��@ � T�  � ��  �� � �0 |�� ShellExecute�� shell32.dll��������& |�� GetDesktopWindow�� win32api�� �� � T� �C� ��3 T�  � �C � �  � �  � �  � �  � �  �	 � �� %��  � � ��� � � B��  � �� U
  THIS MCDOCAPP MCPARAMETERS SHELLEXECUTE GETDESKTOPWINDOW	 HDCSCREEN VALUE MCOPERATION MCDEFAULTDIR MNSHOWCOMMAND�  ��  � � � � � %�C��  �
��< � T� � ���  �� � %�C�� �
��e � T� � ��� �� � %�C�� �
��� � T� � ��� �� � %�C�� �
��� � T� �	 ��� �� � %�C�� �
��� � T� �
 ��� �� � U  LCDOCAPP LCOPERATION LCPARAMETERS LCDEFAULTDIR LNSHOWCOMMAND THIS MCDOCAPP MCOPERATION MCPARAMETERS MCDEFAULTDIR MNSHOWCOMMAND execute,     �� Init�    ��1 A�A A br � 7RB � 3 q2!A 2!A 2!A 2!A 2!A 2                       V        q  L  !    )   �                       *5PROCEDURE getkeyhandle
LPARAMETERS thkeyRoot, tcSubKey

LOCAL lhKey, lnDisposition, lnResult

STORE 0 TO lhKey, lnDisposition

lnResult = RegCreateKeyEx( ;
	thkeyRoot, ;
	tcSubKey, ;
	REG_OPTION_RESERVED, ;
	REG_CLASS_DEFAULT, ;
	REG_OPTION_NON_VOLATILE, ;
	KEY_ALL_ACCESS, ;
	REG_SECURITY_DEFAULT, ;
	@lhKey, ;
	@lnDisposition )

*//  Currently lnDisposition is not used, but
*//  it will either be REG_OPENED_EXISTING_KEY
*//  or REG_CREATED_NEW_KEY

THIS.CheckResult(lnResult, 'RegCreateKeyEx()')

RETURN lhKey

ENDPROC
PROCEDURE checkresult
LPARAMETERS tnResult, tcModule

* See what happened
IF tnResult <> ERROR_SUCCESS
	IF _debug
		=MESSAGEBOX("Error "+ ;
			ALLTRIM(STR(tnResult))+ " was returned from " +  ;
			tcModule +".")
	ELSE
		THIS.nLastError = tnResult
	ENDIF
ENDIF

ENDPROC
PROCEDURE createkey
LPARAMETERS thkeyRoot, tcSubKey

LOCAL lhKey

lhKey = THIS.GetKeyHandle(thkeyRoot, tcSubKey)

* Close the key
THIS.CloseKey(m.lhKey)

ENDPROC
PROCEDURE deletekey
LPARAMETERS thkeyRoot, tcParentKey, tcKeyToDelete

LOCAL lhKey, lnResult

lhKey = THIS.GetKeyHandle(thkeyRoot, tcParentKey)

* Delete the key:
lnResult = RegDeleteKey(lhKey, tcKeyToDelete)

THIS.CheckResult(lnResult, 'RegDeleteKey()')

* Close the key:
THIS.CloseKey(lhKey)

RETURN (lnResult=ERROR_SUCCESS)

ENDPROC
PROCEDURE closekey
LPARAMETERS thkey

* We must support implicit closing of the
* current key THIS.hkeyCurrent, or a specific
* key passed in via the parameter:

LOCAL lhkey

IF pcount() = 1
	lhkey = thkey
ELSE
	lhkey = THIS.hkeyCurrent
ENDIF

* Close the key:
 
lnResult = RegCloseKey(lhkey)

THIS.CheckResult(lnResult, 'RegCloseKey()')

IF pcount() = 0
	* Clear our copy of the handle:
	THIS.hkeyCurrent = 0
ENDIF

RETURN (lnResult=ERROR_SUCCESS)

ENDPROC
PROCEDURE openkey
LPARAMETERS thkeyRoot, tcSubKey

* Opens the requested key, and stores it
* in the member variable .hkeyCurrent

LOCAL lhkey
lhkey = 0

IF THIS.hkeyCurrent <> 0
	* Close the key
	THIS.CloseKey(THIS.hkeyCurrent)
ENDIF

lhkey = THIS.GetKeyHandle(thkeyRoot, tcSubKey )

THIS.hkeyCurrent = lhkey

ENDPROC
PROCEDURE deletevalue
LPARAMETERS thkeyRoot, tcSubKey, tcValueName

LOCAL lhKey, lnResult
lnResult = 0

lhKey = THIS.GetKeyHandle(thkeyRoot, tcSubKey)

* Delete the value:
lnResult = RegDeleteValue(lhKey, tcValueName)

THIS.CheckResult(lnResult, 'RegDeleteValue()')

* Close the key:
THIS.CloseKey(lhKey)

RETURN (lnResult=ERROR_SUCCESS)

ENDPROC
PROCEDURE readvalue
LPARAMETERS tcValueName, tcDefaultValue

* Ensure that the key is currently open:
IF THIS.hkeyCurrent = 0
	RETURN ""
ENDIF

* Check for non-string default value
IF TYPE('tcDefaultValue') <> 'C'
	tcDefaultValue = ""
ENDIF

* Initialize variables:
LOCAL lcReturnValue, lnType, lnResult, lcBuffer, lnBufferSize
STORE ""            TO lcReturnValue
STORE 0             TO lnType, lnResult
STORE SPACE(256)    TO lcBuffer
STORE LEN(lcBuffer) TO lnBufferSize

* Query the value of the key:
lnResult = RegQueryValueEx( ;
	THIS.hkeyCurrent, ;
	tcValueName, ;
	REG_OPTION_RESERVED, ;
	@lnType, ;
	@lcBuffer, ;
	@lnBufferSize )

IF lnResult = ERROR_SUCCESS
	* Clean up the return value:
	lcReturnValue = STRTRAN( LEFT( lcBuffer, ;
		lnBufferSize), CHR(0), "")
ELSE
*!*		* Create the value with the default value:
*!*		THIS.WriteValue(tcValueName, tcDefaultValue)
*!*		lcReturnValue = tcDefaultValue

ENDIF
RETURN lcReturnValue
ENDPROC
PROCEDURE writevalue
LPARAMETERS tcValueName, tcValueData

LOCAL lnResult
lnResult = 0

lnResult = RegSetValueEx( ;
	THIS.hkeyCurrent, ;
	tcValueName, ;
	REG_OPTION_RESERVED, ;
	REG_SZ, ;
	tcValueData + CHR(0), ;
	LEN(tcValueData))

THIS.CheckResult(lnResult, 'RegSetValueEx()')

RETURN (lnResult=ERROR_SUCCESS)

ENDPROC
PROCEDURE getstringvalue
LPARAMETERS thkeyRoot, tcSubKey, tcValueName, tcDefaultValue

LOCAL lcReturnValue
lcReturnValue = ""

THIS.OpenKey(thkeyRoot, tcSubKey)
lcReturnValue = THIS.ReadStringValue(tcValueName, tcDefaultValue)
THIS.CloseKey()

RETURN lcReturnValue

ENDPROC
PROCEDURE getnumvalue
LPARAMETERS thkeyRoot, tcSubKey, tcValueName, tnDefaultValue

LOCAL lcReturnValue
lcReturnValue = ""

THIS.OpenKey(thkeyRoot, tcSubKey)
lnReturnValue = THIS.readNumValue(tcValueName, tnDefaultValue)
THIS.CloseKey()

RETURN lnReturnValue
ENDPROC
PROCEDURE getbooleanvalue
LPARAMETERS thkeyRoot, tcSubKey, tcValueName, tlDefaultValue

LOCAL lcReturnValue
lcReturnValue = ""

THIS.OpenKey(thkeyRoot, tcSubKey)
llReturnValue = THIS.readBooleanValue(tcValueName, tlDefaultValue)
THIS.CloseKey()

RETURN llReturnValue
ENDPROC
PROCEDURE setbooleanvalue
LPARAMETERS thkeyRoot, tcSubKey, tcValueName, tlValueData

THIS.OpenKey(thkeyRoot, tcSubKey)
THIS.WriteBooleanValue(tcValueName, tlValueData)
THIS.CloseKey()

ENDPROC
PROCEDURE setnumvalue
LPARAMETERS thkeyRoot, tcSubKey, tcValueName, tnValueData

THIS.OpenKey(thkeyRoot, tcSubKey)
THIS.WriteNumValue(tcValueName, tnValueData)
THIS.CloseKey()

ENDPROC
PROCEDURE setstringvalue
LPARAMETERS thkeyRoot, tcSubKey, tcValueName, tcValueData

THIS.OpenKey(thkeyRoot, tcSubKey)
THIS.WriteStringValue(tcValueName, tcValueData)
THIS.CloseKey()

ENDPROC
PROCEDURE readbooleanvalue
LPARAMETERS tcValueName, tlDefaultValue

IF tlDefaultValue
	lcDefaultValue = "true"
ELSE
	lcDefaultValue = "false"
ENDIF

lcRetVal = THIS.readValue(tcValueName, lcDefaultValue)

IF lcRetVal = "true"
	RETURN .T.
ELSE
	RETURN .F.
ENDIF
ENDPROC
PROCEDURE readstringvalue
LPARAMETERS tcValueName, tcDefaultValue

lcRetVal = THIS.readValue(tcValueName, tcDefaultValue)

RETURN lcRetVal
ENDPROC
PROCEDURE readnumvalue
LPARAMETERS tcValueName, tnDefaultValue

SET DECIMALS TO 8

lcDefaultValue = STR(tnDefaultValue, 10, 8)

lcRetVal = THIS.readValue(tcValueName, lcDefaultValue)

RETURN VAL(lcRetVal)

ENDPROC
PROCEDURE writebooleanvalue
LPARAMETERS tcValueName, tlValueData

IF tlValueData
	lcValueData = "true"
ELSE
	lcValueData = "false"
ENDIF

llReturnValue = THIS.writeValue(tcValueName, lcValueData)

RETURN llReturnValue
ENDPROC
PROCEDURE writenumvalue
LPARAMETERS tcValueName, tnValueData

lcValueData = STR(tnValueData, 10, 8)

llReturnValue = THIS.writeValue(tcValueName, lcValueData)

RETURN llReturnValue
ENDPROC
PROCEDURE writestringvalue
LPARAMETERS tcValueName, tcValueData

llReturnValue = THIS.writeValue(tcValueName, tcValueData)

RETURN llReturnValue
ENDPROC
PROCEDURE valexists
LPARAMETERS thkeyRoot, tcSubKey, tcValueName

THIS.OpenKey(thkeyRoot, tcSubKey)

* Initialize variables:
LOCAL lnType, lnResult, lcBuffer, lnBufferSize
STORE 0             TO lnType, lnResult
STORE SPACE(256)    TO lcBuffer
STORE LEN(lcBuffer) TO lnBufferSize

* Query the value of the key:
lnResult = RegQueryValueEx( ;
	THIS.hkeyCurrent, ;
	tcValueName, ;
	REG_OPTION_RESERVED, ;
	@lnType, ;
	@lcBuffer, ;
	@lnBufferSize )

IF lnResult = ERROR_SUCCESS
	RETURN .T.
ELSE
	RETURN .F.
ENDIF
ENDPROC
PROCEDURE release
RELEASE THIS
ENDPROC
PROCEDURE zreadme
*!*	Registry Class
*!*	Tim Hockin

*!*	This class is distributed free of charge for all uses, with absolutely
*!*	no guarantees, even fitness of purpose.  Modify it at wiil. If you 
*!*	break it, you keep both parts.  
*!*	This product comes with no guaranteed support, though I will try to 
*!*	answer reasonable questions.
*!*	If you redistribute this product, all I ask is that you 
*!*	leave my name in as "original author".
*!*	 
*!*	Files:
*!*		reg.vcx
*!*		reg.vct
*!*		registry.h
*!*		registrybuton.bmp
*!*		
*!*	Notes
*!*		* All data gets wrapped to string type before it gets 
*!*		  actually written to the registry.
*!*		* Most of this code is munged from one place or another
*!*		* I designed it according to what I needed to do
*!*		* I use it daily - my base form class uses this in its Init() 
*!*		  and Unload() methods to read/write it's position on screen.
*!*		* I will try to answer reasonable questions, directed at 
*!*		  tphocki@gw.orl.ilstu.edu, or thockin@ais.net 
*!*		* I developed this class while working at Illinois State 
*!*		  University's Office of Residential Life, a large proponent of
*!*		  Visual Fox Pro. http://www.orl.ilstu.edu
*!*		  
*!*	Directions for use
*!*		Methods in this class fall into two categories - get/set pairs 
*!*		and read/write pairs.  Each pair has three methods - boolean, num,
*!*		and string operations. The difference is that get/set pairs open a 
*!*		key, perform their function, and close the key.  read/write pairs
*!*		assume the key is open, and are used for performing multiple 
*!*		operations on a key.
*!*		
*!*		For quick and dirty operations use get/set pairs.  The main 
*!*		methods you will use are:
*!*		
*!*		getStringValue()		readStringValue()
*!*		getBooleanValue()		readBooleanValue()
*!*		getNumValue()			readNumValue()
*!*		setStringValue()		writeStringValue()
*!*		setBooleanValue()		writeBooleanValue()
*!*		setNumValue()			writeNumValue()
*!*								openKey()
*!*								closeKey()
*!*		
*!*		open/closeKey() methods store the key in the property hKeyCurrent.
*!*		The main HKEY bases used are also stored in:
*!*		hkey_classes_root		hkey_current_user
*!*		hkey_local_machine		hkey_users
*!*		
*!*		For further details, follow a wise man's advice - 
*!*			"Use the source, Luke.."
*!*			
*!*		This class has not been tested on Windows NT
*!*		
*!*		
*!*	Tim Hockin
*!*	April 1998
*!*	tphocki@gw.orl.ilstu.edu
*!*	thockin@ais.net
ENDPROC
PROCEDURE Destroy
IF THIS.hkeyCurrent <> 0
	* Close the key
	THIS.CloseKey(THIS.hkeyCurrent)
ENDIF

ENDPROC
PROCEDURE Init
* Declare all the API calls
* Define all buffers as STRING, and all methods are wrappers

DECLARE INTEGER RegCreateKeyEx IN Win32API ;
	INTEGER nhKey, ;
	STRING  @cSubKey, ;
	INTEGER nReserved, ;
	STRING  cKeyClass, ;
	INTEGER nOptions, ;
	INTEGER nSecurityAccessMask, ;
	INTEGER nSecurityAttributes, ;
	INTEGER @nKeyHandle, ;
	INTEGER @nDisposition

DECLARE INTEGER RegSetValueEx IN Win32API ;
	INTEGER nKeyHandle, ;
	STRING  cValueName, ;
	INTEGER nReserved, ;
	INTEGER nType, ;
	STRING  cBuffer, ;
	INTEGER nBufferSize

DECLARE INTEGER RegQueryValueEx IN Win32API ;
	INTEGER nhKey, ;
	STRING  cValueName, ;
	INTEGER nReserved, ;
	INTEGER @nType, ;
	STRING  @cBuffer, ;
	INTEGER @nBufferSize

DECLARE INTEGER RegCloseKey    IN Win32API ;
	INTEGER nKeyHandle

DECLARE INTEGER RegDeleteKey IN Win32API ;
	INTEGER nKeyHandle, ;
	STRING  cSubKey

DECLARE INTEGER RegDeleteValue IN Win32API ;
	INTEGER nKeyHandle, ;
	STRING  cValueName

ENDPROC
     �PROCEDURE releasevfptoolbars
* Hides all visible VFP toolbars from view prior to
* launching the application.
DIMENSION THIS.aVFPToolbars(11,2)

LOCAL lnToolbar, laVFPToolbars[ALEN(This.aVFPToolbars, 1), ALEN(This.aVFPToolbars, 2)]


laVFPToolbars[1,1]   = "Form Designer"
laVFPToolbars[2,1]   = "Standard"
laVFPToolbars[3,1]   = "Layout"
laVFPToolbars[4,1]   = "Query Designer"
laVFPToolbars[5,1]   = "View Designer"
laVFPToolbars[6,1]   = "Color Palette"
laVFPToolbars[7,1]   = "Form Controls"
laVFPToolbars[8,1]   = "Database Designer"
laVFPToolbars[9,1]   = "Report Designer"
laVFPToolbars[10,1]  = "Report Controls"
laVFPToolbars[11,1]  = "Print Preview"


* Determine if the specified toolbar was visible
* when the application object was created. Store
* visibility information in column 2 and hide
* the toolbar if visible.  It is interesting to
* note that toolbars are just windows.

FOR lnToolbar = 1 TO ALEN(laVFPToolbars, 1)
	laVFPToolbars[lnToolbar, 2] = WVISIBLE(laVFPToolbars[lnToolbar, 1])
	IF laVFPToolbars[lnToolbar, 2]
		HIDE WINDOW (laVFPToolbars[lnToolbar, 1])
	ENDIF
ENDFOR

ACOPY(laVFPToolbars, This.aVFPToolbars)

RETURN

ENDPROC
PROCEDURE restorevfptoolbars
LOCAL lnToolbar
* Loop through all VFP toolbars
FOR lnToolbar = 1 TO ALEN(This.aVFPToolbars, 1)
	* If it was visible when the application started
	IF This.aVFPToolbars[lnToolbar, 2]
		SHOW WINDOW (This.aVFPToolbars[lnToolbar, 1])
	ENDIF
ENDFOR
RETURN
ENDPROC
PROCEDURE setscreenprops
THIS.OldScreenCaption = _SCREEN.Caption
THIS.OldScreenBackColor = _SCREEN.BackColor
THIS.OldScreenPicture = _SCREEN.Picture
THIS.OldScreenVisible = _SCREEN.Visible
THIS.OldScreenIcon = _SCREEN.Icon


IF !EMPTY(THIS.ScreenIcon)
	_SCREEN.Icon = THIS.ScreenIcon
ENDIF

IF !EMPTY(THIS.ScreenCaption)
	_SCREEN.Caption = THIS.ScreenCaption
ENDIF

IF !EMPTY(THIS.ScreenBackColor)
	_SCREEN.BackColor = THIS.ScreenBackColor
ENDIF

IF !EMPTY(THIS.OldScreenPicture)
	_SCREEN.Picture = THIS.OldScreenPicture
ENDIF

_SCREEN.WindowState = 2
_SCREEN.Visible = .T.

ENDPROC
PROCEDURE restorescreenprops
IF !EMPTY(THIS.OldScreenCaption)
	_SCREEN.Caption = THIS.OldScreenCaption
ENDIF

IF !EMPTY(THIS.OldScreenBackColor)
	_SCREEN.BackColor = THIS.OldScreenBackColor
ENDIF

IF !EMPTY(THIS.OldScreenPicture)
	_SCREEN.Picture = THIS.OldScreenPicture
ENDIF

_SCREEN.Icon = THIS.OldScreenIcon
_SCREEN.Visible = THIS.OldScreenVisible

ENDPROC
PROCEDURE showmenu
IF !EMPTY(THIS.MenuFile)
	DO (THIS.MenuFile)
ENDIF
ENDPROC
PROCEDURE userlogin
IF !EMPTY(THIS.LoginForm)
	DO FORM (THIS.LoginForm) TO llLoginSuccess
	RETURN llLoginSuccess
ENDIF
ENDPROC
PROCEDURE createsecurityobject
IF !EMPTY(THIS.SecurityClass)
	PUBLIC oSecurity
	oSecurity = CREATEOBJECT(THIS.SecurityClass)
	IF !TYPE("oSecurity.Name") = "C"
		RELEASE oSecurity
		RETURN .F.
	ELSE
		RETURN .T.
	ENDIF	
ENDIF
ENDPROC
PROCEDURE createformsmanager
IF !EMPTY(THIS.FormsManagerClass)
	PUBLIC oForms
	oForms = CREATEOBJECT(THIS.FormsManagerClass)
	IF !TYPE("oForms.Name") = "C"
		RELEASE oForms
		RETURN .F.
	ELSE
		RETURN .T.
	ENDIF	
ENDIF
ENDPROC
PROCEDURE getusersetting
LPARA tcSetting

ENDPROC
PROCEDURE cleanup
LOCAL i
FOR i = _SCREEN.FormCount TO 1 STEP -1
	oForm = _SCREEN.Forms(i)
	IF TYPE("oForm.Name") = "C"
		* Toolbar
		IF UPPER(oForm.BaseClass) <> "TOOLBAR"
			IF oForm.QueryUnload()
				oForm.Release()
			ELSE
				RETURN .F.
			ENDIF
		ENDIF
	ENDIF
ENDFOR

_SCREEN.Visible = .F.

THIS.RestoreScreenProps()
THIS.RestoreVFPToolbars()
ON ERROR
SET SYSMENU TO DEFAULT
RELEASE goSecurity
RELEASE goForms

ENDPROC
PROCEDURE showinitialform
IF !EMPTY(THIS.InitialForm)
	DO FORM (THIS.InitialForm)
ENDIF

ENDPROC
PROCEDURE readevents
IF !THIS.CheckAllRequirements()
	MESSAGEBOX("The application object for " + THIS.AppName + " does not have enough information to start.", 48, THIS.AppName)
	RETURN .F.
ENDIF

DO WHILE .T.
	*-- Start the event loop
	READ EVENTS
	*- We do cleanup here, instead of in the menu code
	*- because windows cannot be released from the menu code if
	*- a grid has the focus.
	IF THIS.Cleanup()
		EXIT
	ENDIF
ENDDO

ENDPROC
PROCEDURE checkallrequirements
IF EMPTY(THIS.DataPath)
	lcDataDirectory = GETDIR("c:\","Where is the database folder for " + THIS.AppName + "?")
	IF !EMPTY(lcDataDirectory)
		THIS.DataPath = lcDataDirectory
	ELSE
		RETURN .F.
	ENDIF
ENDIF

ENDPROC
PROCEDURE Init
LPARA tlStartOnCreate

THIS.ReleaseVFPToolBars()
THIS.SetScreenProps()
THIS.ShowMenu()
THIS.CreateFormsManager()
THIS.CreateSecurityObject()
THIS.ShowInitialForm()

IF tlStartOnCreate
	THIS.ReadEvents()
ENDIF

ENDPROC
     �highlightentirerow Specifies whether to highlight entire row when user clicks on a celll
grdcurrow Stores current row of grid. Used for highlighting the back row.
highlightcolor Holds color to highlight row when user clicks on cell
originalwidth Used by set width. Set in grid init.
originalheight Stores height of grid at init. Used for resize operations.
distancetoformbottom
distancetoformright
resizewithright Set to .T. if the grid should stretch when the form is resized horizontally.
resizewithbottom Set to .T. if the grid should stretch when the form is resized vertically.
resizecolumns Set to .T. if the columns should resize proportianally when the grid is resized.
defaultheaderclass
defaultheaderclassdefinition File that holds the custom header class definition specified in THIS.DefaultHeaderClass
builder
sortedbackcolor Color to be used for header background when the grid is sorted by that column.
highlightforecolor Color to change the current rows fore color. This property is ignored if THIS.HighlightEntireRow is false.
registryname The name this grid should use for its registry setttings. Defaults to grid.name
registryapp The name of the app to store this control's registry setting under. If empty, the control attempts to get the value from the same property of the form.
remembercolumnwidths Set to .T. if the grid should save and restore its column widths to the registry
currentcolumn returns a reference to the column with the focus.
*sethighlightrow Adds characteristic of highlighting the entire row when a user clicks on a cell. 
*setwidth Reduces the grid's width to the sum of the columns' widths. takes into account scrollbars, deletemark,  and recordmark.
*reposition Usually called from form.resize, causes the grid to resize itself in proportion to form size.
^acolumnwidths[1,0] Used internally to resize columns when the grid is resized.
*copyprop Receives 2 object as parameters and copies all of the property values from the first one to the second one.
*commonheaderclick Called from the click method of each header in the grid. Receives the header object as a parameter.
*commonheaderdblclick Called from the dblclick method of each header in the grid. Receives the header object as a parameter.
*createindextags A hooked method to be used at the instance level to create any index tags to be used for sorting.
*setsorttags Replaces factory header with subclassed header and assigns that header's sort tag property
*setbackgroundcolor 
*sethighlightcolor 
*restorecolumnwidths Retreives the grid's column widths from the registry and sets the columns to that width.
*savecolumnwidths Stores the grid's columns widths to the registry so they can be restored next time.
*commonheaderrightclick 
*commoncontrolclick 
*commoncontroldblclick 
*commoncontrolrightclick 
*commoncontrolkeypress 
*installcustomheader 
^acolreadonly[1,0] Stores the initial value of each column's ReadOnly property.
*setreadonly Takes a logical parameter to set each column's readonly property to that value. If the parameter is .F., the method skips any column that was originally readonly (using THIS.aColReadOnly
*beforerowchange Called only before Row is changed
*beforecolchange Called only before Column changes.
*getactivecolumn 
*currentcolumn_access 
     PROCEDURE sendmail
LPARAMETERS lcUserName, ;			&& User (Profile) Name - not needed if client already open
			lcPassword, ;			&& User (Profile) Password
			laRecipients, ;			&& Array of recipients
			laCCRecipients, ;		&& Array of CC recipients
			laBCCRecipients, ;		&& Array of BCC recipients
			lcSubject, ;			&& Subject at top of message
			lcBodyText, ;			&& Body text of message (can be memo field name)
			laAttachmentFiles, ;		&& array of attachments
			llReceipt, ;			&& Whether receipt required
			llShowOutlook			&& If .T., will open outlook to send manually

EXTERNAL ARRAY laAttachmentFiles, laRecipients, laCCRecipients, laBCCrecipients

LOCAL lnLoop, lnErrors, lcTemp
	  
STORE 0 TO lnErrors, ;
		   THIS.nRecipCount, ;
		   THIS.nAttachCount

IF EMPTY(lcSubject)
	lnErrors=lnErrors+1
	MESSAGEBOX("No Subject Specified",0,"Error")
ENDIF
IF EMPTY(lcBodyText)
	lnErrors=lnErrors+1
	MESSAGEBOX("No Body Text Specified",0,"Error")
ENDIF
IF lnErrors>0
	RETURN lnErrors
ENDIF

* Default to empty strings
IF EMPTY(lcUserName)
	lcUserName=""
ENDIF
IF EMPTY(lcPassword)
	lcPassword=""
ENDIF

* Make space on end of body text for attachments
THIS.cBodyText=lcBodyText+CHR(13)+CHR(13)+SPACE(ALEN(laAttachmentFiles,1)+2)

THIS.cSubject=ALLTRIM(lcSubject)

* Check that all attachment files exist
IF !EMPTY(laAttachmentFiles[1])
	FOR lnLoop=1 TO ALEN(laAttachmentFiles, 1)
		IF NOT FILE(laAttachmentFiles[lnLoop])
			MESSAGEBOX("Attachment File is Missing or Invalid:";
				+CHR(13)+laAttachmentFiles[lnLoop],0,"Error")
			lnErrors=lnErrors+1
		ENDIF
	ENDFOR
ENDIF


* Abort if an error has been found
IF lnErrors>0
	RETURN lnErrors
ENDIF

* Create session and sign on
lnSessionID=THIS.CreateSession(lcUserName,lcPassword)

* Return -1 if unable to sign on
IF lnSessionID=0
	RETURN -1
ENDIF

* Create message object
THIS.oMessage=CREATEOBJECT("MSMAPI.MAPIMessages.1")
WITH THIS.oMessage
	.SessionID=lnSessionID
	.Compose()
	.MsgIndex=-1
	.MsgNoteText=THIS.cBodyText
	.MsgSubject=THIS.cSubject
	.MsgReceiptRequested=llReceipt
	.RecipDisplayName=laRecipients[1]
	* Multiple recipients
	FOR lnLoop=2 TO ALEN(laRecipients,1)
		.RecipIndex=.RecipCount
		.RecipDisplayName= laRecipients[lnLoop]
	ENDFOR

	* Copy recipients
	IF !EMPTY(laCCRecipients[1])
		FOR lnLoop=1 TO ALEN(laCCRecipients,1)
			.RecipIndex=.RecipCount
			.RecipDisplayName = laCCRecipients[lnLoop]
			.RecipType=2
		ENDFOR
	ENDIF
	* Blind copy recipients
	IF !EMPTY(laBCCRecipients[1])
		FOR lnLoop=1 TO ALEN(laBCCRecipients,1)
			.RecipIndex=.RecipCount
			.RecipDisplayName = laBCCRecipients[lnLoop]
			.RecipType=3
		ENDFOR
	ENDIF

	* Add any required attachment files
	lnAttachPos=(LEN(THIS.cBodyText)-ALEN(laAttachmentFiles,1))-1
	IF NOT EMPTY(laAttachmentFiles[1])
		.AttachmentPosition=lnAttachPos
		.AttachmentPathName=laAttachmentFiles[1]
		* Multiple attachment files
		FOR lnLoop=2 TO ALEN(laAttachmentFiles,1)
			.AttachmentIndex=.AttachmentCount
			lnAttachPos=lnAttachPos+1
			.AttachmentPosition=lnAttachPos
			.AttachmentPathName=laAttachmentFiles[lnLoop]
		ENDFOR
	ENDIF
	.Send(.T.)
ENDWITH

* Return 0 to indicate normal completion
RETURN 0

ENDPROC
PROCEDURE createsession
**************************************************
* Creates a session from UserName and Password
*
* Populates object reference and returns session id
*
**************************************************

LPARAMETERS lcUserName, lcPassword

lcOldFolder=SYS(5)+SYS(2003)
IF TYPE("THIS.oSession")='O'
	IF THIS.oSession.UserName=lcUserName ;
			AND THIS.oSession.Password=lcPassword
		RETURN THIS.oSession.SessionID
	ELSE
		THIS.oSession.SignOff()
	ENDIF
ENDIF
THIS.oSession=CREATEOBJECT("MSMAPI.MAPISession.1")
THIS.oSession.UserName=lcUserName
THIS.oSession.Password=lcPassword
THIS.oSession.SignOn()
SET DEFAULT TO (lcOldFolder)

RETURN THIS.oSession.SessionID

ENDPROC
PROCEDURE filtermessages
***********************************************
* Used internally to set the required filters *
***********************************************

LOCAL ARRAY laFromDate[1], ;
			laToDate[1], ;
			laSubject[1], ;
			laSender[1]
			
LOCAL lnFromDate, ;
	  lnToDate, ;
	  lnSubject, ;
	  lnSender, ;
	  lnLoop, ;
	  lnFilterMatch, ;
	  lnFilterCount
	  
	  
STORE 0 TO lnFromDate, ;
		   lnToDate, ;
		   lnSubject, ;
		   lnSender, ;
		   lnLoop, ;
		   lnFilterCount, ;
		   THIS.nFilteredTotal
	
* Count up how many filters to check for...	   
IF NOT EMPTY(THIS.cSenderName)
	lnFilterCount=lnFilterCount+1
ENDIF
IF NOT EMPTY(THIS.cSubject)
	lnFilterCount=lnFilterCount+1
ENDIF
IF NOT EMPTY(THIS.cMessageFromDate)
	lnFilterCount=lnFilterCount+1
ENDIF
IF NOT EMPTY(THIS.cMessageToDate)
	lnFilterCount=lnFilterCount+1
ENDIF
		   
* Loop through messages checking filters
WITH THIS.oMessage
	FOR lnLoop=1 TO .MsgCount
		.MsgIndex=lnLoop-1
		lnFilterMatch=0
		IF NOT EMPTY(THIS.cSenderName) AND (LOWER(THIS.cSenderName) $ LOWER(.MsgOrigDisplayName) ;
											OR LOWER(THIS.cSenderName) $ STRTRAN(LOWER(.MsgOrigAddress),"smtp:"))
			lnFilterMatch=lnFilterMatch+1
		ENDIF
		IF NOT EMPTY(THIS.cSubject) AND LOWER(THIS.cSubject) $ LOWER(.MsgSubject)
			lnFilterMatch=lnFilterMatch+1
		ENDIF
		IF NOT EMPTY(THIS.cMessageFromDate) AND LEFT(.MsgDateReceived,10)>=THIS.cMessageFromDate
			lnFilterMatch=lnFilterMatch+1
		ENDIF
		IF NOT EMPTY(THIS.cMessageToDate) AND LEFT(.MsgDateReceived,10)<=THIS.cMessageToDate
			lnFilterMatch=lnFilterMatch+1
		ENDIF
		* Compare filter results to required number
		IF lnFilterMatch=lnFilterCount
			THIS.nFilteredTotal=THIS.nFilteredTotal+1
			DIMENSION THIS.aMessageNumbers[THIS.nFilteredTotal]
			THIS.aMessageNumbers[THIS.nFilteredTotal]=.MsgIndex
		ENDIF
	ENDFOR
ENDWITH

RETURN THIS.nFilteredTotal

ENDPROC
PROCEDURE version
************************************************************
* Class for sending and reading email messages via MAPI client
*
* Author: Nigel B Coates
*   Date: 20.April.1999
*
* Version 1.0  (20.Apr.99)
*              - Needs fragmenting into separate modules
* Version 1.01 (22.Apr.99)
*              - Fixed bug in 'Create array of attachments', line 2
*              - Still needs fragmenting
*			   (27.Apr.99)
*			   - Added note after send command
* Version 1.02 (04.May.99)
*              - Added functionality for CC and BCC recipients
* Version 2.01 (06.July.99)
*			   - Fragmented!!! About time too!!
*			   - Split out all arrays and counts to properties
*			   - Moved create session code to it's own method
*			   - Wrote complete readmail method (and filter)
*			   - Redesigned objects - attached as properties
*			   - Added retrieval methods for reading messages
*			   - Added extra parameter on sendmail for send(x)
* Version 2.02 (17.July.99)
*              - Fixed bug in destroy (added IF statement)
* Version 2.03 (23.July.99)
*              - Made createsession check if session exists
*                More efficient if doing multiple sends
* Version 2.04 (21.Sep.99)
*              - Delete attachment files in case of hangover
*              - Default username and password to empty strings in sendmail
* Version 2.10 (23.Sep.99)
*              - Added GetMessageToArray method
*              - Default username and password to empty strings in readmail
*              - Restores default directory after creating session
************************************************************
RETURN 2.10
ENDPROC
PROCEDURE Destroy
IF TYPE("THIS.oSession")='O'
	THIS.oSession.SignOff()
ENDIF


ENDPROC
     5���    �4  �4                        y
   %   +-      3  �  ]/          �  U    ��C� printer�  � �� U  THISFORM BUILDREPORT  ��C� preview�  � �� U  THISFORM BUILDREPORT
  4�  � U  LCOUTPUT ��  � � H� �� �C� f� PREVIEW��} � T�9� �a��1 REPO FORM &tcReportName NEXT 1 NOCO &tcOutput
 T�9� �-�� �C� f� PRINTER��� �6 REPO FORM &tcReportName NEXT 1 NOCO TO &tcOutput  
 2��, R,��" There is no output for that option�� � U  TCREPORTNAME TCOUTPUT VISIBLEC  G � G(������2�� G � G� G� G_ � G�(�� �� G2� U  �  ��  � �� � �' %�C� THISFORM.aDEList[1]b� C��= � B� � %�C����\ � T�  �a�� � ��C� � ���� T� �a�� �� ���(�C� � ����� �$ %�CC � �� �  �  � � 
��� � T� �-�� � ��	 B�� �� U  TLFORCE
 LLALLSAVED I THISFORM ADELIST THIS UPDATETABLE�  ��  � � �� � %�C� tlforceb� U��8 � T� �a�� �  %�C�	 Buffering�  ����� � T� �Ca� �  ��� %�� ��� � B�a�� �� � ��C �  � � �� B�-�� � � U  TCALIAS TLFORCE	 LLSUCCESS THISFORM HANDLECONFLICTS�  ��  �' %�C� � �� � CC�� � �
	��� � ��  ���(�C� � ����� �+ %�C�	 BufferingC �  �� � ����� � ��CaC �  �� � ��� � �� � U  I THISFORM ADELIST� + �	 GetIssuer(� ��� Choose an issuer��F %�C� issuernumberb� N�# C� issuernumberb� N� � � 	��x � B�-�� �� �	 B�� �� � U 	 GETISSUER ISSUERNUMBER�  ��  � ��C�� �z��� ��C� Changes to table "C�  ��9 " could not be saved. The following reason was returned: C� C� C�� C� C� �' Any changes you have made will be lost.�0� Update Error�x�� ��Ca�  ��� U  TCALIAS
 ERRORARRAY}' %�C� THIS.Registry1.Nameb� C��. � B�-�� � T�  �� � � Forms\�� %�C� � �
��v�5 T� �C� � � �  C� � �� Top� �	 � � � ��6 T� �C� � � �  C� � �� Left� �
 � � � ��8 T� �C� � � �  C� � �� Height� � � � � ��7 T� �C� � � �  C� � �� Width� � � � � ��= T� �C� � � �  C� � �� WindowState� � � � � �� � U  LCREGISTRYLOCATION THISFORM REGISTRYAPP THIS REGISTRYNAME	 LLSUCCESS	 REGISTRY1 SETNUMVALUE HKEY_CURRENT_USER TOP LEFT HEIGHT WIDTH WINDOWSTATE ��  � � � � �� � � � � � T� ��	 �
 � Forms\��' %�C� THIS.Registry1.Nameb� C��� � G~(� macbase.vcx�$ ��C�	 Registry1� Registry� � �� � %�� � ���3 T� �C� � � � C� � �� Top���� � � ��4 T� �C� � � � C� � �� Left���� � � ��; T� �C� � � � C� � �� WindowState���� � � ��% %�C� lnTopb� N�	 � ���	���� T� � �� �� �& %�C� lnLeftb� N�	 � ���	���� T� � �� �� �- %�C� lnWindowStateb� N�	 � ���	��
� T� � �� �� � � %�� � ���6 T� �C� � � � C� � �� Height���� � � ��5 T� �C� � � � C� � �� Width���� � � ��( %�C� lnHeightb� N�	 � ���	���� T� � �� �� �' %�C� lnWidthb� N�	 � ���	�� � T� � �� �� � � U  LCCOMPANYNAME LCAPPLICATIONNAME	 LCVERSION LCREGISTRYLOCATION LNTOP LNLEFT LNWINDOWSTATE LNHEIGHT LNWIDTH THISFORM REGISTRYAPP MACBASE VCX THIS	 ADDOBJECT REMEMBERPOSITION	 REGISTRY1 GETNUMVALUE HKEY_CURRENT_USER REGISTRYNAME TOP LEFT WINDOWSTATE REMEMBERSIZE HEIGHT WIDTH$  %��  � �� � ��C�  � �� � U  THISFORM AUTOEDIT EDIT3 ��  � � � �� � � � � � � %�C� tcMethodb� C��M � B�-�� �b � T� ��  �� �$ %�C� toContainer.Nameb� C��� � T� ��	 �� �� � T� �� �� � T� �C� EXACTv�� G �K %�CC� �
 @� form�	 container�	 pageframe� page� grid� column�
��� B�-�� � H�-��7 �CC� �
 @� form�	 container� page� column���� �� � � �� %�C� � ��h���� ��C�
 loControl.� � ()��� �J %�CC� �
 @� form�	 container�	 pageframe� page� grid� column���� ��C �  � �	 � �� � �� �C� �
 @�	 pageframe���� �� � � ��� %�C� � ��h��y� ��C� loPage.� � ()��� � ��C �  � �	 � �� �� �C� �
 @� grid��� �� � � �� %�C� � ��h���� ��C�	 loColumn.� � ()��� � ��C �  � �	 � �� �� � SET EXACT &lcSetExact
 U  TCMETHOD TOCONTAINER TCCLASS LCMETHOD LOCONTAINER	 LOCONTROL LOPAGE LOCOLUMN
 LCSETEXACT THIS	 BASECLASS CONTROLS RUNALL PAGES COLUMNS� ��  � �7 %�C� THISFORM.ActiveControlb� O�
 C� � �
	��w �! %�C� � � SetFocus��h��s � ��C� � � �� � �' %�C� THISFORM.aDEList[1]b� C��� � B�a�� � ��  ���(�C� � ������ T� �C �  �� � �� H�� ���  �C�	 Buffering� ����� .�: �C�	 Buffering� ��� C�	 Buffering� ������' %�C���� �C� 1CC���� �>Q��}� B�-�� �: �C�	 Buffering� ��� C�	 Buffering� ������ %�C� � �� ���� B�-�� � � �� U  I LCALIAS THISFORM ACTIVECONTROL SETFOCUS ADELISTP ��  ���� �� � � � ��C��  � � ��b�� %�CC��  ���J � B� � T� �� �� %�C��  ��� ��I� �� ���(�C��  ����E�1 T� �C� ThisForm.DataEnvironment.C � �  ��� %�C� � @� cursor��A� T� �� ��� � � �� ����� T� � �� ������ � �� T� � �� ������ �	 �� � �� � U
  LALIST LNCURSORCOUNT LOOBJ I THISFORM DATAENVIRONMENT	 BASECLASS ADELIST ALIAS NAME� ��  � �� � � � �! %�C� tcNewDataPathb� C��B � B�-�� �W � T� ��  �� � �� ���� ��C�� � � ��b�� %�CC�� ���� � B� � %�C�� ��� ���� �� ���(�C�� ������1 T� �C� ThisForm.DataEnvironment.C � � ���+ %�C� �	 @� cursor� � \� �
 	���� %�C� �
 �
���� T� �C� �
 C� \� �
 �\�� T� �
 ��  � �� %�C� �
 �
���� ���� �
 �� � G(�� �
 �� ��� T� �C� � C� \� � �\�� T� � ��  � �� � � �� � U  TCNEWDATAPATH LNCNT LOOBJ LCDBC LCNEWDATAPATH LALIST THISFORM DATAENVIRONMENT I	 BASECLASS DATABASE CURSORSOUCE� ��  � �� � � �2 T� �CC� toContainer.Nameb� C� �  � � 6�� �� � � ��� H�g �~� �C� � @�	 pageframe��� � �� � � �� � ��C � � � �� ��# �C� � ControlSource��h����. %�C� � AlwaysReadOnly��h� � �	 	��� � ��� H����= �CC� � @� textbox� checkbox� spinner� editbox���^� T� �
 �-��) �CC� � @� listbox� combobox����� T� � �a�� � � �C� � @� grdchild���� ��C-� � ��L �C� � @� commandbutton� C� � EditModeEnabled��h	� � � 	��#� T� � �a��M �C� � @� commandbutton� C� � EditModeDisabled��h	� � � 	��~� T� � �-�� � �� U  TOCONTAINER LOCONTAINER OCONTROL OPAGE THIS CONTROLS	 BASECLASS PAGES ENABLEALLCONTROLS ALWAYSREADONLY READONLY ENABLED CLASS SETREADONLY EDITMODEENABLED EDITMODEDISABLED� ��  � �� � � �2 T� �CC� toContainer.Nameb� C� �  � � 6�� �� � � ��� H�g �~� �C� � @�	 pageframe��� � �� � � �� � ��C � � � �� ��# �C� � ControlSource��h����. %�C� � AlwaysEditable��h� � �	 	��� � ��� H����= �CC� � @� textbox� checkbox� spinner� editbox���^� T� �
 �a��) �CC� � @� listbox� combobox����� T� � �-�� � � �C� � @� grdchild���� ��Ca� � ��L �C� � @� commandbutton� C� � EditModeEnabled��h	� � � 	��#� T� � �-��M �C� � @� commandbutton� C� � EditModeDisabled��h	� � � 	��~� T� � �a�� � �� U  TOCONTAINER LOCONTAINER OPAGE OCONTROL THIS CONTROLS	 BASECLASS PAGES DISABLEALLCONTROLS ALWAYSEDITABLE READONLY ENABLED CLASS SETREADONLY EDITMODEENABLED EDITMODEDISABLED ��  � �� � �( %�C� toContainerb� O� C�  ���G � T�  �� �� � T� ��  � �� �� �  � �� %�C� � f�	 PAGEFRAME��� � ��CC�� �	 � � �� � %�C� � Tabindex��h���, %�� �
 � � C� � SetFocus��h	��� � T� �� �� � � �� ��C� � �� U  TOCONTAINER OCONTROL OFIRSTCONTROL THIS LNLOWESTTABORDER CONTROLCOUNT CONTROLS	 BASECLASS FIRSTFIELDSETFOCUS PAGES TABINDEX SETFOCUS_ ��  � �� � � �2 T� �CC� toContainer.Nameb� C� �  � � 6�� �� � � �X�8 %�C� � @�	 pageframe� C� � @�	 container��� � �� � � �� � ��C � � � �� �� �T�# %�C� � ControlSource��h��P�# %�C� � RequiredField��h�� � %�� �	 �	 C� �
 �	����/ %�C� � FriendlyName��h�
 C� � �
	����8 T� �� You must enter a � � �  before saving.�� ���= T� ��0 One or more required fields has not been entered�� � ��C� �0� � �x�� ��C� � �� B�-�� � � %�C� � Validate��h��L� %�C� � 
��H� ��C� � �� B�-�� � � � � �� U  TOCONTAINER LOCONTAINER OCONTROL OPAGE THIS CONTROLS	 BASECLASS PAGES VALIDATEALLCONTROLS REQUIREDFIELD VALUE FRIENDLYNAME	 LCMESSAGE THISFORM CAPTION SETFOCUS VALIDATE�  T�  �C�	�%�� T� �� �� T� �� �� �� �9� �� �> %�� � � � � � � 	� � � � 	� � � � 	��� � T� �� � �� T� �� �	 �� � �� %�� � ��� � T� �
 �-�� T� � �� �  �� T� �	 �� �  �� � U  LNTITLEBARHEIGHT LNHIGHESTTOP LNFURTHESTRIGHT OFORM FORMS NAME THIS WINDOWSTATE TOP LEFT
 AUTOCENTER� ( G~(�� k:\tools\obj2bmp\obj2bmp.vcx�� T�  �CC� � � � �� T� �C� BMPMaker�N�� T� �C��]� .bmp�� T� � �� �� ��C �  �� � ��0 |�� ShellExecute�� Shell32.dll��������" ��C� � Print � �  �  � �	 �� U
  LNHWND	 _WHTOHWND
 _WFINDTITL THISFORM CAPTION OBMP
 LCFILENAME	 CFILENAME
 MAKEBITMAP SHELLEXECUTE8  %��  � ��1 � %�C�  � 
��- � �� B�-�� � � U  THISFORM CONFIRMRELEASEONCLOSE CONFIRMRELEASE� %�C�  � ���$ � T�  � ��9� �� � %�� � -��X � T� � ���� T�  � �-�� �� �  %�C�  �	 MinHeight� �h
��� � T�  � ��  � �� � %�C�  � MinWidth� �h
��� � T�  � ��  �	 �� � � %�C�
 goApp.nameb� C��R� T�  �
 �� �
 �� T�  � �� � ��% %�C� goApp.oForms.Nameb� C��N� ��C �  � � � �� � � %�C�  � ���{� T�  � ��  � �� � %�� � ���� T�  � �-�� ��C� � �� ��� ��C� � �� � ��C� � �� ��C� � �� %�C�  � ���� T�  � �� h:\�� � %�C�
 pcdatapathb� U��4� T�  � �� �� �e� %�C�  � ���a� T�  � �� h:\�� � �" %�C�  � @� k:\data\dbf\���� T� � ����� � %�� � � -���� ��C�  � � � �� T� �-�� T� �C� Error��� 1� llCantOpentables = .T.� ��C� � � �� ON ERROR &lcOldOnError
 %�� ����� ��C�
 The form '� � �0 ' can't open one of the tables it needs. (Code: CCC,Z�� ) Click Ok and try again.C� C� C� �	 Message: CE�0� TMR�x�� B�-�� � � U   THIS ICON THISFORM STRETCHABLE BORDERSTYLE	 MAXBUTTON	 MINHEIGHT HEIGHT MINWIDTH WIDTH REGISTRYAPP GOAPP DATAPATH OFORMS REGISTERFORM REGISTRYNAME NAME REMEMBERPOSITION
 AUTOCENTER READPOS	 ADJUSTTOP SETENVIRONMENT BUILDDELIST
 PCDATAPATH	 BACKCOLOR DATAENVIRONMENT AUTOOPENTABLES CHANGEDATAPATH LLCANTOPENTABLES LCOLDONERROR
 OPENTABLES CAPTION T�  � �a�� �� � � �� � � �� �  %�C� �
 Reposition��h��� �* %�C� �
 Reposition��h� Method��� � ��C� � �� � � %�C� � Resize��h��� � T� �C� � Resize��h��' %�� � Method� � � Event��� � ��C� � �� � � �� T�  � �-�� U  THISFORM
 LOCKSCREEN OCONTROL
 LCPROPTYPE THIS CONTROLS
 REPOSITION RESIZEa  %��  � �� � ��C�  � �� �% %�C� goApp.oForms.Nameb� C��Z � ��C � � � � �� � U  THISFORM REMEMBERPOSITION WRITEPOS GOAPP OFORMS
 UNREGISTER THIS printit,     �� previewa     �� buildreport�     ��
 sendreport�     �� setenvironment�    �� saveall"    �� updatetableC    ��	 revertall.    �� getissuerid�    �� handleconflicts�    �� writepos�    �� readpos�    �� dbfieldchange�    �� runall'    �� isbufferclean�    �� builddelist    �� changedatapath�    �� enableallcontrols6    �� disableallcontrols}    �� firstfieldsetfocus�    �� validateallcontrolss    ��	 adjusttop�"    ��	 printform�#    �� QueryUnloadF%    �� Load�%    �� Resize+    �� Destroy,    ��1 q2 q2 q 2 � � �� � �a� �B 2 b a a a a � a 3 q � rA A � A "� �A� A A � 2 � r �� A A� q � q A A 3 q s���A A A 3 �aq � � A 3 q � �� 3 qq A �3Qa�q�A 3 1q�rQAA 1A�QA aA �A A aQ�A qA A 5 � A 4 � ��q � � A D� � � A Ca �q A � q!b�A �QA A �"a�A QA �"a�A QA A �3 � tA A rq A ��� A �rq A �qq A A A 4 � � r2B A � r��a��A A A 4 q 3q � � A � s1B A r��1�AA� A � � �AA A A A 3 q � ""� �!A 1�� � �� �� A A �� �� �� A A 3 q � ""� �!A 1�� � �� �� A A �� �� �� B A 3 q � �� A "�qA ��� A A A � 3 q � ""�!A � 11���� �A Q� q A A �"� q A A A A A 3 � � �A A � AAA 3 ����A"4 !A q A A 3 !!A "� � 1A �1A A �11RAA A "1A � � � � A � � "1A �� !1A A "A R1� Q��� 
q A A 3 � � "�� A A ��q� A A A � 3 � A RAA 2                       2         P   o         �   �         �   <  
      a          5  �  )   -   �  2	  I   <   R	  0  ]   E   R    j   L   9  �  s   Q     �  �   ]   �  f  �   }   �  �  �   �   �  �  �   �   �  ]$    �   $  �&  %  �   �&  �*  @  �   �*  /  k    B/  �3  �  0  �3  �5  �  B  6  �;  �  b  �;  f=  �  q  �=  ?    z  .?  �?    �  �?  (G    �  EG  I  n  �  !I  �I  �   )   �4                       I�PROCEDURE printit
THISFORM.BuildReport('printer')
ENDPROC
PROCEDURE preview
THISFORM.BuildReport('preview')
ENDPROC
PROCEDURE buildreport
PARA lcOutput
ENDPROC
PROCEDURE sendreport
LPARAMETERS tcReportName, tcOutput


DO CASE 
  CASE UPPER(tcOutput) = "PREVIEW"
    
    _SCREEN.Visible = .T.
    REPO FORM &tcReportName NEXT 1 NOCO &tcOutput
    _SCREEN.Visible = .F.
    
  CASE UPPER(tcOutput) = "PRINTER"
    REPO FORM &tcReportName NEXT 1 NOCO TO &tcOutput  
    
  OTHERWISE
    WAIT WIND "There is no output for that option"
    
ENDCASE  
ENDPROC
PROCEDURE setenvironment
*SET LIBRARY TO "FoxTools.fll"
SET DELETE ON
SET CENTURY TO 19 ROLLOVER 50
SET CENTURY ON
SET EXACT OFF
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET STRICTDATE TO 0
SET TALK OFF

ENDPROC
PROCEDURE saveall
LPARAMETERS tlForce
* tlForce is an optional parameter that lets the developer decide if updates should be forced. If it is not passed, updates
* are forced by default

LOCAL llAllSaved, i

IF TYPE('THISFORM.aDEList[1]') <> "C" && There are no cursors loaded in the list
	RETURN
ENDIF

IF PARAMETERS() < 1
	tlForce = .T.
ENDIF

ASORT(THISFORM.aDElist,2)   && Sort by the second column; holds the 'name' property of the cursor

&& This sorting allows the programmer to order the cursors by the .name property for DEs
&& in which the order of Tableupdates is important. For example: If a DE contains both a table and a view that
&& is derived from that table, you would want to update the view first, and then update the table,
&& since the view update 'dirties' the table's buffer. You can do this by naming the view cursor "c1" and the table
&& cursor "c2" or anything else as long as they are in the right order alphabetically
llAllSaved = .T.
FOR i = 1 TO ALEN(THISFORM.aDElist, 1) && Number of Cursors in the array
	IF !THIS.UpdateTable(THISFORM.aDElist[i,1], tlForce)
		llAllSaved = .F.
	ENDIF
ENDFOR


RETURN llAllSaved
ENDPROC
PROCEDURE updatetable
LPARAMETER tcalias, tlforce

LOCAL llSuccess

IF TYPE('tlforce') = "U"
	tlForce = .T.
ENDIF

IF CURSORGETPROP("Buffering", tcAlias) > 1 && Does the table or view have buffering enabled?
	llSuccess = TABLEUPDATE(.T.,tlForce, tcAlias)
	IF llSuccess
		RETURN .T.	
	ELSE
		THISFORM.HandleConflicts(tcAlias)
		RETURN .F.
	ENDIF
ENDIF

ENDPROC
PROCEDURE revertall
LOCAL i
* tlAllrows denotes whether all rows should be reverted or just the current one. All rows is the default.

IF ALEN(thisform.aDEList) > 0 AND !EMPTY(thisform.aDEList[1]) && make sure there are cursors in the array
	FOR i = 1 TO ALEN(thisform.aDEList, 1) && Number of Cursors in the array
		IF CURSORGETPROP("Buffering", thisform.aDEList[i,1]) >1 && Does the table or view have buffering enabled?
			TABLEREVERT(.T., THISFORM.aDEList[i,1])
		ENDIF
	ENDFOR
ENDIF

ENDPROC
PROCEDURE getissuerid
DO FORM GetIssuer TO issuernumber WITH "Choose an issuer"
IF  TYPE('issuernumber') <> "N" or (type('issuernumber') = "N" and issuernumber = 0)
	RETURN .F.
ELSE
	RETURN issuernumber
ENDIF

ENDPROC
PROCEDURE handleconflicts
LPARAMETERS tcalias

* This method is called by THIS.UpdateTable() when a tableupdate fails. It gives the user a message and then reverts the changes.

AERROR(errorarray)

MESSAGEBOX('Changes to table "' + ALLTRIM(tcalias) + '" could not be saved. The following reason was returned: '+ CHR(13) +;
	CHR(13) + (errorarray[2]) + CHR(13) + CHR(13) + "Any changes you have made will be lost.", 48,"Update Error")

TABLEREVERT(.T., tcalias)

ENDPROC
PROCEDURE writepos
IF TYPE('THIS.Registry1.Name') <> "C"
	RETURN .F.
ENDIF

lcRegistryLocation = THISFORM.RegistryApp + "Forms\"


IF !EMPTY(THIS.RegistryName)
	llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Top", THIS.Top)
	llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Left", THIS.Left)
	llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Height", THIS.Height)
	llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Width", THIS.Width)
	llSuccess = THIS.Registry1.SetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "WindowState", THIS.WindowState)
ENDIF

ENDPROC
PROCEDURE readpos
LOCAL lcCompanyName, lcApplicationName, lcVersion, lcRegistryLocation
LOCAL lnTop, lnLeft, lnWindowState, lnHeight, lnWidth


lcRegistryLocation = THISFORM.RegistryApp + "Forms\"

IF TYPE('THIS.Registry1.Name') <> "C"
	SET CLASSLIB TO macbase.vcx ADDI
	THIS.AddObject('Registry1','Registry')
ENDIF

IF THIS.RememberPosition
	lnTop = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation+ ALLTRIM(THIS.RegistryName), "Top", -1)
	lnLeft = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Left", -1)
	lnWindowState = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "WindowState", -1)
	IF TYPE('lnTop') = "N" and lnTop <> -1
		THIS.Top = lnTop
	ENDIF
	IF TYPE('lnLeft') = "N" and lnLeft <> -1
		THIS.Left = lnLeft
	ENDIF	
	IF TYPE('lnWindowState') = "N" and lnWindowState <> -1	
		THIS.WindowState = lnWindowState
	ENDIF	
ENDIF

IF THIS.RememberSize
	lnHeight = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Height", -1)
	lnWidth = THIS.Registry1.GetNumValue(THIS.Registry1.hkey_current_user, lcRegistryLocation + ALLTRIM(THIS.RegistryName), "Width", -1)
	IF TYPE('lnHeight') = "N" and lnHeight <> -1	
		THIS.Height = lnHeight
	ENDIF
	IF TYPE('lnWidth') = "N" and lnWidth <> -1
		THIS.Width = lnWidth
	ENDIF	
ENDIF



ENDPROC
PROCEDURE dbfieldchange
IF THISFORM.AutoEdit
	THISFORM.Edit()
ENDIF


ENDPROC
PROCEDURE runall
lPara tcMethod, toContainer, tcClass

LOCAL lcMethod, loContainer, loControl, loPage, loColumn, lcSetExact

IF TYPE('tcMethod') <> "C"
	RETURN .F.
ELSE
	lcMethod = tcMethod
ENDIF

* If no container object was passed in, assume that
* we are running all methods in THIS
IF TYPE("toContainer.Name") <> "C"
	loContainer = THIS
ELSE
	loContainer = toContainer
ENDIF

* set exact on to make sure pages weren't mistaken for pageframes and vice-versa
lcSetExact = SET('EXACT')
SET EXACT ON

* this method only works for container-type classes
IF !INLIST(LOWER(loContainer.BaseClass), "form","container","pageframe","page","grid","column")
	RETURN .F.
ENDIF

DO CASE
	CASE INLIST(LOWER(loContainer.BaseClass),"form","container","page","column")
		FOR EACH loControl IN loContainer.Controls
			* Does the control have the method passed in?
			IF PEMSTATUS(loControl, lcMethod, 5)
				=EVAL("loControl." + lcMethod + "()")
			ENDIF
			* if the control is a container itself, recurse back into this method to drill down into its controls
			IF INLIST(LOWER(loControl.BaseClass), "form","container","pageframe","page","grid","column")
				THIS.RunAll(lcMethod, loControl)
			ENDIF
		ENDFOR

	* I am really doing the same thing for all three of these container types,
	* but the controls collection is called something different in each of them,
	* so I had to separate them out,
	CASE LOWER(loContainer.BaseClass) = "pageframe"
		* For pageframes, iterate through the pages collection
		FOR EACH loPage IN loContainer.Pages
			IF PEMSTATUS(loPage, lcMethod, 5)
				=EVAL("loPage." + lcMethod + "()")
			ENDIF
			THIS.RunAll(lcMethod, loPage)
		ENDFOR
		
	CASE LOWER(loContainer.BaseClass) = "grid"
		* For grids, iterate through the columns collection
		FOR EACH loColumn IN loContainer.Columns
			IF PEMSTATUS(loColumn, lcMethod, 5)
				=EVAL("loColumn." + lcMethod + "()")
			ENDIF
			THIS.RunAll(lcMethod, loColumn)
		ENDFOR
ENDCASE

SET EXACT &lcSetExact

ENDPROC
PROCEDURE isbufferclean
LOCAL i, lcAlias

* Set focus to the active control in the form. Setting focus causes the control to 
* temporarily lose focus, which forces its value to be written to its controlsource
IF TYPE("THISFORM.ActiveControl") = "O" AND !ISNULL(THISFORM.ActiveControl)
	IF PEMSTATUS(THISFORM.ActiveControl, "SetFocus", 5)
		THISFORM.ActiveControl.Setfocus()
	ENDIF
ENDIF

IF TYPE('THISFORM.aDEList[1]') <> "C" && There are no cursors loaded in the list
	RETURN .T.
ENDIF

FOR i = 1 TO ALEN(THISFORM.aDElist, 1) && Number of Cursors in the array
	lcAlias = THISFORM.aDElist[i,1]
	DO CASE
		CASE CURSORGETPROP("Buffering", lcAlias) = 1
			LOOP
		CASE CURSORGETPROP("Buffering", lcAlias) = 2 OR CURSORGETPROP("Buffering", lcAlias) = 3 && Row Buffering
			* If the GetFldState string is not all 1s or all 3s, one or more fields has been changed.
			IF GETFLDSTATE(-1, lcAlias) <> REPLICATE("1", LEN(GETFLDSTATE(-1, lcAlias)))
				RETURN .F.
			ENDIF
		CASE CURSORGETPROP("Buffering", lcAlias) = 4 OR CURSORGETPROP("Buffering", lcAlias) = 5 && table buffering
			IF GETNEXTMODIFIED(0, lcAlias) <> 0
				RETURN .F.
			ENDIF
	ENDCASE
ENDFOR


ENDPROC
PROCEDURE builddelist
LOCAL ARRAY laList[1]
LOCAL lnCursorCount, loObj, i

=AMEMBERS(laList, THISFORM.DATAENVIRONMENT, 2)

IF EMPTY(laList[1])
*** Nothing in DE
	RETURN
ENDIF

lnCursorCount = 0

IF ALEN( laList,1 ) > 0
	FOR i = 1 TO ALEN(laList,1 )
		loObj =  EVAL("ThisForm.DataEnvironment."+laList[i])
		IF LOWER(loObj.BaseClass) = "cursor"
			lnCursorCount = lnCursorCount + 1
			DIMENSION THISFORM.aDEList[lnCursorCount, 2]
			THISFORM.aDEList[lnCursorCount,1] = loObj.ALIAS
			THISFORM.aDEList[lnCursorCount, 2] = loObj.NAME
		ENDIF
	ENDFOR
ENDIF


ENDPROC
PROCEDURE changedatapath
LPARA tcNewDataPath


LOCAL lnCnt, loObj, lcDBC, lcNewDataPath

IF TYPE("tcNewDataPath") <> "C"
	RETURN .F.
ELSE
	lcNewDataPath = tcNewDataPath
ENDIF

LOCAL ARRAY laList[1]

*** Get Object Members of DE
=AMEMBERS(laList, THISFORM.DATAENVIRONMENT, 2)
IF EMPTY(laList[1])
	*** Nothing in DE
	RETURN
ENDIF

IF ALEN( laList,1 ) > 0
	FOR i = 1 TO ALEN(laList,1 )
		loObj =  EVAL("ThisForm.DataEnvironment."+laList[i])
		IF LOWER(loObj.BASECLASS ) = 'cursor' AND "\"$loObj.DATABASE
			IF !EMPTY(loObj.DATABASE)
				*** Contained Table
				lcDBC = SUBSTR(loObj.DATABASE, RAT('\', loObj.DATABASE))
				loObj.DATABASE = tcNewDataPath + lcDBC
				IF !DBUSED(loObj.Database)
					OPEN DATABASE (loObj.Database)
				ENDIF
				SET DATABASE TO (loObj.Database)
			ELSE
				*** Free Table
				lcDBC = SUBSTR( loObj.CursorSouce, RAT('\',loObj.CursorSouce))
				loObj.CursorSouce = tcNewDataPath + lcDBC
			ENDIF
		ENDIF
	NEXT
ENDIF

ENDPROC
PROCEDURE enableallcontrols
LPARA toContainer
LOCAL loContainer, oControl, oPage

loContainer = IIF(TYPE("toContainer.Name") = "C", toContainer, THIS)

FOR EACH oControl IN loContainer.Controls
	DO CASE
		CASE LOWER(oControl.BaseClass) = "pageframe"
			FOR EACH oPage IN oControl.Pages
				THIS.EnableAllControls(oPage)
			ENDFOR
		CASE PEMSTATUS(oControl, "ControlSource", 5) && is the control databound?
			IF PEMSTATUS(oControl, "AlwaysReadOnly", 5) AND oControl.AlwaysReadOnly
			ELSE
				DO CASE 
					CASE INLIST(LOWER(oControl.Baseclass),"textbox","checkbox","spinner","editbox")
						oControl.ReadOnly = .F.
					CASE INLIST(LOWER(oControl.Baseclass),"listbox","combobox")
						oControl.Enabled = .T.
				ENDCASE
			ENDIF
		CASE LOWER(oControl.Class) = "grdchild"
			oControl.SetReadOnly(.F.)
		CASE LOWER(oControl.BaseClass) = "commandbutton" AND PEMSTATUS(oControl, "EditModeEnabled", 5) AND oControl.EditModeEnabled
			oControl.Enabled = .T.
		CASE LOWER(oControl.BaseClass) = "commandbutton" AND PEMSTATUS(oControl, "EditModeDisabled", 5) AND oControl.EditModeDisabled
			oControl.Enabled = .F.
	ENDCASE
ENDFOR

ENDPROC
PROCEDURE disableallcontrols
LPARA toContainer

LOCAL loContainer, oPage, oControl

loContainer = IIF(TYPE("toContainer.Name") = "C", toContainer, THIS)

FOR EACH oControl IN loContainer.Controls

	DO CASE 
		CASE LOWER(oControl.BaseClass) = "pageframe"
			FOR EACH oPage IN oControl.Pages
				THIS.DisableAllControls(oPage)
			ENDFOR
		CASE PEMSTATUS(oControl, "ControlSource", 5) && is the control databound?
			IF PEMSTATUS(oControl, "AlwaysEditable", 5) AND oControl.AlwaysEditable
			ELSE
				DO CASE 
					CASE INLIST(LOWER(oControl.Baseclass),"textbox","checkbox","spinner","editbox")
						oControl.ReadOnly = .T.
					CASE INLIST(LOWER(oControl.Baseclass),"listbox","combobox")
						oControl.Enabled = .F.
				ENDCASE
			ENDIF
		CASE LOWER(oControl.Class) = "grdchild"
			oControl.SetReadOnly(.T.)
		CASE LOWER(oControl.BaseClass) = "commandbutton" AND PEMSTATUS(oControl, "EditModeEnabled", 5) AND oControl.EditModeEnabled
			oControl.Enabled = .F.
		CASE LOWER(oControl.BaseClass) = "commandbutton" AND PEMSTATUS(oControl, "EditModeDisabled", 5) AND oControl.EditModeDisabled
			oControl.Enabled = .T.
		
	ENDCASE
ENDFOR

ENDPROC
PROCEDURE firstfieldsetfocus
LPARA toContainer

LOCAL oControl, oFirstControl

IF TYPE("toContainer") <> "O" OR ISNULL(toContainer)
	toContainer = THIS
ENDIF

lnLowestTabOrder = toContainer.ControlCount

FOR EACH oControl IN toContainer.Controls
	IF UPPER(oControl.BaseClass) = "PAGEFRAME"
		THIS.FirstFieldSetFocus(oControl.Pages(1))
	ENDIF
	IF PEMSTATUS(oControl, "Tabindex", 5)
		IF oControl.TabIndex < lnLowestTabOrder AND PEMSTATUS(oControl, "SetFocus", 5)
			oFirstControl = oControl
		ENDIF
	ENDIF
ENDFOR

oFirstControl.Setfocus()

ENDPROC
PROCEDURE validateallcontrols
LPARA toContainer
* this method drills down into all the form controls and 
* checks to make sure required fields are filled in and
* all the validate methods pass.
LOCAL loContainer, oControl, oPage

loContainer = IIF(TYPE("toContainer.Name") = "C", toContainer, THIS)

FOR EACH oControl IN loContainer.Controls
	IF LOWER(oControl.BaseClass) = "pageframe" OR LOWER(oControl.BaseClass) = "container" 
		FOR EACH oPage IN oControl.Pages
			THIS.ValidateAllControls(oPage)
		ENDFOR
	ELSE
		IF PEMSTATUS(oControl, "ControlSource", 5) && is the control databound?
			IF PEMSTATUS(oControl, "RequiredField", 5) 
				* If the field is required, but the value is empty, return .F.
				IF oControl.RequiredField AND EMPTY(oControl.Value)
					IF PEMSTATUS(oControl, "FriendlyName", 5) AND !EMPTY(oControl.FriendlyName)
						lcMessage = "You must enter a " + oControl.FriendlyName + " before saving."
					ELSE
						lcMessage = "One or more required fields has not been entered"
					ENDIF
					MESSAGEBOX(lcMessage, 48, THISFORM.Caption)
					oControl.SetFocus()
					RETURN .F.
				ENDIF
			ENDIF
			* Then, run the control's validate method to make sure it says it's value is ok
			IF PEMSTATUS(oControl, "Validate", 5) 
				* If it fails, this method fails.
				IF !oControl.Validate()
					oControl.SetFocus()
					RETURN .F.
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDFOR

ENDPROC
PROCEDURE adjusttop
lnTitleBarHeight = SYSMETRIC(9)

lnHighestTop = 0
lnFurthestRight = 0

FOR EACH oForm IN _SCREEN.Forms
	IF oForm.Name = THIS.Name AND oForm <> THIS AND oForm.WindowState = 0 AND oForm.Top > lnHighestTop
		lnHighestTop = oForm.Top
		lnFurthestRight = oForm.Left
	ENDIF
ENDFOR

IF lnHighestTop > 0
	THIS.Autocenter = .F.
	THIS.Top = lnHighestTop + lnTitleBarHeight
	THIS.Left = lnFurthestRight + lnTitleBarHeight
ENDIF

ENDPROC
PROCEDURE printform
SET CLASSLIB TO "k:\tools\obj2bmp\obj2bmp.vcx" ADDITIVE
lnHwnd = _WhToHWnd(_WFindTitl(THISFORM.Caption))

oBmp = CREATEOBJECT("BMPMaker")
lcFileName = SYS(2015) + ".bmp"
oBmp.cFileName = lcFileName
=oBmp.MakeBitmap(lnHwnd, 24)

DECLARE INTEGER ShellExecute IN "Shell32.dll" ;
	INTEGER, STRING, STRING, STRING, STRING, INTEGER

=ShellExecute(0, "Print", lcFileName, "", "", 0)


ENDPROC
PROCEDURE QueryUnload
IF THISFORM.ConfirmReleaseOnClose
	IF !THISFORM.ConfirmRelease()
		NODEFAULT
		RETURN .F.
	ENDIF
ENDIF 

ENDPROC
PROCEDURE Load
IF EMPTY(THIS.Icon)
	THIS.icon = _SCREEN.Icon
ENDIF

IF THISFORM.Stretchable = .F.
	THISFORM.borderstyle = 1 && UnStretchable.
	THIS.MaxButton = .F.
ELSE
	* We don't want the user making the form small enough to cause errors
	* If the MinHeight and MinWidth properties have not been touched, 
	* change them to the current height and width of the form.
	IF !PEMSTATUS(THIS, "MinHeight",0) 
		THIS.MinHeight = THIS.Height
	ENDIF
	IF !PEMSTATUS(THIS, "MinWidth",0) 
		THIS.MinWidth = THIS.Width
	ENDIF
ENDIF

* Get the registry application location and the data location from the application object.
IF TYPE("goApp.name") = "C"
	THIS.RegistryApp = goApp.RegistryApp
	THIS.DataPath = goApp.DataPath
	* Register this form with the forms manager
	IF TYPE("goApp.oForms.Name") = "C"
		goApp.oForms.RegisterForm(THIS)
	ENDIF
ENDIF

IF EMPTY(THIS.RegistryName)
	THIS.RegistryName = THIS.Name
ENDIF

IF THISFORM.RememberPosition
	THIS.Autocenter = .F.
	THISFORM.ReadPos()
ELSE
*	THIS.top = 1
	THISFORM.AdjustTop()
ENDIF

THISFORM.SetEnvironment()

THISFORM.BuildDEList()

IF EMPTY(THIS.DataPath)
	THIS.Datapath = "h:\"
ENDIF


IF TYPE('pcdatapath') <> "U"
	THIS.DataPath = pcDataPath
ELSE
	IF EMPTY(THIS.Datapath)
		THIS.DataPath = "h:\"
	ENDIF
ENDIF

IF LOWER(THIS.DataPath) = "k:\data\dbf\"
	THISFORM.BackColor = 255
ENDIF

IF THISFORM.DataEnvironment.AutoOpenTables = .F.
	THISFORM.ChangeDataPath(THIS.DataPath)
	llCantOpenTables = .F.
	lcOldOnError = ON('Error')
	ON ERROR llCantOpentables = .T.
	ThisForm.DataEnvironment.OpenTables()

	ON ERROR &lcOldOnError

	IF llCantOpentables
		MESSAGEBOX("The form '" + THISFORM.Caption +"' can't open one of the tables it needs. (Code: " + ALLTRIM(STR(ERROR())) + ;
						") Click Ok and try again." + CHR(13) + CHR(13) + CHR(13) + "Message: " + MESSAGE(),48,"TMR")
		RETURN .F.
	ENDIF
ENDIF

ENDPROC
PROCEDURE Resize
THISFORM.LockScreen = .T.

LOCAL oControl, lcPropType

FOR EACH oControl IN THIS.Controls
	IF PEMSTATUS(oControl, 'Reposition',5)
		IF PEMSTATUS(oControl, 'Reposition',3) = "Method"
			oControl.Reposition()
		ENDIF
	ENDIF
	IF PEMSTATUS(oControl, 'Resize',5)
		lcPropType = PEMSTATUS(oControl, 'Resize',3) 
		IF lcPropType = "Method" OR lcPropType = "Event"
			oControl.Resize()
		ENDIF
	ENDIF
ENDFOR

THISFORM.LockScreen = .F.

ENDPROC
PROCEDURE Destroy
IF THISFORM.RememberPosition
	THISFORM.WritePos()
ENDIF

IF TYPE("goApp.oForms.Name") = "C"
	goApp.oForms.Unregister(THIS)
ENDIF

ENDPROC
     ���    �  �                        ��   %   �      `  (             �  U  Z ��  � � � �� ���� ��C�� � � ��b�� %�CC�� ���J � B� � ��  ���(�C�� ����?�1 T� �C� ThisForm.DataEnvironment.C �  � ��� %�C� � @� cursor��;� %�C� � �
��� � T� �C� � C� \� � �\�� T� � �� � �� �7� T� �C� �	 C� \� �	 �\�� T� �	 �� � �� � � �� ��C� � �
 �� B� U  LNCNT LOOBJ LCDBC LALIST THISFORM DATAENVIRONMENT	 BASECLASS DATABASE
 PCDATAPATH CURSORSOURCE
 OPENTABLES
  4�  � U  LCOUTPUT  ��C� preview�  � �� U  THISFORM BUILDREPORT  ��C� printer�  � �� U  THISFORM BUILDREPORT 4��  �� � H� �	� �C�� f� PREVIEW��� � T�9� �a��1 REPO FORM &lcReportName NEXT 1 NOCO &lcOutput
 T�9� �-�� �C�� f� PRINTER��� �6 REPO FORM &lcReportName NEXT 1 NOCO TO &lcOutput  
 2�	�, R,��" There is no output for that option�� � U  LCREPORTNAME LCOUTPUT VISIBLE buildde,     �� buildreport�    �� preview    �� printitJ    ��
 sendreport    ��1 � � s1B A ��1�A� �AA A A B 4 q 2 q2 q2 � � �� � �a� �B 1                       	        +  8  $      V  u  '      �  �  *      �  U  -    )   �                       
QPROCEDURE resize
IF THIS.ResizeToBottom
	THIS.Height = THISFORM.Height - THIS.HeightDifference
ENDIF
IF THIS.ResizeToRight
	THIS.Width = THISFORM.Width - THIS.WidthDifference
ENDIF

ENDPROC
PROCEDURE spellcheck
IF !EMPTY(THIS.Value)

	WAIT WIND NOWA "Starting Spell Checker... "
	IF TYPE('THISFORM.oWord') <> "O" OR ISNULL(THISFORM.oWord)
		THISFORM.addobject('oWord','olecontrol','word.document')
		THISFORM.oWord.Width=0
		THISFORM.oWord.Height=0
	ENDIF

	lcCheckText = THIS.Value

	WITH THISFORM.oWord
	   .DoVerb(0)
	   .Object.Content = lcCheckText 
	   .CheckSpelling() && this will put us in a wait state while the spell checking occurs
	   .Object.Application.Selection.WholeStory()
		lcResultText = .Object.Application.Selection.Text

	   .Object.Application.Quit()
	   WAIT CLEA
	ENDWITH

	THISFORM.RemoveObject('oWord')

	THIS.Value = lcResultText

	=MESSAGEBOX("Spellcheck is complete",64)
ELSE

ENDIF
ENDPROC
PROCEDURE reposition
IF THIS.LockToBottom
	THIS.Top = THISFORM.Height - THIS.DistToFormBottom
ENDIF
IF THIS.LockToRight
	THIS.Left = THISFORM.Width - THIS.DistToFormRight
ENDIF

ENDPROC
PROCEDURE ProgrammaticChange
THIS.AnyChange()

ENDPROC
PROCEDURE InteractiveChange
THIS.AnyChange()
IF !EMPTY(THIS.ControlSource) 
	IF PEMSTATUS(THISFORM, 'DBFieldChange',5)
		THISFORM.DBFieldchange()
	ENDIF
ENDIF

ENDPROC
PROCEDURE GotFocus
this.initialvalue = this.value

ENDPROC
PROCEDURE RightClick
LOCAL loObject, ;
	lnRow, ;
	lnCol
loObject = THIS
lnRow    = THISFORM.TOP  + THIS.TOP  + MROW()
lnCol    = THISFORM.LEFT + THIS.LEFT + MCOL()

* Create and acivate the shortcut menu.

DEFINE POPUP SHORTCUT SHORTCUT FROM MROW(), MCOL()
DEFINE BAR 1 OF SHORTCUT PROMPT 'Cut'
DEFINE BAR 2 OF SHORTCUT PROMPT 'Copy'
DEFINE BAR 3 OF SHORTCUT PROMPT 'Paste'
DEFINE BAR 4 OF SHORTCUT PROMPT 'Clear'
DEFINE BAR 5 OF SHORTCUT PROMPT '\-'
ON SELECTION BAR 1 OF SHORTCUT SYS(1500, '_MED_CUT',   '_MEDIT')
ON SELECTION BAR 2 OF SHORTCUT SYS(1500, '_MED_COPY',  '_MEDIT')
ON SELECTION BAR 3 OF SHORTCUT SYS(1500, '_MED_PASTE', '_MEDIT')
ON SELECTION BAR 4 OF SHORTCUT SYS(1500, '_MED_CLEAR', '_MEDIT')
ACTIVATE POPUP SHORTCUT

ENDPROC
PROCEDURE Init
THIS.Heightdifference = THISFORM.Height - THIS.Height
THIS.Widthdifference = THISFORM.Width - THIS.Width

THIS.DistToFormBottom = THISFORM.Height - THIS.Top
THIS.DistToFormRight = THISFORM.Width - THIS.Left

IF THIS.AlwaysReadOnly
	THIS.ReadOnly = .T.
ENDIF
IF THIS.AlwaysEditable 
	THIS.ReadOnly = .F.
ELSE
	IF THISFORM.AutoEdit = .F. 
		THIS.ReadOnly = .T.
	ENDIF
ENDIF


ENDPROC
     G�PROCEDURE conditions
THIS.OpenTables()

LOCAL CR
CR = CHR(13)

lcConditions = "^"+ALLT(UPPER(Issuer.Desc1))+"^" + CR + ;
				THIS.CountiesList() + ;
				STRTRAN(BidInfo.Location, CHR(10), "")	+ CR
				
lcConditions = lcConditions + "^Description:^ " + CR + ;
				"Amount: $" + ALLTRIM(TRANSFORM(BondCard.AmtSold, "999,999,999,999")) + CR + ;
				"Title: "+ALLT(BondCard.Title)+ CR + ;
				"Dated: "+DTOC(BondCard.IssueDate) + CR + ;
				"Bond Form: "+ IIF(BondCard.BondForm="BE", "Book-Entry-Only", BondCard.BondForm) + CR + ;
				THIS.CouponDates() + CR +;
				"Record Date: " + ALLT(BondCard.RecordDate) + CR + ;
				"Paying Agent/Registrar: " + ALLT(Pay1.Desc)+ CR 
				
lcConditions = lcConditions + THIS.ConditionsMats() + CR +;
				THIS.InsAgent()

lcConditions = lcConditions + IIF(UPPER(BondCard.CallMemo) = "NON CALLABLE", "NON CALLABLE", "Call: "+STRTRAN(ALLT(BondCard.CallMemo),'$','')+" ")
lcConditions = lcConditions + CR + CR + "^Bidding Conditions:^  " + CR + ;
				STRTRAN(BidInfo.Condition, CHR(10), "")
  
RETURN lcConditions

ENDPROC
PROCEDURE insagent
THIS.OpenTables()

LOCAL lcRetVal, lcCredit

lcCredit = InsAgent.Desc
IF lcCredit <> "Not" AND !EMPTY(lcCredit)
	lcRetVal = "Credit Enhancement: "+ ALLTRIM(lcCredit)
ELSE
	lcRetVal = ""
ENDIF

RETURN IIF(!EMPTY(lcRetVal), lcRetVal + CHR(13), "")


ENDPROC
PROCEDURE opentables
lcCurDir = SYS(5) + CURDIR()
CD h:\

IF !USED("BondCard")
	USE BondCard IN 0
ENDIF

IF !USED("BidInfo")
	USE BidInfo IN 0
ENDIF

IF !USED("InsAgent")
	USE InsAgent IN 0
ENDIF
IF !USED("Attorney")
	USE Attorney IN 0
ENDIF

IF !USED("BondPurchase")
	USE BondPurchase IN 0
ENDIF

IF !USED("BondPurpose")
	USE BondPurpose IN 0
ENDIF

IF !USED("BondAtty")
	USE BondAtty IN 0
ENDIF

IF !USED("BidParam")
	USE Bidparam IN 0
ENDIF

IF !USED("BidInfo")
	USE BidInfo IN 0
ENDIF

IF !USED("CallDate")
	USE CallDate IN 0
ENDIF

IF !USED("Counties")
	USE Counties AGAIN IN 0
ENDIF

IF !USED("DEBTSVS")
	USE DEBTSVS IN 0
ENDIF

IF !USED("DocIndex")
	USE DocIndex IN 0
ENDIF

IF !USED("Elections")
	USE Elections IN 0
ENDIF

IF !USED("InsAgent")
	USE INSAGENT IN 0
ENDIF

IF !USED("Interest1")
	USE Interest IN 0 AGAIN ALIAS Interest1
ENDIF
IF !USED("Interest2")
	USE Interest IN 0 AGAIN ALIAS Interest2
ENDIF

IF !USED("Issuer")
	USE Issuer IN 0
ENDIF

IF !USED("CallDate")  
	USE Calldate IN 0
ENDIF

IF !USED("IntBasis")
	USE IntBasis IN 0
ENDIF

IF !USED("MULTIQSP")
	USE MultiQsp IN 0
ENDIF

IF !USED("Pay1")
	USE Payagent AGAIN IN 0 ALIAS Pay1
ENDIF
IF !USED("Pay2")
	USE Payagent AGAIN IN 0 ALIAS Pay2
ENDIF

IF !USED("Props")
	USE Props IN 0
ENDIF

IF !USED("PropIssu")
	USE PropIssu IN 0
ENDIF

IF !USED("PURCHASE1")
	USE PURCHASE AGAIN ALIAS Purchase1 IN 0
ENDIF
IF !USED("PURCHASE2")
	USE PURCHASE AGAIN ALIAS Purchase2 IN 0
ENDIF
IF !USED("PURCHASE3")
	USE PURCHASE AGAIN ALIAS Purchase3 IN 0
ENDIF

IF !USED("SourcPmt")
	USE SourcPmt IN 0
ENDIF

IF !USED("Tickler")
	USE Tickler IN 0
ENDIF

IF !USED("Tickles")
	USE Tickles IN 0
ENDIF

IF !USED("TypeDebt")
	USE TypeDebt IN 0
ENDIF

THIS.SetPointers()

SET DATA TO mac

CD (lcCurDir)

ENDPROC
PROCEDURE coupondates
THIS.Opentables()
LOCAL lcRetVal, ldDate1, ldDate2

DO CASE
	CASE BondCard.IntPays = "A"
		lnMonths = 6
	CASE BondCard.IntPays = "B"
		lnMonths = 12
	CASE BondCard.IntPays = "C"
		lnMonths = 3
	CASE BondCard.IntPays = "D"
		lnMonths = 1
	OTHERWISE
		lnMonths = 6 && Default to Semi-Annually
ENDCASE

ldDate1 = GOMONTH(BondCard.CouponDate, lnMonths)
ldDate2 = GOMONTH(ldDate1, lnMonths)

lcRetVal = "First Coupon: " + DTOC(BondCard.CouponDate) + ;
			" and then on " + LEFT(DTOC(ldDate1),5) + " and " + LEFT(DTOC(ldDate2),5)

RETURN lcRetval


ENDPROC
PROCEDURE setpointers
IF !EMPTY(THIS.BondCardID)
	SEEK THIS.BondCardID IN BondCard ORDER ID
	SELECT BondCard
	SEEK BondCard.BondCounsl IN Attorney ORDER CODE
	SEEK BondCard.County IN Counties ORDER Code
	SEEK BondCard.INSAGENT IN insAgent ORDER Code
	SEEK BondCard.IntBasis IN IntBasis ORDER Code
	SEEK BondCard.IntPays IN Interest1 ORDER Code
	SEEK BondCard.PRIPAYS IN INTEREST2 ORDER Code
	SEEK BondCard.PAGENT1 IN Pay1 ORDER Code
	SEEK BondCard.PAGENT2 IN Pay2 ORDER Code
	SEEK BondCard.REMKTAGENT IN PURCHASE1 ORDER Code
	SEEK BondCard.UnderWrite IN Purchase2 ORDER Code
	SEEK BondCard.FinAdvisor IN Purchase3 ORDER Code
	SEEK BondCard.ID IN BidInfo ORDER BondCardID

	IF !EMPTY(Assid) AND AssPct = 100
		SEEK BondCard.AssID IN Issuer ORDER Issuer
	ELSE
		SEEK BondCard.ParentID IN Issuer ORDER ID
	ENDIF
ENDIF

ENDPROC
PROCEDURE conditionsmats
SELE DebtSvs.* ;
	FROM DebtSvs ;
	WHERE DebtSvs.ParentID = THIS.BondCardID ;
	INTO CURSOR DSForBond

SELE DSForBond
lcSchedule = "Maturity          Principal" + CHR(13)
SCAN
	lcSchedule = lcSchedule + DTOC(Matdate) + "  " + PADL(TRANSFORM(Principal, "999,999,999,999"),15," ") + CHR(13)
ENDSCAN

RETURN lcSchedule

ENDPROC
PROCEDURE countieslist
lnSelect = SELECT()

LOCAL i

SELECT Issuer
DIMENSION laCountyFields[5,3]
laCountyFields(1,1) = "cnty"
laCountyFields(2,1) = "adcnty1"
laCountyFields(3,1) = "adcnty2"
laCountyFields(4,1) = "adcnty3"
laCountyFields(5,1) = "adcnty4"

FOR i = 1 TO 5
	laCountyFields(i,2) = EVAL(laCountyFields(i,1))
	=SEEK(laCountyFields(i,2), "Counties", "Code")
	laCountyFields(i,3) = ALLTRIM(Counties.Desc)
ENDFOR

lcPreface = IIF(!EMPTY(laCountyFields[2,3]),"Counties: ", "County: ")

lcCounties = ""
FOR i = 1 TO 5
	IF !EMPTY(laCountyFields[i,3])
		lcCounties = lcCounties + ALLTRIM(STRTRAN(laCountyFields[i,3],"County","")) + ", " 
	ENDIF
ENDFOR

lcCounties = LEFT(lcCounties, LEN(lcCounties)-2)

RETURN IIF(!EMPTY(lcCounties), lcPreface + lcCounties + CHR(13), "")


ENDPROC
PROCEDURE compcalendar
THIS.OpenTables()
CR = CHR(13)

lcCalendar = "^"+ALLTRIM(Issuer.DESC1) + "^" + CR + ;
			"Amount: $" + ALLTRIM(TRANSFORM(BondCard.AmtSold, "999,999,999,999")) + ;
			 IIF(BondCard.EstAmtSold, " (Preliminary, subject to change)","") + CR + ;
	         "Description: " + ALLTRIM(BondCard.Title) + CR 

lcCalendar = lcCalendar + IIF(!EMPTY(BondCard.TaxTreat),"Tax Status: "+BondCard.TaxTreat + CR,"") + ;
			"Sale time: " + BondCard.Saletime + " " + IIF(BondCard.SaletimePM, "PM","AM") + CR +;
			THIS.FA() + CR +;
			IIF(!EMPTY(BidInfo.Details),"Details: Pg."+ BidInfo.Details + CR,CR)

RETURN lcCalendar

ENDPROC
PROCEDURE fa
THIS.OpenTables()

lcFA = ALLTRIM(Purchase3.Desc) + ", " 

SELECT Purchase.Desc ;
	FROM Purchase, BondPurchase ;
	WHERE Purchase.Code = BondPurchase.Purchaser ;
	AND BondPurchase.BondCardID = THIS.BondCardID ;
	AND BondPurchase.Type = "Addl F" ;
	INTO CURSOR AddlFA

IF _TALLY > 0
	SCAN
		lcFA = lcFA + AddlFA.Desc + ", "
	ENDSCAN
	lcPreface = "Financial Advisors: " 
ELSE
	lcPreface = "Financial Advisor: " 
ENDIF
	
lcFA = LEFT(lcFA, LEN(lcFA) -2)

RETURN IIF(!EMPTY(lcFA), lcPreface + lcFa + CHR(13),"")

ENDPROC
PROCEDURE negcalendar
THIS.Opentables()
LOCAL lcCalendar
CR = CHR(13)

lcCalendar = "Amount: $" + ALLTRIM(TRANSFORM(BondCard.AmtSold, "999,999,999,999")) + CR + ;
         "Description: " + ALLTRIM(BOndCard.Title) + CR 
         
lcCalendar = lcCalendar + IIF(!EMPTY(BondCard.TaxTreat),"Tax Status: "+BondCard.TaxTreat+CR,"")+;
		"Lead Manager: " + ALLTRIM(Purchase2.Desc) + ;
		THIS.InsAgent() + CR

RETURN lcCalendar

ENDPROC
PROCEDURE agapproval
THIS.Opentables()
LOCAL lcProceeds, lcCounties, lcUnderWriters, lcBondCounsel, lcInsAgent

lcProceeds = THIS.Proceeds()
lcCounties = THIS.CountiesList()
lcUnderWriters = THIS.UnderWriters()
lcBondCounsel = THIS.BondCounsel()
lcInsAgent = THIS.InsAgent()

DO CASE
	CASE BondCard.UWType = "L"
		lcUWType = "Lead Manager"
	CASE BondCard.UWType = "P"
		lcUWType = "Purchaser"
	CASE BondCard.UWType = "A"
		lcUWType = "Placement Agent"
	OTHERWISE
		lcUWType = "Purchaser"
ENDCASE

lcOutPut = "^"+ALLT(UPPER(Issuer.Desc1))+"^"+CR+;
			lcCounties +;
	        "Amount: $"+ALLTRIM(TRANSFORM(BondCard.AmtSold, "999,999,999,999")) + CR + ;
	        "Description: "+ALLTRIM(BondCard.Title) + CR + ;
	        "Dated: "+DTOC(BondCard.IssueDate) + CR + ;
	        "1st Coupon: "  + DTOC(BondCard.CouponDate) + CR + ;
	        "Record Date: " + BondCard.RecordDate + CR + ;
	        "Paying Agent: "+ALLT(Pay1.Desc) + CR + ;
	        lcUWType + ": " + ALLTRIM(Purchase2.Desc) + CR + ;
			lcUnderwriters + ;
	        lcBondCounsel + ;
	        lcProceeds + ;
			lcInsAgent + ;
	        "Approved: "+ DTOC(BondCard.ApprvDate) + CR + ;
	        "Comp Reg #: "+BondCard.RegNumb+ CR + CR

RETURN lcOutput


ENDPROC
PROCEDURE underwriters
THIS.OpenTables()

LOCAL lcUW

lcUW = ""

SELECT Purchase.Desc ;
	FROM Purchase, BondPurchase ;
	WHERE Purchase.Code = BondPurchase.Purchaser ;
	AND BondPurchase.BondCardID = THIS.BondCardID ;
	AND BondPurchase.Type = "Joint" ;
	INTO CURSOR AddlUW
	
IF _TALLY > 0
	lcUW = "Joint Managers: " 
	SCAN
		lcUW = lcUW + ALLTRIM(AddlUW.Desc) + ", "
	ENDSCAN
ENDIF

lcUW = LEFT(lcUW, LEN(lcUW) -2)
RETURN IIF(!EMPTY(lcUW), lcUW + CHR(13), "")

ENDPROC
PROCEDURE bondcounsel
THIS.OpenTables()

lcBC = ALLTRIM(Attorney.Desc) + ", " 

SELECT Attorney.Desc ;
	FROM Attorney, BondAtty ;
	WHERE Attorney.Code = BondAtty.Attorney ;
	AND BondAtty.BondCardID = THIS.BondCardID ;
	INTO CURSOR AddlBC

IF _TALLY > 0
	SCAN
		lcBC = lcBC + ALLTRIM(AddlBC.Desc) + ", "
	ENDSCAN
ENDIF
	
lcBC = LEFT(lcBC, LEN(lcBC) -2)

RETURN IIF(!EMPTY(lcBC), "Bond Counsel: " + lcBC + CHR(13), "")


ENDPROC
PROCEDURE proceeds
THIS.OpenTables()

SELECT SourcPmt.Desc ;
	FROM SourcPmt, BondPurpose ;
	WHERE SourcPmt.Code = BondPurpose.Purpose ;
	AND BondPurpose.BondCardID = THIS.BondCardID ;
	INTO CURSOR AddlProceeds

lcProceeds = ""

IF _TALLY > 0
	SCAN
		lcProceeds = lcProceeds + ALLTRIM(AddlProceeds.Desc) + "; "
	ENDSCAN
ENDIF
	
lcProceeds = LEFT(lcProceeds, LEN(lcProceeds) -2)

RETURN IIF(!EMPTY(lcProceeds), "Use of Proceeds: " + lcProceeds + CHR(13),"")


ENDPROC
PROCEDURE compsales
THIS.OpenTables()
CR = CHR(13)
lcRetVal = "^"+ALLT(Issuer.Desc1) + "^" + CR + ;
		THIS.CountiesList() + ;
        "Amount: $" + ALLTRIM(TRANSFORM(BondCard.AmtSold, "999,999,999,999")) + CR + ;
        "Description: "+ ALLTRIM(BondCard.Title) + CR + ;
        IIF(!EMPTY(BondCard.TaxTreat),"Tax Status: "+BondCard.TaxTreat+CR,"") + ;
        "Dated: " + DTOC(BondCard.IssueDate) + CR + ;
       	THIS.InsAgent()

DO CASE
	CASE BondCard.uwtype = "P"
		lcUWType = "Purchaser"
	CASE BondCard.uwtype = "A"
		lcUWType = "Placement Agent"
	CASE BondCard.uwtype = "L"
		lcUWType = "Lead Manager"
	OTHERWISE
		lcUWType = "Lead Manager"
ENDCASE

lcRetval = lcRetVal + lcUWType + ": " + ALLTRIM(Purchase2.Desc) + CR + ;
		THIS.UnderWriters() + ;
        THIS.BondCounsel() + ;
        THIS.SalesMats() + ;
		THIS.TICNICEIR() + ;
		IIF(!EMPTY(BondCard.CallMemo),"Call: " + ALLT(BondCard.CallMemo)+CR,"")

RETU lcRetVal

ENDPROC
PROCEDURE ticniceir
lcTICNIC = ""

DO CASE
  CASE !EMPTY(BondCard.TIC)
    lcTICNIC = "TIC: "+STR(BondCard.TIC,6,4)+"%"
  CASE !EMPTY(BondCard.NIC)
    lcTICNIC = "NIC: "+STR(BondCard.NIC,6,4)+"%"
  CASE !EMPTY(BondCard.EIR)  
    lcTICNIC = "EIR: "+STR(BondCard.EIR,6,4)+"%"
ENDCASE

RETURN IIF(!EMPTY(lcTICNIC), lcTICNIC + CHR(13), "")

ENDPROC
PROCEDURE salesmats
THIS.OpenTables()

SELE Matdate, Principal, Coupon, ReoffYield, ReoffPrice ;
	FROM DebtSvs ;
	WHERE DebtSvs.ParentID = THIS.BondCardID ;
	AND Component <> "T" ;
	INTO CURSOR NonTermsForBond


SELE MAX(MatDate) AS Matdate, SUM(Principal) AS Principal, Coupon, ReoffYield, ReoffPrice;
	FROM DebtSvs ;
	WHERE DebtSvs.ParentID = THIS.BondCardID ;
	AND Component = "T" ;
	GROUP BY Component ;
	INTO CURSOR TermsForBond

* Put terms and non-terms together in one happy cursor
SELE * FROM NontermsForBond ;
UNION ;
SELECT * FROM TermsForBond ;
INTO CURSOR DSForBondtmp

SELECT * ;
	FROM DSForBondtmp ;
	ORDER BY MatDate ;
	INTO CURSOR DSForBond 

SELE DSForBond
lcSchedule = ""
IF BondCard.Cab
	lcHeader = "Maturity    " + "     Principal" 
ELSE
	lcHeader = "Maturity    " + "     Principal" + " Coupon" + IIF(DSForBond.ReoffYield>0 OR DSForBond.ReoffPrice > 0 , " Yield/Price", "") + CHR(13)
ENDIF

SCAN
	IF BondCard.Cab
		lcSchedule = lcSchedule + DTOC(Matdate) + " " + ;
			PADL(TRANSFORM(Principal, "999,999,999,999"),15," ") + CHR(13)
	ELSE
		lcSchedule = lcSchedule + DTOC(Matdate) + " " + ;
			PADL(TRANSFORM(Principal, "999,999,999,999"),15," ") + ;
			PADL(ALLTRIM(STR(Coupon, 6, 3)), 7) + " " 
		DO CASE
			CASE DSForBond.ReoffYield > 0.001
				lcSchedule = lcSchedule + PADL(ALLTRIM(STR(ReoffYield, 6, 3)), 7) + CHR(13)
			CASE DSForBond.ReoffYield = 0.001
				lcSchedule = lcSchedule + "NRO" + CHR(13)
			OTHERWISE
				lcSchedule = lcSchedule + IIF(DSForBond.ReoffPrice>0, PADL(ALLTRIM(STR(ReoffPrice, 7, 3)), 7),"") + CHR(13)
		ENDCASE
	ENDIF
ENDSCAN

*!*	USE IN termsForBond
*!*	USE IN DSForBond
*!*	USE IN NonTermSforBond
*!*	USE IN DSForBondTmp

RETURN lcHeader + lcSchedule


ENDPROC
PROCEDURE calldates
LOCAL lcCallText

SELE * ;
	FROM CallDate ;
	WHERE BondCardID = THIS.BondCardiD ;
	ORDER BY BeginDate ;
	INTO CURSOR BondCall


SELE BondCall
lcCallText = "Call Dates:  Code  Beg Date    End Date    Price" + CHR(13)

SCAN
	lcCallText = lcCallTExt + SPACE(9)+ "   " +;
		PADL(ALLTRIM(BondCall.DateCode),5,' ') + "  " +;
		DTOC(BondCall.BeginDate) + "  " +;
		DTOC(BondCall.EndDate)+ "  " +;
		STR(BondCall.Price,6,2)+ CHR(13)
ENDSCAN

RETURN lcCallText

ENDPROC
PROCEDURE elections
LOCAL lcOutput

lnIssuerID = Issuer.ID

SELE Elections.Elec_Dt, Elections.Amount, Props.Purpose, Props.Issued, ;
	Props.Amount -Props.Issued AS Unissued, Props.id, Elections.Id ;
	FROM Elections, Props ;
	WHERE Props.ElectionID = Elections.ID ;
	AND Elections.IssuerID = lnIssuerID ;
	GROUP BY Props.Id ;
	INTO CURSOR BondElections

* Debbie and Helene wanted all elections, so remove the line below
*	AND Props.Amount > Props.Issued ;

*	AND PropIssu.BondCardID = THIS.BondCardID ;

IF _TALLY > 0
	lcOutput = "Date                 Amount   Purpose                        Issued          Unissued" + CHR(13)
	SCAN
		lcOutput = lcOutput + DTOC(Elec_Dt) + "  " + ;
			PADL(TRANSFORM(Amount, "999,999,999,999"), 15) + "   " + ;
			PADR(ALLTRIM(Purpose), 20) + "  " + PADL(TRANSFORM(Issued, "999,999,999,999"), 15) + "   " + ;
			PADL(TRANSFORM(Unissued, "999,999,999,999"), 15) + CHR(13)
	ENDSCAN
ELSE
	lcOutput = ""
ENDIF


*USE IN BondElections

RETURN lcOutput
ENDPROC
PROCEDURE documents
LOCAL lcOutput

SELE DocIndex.DocType, DocDate, DateRecvd, DocTitle ;
	FROM DocIndex ;
	WHERE DocIndex.RegNumb = BondCard.RegNumb ;
	INTO CURSOR BondDocs

lcOutput = ""
SCAN
	lcOutput = lcOutput + DocType + "      " + 	DTOC(DocDate) + "  " + DTOC(DateRecvd) + "  " + ALLTRIM(DocTitle) + CHR(13)
ENDSCAN

RETURN lcOutput
ENDPROC
PROCEDURE disclosure
RETURN ""

ENDPROC
PROCEDURE tickler
SELE Tickler.Date, Tickles.Desc FROM ;
	Tickler, Tickles WHERE ;
	Tickler.Code = Tickles.Code ; 
	AND Tickler.BondCardID = THIS.BondCardID ;
	INTO CURSOR BondTickler

lcOutput = ""
SCAN
	lcOutput = lcOutput + DTOC(BondTickler.Date) + "  " + ALLTRIM(BondTickler.Desc) + CHR(13)
ENDSCAN

RETURN lcOutput


ENDPROC
PROCEDURE printinsagent
IF InsAgent.Desc <> "Not" AND !EMPTY(InsAgent.Desc)
	lcRetVal = ALLTRIM(InsAgent.Code) + "  " + ALLTRIM(InsAgent.Desc) + CHR(13) + ;
		"  " + "Moodys    S&P       Fitch     " + CHR(13) + ;
		"  " + PADR(InsAgent.Moodys, 10) + PADR(InsAgent.SAndP, 10) + PADR(InsAgent.Fitch, 10)
ELSE
	lcRetVal = ""
ENDIF

RETURN lcRetVal




ENDPROC
PROCEDURE printproceeds
THIS.OpenTables()

SELECT SourcPmt.Desc, BondPurpose.Amount ;
	FROM SourcPmt, BondPurpose ;
	WHERE SourcPmt.Code = BondPurpose.Purpose ;
	AND BondPurpose.BondCardID = THIS.BondCardID ;
	INTO CURSOR AddlProceeds

lcProceeds = ""

IF _TALLY > 0
	SCAN
		lcProceeds = lcProceeds + PADR(ALLTRIM(AddlProceeds.Desc), 25) + " " + TRANSFORM(Amount, "999,999,999,999") + CHR(13)
	ENDSCAN
ENDIF

RETURN lcProceeds

	


ENDPROC
PROCEDURE printunderwriters
THIS.OpenTables()

LOCAL lcUW

lcUW = ""

SELECT Purchase.Desc, Purchase.Code, LEFT(BondPurchase.Type, 1) AS Type, BondPurchase.id ;
	FROM Purchase, BondPurchase ;
	WHERE Purchase.Code = BondPurchase.Purchaser ;
	AND BondPurchase.BondCardID = THIS.BondCardID ;
	AND BondPurchase.Type <> "Addl Financial Advisor" ;
	ORDER BY BondPurchase.id ;
	INTO CURSOR AddlUW

IF _TALLY > 0
	SCAN
		lcUW = lcUW + Type + " " + Code + " " + ALLTRIM(AddlUW.Desc) + CHR(13)
	ENDSCAN
	lcUW = LEFT(lcUW, LEN(lcUW) -1)
ENDIF
	
RETURN lcUW

ENDPROC
PROCEDURE printfa
THIS.OpenTables()

lcFA = ALLTRIM(Purchase3.Desc) + CHR(13)

SELECT Purchase.Desc ;
	FROM Purchase, BondPurchase ;
	WHERE Purchase.Code = BondPurchase.Purchaser ;
	AND BondPurchase.BondCardID = THIS.BondCardID ;
	AND BondPurchase.Type = "Addl F" ;
	INTO CURSOR AddlFA

IF _TALLY > 0
	SCAN
		lcFA = lcFA + AddlFA.Desc + CHR(13)
	ENDSCAN
	lcFA = LEFT(lcFA, LEN(lcFA) -2)
ENDIF
	
RETURN lcFA
ENDPROC
PROCEDURE printbondcounsel
THIS.OpenTables()

lcBC = ALLTRIM(Attorney.Desc) + CHR(13)

SELECT Attorney.Desc ;
	FROM Attorney, BondAtty ;
	WHERE Attorney.Code = BondAtty.Attorney ;
	AND BondAtty.BondCardID = THIS.BondCardID ;
	INTO CURSOR AddlBC

IF _TALLY > 0
	SCAN
		lcBC = lcBC + ALLTRIM(AddlBC.Desc) + CHR(13)
	ENDSCAN
ENDIF
	
RETURN lcBC


ENDPROC
PROCEDURE redemption
LOCAL lcOneNotice 
CR = CHR(13) + CHR(10)

lcOneNotice = "^"+ALLT(UPPER(Issuer.Desc1))+"^ - " + ALLT(BondCard.TITLE) + ;
	IIF(!EMPTY(BondCard.CallMemo),": "+ALLT(BondCard.CallMemo),"") + CR

RETURN lcOneNotice

ENDPROC
PROCEDURE matevents
LOCA FOR DocIndex.RegNumb = m.cReg AND DocIndex.DocType = "M"
	m.cText=""
	m.cText="^"+ALLT(UPPER(Issuer.Desc1))+"^"+;
	" - "+ALLT(DocIndex.DocTitle)+;
	CR(2)
RETU (m.cText)

ENDPROC
      ��ࡱ�                >  ��	                               ����        ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������   ����   ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������R o o t   E n t r y                                               ��������   ���s���� � 7IY             ��F Ŀ   @       O l e                                                         
 ������������                                                A c c e s s O b j S i t e D a t a                             & ������������                                       8        C h a n g e d P r o p s                                               ����                                              ������������         ����   ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������                  8�                                         8                              8                                 �                                                            {\rtf1\ansi\deff0\deftab720{\fonttbl{\f0\fswiss MS Sans Serif;}{\f1\froman\fcharset2 Symbol;}{\f2\fnil Times New Roman;}}
{\colortbl\red0\green0\blue0;}
\deflang1033\pard\plain\f2\fs20 
\par }
   8    �  �                                          ����         ����       �'  �  "    	               C o n t e n t s                                                        ����                                       �        O l e P r e s 0 0 0                                            ������������                                       d        O l e                                                         
   ������������                                    ����                                                                            ������������                                                                          NANI    ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������     v���    ]  ]                        )�   %   �      �  �   �          �  U  �  ��  � � �� � � � J�� �(� � �- T� �C �   � � �  � �?� � � � ��$ ��C � � RegCreateKeyEx()� � ��	 B�� �� U 	 THKEYROOT TCSUBKEY LHKEY LNDISPOSITION LNRESULT REGCREATEKEYEX THIS CHECKRESULT�  ��  � � %��  � ��} � %�-��a �: ��C� Error CC�  Z��  was returned from � � .�x�� �y � T� � ��  �� � � U  TNRESULT TCMODULE THIS
 NLASTERRORA  ��  � � �� � T� �C �   � � � �� ��C �� � � �� U 	 THKEYROOT TCSUBKEY LHKEY THIS GETKEYHANDLE CLOSEKEY�  ��  � � � �� � � T� �C �   � � � �� T� �C �  � � ��" ��C � � RegDeleteKey()� � �� ��C � � �	 �� B�� � �� U
 	 THKEYROOT TCPARENTKEY TCKEYTODELETE LHKEY LNRESULT THIS GETKEYHANDLE REGDELETEKEY CHECKRESULT CLOSEKEY�  ��  � �� � %�C�t���, � T� ��  �� �D � T� �� � �� � T� �C � � ��! ��C � � RegCloseKey()� � �� %�C�t� ��� � T� � �� �� � B�� � �� U  THKEY LHKEY THIS HKEYCURRENT LNRESULT REGCLOSEKEY CHECKRESULTv  ��  � � �� � T� �� �� %�� � � ��F � ��C� � � � �� � T� �C �   � � � �� T� � �� �� U 	 THKEYROOT TCSUBKEY LHKEY THIS HKEYCURRENT CLOSEKEY GETKEYHANDLE�  ��  � � � �� � � T� �� �� T� �C �   � � � �� T� �C �  � � ��$ ��C � � RegDeleteValue()� � �� ��C � � �	 �� B�� � �� U
 	 THKEYROOT TCSUBKEY TCVALUENAME LHKEY LNRESULT THIS GETKEYHANDLE REGDELETEVALUE CHECKRESULT CLOSEKEY ��  � � %�� � � ��( �	 B��  �� �" %�C� tcDefaultValueb� C��[ � T� ��  �� � �� � � � � � J��  �(� � J�� �(� � � J�C� X�(� � J�C� >�(� �' T� �C� �  �  � � � � �	 �� %�� � ��� T� �CC� � =C�  �  ��� �� �	 B�� �� U
  TCVALUENAME TCDEFAULTVALUE THIS HKEYCURRENT LCRETURNVALUE LNTYPE LNRESULT LCBUFFER LNBUFFERSIZE REGQUERYVALUEEX  ��  � � �� � T� �� ��, T� �C� �  �  � �� C�  C� >� ��# ��C � � RegSetValueEx()� � �� B�� � �� U  TCVALUENAME TCVALUEDATA LNRESULT REGSETVALUEEX THIS HKEYCURRENT CHECKRESULTn  ��  � � � � �� � T� ��  �� ��C �   � � � �� T� �C �  � � � �� ��C� � ��	 B�� �� U	 	 THKEYROOT TCSUBKEY TCVALUENAME TCDEFAULTVALUE LCRETURNVALUE THIS OPENKEY READSTRINGVALUE CLOSEKEYn  ��  � � � � �� � T� ��  �� ��C �   � � � �� T� �C �  � � � �� ��C� �	 ��	 B�� �� U
 	 THKEYROOT TCSUBKEY TCVALUENAME TNDEFAULTVALUE LCRETURNVALUE THIS OPENKEY LNRETURNVALUE READNUMVALUE CLOSEKEYn  ��  � � � � �� � T� ��  �� ��C �   � � � �� T� �C �  � � � �� ��C� �	 ��	 B�� �� U
 	 THKEYROOT TCSUBKEY TCVALUENAME TLDEFAULTVALUE LCRETURNVALUE THIS OPENKEY LLRETURNVALUE READBOOLEANVALUE CLOSEKEYM  ��  � � � � ��C �   � � � �� ��C �  � � � �� ��C� � �� U 	 THKEYROOT TCSUBKEY TCVALUENAME TLVALUEDATA THIS OPENKEY WRITEBOOLEANVALUE CLOSEKEYM  ��  � � � � ��C �   � � � �� ��C �  � � � �� ��C� � �� U 	 THKEYROOT TCSUBKEY TCVALUENAME TNVALUEDATA THIS OPENKEY WRITENUMVALUE CLOSEKEYM  ��  � � � � ��C �   � � � �� ��C �  � � � �� ��C� � �� U 	 THKEYROOT TCSUBKEY TCVALUENAME TCVALUEDATA THIS OPENKEY WRITESTRINGVALUE CLOSEKEY�  ��  � � %�� ��) � T� �� true�� �C � T� �� false�� � T� �C �   � � � �� %�� � true��| � B�a�� �� � B�-�� � U  TCVALUENAME TLDEFAULTVALUE LCDEFAULTVALUE LCRETVAL THIS	 READVALUE0  ��  � � T� �C �   � � � ��	 B�� �� U  TCVALUENAME TCDEFAULTVALUE LCRETVAL THIS	 READVALUER  ��  � � G(���� T� �C� �
�Z�� T� �C �   � � � �� B�C� g�� U  TCVALUENAME TNDEFAULTVALUE LCDEFAULTVALUE LCRETVAL THIS	 READVALUEl  ��  � � %�� ��) � T� �� true�� �C � T� �� false�� � T� �C �   � � � ��	 B�� �� U  TCVALUENAME TLVALUEDATA LCVALUEDATA LLRETURNVALUE THIS
 WRITEVALUEE  ��  � � T� �C� �
�Z�� T� �C �   � � � ��	 B�� �� U  TCVALUENAME TNVALUEDATA LCVALUEDATA LLRETURNVALUE THIS
 WRITEVALUE0  ��  � � T� �C �   � � � ��	 B�� �� U  TCVALUENAME TCVALUEDATA LLRETURNVALUE THIS
 WRITEVALUE�  ��  � � � ��C �   � � � �� �� � � � � J�� �(� � � J�C� X�(� � J�C� >�(� �' T� �C� �
  � � � � � �	 �� %�� � ��� � B�a�� �� � B�-�� � U 	 THKEYROOT TCSUBKEY TCVALUENAME THIS OPENKEY LNTYPE LNRESULT LCBUFFER LNBUFFERSIZE REGQUERYVALUEEX HKEYCURRENT
  <�  � U  THIS  U  .  %��  � � ��' � ��C�  � �  � �� � U  THIS HKEYCURRENT CLOSEKEY� 6 |�� RegCreateKeyEx� Win32API����������, |�� RegSetValueEx� Win32API�������1 |�� RegQueryValueEx� Win32API�������  |�� RegCloseKey� Win32API��# |�� RegDeleteKey� Win32API���% |�� RegDeleteValue� Win32API��� U  REGCREATEKEYEX WIN32API REGSETVALUEEX REGQUERYVALUEEX REGCLOSEKEY REGDELETEKEY REGDELETEVALUE getkeyhandle,     �� checkresult    ��	 createkey�    ��	 deletekey=    �� closekey?    �� openkey9    �� deletevalue�    ��	 readvalue    ��
 writevalue�    �� getstringvalue{    �� getnumvalueX	    �� getbooleanvalueA
    �� setbooleanvalue.    �� setnumvalue�    �� setstringvalue�    �� readbooleanvalue-    �� readstringvalue    �� readnumvaluew    �� writebooleanvalue    �� writenumvalue�    �� writestringvalue^    ��	 valexists�    �� release    �� zreadme    �� Destroy!    �� Initp    ��1 � � �F� 3 � � �� A A 3 � r �33 � � �c"� 3 q v � � A $A � 3 � u � B2A �3 � � � �cB� 3 � C� A #� A s� � y�� E � 2 � r � �2� 3 1r � R�� � 3 1r � R�� � 2 1r � R�� � 2 1RQ� 3 1RQ� 3 1RQ� 3 � � � !A �Rq � q A 2 � �� 2 � � R�� 3 � � � !A �� 2 � R�� 2 � �� 2 � R3� yq � q A 2 q 2  1 A2A 3 m�4T2                               =  7        W  �  +        F  6      e  -  H   ,   K    e   5   �  �	  x   >   
  �  �   Q   �    �   X   @  :  �   `   \  Q  �   h   w  p  �   p   �  9  �   u   [  �  �   z     �  �      �  �    �     y    �   �  [    �   �  J  (  �   n    5  �   7  �  >  �   �  �  E  �   �  �  _  �     �%  b  �   �%  B&  �  �   ]&  **  �   )   ]                       !����    �!  �!                        ��   %   >      V     2          �  U  � %��  � ���� ��C� DynamicBackColor�S IIF(this.grdcurrow = RECNO(this.recordsource), this.highlightcolor, this.backcolor)� Column�  � �� %�C�  � �
��	�g T� � ��W IIF(this.grdcurrow = RECNO(this.recordsource), THIS.HighlightForeColor, THIS.ForeColor)�� � �� �  � ��� �� � � ��� %�C� �	 f� HEADER���� %�C� �	 BackColor��h��� T� �
 ��  � �� � %�C� �	 ForeColor��h���� T� � ��  � �� � � �� �� � U  THIS HIGHLIGHTENTIREROW SETALL HIGHLIGHTFORECOLOR OCOLUMN DYNAMICFORECOLOR COLUMNS OCONTROL CONTROLS	 BASECLASS	 BACKCOLOR HIGHLIGHTCOLOR	 FORECOLOR3 T�  �� �� �� ���(�� � ��C � T�  ��  C � � � � �� �� T� �C� � � �� � 6�� T� �C� �	 � �
� � 6��% T�
 �C� � ��	 C��%� � 6�� T� �� � � � ��! T� ��  � � �
 � ��� %�� � � ��,� T� � �� �� %�� � � ��(� T� � ���� � � U  TOTALCOLWIDTH I THIS COLUMNCOUNT COLUMNS WIDTH DELETEMARKWIDTH
 DELETEMARK RECORDMARKWIDTH
 RECORDMARK SCROLLBARWIDTH
 SCROLLBARS TOTALGRIDLINEWIDTH GRIDLINEWIDTH NEWGRIDWIDTH ORIGINALWIDTHH ��  � �0 %�C� o1.Nameb� C� C� o2.Nameb� C��B � B�-�� � T� �C�� �  �b�� �� ���(�� ��A�; %�CCC � � f��  CLASS:PARENTCLASS:BASECLASS:NAME
��=� T� �C�  C � � �!�� %�C� C � � ��h��9� %�C� C � � ��h
��5� %�C� C � � ��h
��1� ��CC � �  � � � �� � � � � �� U  O1 O2 LNPROPERTYCOUNT APROPS I UVAL WRITEEXPRESSION
  ��  � U  TOHEADER
  ��  � U  TOHEADER! %�C�  � �
� �  � �	��� T� �CW�� F��  � �� T� �C��� T� �C�	 Buffering��� ��C�	 Buffering���� ��C�  � �� ��C�	 Buffering� ��� G((� lcTAG� %�C�V� ��&� � �C�V����� �� ���(�C�V��"� T� �� �����CC� �@��  T� �� �����CC�� ]f�� �� � ��	 �  �
 ���, %�C�	 � �
� C� laTags[1,1]b� C	���� %�� .�	 � ����) T� �CC�	 � C�	 � >C� .�	 � �R@�� ��� T� �C�	 � @�� � %�C�� C� ���� ���� ��C � �	 � � �� � � ��
 F�� �� � U  THIS RECORDSOURCE RECORDSOURCETYPE LNSELECT LCTAG LNBUFFERMODE CREATEINDEXTAGS LATAGS I OCOLUMN COLUMNS CONTROLSOURCE LCSOURCEFIELD HEADER1
 SETSORTTAGv  ��  � %�C�  �
��$ � T� ��  �� �9 � T� �C��� �" %�C� lnNewBackColorb� N��o � T� � �� �� � U  TNBACKGROUNDCOLOR LNNEWBACKCOLOR THIS	 BACKCOLORX  T�  �C���' %�C� lnNewHighlightColorb� N��D � T� � ��  �� � ��C� � �� U  LNNEWHIGHLIGHTCOLOR THIS HIGHLIGHTCOLOR SETHIGHLIGHTROW�, %�C� THISFORM.Registry1.Nameb� C
��a � G~(� MacBase�$ ��C�	 Registry1� Registry� � �� �y � T� �� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���	� T� � �� � �� �B T�	 �� � � Forms\� � � \� � � \� ColumnWidths�� �
 �� � �� �� ���(�� � ����, T� �C� � �  �	 CC� Z����� � � �� %�� � ���� T� � �� �� �� �� � �� U  MACBASE THISFORM	 ADDOBJECT	 OREGISTRY	 REGISTRY1 THIS REGISTRYAPP REGISTRYNAME NAME LCREGISTRYLOCATION LACOLUMNSWIDTHS COLUMNCOUNT I LNWIDTH GETNUMVALUE HKEY_CURRENT_USER COLUMNS WIDTH+ %�C� THISFORM.Registry1.Nameb� C��; � T�  �� � �� �k � G~(� MacBase� T�  �C� Registry�N�� �B T� �� � � Forms\� � � \� � � \� ColumnWidths�� �	 �� �
 �� �� ���(�� �
 ���, ��C�  �  � CC� Z�C � � � � �  � �� �� U 	 OREGISTRY THISFORM	 REGISTRY1 MACBASE LCREGISTRYLOCATION THIS REGISTRYAPP NAME REGISTRYNAME LACOLUMNSWIDTHS COLUMNCOUNT I SETNUMVALUE HKEY_CURRENT_USER COLUMNS WIDTH
  ��  � U  TOHEADER�  %�C�  � �
��� � %�C�  � �
��6 � G+(��  � �� � �� �  � �� � T� �� � � �� T� �� � �	 �� ��C� Header1� �
 �� ��C� Header1�  � � � �� T� � � �� �� T� � �	 �� �� �� � U  THIS DEFAULTHEADERCLASS DEFAULTHEADERCLASSDEFINITION OCOLUMN COLUMNS LCHEADERCAPTION HEADER1 CAPTION LCHEADERFORECOLOR	 FORECOLOR REMOVEOBJECT	 ADDOBJECT�  ��  � T� � ��  �� %��  ��F �" ��C� ReadOnlya� Column� � �� �� � �� ���(�� � ��� � %�C � � � 
��� � T� � �� �� �-�� � �� � U 
 TLREADONLY THIS READONLY SETALL I COLUMNCOUNT ACOLREADONLY COLUMNS[  ��  � ��  � � �H � %��  � � � ��D � T� � ��  �� !� � �� B�� � �� U  LOCOLUMN THIS COLUMNS COLUMNORDER ACTIVECOLUMN CURRENTCOLUMN�  s��  �C���C���W�( s�����  "�� Set background color��' s�����  "�� Set Highlight color��G 1������  �5 _SCREEN.ActiveForm.ActiveControl.SetBackGroundColor()�F 1������  �4 _SCREEN.ActiveForm.ActiveControl.SetHighlightColor()� t��  � U  GRIDOPTIONSC  ��  � %�C� � �
��/ � T� � �C� � O�� � ��C� � �� U 	 NCOLINDEX THIS RECORDSOURCE	 GRDCURROW REFRESH� T�  � ��  � �� T�  � ��  � ��" T�  � �� � �  � �  � ��" T�  � �� � �  �	 �  � �� %��  �
 ��� �" ��C� readonlya� Column�  � �� � ��C�  � �� ��C�  � �� ��C�  � ��% ��C� shp�  � � Shape�  � � ��% T� �C� THIS.Parent.shp�  � ��� T� � ��  � �� T� �	 ��  �	 �� T� � ��  � �� T� � ��  � �� T� � �� �� T� � �� �� T� � ��  � �� ��C�� � �� T� � �a�� %��  � � ��f� �  � ��  � �� �� ���(��  � ���! T�  � �� ��C � �  � � �� �� �  � ��  � �� �� ���(��  � ��b�! T�  � �� ��C � �  � �
 �� �� � %��  � ���� ��C�  � �� � %�-���� � macbase.prg� � U"  THIS ORIGINALHEIGHT HEIGHT ORIGINALWIDTH WIDTH DISTANCETOFORMBOTTOM THISFORM TOP DISTANCETOFORMRIGHT LEFT READONLY SETALL SETHIGHLIGHTROW INSTALLCUSTOMHEADER SETSORTTAGS PARENT	 ADDOBJECT NAME OSHAPE	 FILLSTYLE BORDERSTYLE	 FILLCOLOR HIGHLIGHTCOLOR ZORDER VISIBLE COLUMNCOUNT ACOLUMNWIDTHS I COLUMNS ACOLREADONLY REMEMBERCOLUMNWIDTHS RESTORECOLUMNWIDTHS MACBASE PRG  ��C�  � �� U  THIS AFTERROWCOLCHANGEl %��  � ��2 �" T�  � �� � �  � �  � �� � %��  � ��h �" T�  � �� � �  � �  �	 �� � %��  �
 a��� � �� ���(��  � ��� � T� �C � �  � �  � ��  T�  � �� �� �� �  � �� �� �* %�C� THIS.Parent.shp�  � b� O��e�% T� �C� THIS.Parent.shp�  � ��� %�C� �
��a� T� � ��  � �� T� � ��  � �� � � U  THIS RESIZEWITHBOTTOM HEIGHT THISFORM DISTANCETOFORMBOTTOM TOP RESIZEWITHRIGHT WIDTH DISTANCETOFORMRIGHT LEFT RESIZECOLUMNS I COLUMNCOUNT LNORIGINALPROPORTION ACOLUMNWIDTHS ORIGINALWIDTH COLUMNS NAME OSHAPE$  %��  � �� � ��C�  � �� � U  THIS REMEMBERCOLUMNWIDTHS SAVECOLUMNWIDTHS ��  � ��� ��� � %�C���� � T� ��� �� �� �� �� T� �� � � �� T� �CC����� T�	 �CC�����- T�
 �C� � � �� C�	 �� �� �� �	
�� �� �  T�
 �CC|����������� � �� %��
 ��� � ��C� � �� �� � ��C� � �� � U 	 NCOLINDEX THIS LNBOTTOM TOP HEADERHEIGHT RELATIVEROW	 ROWHEIGHT LNTOP LNMOUSEROWPOS LNMOUSECOLPOS LLCHANGINGROW LEFT WIDTH BEFOREROWCHANGE BEFORECOLCHANGE sethighlightrow,     �� setwidth�    �� copyprop�    �� commonheaderclick$    �� commonheaderdblclick<    �� setsorttagsT    �� setbackgroundcolor	    �� sethighlightcolor�	    �� restorecolumnwidthsV
    �� savecolumnwidths�    �� commonheaderrightclick�    �� installcustomheader�    �� setreadonly[    �� currentcolumn_accessN    ��
 RightClick�    �� AfterRowColChange�    �� Initv    �� Refresh�    �� Resize�    �� Destroy5    �� BeforeRowColChange�    ��1 �1qA ""��1A �1A A A A A 3 � ��A ��QqBAA A 3 � q A Rr������A A A A A 3 q 3 q 3 � � � ��� �� 1q�A A #�S�� !A �AB B A � A 4 q � � � A "A 3 � qA � 3 �A� A "�1� C A A "1A "���A A 3 �� �A "��A 3 q 3 11A !11s�11A A 4 q � !� �aqA A A 3 q "qA A A � 3 A�qqa� 3 q 1QA � 3 11"!!A � � � TQ11111� B3�A 4�A A � A � "A 3 � 3 !A !A "��A A �Q11A A 3 � A 3 q � � �A�� A A � � � � A 2                       J        i  �     $     �  .   6   �  �  F   8   �  	  J   :   (	  �  N   Y   "  �  �   c     �  �   i   �  t  �   �   �  p  �   �   �  �  �   �   �  7  �   �   Y  �  �   �     �  �   �   �  j     �   �  
  	  �   %  �%    �   �%  &  I  �   (&  )  M  �   %)  d)  h     �)  }+  n   )   �!                       ?V���    =?  =?                        ��   %   �7      4=  �  �9          �  U  F ��C�  � �� �� � T� �C� ��? T� �� ^CC� � f�� ^� C�  � C� � C�
 �  �� ��T� �� � ^Description:^ � �	 Amount: $CC�	 �
 � 999,999,999,999_�� � Title: C�	 � �� � Dated: C�	 � *� � Bond Form: C�	 � � BE� � Book-Entry-Only� �	 � 6� C�  � � � Record Date: C�	 � �� � Paying Agent/Registrar: C� � �� ��! T� �� C�  � � C�  � ��] T� �� CC�	 � f� NON CALLABLE� � NON CALLABLE�  � Call: CC�	 � �� $�  ��  6��E T� �� � � � ^Bidding Conditions:^  � C� � C�
 �  ���	 B�� �� U  THIS
 OPENTABLES CR LCCONDITIONS ISSUER DESC1 COUNTIESLIST BIDINFO LOCATION BONDCARD AMTSOLD TITLE	 ISSUEDATE BONDFORM COUPONDATES
 RECORDDATE PAY1 DESC CONDITIONSMATS INSAGENT CALLMEMO	 CONDITION�  ��C�  � �� �� � � T� �� � �� %�� � Not� C� �
	��m �' T� �� Credit Enhancement: C� ��� �� � T� ��  �� �  B�CC� �
� � C� � �  6�� U  THIS
 OPENTABLES LCRETVAL LCCREDIT INSAGENT DESC_ T�  �C�]C���
 �� h:\� %�C� BondCard�
��H � Q�  � BondCard� � %�C� BidInfo�
��v � Q�  � BidInfo� � %�C� InsAgent�
��� � Q�  � InsAgent� � %�C� Attorney�
��� � Q�  � Attorney� � %�C� BondPurchase�
��� Q�  � BondPurchase� � %�C� BondPurpose�
��D� Q�  � BondPurpose� � %�C� BondAtty�
��t� Q�  � BondAtty� � %�C� BidParam�
���� Q�  � Bidparam� � %�C� BidInfo�
���� Q�  � BidInfo� � %�C� CallDate�
��� Q�  � CallDate� � %�C� Counties�
��3� Q�  � Counties�� � %�C� DEBTSVS�
��a� Q�  � DEBTSVS� � %�C� DocIndex�
���� Q�  � DocIndex� � %�C�	 Elections�
���� Q�  �	 Elections� � %�C� InsAgent�
���� Q�  � INSAGENT� � %�C�	 Interest1�
��)� Q�  � Interest�� � � %�C�	 Interest2�
��_� Q�  � Interest�� � � %�C� Issuer�
���� Q�  � Issuer� � %�C� CallDate�
���� Q�  � Calldate� � %�C� IntBasis�
���� Q�  � IntBasis� � %�C� MULTIQSP�
��� Q�  � MultiQsp� � %�C� Pay1�
��L� Q�  � Payagent�� � � %�C� Pay2�
��}� Q�  � Payagent�� � � %�C� Props�
���� Q�  � Props� � %�C� PropIssu�
���� Q�  � PropIssu� � %�C�	 PURCHASE1�
��� Q�  � PURCHASE�� � � %�C�	 PURCHASE2�
��C� Q�  � PURCHASE�� � � %�C�	 PURCHASE3�
��y� Q�  � PURCHASE�� � � %�C� SourcPmt�
���� Q�  � SourcPmt� � %�C� Tickler�
���� Q�  � Tickler� � %�C� Tickles�
��� Q�  � Tickles� � %�C� TypeDebt�
��5� Q�  � TypeDebt� � ��C�" �# �� G(� mac�
 ���  �� U%  LCCURDIR H BONDCARD BIDINFO INSAGENT ATTORNEY BONDPURCHASE BONDPURPOSE BONDATTY BIDPARAM CALLDATE COUNTIES DEBTSVS DOCINDEX	 ELECTIONS INTEREST	 INTEREST1	 INTEREST2 ISSUER INTBASIS MULTIQSP PAYAGENT PAY1 PAY2 PROPS PROPISSU PURCHASE	 PURCHASE1	 PURCHASE2	 PURCHASE3 SOURCPMT TICKLER TICKLES TYPEDEBT THIS SETPOINTERS MACQ ��C�  � �� �� � � � H�) �� � �� � � A��K � T� ���� �� � � B��m � T� ���� �� � � C��� � T� ���� �� � � D��� � T� ���� 2�� � T� ���� � T� �C� � � ��� T� �C� � ���T T� �� First Coupon: C� � *�  and then on CC� *�=�  and CC� *�=��	 B�� �� U	  THIS
 OPENTABLES LCRETVAL LDDATE1 LDDATE2 BONDCARD INTPAYS LNMONTHS
 COUPONDATE� %�C�  � �
���� E� �� ID��  � �� F� � E� �� CODE�� � �� E� �� Code�� � �� E�	 �� Code�� �	 �� E�
 �� Code�� �
 �� E� �� Code�� � �� E� �� Code�� � �� E� �� Code�� � �� E� �� Code�� � �� E� �� Code�� � �� E� �� Code�� � �� E� �� Code�� � �� E� ��
 BondCardID�� � �� %�C� �
� � �d	���� E� �� Issuer�� � �� ��� E� �� ID�� � �� � � U  THIS
 BONDCARDID BONDCARD ID
 BONDCOUNSL ATTORNEY CODE COUNTY COUNTIES INSAGENT INTBASIS INTPAYS	 INTEREST1 PRIPAYS	 INTEREST2 PAGENT1 PAY1 PAGENT2 PAY2
 REMKTAGENT	 PURCHASE1
 UNDERWRITE	 PURCHASE2
 FINADVISOR	 PURCHASE3 BIDINFO ASSID ASSPCT ISSUER PARENTID� 1 o� DebtSvs�  ����  � � � ����	 DSForBond� F� �. T� �� Maturity          PrincipalC� �� ~�� �@ T� �� C� *�   CC� � 999,999,999,999_��  �C� �� �	 B�� �� U  DEBTSVS PARENTID THIS
 BONDCARDID	 DSFORBOND
 LCSCHEDULE MATDATE	 PRINCIPAL4 T�  �CW�� �� � F� � � ������� T� �������� cnty��  T� �������� adcnty1��  T� �������� adcnty2��  T� �������� adcnty3��  T� �������� adcnty4�� �� ���(����G�# T� �� �����CC � �� ���% ��CC � �� � Counties� Code��� T� �� �����C� � ��� ��7 T� �CCC��� �
� �
 Counties: � � County: 6�� T� ��  �� �� ���(������ %�CC � �� �
����/ T� �� CCC � �� � County�  ��� , �� � �� T� �C� C� >�=��$ B�CC� �
� � � C� � �  6�� U  LNSELECT I ISSUER LACOUNTYFIELDS COUNTIES DESC	 LCPREFACE
 LCCOUNTIESy ��C�  � �� T� �C� ��� T� �� ^C� � �� ^� �	 Amount: $CC� � � 999,999,999,999_�C� � �' �!  (Preliminary, subject to change)� �  6� � Description: C� �	 �� ��� T� �� CC� �
 �
� � Tax Status: � �
 � � �  6� Sale time: � � �  C� � � � PM� � AM6� C�  � � CC� � �
� � Details: Pg.� � � � � 6��	 B�� �� U  THIS
 OPENTABLES CR
 LCCALENDAR ISSUER DESC1 BONDCARD AMTSOLD
 ESTAMTSOLD TITLE TAXTREAT SALETIME
 SALETIMEPM FA BIDINFO DETAILSO ��C�  � �� T� �C� � �� , ��h o� Purchase� BondPurchase�� � ���� � � � � � �	 �  �	 	� � �
 � Addl F	���� AddlFA� %�� � ��� � ~�� � T� �� � � � , �� �! T� �� Financial Advisors: �� ��  T� �� Financial Advisor: �� � T� �C� C� >�=��$ B�CC� �
� � � C� � �  6�� U  THIS
 OPENTABLES LCFA	 PURCHASE3 DESC PURCHASE BONDPURCHASE CODE	 PURCHASER
 BONDCARDID TYPE ADDLFA	 LCPREFACE�  ��C�  � �� �� � T� �C� ��U T� ��	 Amount: $CC� � � 999,999,999,999_�� � Description: C� � �� ��c T� �� CC� � �
� � Tax Status: � � � � �  6� Lead Manager: C� �	 �C�  �
 � ��	 B�� �� U  THIS
 OPENTABLES
 LCCALENDAR CR BONDCARD AMTSOLD TITLE TAXTREAT	 PURCHASE2 DESC INSAGENT� ��C�  � �� �� � � � � � T� �C�  � �� T� �C�  � �� T� �C�  �	 �� T� �C�  �
 �� T� �C�  � �� H�� �.� �� � � L��� � T� �� Lead Manager�� �� � � P��� � T� ��	 Purchaser�� �� � � A��� T� �� Placement Agent�� 2�.� T� ��	 Purchaser�� �CT� �� ^CC� � f�� ^� � �	 Amount: $CC� � � 999,999,999,999_�� � Description: C� � �� � Dated: C� � *� � 1st Coupon: C� � *� � Record Date: � � � � Paying Agent: C� � �� � � : C� � �� � � � � �
 Approved: C� � *� � Comp Reg #: � � � � ��	 B�� �� U  THIS
 OPENTABLES
 LCPROCEEDS
 LCCOUNTIES LCUNDERWRITERS LCBONDCOUNSEL
 LCINSAGENT PROCEEDS COUNTIESLIST UNDERWRITERS BONDCOUNSEL INSAGENT BONDCARD UWTYPE LCUWTYPE LCOUTPUT ISSUER DESC1 CR AMTSOLD TITLE	 ISSUEDATE
 COUPONDATE
 RECORDDATE PAY1 DESC	 PURCHASE2	 APPRVDATE REGNUMB ��C�  � �� �� � T� ��  ��g o� Purchase� BondPurchase�� � ���� � � � � � � �  � 	� � �	 � Joint	���� AddlUW� %�� � ��� � T� �� Joint Managers: �� ~�� � T� �� C�
 � �� , �� � � T� �C� C� >�=��  B�CC� �
� � C� � �  6�� U  THIS
 OPENTABLES LCUW PURCHASE DESC BONDPURCHASE CODE	 PURCHASER
 BONDCARDID TYPE ADDLUW�  ��C�  � �� T� �C� � �� , ��P o� Attorney� BondAtty�� � ���� � � � � � � �  � 	���� AddlBC� %�� � ��� � ~�� � T� �� C� � �� , �� � � T� �C� C� >�=��2 B�CC� �
� � Bond Counsel: � C� � �  6�� U	  THIS
 OPENTABLES LCBC ATTORNEY DESC BONDATTY CODE
 BONDCARDID ADDLBC�  ��C�  � ��Y o� SourcPmt� BondPurpose�� � ���� � � � � � � �  � 	���� AddlProceeds� T�	 ��  �� %�� � ��� � ~�� � T�	 ��	 C� � �� ; �� � � T�	 �C�	 C�	 >�=��5 B�CC�	 �
�! � Use of Proceeds: �	 C� � �  6�� U
  THIS
 OPENTABLES SOURCPMT DESC BONDPURPOSE CODE PURPOSE
 BONDCARDID ADDLPROCEEDS
 LCPROCEEDS ��C�  � �� T� �C� ��� T� �� ^C� � �� ^� C�  � �	 Amount: $CC� � � 999,999,999,999_�� � Description: C� �	 �� CC� �
 �
� � Tax Status: � �
 � � �  6� Dated: C� � *� C�  � �� H�� ��� �� � � P��� T� ��	 Purchaser�� �� � � A��H� T� �� Placement Agent�� �� � � L��v� T� �� Lead Manager�� 2��� T� �� Lead Manager�� �o T� �� � � : C� � �� C�  � C�  � C�  � C�  � CC� � �
� � Call: C� � �� � �  6��	 B�� �� U  THIS
 OPENTABLES CR LCRETVAL ISSUER DESC1 COUNTIESLIST BONDCARD AMTSOLD TITLE TAXTREAT	 ISSUEDATE INSAGENT UWTYPE LCUWTYPE	 PURCHASE2 DESC UNDERWRITERS BONDCOUNSEL	 SALESMATS	 TICNICEIR CALLMEMO�  T�  ��  �� H� �� � �C� � �
��S �& T�  �� TIC: C� � ��Z� %�� �C� � �
��� �& T�  �� NIC: C� � ��Z� %�� �C� � �
��� �& T�  �� EIR: C� � ��Z� %�� �  B�CC�  �
� �  C� � �  6�� U  LCTICNIC BONDCARD TIC NIC EIR� ��C�  � ��\ o� DebtSvs�� ��� ��� ��� ��� ���� � �  �	 �	 �
 � T	���� NonTermsForBond�m o� DebtSvs�C� ���Q� �C� ���Q� �� ��� ��� ���� � �  �	 �	 �
 � T	����
 ���� TermsForBond�? o��  � TermsForBond�� NontermsForBondǼ�� DSForBondtmp�) o� DSForBondtmp���� ����	 DSForBond� F� � T� ��  �� %�� � ����+ T� �� Maturity    �      Principal�� ��o T� �� Maturity    �      Principal�  CouponC� � � � � � � � �  Yield/Price� �  6C� �� � ~��� %�� � ��_�? T� �� C� *�  CC� � 999,999,999,999_��  �C� �� ���Q T� �� C� *�  CC� � 999,999,999,999_��  �CCC� ��Z����  �� H����� �� � �����MbP?���& T� �� CCC� ��Z���C� �� �� � �����MbP?��=� T� �� � NROC� �� 2���; T� �� C� � � � CCC� ��Z���� �  6C� �� � � � B�� � �� U  THIS
 OPENTABLES MATDATE	 PRINCIPAL COUPON
 REOFFYIELD
 REOFFPRICE DEBTSVS PARENTID
 BONDCARDID	 COMPONENT NONTERMSFORBOND TERMSFORBOND DSFORBONDTMP	 DSFORBOND
 LCSCHEDULE BONDCARD CAB LCHEADER�  ��  �1 o� CallDate���� � � ���� ���� BondCall� F� �C T�  ��0 Call Dates:  Code  Beg Date    End Date    PriceC� �� ~�� �e T�  ��  C�	X�    CC� � ���  ��   C� � *�   C� � *�   C� � ��ZC� �� �	 B��  �� U	 
 LCCALLTEXT CALLDATE
 BONDCARDID THIS	 BEGINDATE BONDCALL DATECODE ENDDATE PRICE� ��  � T� �� � ��� o�	 Elections� Props�� � ��� � ��� � ��� �	 ��� � � �	 �Q�
 �� � ��� � ���� � � � � � � � 	���� � ���� BondElections� %�� � ����h T�  ��U Date                 Amount   Purpose                        Issued          UnissuedC� �� ~���� T�  ��  C� *�   CC� � 999,999,999,999_���    CC� ����   CC�	 � 999,999,999,999_���    CC�
 � 999,999,999,999_��C� �� � ��� T�  ��  �� �	 B��  �� U  LCOUTPUT
 LNISSUERID ISSUER ID	 ELECTIONS ELEC_DT AMOUNT PROPS PURPOSE ISSUED UNISSUED
 ELECTIONID ISSUERID BONDELECTIONS�  ��  �G o� DocIndex�� � ��� ��� ��� ���� � � � ���� BondDocs� T�  ��  �� ~�� �? T�  ��  � �       C� *�   C� *�   C� �C� �� �	 B��  �� U	  LCOUTPUT DOCINDEX DOCTYPE DOCDATE	 DATERECVD DOCTITLE REGNUMB BONDCARD BONDDOCS 	 B��  �� U  � \ o� Tickler� Tickles��  � ��� � ����  � � � � �  � � � 	���� BondTickler� T� ��  �� ~�� �+ T� �� C� � *�   C� � �C� �� �	 B�� �� U	  TICKLER DATE TICKLES DESC CODE
 BONDCARDID THIS BONDTICKLER LCOUTPUT'$ %��  � � Not�
 C�  � �
	���� lcRetVal = ALLTRIM(InsAgent.Code) + "  " + ALLTRIM(InsAgent.Desc) + CHR(13) +  "  " + "Moodys    S&P       Fitch     " + CHR(13) +  "  " + PADR(InsAgent.Moodys, 10) + PADR(InsAgent.SAndP, 10) + PADR(InsAgent.Fitch, 10)
 �� T� ��  �� �	 B�� �� U  INSAGENT DESC LCRETVAL�  ��C�  � ��b o� SourcPmt� BondPurpose�� � ��� � ���� � � � � � � �  � 	���� AddlProceeds� T�
 ��  �� %�� � ��� � ~�� �> T�
 ��
 CC�	 � ����  C� � 999,999,999,999_C� �� � �	 B��
 �� U  THIS
 OPENTABLES SOURCPMT DESC BONDPURPOSE AMOUNT CODE PURPOSE
 BONDCARDID ADDLPROCEEDS
 LCPROCEEDS8 ��C�  � �� �� � T� ��  ��� o� Purchase� BondPurchase�� � ��� � ��C� � �=�Q� �� � ���� � � �	 � � �
 �  �
 	�! � � � Addl Financial Advisor	���� � ���� AddlUW� %�� � ��(� ~��. T� �� � �  � �  C� � �C� �� � T� �C� C� >�=�� �	 B�� �� U  THIS
 OPENTABLES LCUW PURCHASE DESC CODE BONDPURCHASE TYPE ID	 PURCHASER
 BONDCARDID ADDLUW�  ��C�  � �� T� �C� � �C� ��h o� Purchase� BondPurchase�� � ���� � � � � � �	 �  �	 	� � �
 � Addl F	���� AddlFA� %�� � ��� � ~�� � T� �� � � C� �� � T� �C� C� >�=�� �	 B�� �� U  THIS
 OPENTABLES LCFA	 PURCHASE3 DESC PURCHASE BONDPURCHASE CODE	 PURCHASER
 BONDCARDID TYPE ADDLFA�  ��C�  � �� T� �C� � �C� ��P o� Attorney� BondAtty�� � ���� � � � � � � �  � 	���� AddlBC� %�� � ��� � ~�� � T� �� C� � �C� �� � �	 B�� �� U	  THIS
 OPENTABLES LCBC ATTORNEY DESC BONDATTY CODE
 BONDCARDID ADDLBCy  ��  � T� �C� C�
 ��Q T�  �� ^CC� � f�� ^ - C� � �CC� � �
� � : C� � �� �  6� ��	 B��  �� U  LCONENOTICE CR ISSUER DESC1 BONDCARD TITLE CALLMEMOx " -��  � �� � �  � � M	�� T�� ��  ��8 T�� �� ^CC� � f�� ^�  - C�  � �C�� �� B��� �� U	  DOCINDEX REGNUMB CREG DOCTYPE CTEXT ISSUER DESC1 DOCTITLE CR
 conditions,     �� insagentM    ��
 opentables0    �� coupondates�    �� setpointers�    �� conditionsmatso    �� countieslist�    �� compcalendar    �� fa    �� negcalendar�    ��
 agapproval%    �� underwriters�    �� bondcounselT    �� proceeds�    ��	 compsales	!    ��	 ticniceir�#    ��	 salesmats
%    ��	 calldatesw)    ��	 elections�*    ��	 documentsK-    ��
 disclosureY.    �� tickleri.    �� printinsagentf/    �� printproceeds�0    �� printunderwriters2    �� printfa�3    �� printbondcounsel�4    ��
 redemption
6    ��	 matevents�6    ��1 � r � �Y�R� 3 � � �q� � A 4 !� �AA r1A �AA �AA ��A �qA �AA �AA r1A �AA �QA r1A �AA �QA �AA ��A ��A b!A �AA �AA �AA B�A A�A RA �AA ��A ��A ��A �AA r1A r1A �AA � � � 3 � � � Q� Q� Q� Q� � � A R!C� 4 1aq ��������������� aA A 3 r �� A � 3 � r r 1�r1Q�A r� q��A A �B4 � � %
�
� 3 � ��� �A � A �B3 � q � S4� 3 � q� Q�QaQ�� aA � 1� 4 � r � w�� �A A �3 � �� �A A �"4 � �� � �A A �R4 � � 7� QaQ�Q�� �A �� 3 � � 1a1a1aA 3 � ����r � �� �A � �� � �a��� �A A A � 4 q s 1� UA � 3 q �	�� T	A � � A � 2 q u� � �A � 2 � 3 �� � �A � 4 A�� � A � 6 � &� � �A A � 6 � r � X
� �A �A � 3 � ��� �A �A � 2 � �� �A A � 4 q Q� 3 !� �� 2                       /        N  R        s  �  .   {   �    �   �   4  c  �   �   �  �  �   �   �    �   �   $  �    �   �  �  *  �   �  r  D  �   �  Z"  S  �   }"  F$  |    h$  &  �    '&  �'  �    (  �+  �  '  �+  #-  �  2  C-  4  �  O  54  6  2  X  .6  :  J  e  .:  y;  m  m  �;  �;  |  o  �;  �<  �  v  #=  s>  �  }  �>  B@  �  �  j@  �B  �  �  �B  :D  �  �  aD  �E  �  �  �E  �F  �  �  �F  }G     )   =?                        grid      grid      macgrid     �DeleteMark = .F.
GridLines = 0
HeaderHeight = 16
Height = 200
HighlightRow = .T.
RecordMark = .F.
ScrollBars = 2
Width = 320
highlightentirerow = .T.
grdcurrow = 1
highlightcolor = 8454143
defaultheaderclass = MacHeader
defaultheaderclassdefinition = macbase.prg
builder = Macgrid Builder
sortedbackcolor = 65535
highlightforecolor = 0
registryname = 
registryapp = 
Name = "macgrid"
     +�PROCEDURE sethighlightrow
IF THIS.highlightentirerow
	THIS.SETALL("DynamicBackColor","IIF(this.grdcurrow = RECNO(this.recordsource), this.highlightcolor, this.backcolor)","Column")
	IF !EMPTY(THIS.HighlightForeColor)
		oColumn.DynamicForeColor = "IIF(this.grdcurrow = RECNO(this.recordsource), THIS.HighlightForeColor, THIS.ForeColor)"
	ENDIF

	FOR EACH oColumn IN THIS.COLUMNS

		FOR EACH oControl IN oColumn.Controls
			* Check to see if that control has a BackColor property, and if it does, change it to match the grid's highlight color.
			IF UPPER(oControl.BaseClass) <> "HEADER"
				IF PEMSTATUS(oControl, "BackColor", 5)
					oControl.BACKCOLOR = THIS.HighlightColor
				ENDIF
				IF PEMSTATUS(oControl, "ForeColor", 5)
					oControl.FORECOLOR = THIS.HighlightForeColor
				ENDIF
			ENDIF
		ENDFOR
	ENDFOR
ENDIF

ENDPROC
PROCEDURE setwidth
TotalColWidth = 0

FOR i = 1 TO THIS.COLUMNCOUNT
	TotalColWidth = TotalColWidth + THIS.COLUMNS(i).WIDTH
ENDFOR

DeleteMarkWidth = IIF(THIS.DELETEMARK, 8,0)
RecordMarkWidth = IIF(THIS.RECORDMARK, 10, 0)
ScrollBarWidth = IIF(THIS.SCROLLBARS > 1, SYSMETRIC(7), 0)
TotalGridLineWidth = THIS.COLUMNCOUNT * THIS.GRIDLINEWIDTH
NewGridWidth = TotalColWidth + DeleteMarkWidth + RecordMarkWidth + ScrollBarWidth + TotalGridLineWidth + 2

IF NewGridWidth < THIS.originalwidth
	THIS.WIDTH = NewGridWidth
	IF THIS.SCROLLBARS > 0
		THIS.ScrollBars = 2     && If columns don't go beyond grid size, we don't need a horizontal scrollbar
	ENDIF
ENDIF

ENDPROC
PROCEDURE copyprop
LPARA o1, o2

* Copy all property values from one object to another
IF TYPE('o1.Name') <> "C" OR TYPE('o2.Name') <> "C"
	RETURN .F.
ENDIF

lnPropertyCount = AMEMBERS(aProps, o1)

FOR i = 1 TO lnPropertyCount
	IF !ALLTRIM(UPPER(aProps(i)))$"CLASS:PARENTCLASS:BASECLASS:NAME"
		uVal = GETPEM(o1,aProps(i)) && Value of property in source
		IF PEMSTATUS(o2,aProps(i),5) && Does property exist in the second object?
			IF !PEMSTATUS(o2,aProps(i),1) && Is the property readonly?
				IF !PEMSTATUS(o2,aProps(i),2) && Is the property protected?
					o2.WriteExpression(aProps(i), uVal)
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDFOR

ENDPROC
PROCEDURE commonheaderclick
LPARA toHeader

ENDPROC
PROCEDURE commonheaderdblclick
LPARA toHeader

ENDPROC
PROCEDURE setsorttags
IF !EMPTY(THIS.RecordSource) AND THIS.RecordSourceType = 1 && Alias
	lnSelect = SELECT()
	SELECT (THIS.RecordSource)
	lcTag = TAG()
	lnBufferMode = CURSORGETPROP("Buffering")
	CURSORSETPROP("Buffering", 3)
	* CreateIndexTags is an empty method. It can be filled out at the instance level to 
	* create indexes to be used for grid sorting.
	THIS.CreateIndexTags()
	CURSORSETPROP("Buffering", lnBufferMode)
	SET ORDER TO lcTAG
	* Create an array and fill it with the names of all tags on the
	* recordsource table or view, and all the index expressions
	IF TAGCOUNT() > 0
		DIMENSION latags(TAGCOUNT(),2)
		FOR i = 1 TO TAGCOUNT()
			* Store the name of the tag
			laTags[i,1] = LOWER(TAG(i))
			* Store the expression
			laTags[i,2] = UPPER(SYS(14, i))
		ENDFOR
	ENDIF


		FOR EACH oColumn IN THIS.Columns
			* We can only do this if the column has a control source, and there are 
			* one or more indexes on the grid's recordsource
			IF !EMPTY(oColumn.ControlSource) AND TYPE('laTags[1,1]') = "C"
				* If the alias is included in the controlsource, parse out the field name
				* otherwise just use the controlsource
				IF "."$oColumn.ControlSource
					lcSourceField = LOWER(RIGHT(oColumn.ControlSource, LEN(oColumn.ControlSource) - RAT(".",oColumn.ControlSource)))
				ELSE
					lcSourceField = LOWER(oColumn.ControlSource)
				ENDIF

				* Search the tags array for a tag with the same name as the controlsource for this column
				* If there is one, set the header's SortTag property to that tag.
				IF ASCAN(laTags, ALLTRIM(lcSourceField), 1) > 0
					oColumn.header1.SetSortTag(lcSourceField)
*					oColumn.Header1.FontBold = .T.
				ENDIF

			ENDIF
		ENDFOR
	
	SELE (lnSelect)
ENDIF


ENDPROC
PROCEDURE setbackgroundcolor
LPARA tnBackGroundColor
IF !EMPTY(tnBackGroundColor)
	lnNewBackColor = tnBackGroundColor
ELSE
	lnNewBackColor = GETCOLOR()
ENDIF

IF TYPE("lnNewBackColor") = "N"
	THIS.BackColor = lnNewBackColor
ENDIF

ENDPROC
PROCEDURE sethighlightcolor
lnNewHighlightColor = GETCOLOR()
IF TYPE("lnNewHighlightColor") = "N"
	THIS.HighlightColor = lnNewHighlightColor
ENDIF

THIS.SethighlightRow()

ENDPROC
PROCEDURE restorecolumnwidths
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase ADDI
	THISFORM.AddObject("Registry1","Registry")
ELSE
	oRegistry = THISFORM.Registry1
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF

IF EMPTY(THIS.RegistryName)
	THIS.RegistryName = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name + "\" + THIS.RegistryName + "\" + "ColumnWidths"

DIMENSION laColumnsWidths(THIS.ColumnCount)
FOR i = 1 TO THIS.ColumnCount
	lnWidth = THISFORM.Registry1.GetNumValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , ALLTRIM(STR(i)), -1)
	IF lnWidth > 0 	
		THIS.Columns(i).Width = lnWidth
	ENDIF
ENDFOR

ENDPROC
PROCEDURE savecolumnwidths
IF TYPE('THISFORM.Registry1.Name') = "C"
	oRegistry = THISFORM.Registry1
ELSE
	SET CLASSLIB TO MacBase
	oRegistry = CREATEOBJECT("Registry")
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name + "\" + THIS.RegistryName + "\" + "ColumnWidths"

DIMENSION laColumnsWidths(THIS.ColumnCount)
FOR i = 1 TO THIS.ColumnCount
	oRegistry.SetNumValue(oRegistry.hkey_current_user, lcRegistryLocation , ALLTRIM(STR(i)), THIS.Columns(i).Width)
ENDFOR
ENDPROC
PROCEDURE commonheaderrightclick
LPARA toHeader

ENDPROC
PROCEDURE installcustomheader
IF !EMPTY(THIS.DefaultHeaderClass)
	IF !EMPTY(THIS.DefaultHeaderClassDefinition) 
		SET PROCEDURE TO (THIS.DefaultHeaderClassDefinition) ADDITIVE
	ENDIF
	FOR EACH oColumn IN THIS.Columns
		lcHeaderCaption = oColumn.Header1.Caption
		lcHeaderForeColor = oColumn.Header1.ForeColor
		* Remove the default header object, and replace it with one from
		* the class specified in the grid's properties.
		oColumn.RemoveObject('Header1')
		oColumn.AddObject('Header1',THIS.DefaultHeaderClass)
		oColumn.Header1.Caption = lcHeaderCaption
		oColumn.Header1.ForeColor = lcHeaderForeColor
	ENDFOR
ENDIF


ENDPROC
PROCEDURE setreadonly
LPARA tlReadOnly

THIS.ReadOnly = tlReadOnly

* If we are setting Readonly, set all columns to readonly.
* If we are enabling columns, only enable the ones that were 
* enabled when the grid ws instanciated.
IF tlReadOnly
	THIS.SetAll("ReadOnly",.T.,"Column")
ELSE
	FOR i = 1 TO THIS.ColumnCount
		IF !THIS.aColReadOnly[i]
			THIS.Columns[i].ReadOnly = .F.
		ENDIF
	ENDFOR
ENDIF

ENDPROC
PROCEDURE currentcolumn_access
LOCAL loColumn

FOR EACH loColumn IN THIS.Columns
	IF loColumn.ColumnOrder = THIS.ActiveColumn
		THIS.CurrentColumn = loColumn
		EXIT
	ENDIF
ENDFOR

RETURN THIS.CurrentColumn

ENDPROC
PROCEDURE BeforeRowColChange
LPARAMETERS nColIndex

WITH THIS
	IF MDOWN()
		lnBottom		= .TOP+.HEADERHEIGHT+.RELATIVEROW * .ROWHEIGHT
		lnTop		= lnBottom - THIS.ROWHEIGHT
		lnMouseRowPos	= MROW(WONTOP(),3)
		lnMouseColPos	= MCOL(WONTOP(),3)
		llChangingRow	= !(BETWEEN(lnMouseRowPos,lnTop, lnBottom) ;
			AND BETWEEN(lnMouseColPos,.LEFT,.LEFT+.WIDTH))
	ELSE
		llChangingRow	= INLIST(LASTKEY(),24,5,18,3,145,148)
	ENDIF
ENDWITH


IF llChangingRow
	THIS.BeforeRowChange()
ELSE
	THIS.BeforeColChange()
ENDIF

ENDPROC
PROCEDURE Destroy
IF THIS.RememberColumnWidths
	THIS.SaveColumnWidths()
ENDIF

ENDPROC
PROCEDURE Resize
IF THIS.ResizeWithBottom
	THIS.Height = THISFORM.Height - (THIS.DistanceToFormBottom + THIS.Top)
ENDIF

IF THIS.ResizeWithRight
	THIS.Width = THISFORM.Width - (THIS.DistanceToFormRight + THIS.Left)
ENDIF

IF THIS.ResizeColumns = .T.
	FOR i = 1 TO THIS.ColumnCount
			* How wide was the column originally in proportion to the whole grid?
			lnOriginalProportion = THIS.aColumnWidths[i] / THIS.OriginalWidth
			* Resize the column to the same proportion
			THIS.Columns(i).Width = lnOriginalProportion * THIS.Width
	ENDFOR
ENDIF

IF TYPE("THIS.Parent.shp" + THIS.Name) = "O" 
	oShape = EVAL("THIS.Parent.shp" + THIS.Name)
	IF !ISNULL(oShape)
		oShape.Width = THIS.Width
		oShape.Height = THIS.Height
	ENDIF
ENDIF

ENDPROC
PROCEDURE Refresh
THIS.AfterRowColChange()

ENDPROC
PROCEDURE Init
THIS.OriginalHeight = THIS.Height
THIS.OriginalWidth = THIS.Width

THIS.DistancetoFormBottom = THISFORM.Height - (THIS.Top + THIS.Height)
THIS.DistancetoFormRight = THISFORM.Width - (THIS.Left + THIS.Width)

*****************************************************
IF THIS.ReadOnly
	THIS.SETALL('readonly', .T.,"Column")
ENDIF
THIS.SetHighlightRow()
THIS.InstallCustomHeader()
THIS.SetSortTags()

* The shape object sits behind the grid to make the "see through" grid properties invisible
* This is an attempt to make a grid that should not highlight it's rows more aesthetic
THIS.Parent.Addobject("shp" + THIS.Name, "Shape")
oShape = EVAL("THIS.Parent.shp" + THIS.Name)
oShape.top = THIS.Top
oShape.Left = THIS.Left
oShape.height = THIS.Height
oShape.Width = THIS.Width
oShape.FillStyle = 0 && Solid
oShape.BorderStyle = 0
oShape.FillColor = THIS.HighlightColor
oShape.ZOrder(1)
oShape.Visible = .T.

IF THIS.ColumnCount > 0
	* Store the original column widths in a grid property, so their proportionality can be used later
	* to resize the columns when the grid is resized.
	DIMENSION THIS.aColumnWidths(THIS.ColumnCount)
	FOR i = 1 TO THIS.ColumnCount
		THIS.aColumnWidths[i] = THIS.Columns(i).Width
	ENDFOR

	* Store the initial value of each column's ReadOnly property to be used when 
	* Setting or removing the grid's readonly status
	DIMENSION THIS.aColReadOnly(THIS.ColumnCount)
	FOR i = 1 TO THIS.ColumnCount
		THIS.aColReadOnly[i] = THIS.Columns(i).ReadOnly
	ENDFOR
ENDIF


IF THIS.RememberColumnWidths
	THIS.RestoreColumnWidths()
ENDIF

IF .F.
	* fool the compiler to have the header definition file included with the project
	DO macbase.prg
ENDIF

ENDPROC
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex
IF !EMPTY(THIS.RecordSource)
	THIS.grdCurRow = RECNO(THIS.RecordSource)
ENDIF
THIS.Refresh()

ENDPROC
PROCEDURE RightClick
DEFINE POPUP Gridoptions SHORTCUT RELATIVE FROM MROW(),MCOL()
DEFINE BAR 1 OF Gridoptions PROMPT "Set background color"
DEFINE BAR 2 OF Gridoptions PROMPT "Set Highlight color"
ON SELECTION BAR 1 OF Gridoptions _SCREEN.ActiveForm.ActiveControl.SetBackGroundColor()
ON SELECTION BAR 2 OF Gridoptions _SCREEN.ActiveForm.ActiveControl.SetHighlightColor()
ACTIVATE POPUP GridOptions

ENDPROC
     !����    �!  �!                        ��   %   >      V     2          �  U  � %��  � ���� ��C� DynamicBackColor�S IIF(this.grdcurrow = RECNO(this.recordsource), this.highlightcolor, this.backcolor)� Column�  � �� %�C�  � �
��	�g T� � ��W IIF(this.grdcurrow = RECNO(this.recordsource), THIS.HighlightForeColor, THIS.ForeColor)�� � �� �  � ��� �� � � ��� %�C� �	 f� HEADER���� %�C� �	 BackColor��h��� T� �
 ��  � �� � %�C� �	 ForeColor��h���� T� � ��  � �� � � �� �� � U  THIS HIGHLIGHTENTIREROW SETALL HIGHLIGHTFORECOLOR OCOLUMN DYNAMICFORECOLOR COLUMNS OCONTROL CONTROLS	 BASECLASS	 BACKCOLOR HIGHLIGHTCOLOR	 FORECOLOR3 T�  �� �� �� ���(�� � ��C � T�  ��  C � � � � �� �� T� �C� � � �� � 6�� T� �C� �	 � �
� � 6��% T�
 �C� � ��	 C��%� � 6�� T� �� � � � ��! T� ��  � � �
 � ��� %�� � � ��,� T� � �� �� %�� � � ��(� T� � ���� � � U  TOTALCOLWIDTH I THIS COLUMNCOUNT COLUMNS WIDTH DELETEMARKWIDTH
 DELETEMARK RECORDMARKWIDTH
 RECORDMARK SCROLLBARWIDTH
 SCROLLBARS TOTALGRIDLINEWIDTH GRIDLINEWIDTH NEWGRIDWIDTH ORIGINALWIDTHH ��  � �0 %�C� o1.Nameb� C� C� o2.Nameb� C��B � B�-�� � T� �C�� �  �b�� �� ���(�� ��A�; %�CCC � � f��  CLASS:PARENTCLASS:BASECLASS:NAME
��=� T� �C�  C � � �!�� %�C� C � � ��h��9� %�C� C � � ��h
��5� %�C� C � � ��h
��1� ��CC � �  � � � �� � � � � �� U  O1 O2 LNPROPERTYCOUNT APROPS I UVAL WRITEEXPRESSION
  ��  � U  TOHEADER
  ��  � U  TOHEADER! %�C�  � �
� �  � �	��� T� �CW�� F��  � �� T� �C��� T� �C�	 Buffering��� ��C�	 Buffering���� ��C�  � �� ��C�	 Buffering� ��� G((� lcTAG� %�C�V� ��&� � �C�V����� �� ���(�C�V��"� T� �� �����CC� �@��  T� �� �����CC�� ]f�� �� � ��	 �  �
 ���, %�C�	 � �
� C� laTags[1,1]b� C	���� %�� .�	 � ����) T� �CC�	 � C�	 � >C� .�	 � �R@�� ��� T� �C�	 � @�� � %�C�� C� ���� ���� ��C � �	 � � �� � � ��
 F�� �� � U  THIS RECORDSOURCE RECORDSOURCETYPE LNSELECT LCTAG LNBUFFERMODE CREATEINDEXTAGS LATAGS I OCOLUMN COLUMNS CONTROLSOURCE LCSOURCEFIELD HEADER1
 SETSORTTAGv  ��  � %�C�  �
��$ � T� ��  �� �9 � T� �C��� �" %�C� lnNewBackColorb� N��o � T� � �� �� � U  TNBACKGROUNDCOLOR LNNEWBACKCOLOR THIS	 BACKCOLORX  T�  �C���' %�C� lnNewHighlightColorb� N��D � T� � ��  �� � ��C� � �� U  LNNEWHIGHLIGHTCOLOR THIS HIGHLIGHTCOLOR SETHIGHLIGHTROW�, %�C� THISFORM.Registry1.Nameb� C
��a � G~(� MacBase�$ ��C�	 Registry1� Registry� � �� �y � T� �� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���	� T� � �� � �� �B T�	 �� � � Forms\� � � \� � � \� ColumnWidths�� �
 �� � �� �� ���(�� � ����, T� �C� � �  �	 CC� Z����� � � �� %�� � ���� T� � �� �� �� �� � �� U  MACBASE THISFORM	 ADDOBJECT	 OREGISTRY	 REGISTRY1 THIS REGISTRYAPP REGISTRYNAME NAME LCREGISTRYLOCATION LACOLUMNSWIDTHS COLUMNCOUNT I LNWIDTH GETNUMVALUE HKEY_CURRENT_USER COLUMNS WIDTH+ %�C� THISFORM.Registry1.Nameb� C��; � T�  �� � �� �k � G~(� MacBase� T�  �C� Registry�N�� �B T� �� � � Forms\� � � \� � � \� ColumnWidths�� �	 �� �
 �� �� ���(�� �
 ���, ��C�  �  � CC� Z�C � � � � �  � �� �� U 	 OREGISTRY THISFORM	 REGISTRY1 MACBASE LCREGISTRYLOCATION THIS REGISTRYAPP NAME REGISTRYNAME LACOLUMNSWIDTHS COLUMNCOUNT I SETNUMVALUE HKEY_CURRENT_USER COLUMNS WIDTH
  ��  � U  TOHEADER�  %�C�  � �
��� � %�C�  � �
��6 � G+(��  � �� � �� �  � �� � T� �� � � �� T� �� � �	 �� ��C� Header1� �
 �� ��C� Header1�  � � � �� T� � � �� �� T� � �	 �� �� �� � U  THIS DEFAULTHEADERCLASS DEFAULTHEADERCLASSDEFINITION OCOLUMN COLUMNS LCHEADERCAPTION HEADER1 CAPTION LCHEADERFORECOLOR	 FORECOLOR REMOVEOBJECT	 ADDOBJECT�  ��  � T� � ��  �� %��  ��F �" ��C� ReadOnlya� Column� � �� �� � �� ���(�� � ��� � %�C � � � 
��� � T� � �� �� �-�� � �� � U 
 TLREADONLY THIS READONLY SETALL I COLUMNCOUNT ACOLREADONLY COLUMNS[  ��  � ��  � � �H � %��  � � � ��D � T� � ��  �� !� � �� B�� � �� U  LOCOLUMN THIS COLUMNS COLUMNORDER ACTIVECOLUMN CURRENTCOLUMN ��  � ��� ��� � %�C���� � T� ��� �� �� �� �� T� �� � � �� T� �CC����� T�	 �CC�����- T�
 �C� � � �� C�	 �� �� �� �	
�� �� �  T�
 �CC|����������� � �� %��
 ��� � ��C� � �� �� � ��C� � �� � U 	 NCOLINDEX THIS LNBOTTOM TOP HEADERHEIGHT RELATIVEROW	 ROWHEIGHT LNTOP LNMOUSEROWPOS LNMOUSECOLPOS LLCHANGINGROW LEFT WIDTH BEFOREROWCHANGE BEFORECOLCHANGE$  %��  � �� � ��C�  � �� � U  THIS REMEMBERCOLUMNWIDTHS SAVECOLUMNWIDTHSl %��  � ��2 �" T�  � �� � �  � �  � �� � %��  � ��h �" T�  � �� � �  � �  �	 �� � %��  �
 a��� � �� ���(��  � ��� � T� �C � �  � �  � ��  T�  � �� �� �� �  � �� �� �* %�C� THIS.Parent.shp�  � b� O��e�% T� �C� THIS.Parent.shp�  � ��� %�C� �
��a� T� � ��  � �� T� � ��  � �� � � U  THIS RESIZEWITHBOTTOM HEIGHT THISFORM DISTANCETOFORMBOTTOM TOP RESIZEWITHRIGHT WIDTH DISTANCETOFORMRIGHT LEFT RESIZECOLUMNS I COLUMNCOUNT LNORIGINALPROPORTION ACOLUMNWIDTHS ORIGINALWIDTH COLUMNS NAME OSHAPE  ��C�  � �� U  THIS AFTERROWCOLCHANGE� T�  � ��  � �� T�  � ��  � ��" T�  � �� � �  � �  � ��" T�  � �� � �  �	 �  � �� %��  �
 ��� �" ��C� readonlya� Column�  � �� � ��C�  � �� ��C�  � �� ��C�  � ��% ��C� shp�  � � Shape�  � � ��% T� �C� THIS.Parent.shp�  � ��� T� � ��  � �� T� �	 ��  �	 �� T� � ��  � �� T� � ��  � �� T� � �� �� T� � �� �� T� � ��  � �� ��C�� � �� T� � �a�� %��  � � ��f� �  � ��  � �� �� ���(��  � ���! T�  � �� ��C � �  � � �� �� �  � ��  � �� �� ���(��  � ��b�! T�  � �� ��C � �  � �
 �� �� � %��  � ���� ��C�  � �� � %�-���� � macbase.prg� � U"  THIS ORIGINALHEIGHT HEIGHT ORIGINALWIDTH WIDTH DISTANCETOFORMBOTTOM THISFORM TOP DISTANCETOFORMRIGHT LEFT READONLY SETALL SETHIGHLIGHTROW INSTALLCUSTOMHEADER SETSORTTAGS PARENT	 ADDOBJECT NAME OSHAPE	 FILLSTYLE BORDERSTYLE	 FILLCOLOR HIGHLIGHTCOLOR ZORDER VISIBLE COLUMNCOUNT ACOLUMNWIDTHS I COLUMNS ACOLREADONLY REMEMBERCOLUMNWIDTHS RESTORECOLUMNWIDTHS MACBASE PRGC  ��  � %�C� � �
��/ � T� � �C� � O�� � ��C� � �� U 	 NCOLINDEX THIS RECORDSOURCE	 GRDCURROW REFRESH�  s��  �C���C���W�( s�����  "�� Set background color��' s�����  "�� Set Highlight color��G 1������  �5 _SCREEN.ActiveForm.ActiveControl.SetBackGroundColor()�F 1������  �4 _SCREEN.ActiveForm.ActiveControl.SetHighlightColor()� t��  � U  GRIDOPTIONS sethighlightrow,     �� setwidth�    �� copyprop�    �� commonheaderclick$    �� commonheaderdblclick<    �� setsorttagsT    �� setbackgroundcolor	    �� sethighlightcolor�	    �� restorecolumnwidthsV
    �� savecolumnwidths�    �� commonheaderrightclick�    �� installcustomheader�    �� setreadonly[    �� currentcolumn_accessN    �� BeforeRowColChange�    �� Destroy�    �� Resize�    �� RefreshK    �� Initx    �� AfterRowColChange�    ��
 RightClick2    ��1 �1qA ""��1A �1A A A A A 3 � ��A ��QqBAA A 3 � q A Rr������A A A A A 3 q 3 q 3 � � � ��� �� 1q�A A #�S�� !A �AB B A � A 4 q � � � A "A 3 � qA � 3 �A� A "�1� C A A "1A "���A A 3 �� �A "��A 3 q 3 11A !11s�11A A 4 q � !� �aqA A A 3 q "qA A A � 3 q � � �A�� A A � � � � A 3 � A 3 !A !A "��A A �Q11A A 3 � 3 11"!!A � � � TQ11111� B3�A 4�A A � A � "A 3 q 1QA � 3 A�qqa� 2                       J        i  �     $     �  .   6   �  �  F   8   �  	  J   :   (	  �  N   Y   "  �  �   c     �  �   i   �  t  �   �   �  p  �   �   �  �  �   �   �  7  �   �   Y  �  �   �     �  �   �   �  �     �   �  >    �   [  :"    �   X"  r"  9  �   �"  ;)  =    c)  �)  u    �)  }+  }   )   �!                       �highlightentirerow Specifies whether to highlight entire row when user clicks on a celll
grdcurrow Stores current row of grid. Used for highlighting the back row.
highlightcolor Holds color to highlight row when user clicks on cell
originalwidth Used by set width. Set in grid init.
originalheight Stores height of grid at init. Used for resize operations.
distancetoformbottom
distancetoformright
resizewithright Set to .T. if the grid should stretch when the form is resized horizontally.
resizewithbottom Set to .T. if the grid should stretch when the form is resized vertically.
resizecolumns Set to .T. if the columns should resize proportianally when the grid is resized.
defaultheaderclass
defaultheaderclassdefinition File that holds the custom header class definition specified in THIS.DefaultHeaderClass
builder
sortedbackcolor Color to be used for header background when the grid is sorted by that column.
highlightforecolor Color to change the current rows fore color. This property is ignored if THIS.HighlightEntireRow is false.
registryname The name this grid should use for its registry setttings. Defaults to grid.name
registryapp The name of the app to store this control's registry setting under. If empty, the control attempts to get the value from the same property of the form.
remembercolumnwidths Set to .T. if the grid should save and restore its column widths to the registry
currentcolumn returns a reference to the column with the focus.
*sethighlightrow Adds characteristic of highlighting the entire row when a user clicks on a cell. 
*setwidth Reduces the grid's width to the sum of the columns' widths. takes into account scrollbars, deletemark,  and recordmark.
*reposition Usually called from form.resize, causes the grid to resize itself in proportion to form size.
^acolumnwidths[1,0] Used internally to resize columns when the grid is resized.
*copyprop Receives 2 object as parameters and copies all of the property values from the first one to the second one.
*commonheaderclick Called from the click method of each header in the grid. Receives the header object as a parameter.
*commonheaderdblclick Called from the dblclick method of each header in the grid. Receives the header object as a parameter.
*createindextags A hooked method to be used at the instance level to create any index tags to be used for sorting.
*setsorttags Replaces factory header with subclassed header and assigns that header's sort tag property
*setbackgroundcolor 
*sethighlightcolor 
*restorecolumnwidths Retreives the grid's column widths from the registry and sets the columns to that width.
*savecolumnwidths Stores the grid's columns widths to the registry so they can be restored next time.
*commonheaderrightclick 
*commoncontrolclick 
*commoncontroldblclick 
*commoncontrolrightclick 
*commoncontrolkeypress 
*installcustomheader 
^acolreadonly[1,0] Stores the initial value of each column's ReadOnly property.
*setreadonly Takes a logical parameter to set each column's readonly property to that value. If the parameter is .F., the method skips any column that was originally readonly (using THIS.aColReadOnly
*beforerowchange Called only before Row is changed
*beforecolchange Called only before Column changes.
*getactivecolumn 
*currentcolumn_access 
      macgrid      grid      1      Class      Pixels      macgrid      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      grid      grid      macgrid     �DeleteMark = .F.
GridLines = 0
HeaderHeight = 16
Height = 200
HighlightRow = .T.
RecordMark = .F.
ScrollBars = 2
Width = 320
highlightentirerow = .T.
grdcurrow = 1
highlightcolor = 8454143
defaultheaderclass = MacHeader
defaultheaderclassdefinition = macbase.prg
builder = Macgrid Builder
sortedbackcolor = 65535
highlightforecolor = 0
registryname = 
registryapp = 
Name = "macgrid"
     -+PROCEDURE sethighlightrow
IF THIS.highlightentirerow
	THIS.SETALL("DynamicBackColor","IIF(this.grdcurrow = RECNO(this.recordsource), this.highlightcolor, this.backcolor)","Column")
	IF !EMPTY(THIS.HighlightForeColor)
		oColumn.DynamicForeColor = "IIF(this.grdcurrow = RECNO(this.recordsource), THIS.HighlightForeColor, THIS.ForeColor)"
	ENDIF

	FOR EACH oColumn IN THIS.COLUMNS

		FOR EACH oControl IN oColumn.Controls
			* Check to see if that control has a BackColor property, and if it does, change it to match the grid's highlight color.
			IF UPPER(oControl.BaseClass) <> "HEADER"
				IF PEMSTATUS(oControl, "BackColor", 5)
					oControl.BACKCOLOR = THIS.HighlightColor
				ENDIF
				IF PEMSTATUS(oControl, "ForeColor", 5)
					oControl.FORECOLOR = THIS.HighlightForeColor
				ENDIF
			ENDIF
		ENDFOR
	ENDFOR
ENDIF

ENDPROC
PROCEDURE setwidth
TotalColWidth = 0

FOR i = 1 TO THIS.COLUMNCOUNT
	TotalColWidth = TotalColWidth + THIS.COLUMNS(i).WIDTH
ENDFOR

DeleteMarkWidth = IIF(THIS.DELETEMARK, 8,0)
RecordMarkWidth = IIF(THIS.RECORDMARK, 10, 0)
ScrollBarWidth = IIF(THIS.SCROLLBARS > 1, SYSMETRIC(7), 0)
TotalGridLineWidth = THIS.COLUMNCOUNT * THIS.GRIDLINEWIDTH
NewGridWidth = TotalColWidth + DeleteMarkWidth + RecordMarkWidth + ScrollBarWidth + TotalGridLineWidth + 2

IF NewGridWidth < THIS.originalwidth
	THIS.WIDTH = NewGridWidth
	IF THIS.SCROLLBARS > 0
		THIS.ScrollBars = 2     && If columns don't go beyond grid size, we don't need a horizontal scrollbar
	ENDIF
ENDIF

ENDPROC
PROCEDURE copyprop
LPARA o1, o2

* Copy all property values from one object to another
IF TYPE('o1.Name') <> "C" OR TYPE('o2.Name') <> "C"
	RETURN .F.
ENDIF

lnPropertyCount = AMEMBERS(aProps, o1)

FOR i = 1 TO lnPropertyCount
	IF !ALLTRIM(UPPER(aProps(i)))$"CLASS:PARENTCLASS:BASECLASS:NAME"
		uVal = GETPEM(o1,aProps(i)) && Value of property in source
		IF PEMSTATUS(o2,aProps(i),5) && Does property exist in the second object?
			IF !PEMSTATUS(o2,aProps(i),1) && Is the property readonly?
				IF !PEMSTATUS(o2,aProps(i),2) && Is the property protected?
					o2.WriteExpression(aProps(i), uVal)
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDFOR

ENDPROC
PROCEDURE commonheaderclick
LPARA toHeader

ENDPROC
PROCEDURE commonheaderdblclick
LPARA toHeader

ENDPROC
PROCEDURE setsorttags
IF !EMPTY(THIS.RecordSource) AND THIS.RecordSourceType = 1 && Alias
	lnSelect = SELECT()
	SELECT (THIS.RecordSource)
	lcTag = TAG()
	lnBufferMode = CURSORGETPROP("Buffering")
	CURSORSETPROP("Buffering", 3)
	* CreateIndexTags is an empty method. It can be filled out at the instance level to 
	* create indexes to be used for grid sorting.
	THIS.CreateIndexTags()
	CURSORSETPROP("Buffering", lnBufferMode)
	SET ORDER TO lcTAG
	* Create an array and fill it with the names of all tags on the
	* recordsource table or view, and all the index expressions
	IF TAGCOUNT() > 0
		DIMENSION latags(TAGCOUNT(),2)
		FOR i = 1 TO TAGCOUNT()
			* Store the name of the tag
			laTags[i,1] = LOWER(TAG(i))
			* Store the expression
			laTags[i,2] = UPPER(SYS(14, i))
		ENDFOR
	ENDIF


		FOR EACH oColumn IN THIS.Columns
			* We can only do this if the column has a control source, and there are 
			* one or more indexes on the grid's recordsource
			IF !EMPTY(oColumn.ControlSource) AND TYPE('laTags[1,1]') = "C"
				* If the alias is included in the controlsource, parse out the field name
				* otherwise just use the controlsource
				IF "."$oColumn.ControlSource
					lcSourceField = LOWER(RIGHT(oColumn.ControlSource, LEN(oColumn.ControlSource) - RAT(".",oColumn.ControlSource)))
				ELSE
					lcSourceField = LOWER(oColumn.ControlSource)
				ENDIF

				* Search the tags array for a tag with the same name as the controlsource for this column
				* If there is one, set the header's SortTag property to that tag.
				IF ASCAN(laTags, ALLTRIM(lcSourceField), 1) > 0
					oColumn.header1.SetSortTag(lcSourceField)
*					oColumn.Header1.FontBold = .T.
				ENDIF

			ENDIF
		ENDFOR
	
	SELE (lnSelect)
ENDIF


ENDPROC
PROCEDURE setbackgroundcolor
LPARA tnBackGroundColor
IF !EMPTY(tnBackGroundColor)
	lnNewBackColor = tnBackGroundColor
ELSE
	lnNewBackColor = GETCOLOR()
ENDIF

IF TYPE("lnNewBackColor") = "N"
	THIS.BackColor = lnNewBackColor
ENDIF

ENDPROC
PROCEDURE sethighlightcolor
lnNewHighlightColor = GETCOLOR()
IF TYPE("lnNewHighlightColor") = "N"
	THIS.HighlightColor = lnNewHighlightColor
ENDIF

THIS.SethighlightRow()

ENDPROC
PROCEDURE restorecolumnwidths
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase ADDI
	THISFORM.AddObject("Registry1","Registry")
ELSE
	oRegistry = THISFORM.Registry1
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF

IF EMPTY(THIS.RegistryName)
	THIS.RegistryName = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name + "\" + THIS.RegistryName + "\" + "ColumnWidths"

DIMENSION laColumnsWidths(THIS.ColumnCount)
FOR i = 1 TO THIS.ColumnCount
	lnWidth = THISFORM.Registry1.GetNumValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , ALLTRIM(STR(i)), -1)
	IF lnWidth > 0 	
		THIS.Columns(i).Width = lnWidth
	ENDIF
ENDFOR

ENDPROC
PROCEDURE savecolumnwidths
IF TYPE('THISFORM.Registry1.Name') = "C"
	oRegistry = THISFORM.Registry1
ELSE
	SET CLASSLIB TO MacBase
	oRegistry = CREATEOBJECT("Registry")
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name + "\" + THIS.RegistryName + "\" + "ColumnWidths"

DIMENSION laColumnsWidths(THIS.ColumnCount)
FOR i = 1 TO THIS.ColumnCount
	oRegistry.SetNumValue(oRegistry.hkey_current_user, lcRegistryLocation , ALLTRIM(STR(i)), THIS.Columns(i).Width)
ENDFOR
ENDPROC
PROCEDURE commonheaderrightclick
LPARA toHeader

ENDPROC
PROCEDURE installcustomheader
IF !EMPTY(THIS.DefaultHeaderClass)
	IF !EMPTY(THIS.DefaultHeaderClassDefinition) 
		SET PROCEDURE TO (THIS.DefaultHeaderClassDefinition) ADDITIVE
	ENDIF
	FOR EACH oColumn IN THIS.Columns
		lcHeaderCaption = oColumn.Header1.Caption
		lcHeaderForeColor = oColumn.Header1.ForeColor
		* Remove the default header object, and replace it with one from
		* the class specified in the grid's properties.
		oColumn.RemoveObject('Header1')
		oColumn.AddObject('Header1',THIS.DefaultHeaderClass)
		oColumn.Header1.Caption = lcHeaderCaption
		oColumn.Header1.ForeColor = lcHeaderForeColor
	ENDFOR
ENDIF


ENDPROC
PROCEDURE setreadonly
LPARA tlReadOnly

THIS.ReadOnly = tlReadOnly

* If we are setting Readonly, set all columns to readonly.
* If we are enabling columns, only enable the ones that were 
* enabled when the grid ws instanciated.
IF tlReadOnly
	THIS.SetAll("ReadOnly",.T.,"Column")
ELSE
	FOR i = 1 TO THIS.ColumnCount
		IF !THIS.aColReadOnly[i]
			THIS.Columns[i].ReadOnly = .F.
		ENDIF
	ENDFOR
ENDIF

ENDPROC
PROCEDURE currentcolumn_access
LOCAL loColumn

FOR EACH loColumn IN THIS.Columns
	IF loColumn.ColumnOrder = THIS.ActiveColumn
		THIS.CurrentColumn = loColumn
		EXIT
	ENDIF
ENDFOR

RETURN THIS.CurrentColumn

ENDPROC
PROCEDURE RightClick
DEFINE POPUP Gridoptions SHORTCUT RELATIVE FROM MROW(),MCOL()
DEFINE BAR 1 OF Gridoptions PROMPT "Set background color"
DEFINE BAR 2 OF Gridoptions PROMPT "Set Highlight color"
ON SELECTION BAR 1 OF Gridoptions _SCREEN.ActiveForm.ActiveControl.SetBackGroundColor()
ON SELECTION BAR 2 OF Gridoptions _SCREEN.ActiveForm.ActiveControl.SetHighlightColor()
ACTIVATE POPUP GridOptions

ENDPROC
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex
IF !EMPTY(THIS.RecordSource)
	THIS.grdCurRow = RECNO(THIS.RecordSource)
ENDIF
THIS.Refresh()

ENDPROC
PROCEDURE Init
THIS.OriginalHeight = THIS.Height
THIS.OriginalWidth = THIS.Width

THIS.DistancetoFormBottom = THISFORM.Height - (THIS.Top + THIS.Height)
THIS.DistancetoFormRight = THISFORM.Width - (THIS.Left + THIS.Width)

*****************************************************
IF THIS.ReadOnly
	THIS.SETALL('readonly', .T.,"Column")
ENDIF
THIS.SetHighlightRow()
THIS.InstallCustomHeader()
THIS.SetSortTags()

* The shape object sits behind the grid to make the "see through" grid properties invisible
* This is an attempt to make a grid that should not highlight it's rows more aesthetic
THIS.Parent.Addobject("shp" + THIS.Name, "Shape")
oShape = EVAL("THIS.Parent.shp" + THIS.Name)
oShape.top = THIS.Top
oShape.Left = THIS.Left
oShape.height = THIS.Height
oShape.Width = THIS.Width
oShape.FillStyle = 0 && Solid
oShape.BorderStyle = 0
oShape.FillColor = THIS.HighlightColor
oShape.ZOrder(1)
oShape.Visible = .T.

IF THIS.ColumnCount > 0
	* Store the original column widths in a grid property, so their proportionality can be used later
	* to resize the columns when the grid is resized.
	DIMENSION THIS.aColumnWidths(THIS.ColumnCount)
	FOR i = 1 TO THIS.ColumnCount
		THIS.aColumnWidths[i] = THIS.Columns(i).Width
	ENDFOR

	* Store the initial value of each column's ReadOnly property to be used when 
	* Setting or removing the grid's readonly status
	DIMENSION THIS.aColReadOnly(THIS.ColumnCount)
	FOR i = 1 TO THIS.ColumnCount
		THIS.aColReadOnly[i] = THIS.Columns(i).ReadOnly
	ENDFOR
	
	* Store the value of each column's controlsource property, so it can be 
	* restored from THIS.RestoreControlSources()
	DIMENSION THIS.aControlSources(THIS.ColumnCount)
	FOR i = 1 TO THIS.ColumnCount
		THIS.aControlSources[i] = THIS.Columns(i).ControlSource
	ENDFOR

ENDIF


IF THIS.RememberColumnWidths
	THIS.RestoreColumnWidths()
ENDIF

IF .F.
	* fool the compiler to have the header definition file included with the project
	DO macbase.prg
ENDIF

ENDPROC
PROCEDURE Refresh
THIS.AfterRowColChange()

ENDPROC
PROCEDURE Resize
IF THIS.ResizeWithBottom
	THIS.Height = THISFORM.Height - (THIS.DistanceToFormBottom + THIS.Top)
ENDIF

IF THIS.ResizeWithRight
	THIS.Width = THISFORM.Width - (THIS.DistanceToFormRight + THIS.Left)
ENDIF

IF THIS.ResizeColumns = .T.
	FOR i = 1 TO THIS.ColumnCount
			* How wide was the column originally in proportion to the whole grid?
			lnOriginalProportion = THIS.aColumnWidths[i] / THIS.OriginalWidth
			* Resize the column to the same proportion
			THIS.Columns(i).Width = lnOriginalProportion * THIS.Width
	ENDFOR
ENDIF

IF TYPE("THIS.Parent.shp" + THIS.Name) = "O" 
	oShape = EVAL("THIS.Parent.shp" + THIS.Name)
	IF !ISNULL(oShape)
		oShape.Width = THIS.Width
		oShape.Height = THIS.Height
	ENDIF
ENDIF

ENDPROC
PROCEDURE Destroy
IF THIS.RememberColumnWidths
	THIS.SaveColumnWidths()
ENDIF

ENDPROC
PROCEDURE BeforeRowColChange
LPARAMETERS nColIndex

WITH THIS
	IF MDOWN()
		lnBottom		= .TOP+.HEADERHEIGHT+.RELATIVEROW * .ROWHEIGHT
		lnTop		= lnBottom - THIS.ROWHEIGHT
		lnMouseRowPos	= MROW(WONTOP(),3)
		lnMouseColPos	= MCOL(WONTOP(),3)
		llChangingRow	= !(BETWEEN(lnMouseRowPos,lnTop, lnBottom) ;
			AND BETWEEN(lnMouseColPos,.LEFT,.LEFT+.WIDTH))
	ELSE
		llChangingRow	= INLIST(LASTKEY(),24,5,18,3,145,148)
	ENDIF
ENDWITH


IF llChangingRow
	THIS.BeforeRowChange()
ELSE
	THIS.BeforeColChange()
ENDIF

ENDPROC
PROCEDURE restorecontrolsources
FOR i = 1 TO THIS.ColumnCount
	THIS.Columns(i).ControlSource = THIS.aControlSources[i]
ENDFOR

ENDPROC
     #.���    #  #                        ]6   %   5      |!    H          �  U  � %��  � ���� ��C� DynamicBackColor�S IIF(this.grdcurrow = RECNO(this.recordsource), this.highlightcolor, this.backcolor)� Column�  � �� %�C�  � �
��	�g T� � ��W IIF(this.grdcurrow = RECNO(this.recordsource), THIS.HighlightForeColor, THIS.ForeColor)�� � �� �  � ��� �� � � ��� %�C� �	 f� HEADER���� %�C� �	 BackColor��h��� T� �
 ��  � �� � %�C� �	 ForeColor��h���� T� � ��  � �� � � �� �� � U  THIS HIGHLIGHTENTIREROW SETALL HIGHLIGHTFORECOLOR OCOLUMN DYNAMICFORECOLOR COLUMNS OCONTROL CONTROLS	 BASECLASS	 BACKCOLOR HIGHLIGHTCOLOR	 FORECOLOR3 T�  �� �� �� ���(�� � ��C � T�  ��  C � � � � �� �� T� �C� � � �� � 6�� T� �C� �	 � �
� � 6��% T�
 �C� � ��	 C��%� � 6�� T� �� � � � ��! T� ��  � � �
 � ��� %�� � � ��,� T� � �� �� %�� � � ��(� T� � ���� � � U  TOTALCOLWIDTH I THIS COLUMNCOUNT COLUMNS WIDTH DELETEMARKWIDTH
 DELETEMARK RECORDMARKWIDTH
 RECORDMARK SCROLLBARWIDTH
 SCROLLBARS TOTALGRIDLINEWIDTH GRIDLINEWIDTH NEWGRIDWIDTH ORIGINALWIDTHH ��  � �0 %�C� o1.Nameb� C� C� o2.Nameb� C��B � B�-�� � T� �C�� �  �b�� �� ���(�� ��A�; %�CCC � � f��  CLASS:PARENTCLASS:BASECLASS:NAME
��=� T� �C�  C � � �!�� %�C� C � � ��h��9� %�C� C � � ��h
��5� %�C� C � � ��h
��1� ��CC � �  � � � �� � � � � �� U  O1 O2 LNPROPERTYCOUNT APROPS I UVAL WRITEEXPRESSION
  ��  � U  TOHEADER
  ��  � U  TOHEADER! %�C�  � �
� �  � �	��� T� �CW�� F��  � �� T� �C��� T� �C�	 Buffering��� ��C�	 Buffering���� ��C�  � �� ��C�	 Buffering� ��� G((� lcTAG� %�C�V� ��&� � �C�V����� �� ���(�C�V��"� T� �� �����CC� �@��  T� �� �����CC�� ]f�� �� � ��	 �  �
 ���, %�C�	 � �
� C� laTags[1,1]b� C	���� %�� .�	 � ����) T� �CC�	 � C�	 � >C� .�	 � �R@�� ��� T� �C�	 � @�� � %�C�� C� ���� ���� ��C � �	 � � �� � � ��
 F�� �� � U  THIS RECORDSOURCE RECORDSOURCETYPE LNSELECT LCTAG LNBUFFERMODE CREATEINDEXTAGS LATAGS I OCOLUMN COLUMNS CONTROLSOURCE LCSOURCEFIELD HEADER1
 SETSORTTAGv  ��  � %�C�  �
��$ � T� ��  �� �9 � T� �C��� �" %�C� lnNewBackColorb� N��o � T� � �� �� � U  TNBACKGROUNDCOLOR LNNEWBACKCOLOR THIS	 BACKCOLORX  T�  �C���' %�C� lnNewHighlightColorb� N��D � T� � ��  �� � ��C� � �� U  LNNEWHIGHLIGHTCOLOR THIS HIGHLIGHTCOLOR SETHIGHLIGHTROW�, %�C� THISFORM.Registry1.Nameb� C
��a � G~(� MacBase�$ ��C�	 Registry1� Registry� � �� �y � T� �� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���	� T� � �� � �� �B T�	 �� � � Forms\� � � \� � � \� ColumnWidths�� �
 �� � �� �� ���(�� � ����, T� �C� � �  �	 CC� Z����� � � �� %�� � ���� T� � �� �� �� �� � �� U  MACBASE THISFORM	 ADDOBJECT	 OREGISTRY	 REGISTRY1 THIS REGISTRYAPP REGISTRYNAME NAME LCREGISTRYLOCATION LACOLUMNSWIDTHS COLUMNCOUNT I LNWIDTH GETNUMVALUE HKEY_CURRENT_USER COLUMNS WIDTH+ %�C� THISFORM.Registry1.Nameb� C��; � T�  �� � �� �k � G~(� MacBase� T�  �C� Registry�N�� �B T� �� � � Forms\� � � \� � � \� ColumnWidths�� �	 �� �
 �� �� ���(�� �
 ���, ��C�  �  � CC� Z�C � � � � �  � �� �� U 	 OREGISTRY THISFORM	 REGISTRY1 MACBASE LCREGISTRYLOCATION THIS REGISTRYAPP NAME REGISTRYNAME LACOLUMNSWIDTHS COLUMNCOUNT I SETNUMVALUE HKEY_CURRENT_USER COLUMNS WIDTH
  ��  � U  TOHEADER�  %�C�  � �
��� � %�C�  � �
��6 � G+(��  � �� � �� �  � �� � T� �� � � �� T� �� � �	 �� ��C� Header1� �
 �� ��C� Header1�  � � � �� T� � � �� �� T� � �	 �� �� �� � U  THIS DEFAULTHEADERCLASS DEFAULTHEADERCLASSDEFINITION OCOLUMN COLUMNS LCHEADERCAPTION HEADER1 CAPTION LCHEADERFORECOLOR	 FORECOLOR REMOVEOBJECT	 ADDOBJECT�  ��  � T� � ��  �� %��  ��F �" ��C� ReadOnlya� Column� � �� �� � �� ���(�� � ��� � %�C � � � 
��� � T� � �� �� �-�� � �� � U 
 TLREADONLY THIS READONLY SETALL I COLUMNCOUNT ACOLREADONLY COLUMNS[  ��  � ��  � � �H � %��  � � � ��D � T� � ��  �� !� � �� B�� � �� U  LOCOLUMN THIS COLUMNS COLUMNORDER ACTIVECOLUMN CURRENTCOLUMN�  s��  �C���C���W�( s�����  "�� Set background color��' s�����  "�� Set Highlight color��G 1������  �5 _SCREEN.ActiveForm.ActiveControl.SetBackGroundColor()�F 1������  �4 _SCREEN.ActiveForm.ActiveControl.SetHighlightColor()� t��  � U  GRIDOPTIONSC  ��  � %�C� � �
��/ � T� � �C� � O�� � ��C� � �� U 	 NCOLINDEX THIS RECORDSOURCE	 GRDCURROW REFRESH T�  � ��  � �� T�  � ��  � ��" T�  � �� � �  � �  � ��" T�  � �� � �  �	 �  � �� %��  �
 ��� �" ��C� readonlya� Column�  � �� � ��C�  � �� ��C�  � �� ��C�  � ��% ��C� shp�  � � Shape�  � � ��% T� �C� THIS.Parent.shp�  � ��� T� � ��  � �� T� �	 ��  �	 �� T� � ��  � �� T� � ��  � �� T� � �� �� T� � �� �� T� � ��  � �� ��C�� � �� T� � �a�� %��  � � ���� �  � ��  � �� �� ���(��  � ���! T�  � �� ��C � �  � � �� �� �  � ��  � �� �� ���(��  � ��b�! T�  � �� ��C � �  � �
 �� �� �  � ��  � �� �� ���(��  � ����! T�  � �� ��C � �  � � �� �� � %��  �  ���� ��C�  �! �� � %�-���� � macbase.prg� � U$  THIS ORIGINALHEIGHT HEIGHT ORIGINALWIDTH WIDTH DISTANCETOFORMBOTTOM THISFORM TOP DISTANCETOFORMRIGHT LEFT READONLY SETALL SETHIGHLIGHTROW INSTALLCUSTOMHEADER SETSORTTAGS PARENT	 ADDOBJECT NAME OSHAPE	 FILLSTYLE BORDERSTYLE	 FILLCOLOR HIGHLIGHTCOLOR ZORDER VISIBLE COLUMNCOUNT ACOLUMNWIDTHS I COLUMNS ACOLREADONLY ACONTROLSOURCES CONTROLSOURCE REMEMBERCOLUMNWIDTHS RESTORECOLUMNWIDTHS MACBASE PRG  ��C�  � �� U  THIS AFTERROWCOLCHANGEl %��  � ��2 �" T�  � �� � �  � �  � �� � %��  � ��h �" T�  � �� � �  � �  �	 �� � %��  �
 a��� � �� ���(��  � ��� � T� �C � �  � �  � ��  T�  � �� �� �� �  � �� �� �* %�C� THIS.Parent.shp�  � b� O��e�% T� �C� THIS.Parent.shp�  � ��� %�C� �
��a� T� � ��  � �� T� � ��  � �� � � U  THIS RESIZEWITHBOTTOM HEIGHT THISFORM DISTANCETOFORMBOTTOM TOP RESIZEWITHRIGHT WIDTH DISTANCETOFORMRIGHT LEFT RESIZECOLUMNS I COLUMNCOUNT LNORIGINALPROPORTION ACOLUMNWIDTHS ORIGINALWIDTH COLUMNS NAME OSHAPE$  %��  � �� � ��C�  � �� � U  THIS REMEMBERCOLUMNWIDTHS SAVECOLUMNWIDTHS ��  � ��� ��� � %�C���� � T� ��� �� �� �� �� T� �� � � �� T� �CC����� T�	 �CC�����- T�
 �C� � � �� C�	 �� �� �� �	
�� �� �  T�
 �CC|����������� � �� %��
 ��� � ��C� � �� �� � ��C� � �� � U 	 NCOLINDEX THIS LNBOTTOM TOP HEADERHEIGHT RELATIVEROW	 ROWHEIGHT LNTOP LNMOUSEROWPOS LNMOUSECOLPOS LLCHANGINGROW LEFT WIDTH BEFOREROWCHANGE BEFORECOLCHANGEB  ��  ���(�� � ��; �! T� � ��  �� �C �  � � �� �� U  I THIS COLUMNCOUNT COLUMNS CONTROLSOURCE ACONTROLSOURCES sethighlightrow,     �� setwidth�    �� copyprop�    �� commonheaderclick$    �� commonheaderdblclick<    �� setsorttagsT    �� setbackgroundcolor	    �� sethighlightcolor�	    �� restorecolumnwidthsV
    �� savecolumnwidths�    �� commonheaderrightclick�    �� installcustomheader�    �� setreadonly[    �� currentcolumn_accessN    ��
 RightClick�    �� AfterRowColChange�    �� Initv    �� Refresh(    �� ResizeU    �� Destroy�    �� BeforeRowColChange�    �� restorecontrolsources�    ��1 �1qA ""��1A �1A A A A A 3 � ��A ��QqBAA A 3 � q A Rr������A A A A A 3 q 3 q 3 � � � ��� �� 1q�A A #�S�� !A �AB B A � A 4 q � � � A "A 3 � qA � 3 �A� A "�1� C A A "1A "���A A 3 �� �A "��A 3 q 3 11A !11s�11A A 4 q � !� �aqA A A 3 q "qA A A � 3 A�qqa� 3 q 1QA � 3 11"!!A � � � TQ11111� B3�A 4�A 4�A B � A � "A 3 � 3 !A !A "��A A �Q11A A 3 � A 3 q � � �A�� A A � � � � A 3 �A 2                       J        i  �     $     �  .   6   �  �  F   8   �  	  J   :   (	  �  N   Y   "  �  �   c     �  �   i   �  t  �   �   �  p  �   �   �  �  �   �   �  7  �   �   Y  �  �   �     �  �   �   �  j     �   �  
  	  �   %  �&    �   '  !'  Q  �   >'  *  U     ;*  z*  p    �*  �,  v    �,   -  �   )   #                       �highlightentirerow Specifies whether to highlight entire row when user clicks on a celll
grdcurrow Stores current row of grid. Used for highlighting the back row.
highlightcolor Holds color to highlight row when user clicks on cell
originalwidth Used by set width. Set in grid init.
originalheight Stores height of grid at init. Used for resize operations.
distancetoformbottom
distancetoformright
resizewithright Set to .T. if the grid should stretch when the form is resized horizontally.
resizewithbottom Set to .T. if the grid should stretch when the form is resized vertically.
resizecolumns Set to .T. if the columns should resize proportianally when the grid is resized.
defaultheaderclass
defaultheaderclassdefinition File that holds the custom header class definition specified in THIS.DefaultHeaderClass
builder
sortedbackcolor Color to be used for header background when the grid is sorted by that column.
highlightforecolor Color to change the current rows fore color. This property is ignored if THIS.HighlightEntireRow is false.
registryname The name this grid should use for its registry setttings. Defaults to grid.name
registryapp The name of the app to store this control's registry setting under. If empty, the control attempts to get the value from the same property of the form.
remembercolumnwidths Set to .T. if the grid should save and restore its column widths to the registry
currentcolumn returns a reference to the column with the focus.
*sethighlightrow Adds characteristic of highlighting the entire row when a user clicks on a cell. 
*setwidth Reduces the grid's width to the sum of the columns' widths. takes into account scrollbars, deletemark,  and recordmark.
*reposition Usually called from form.resize, causes the grid to resize itself in proportion to form size.
^acolumnwidths[1,0] Used internally to resize columns when the grid is resized.
*copyprop Receives 2 object as parameters and copies all of the property values from the first one to the second one.
*commonheaderclick Called from the click method of each header in the grid. Receives the header object as a parameter.
*commonheaderdblclick Called from the dblclick method of each header in the grid. Receives the header object as a parameter.
*createindextags A hooked method to be used at the instance level to create any index tags to be used for sorting.
*setsorttags Replaces factory header with subclassed header and assigns that header's sort tag property
*setbackgroundcolor 
*sethighlightcolor 
*restorecolumnwidths Retreives the grid's column widths from the registry and sets the columns to that width.
*savecolumnwidths Stores the grid's columns widths to the registry so they can be restored next time.
*commonheaderrightclick 
*commoncontrolclick 
*commoncontroldblclick 
*commoncontrolrightclick 
*commoncontrolkeypress 
*installcustomheader 
^acolreadonly[1,0] Stores the initial value of each column's ReadOnly property.
*setreadonly Takes a logical parameter to set each column's readonly property to that value. If the parameter is .F., the method skips any column that was originally readonly (using THIS.aColReadOnly
*beforerowchange Called only before Row is changed
*beforecolchange Called only before Column changes.
*getactivecolumn 
*currentcolumn_access 
^acontrolsources[1,0] 
*restorecontrolsources Restores the controlsource for each column from the value stored in THIS.aControlSources at grid.init.
      macgrid      grid      1      Class      Pixels      macgrid      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
    %           �     �  op�(y   �_ s��  �C���C���W�Q s��9���  "�� \<Undo���! Undoes the last command or action�� CTRL+Z��  ��e s��<���  "�� Cu\<t���6 Removes the selection and places it onto the Clipboard�� CTRL+X��  ��W s��=���  "�� \<Copy���' Copies the selection onto the Clipboard�� CTRL+C��  ��U s��>���  "�� \<Paste���$ Pastes the contents of the Clipboard�� CTRL+V��  ��^ s��@���  "�� Cle\<ar���> Removes the selection and does not place it onto the Clipboard�� s�����  "�� \-��j s��G���  "�� Se\<lect All���/ Selects all text or items in the current window�� CTRL+A�� Ctrl+A�� t��  � U  SHORTCUT�ASsS�a�� 1                   %   �  9  �  0   R  :rT'�   �  U    ��C �  �  � � � �� U  THIS PARENT COMMONHEADERDBLCLICK  ��C �  �  � � � �� U  THIS PARENT COMMONHEADERRIGHTCLICK� ��C �  �  � � � ��& %�C�  � �
� C�  � � � �
	���� T� � �a�� T� �CW�� F��  � � � �� T� �CO�� %�CC�@�  � ��� � G((��  � �� �� � %�C�U��� � G((��  � ��� �� � G((��  � �<� � � ��	 �  � � �
 �� ��C�	 BackColor�	 � � �� �� T�  � ��  � � � ��
 F�� �� ��C�  � � � �� %�� � ��h�
 -#�� �� � ��C�  � � � �� T� � �-�� � U  THIS PARENT COMMONHEADERCLICK SORTTAG RECORDSOURCE THISFORM
 LOCKSCREEN LNSELECT LNRECNO OCOLUMN COLUMNS HEADER1 RESETTODEFAULT	 BACKCOLOR SORTEDBACKCOLOR AFTERROWCOLCHANGE REFRESHY  ��  �& %�C�	 tcSortTagb� C� C�  ���4 � B�-�� � T� � ��  �� T� � �a�� U 	 TCSORTTAG THIS SORTTAG FONTBOLD DblClick,      
 RightClickn       Click�      
 SetSortTag     C  T�  ��  �� T� �a��
 ��    �
 ��    �
 ��    �
 ��    � U  SORTTAG STRETCHWITHGRID	 MACHeader Header�    8 q3 q3 qb� � 1� R� � � � A A ��A �� 2� A 1� A 3 q aq A � 3 � � � � � 0� 9                      ?        c  �        �  �     !     �  4   (   "   �     BMB      v   (               �   �  �                �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   BMB      v   (               �   �  �                �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   BMB      v   (               �   �  �                �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   BMB      v   (               �   �  �                �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   ���������   BM&      6  (                                         �  �   �� �   � � ��  ��� ��� �Ȥ                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ��� ��� ���   �  �   �� �   � � ��  ���             ���������  ���������  ���������  ���������  ���������  ���������  ���������  ���������  ������     ������ �  ������          BM�       v   (               x                     �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ������������������������������������������������������������������������������������������������������������BM�       v   (               x                     �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���        ������       ��������� �������� ������������� ��������������������p����� ������������� �0 	   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _S4V0Q1UQY 657282632�B  U  �2  C      AU      �C  q          �B  �B   C          �B               COMMENT RESERVED                        �B      �B                                                           WINDOWS _S4Z0T63PJ 657282643);  �B  sB  <;      !B      �;  �          ;   ;  T;          �               COMMENT RESERVED                        �      �:                                                           WINDOWS _S820QVQCT 657282735{  �  �  �      �      �2   
          e  r  Z          W               COMMENT RESERVED                        A                                                                 WINDOWS _S4V0NJRW3 659442698:'  �U  r2  L'      $2      �)            D  Q  `'          �               COMMENT RESERVED                        �      '                                                            U�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      registryoption      Pixels      Class      1      macoptiongroup      registryoption      optiongroup      macbase.vcx      registrytext      Pixels      registrycheckbox     ���    �  �                        �   %   �        ;   	          �  U  �, %�C� THISFORM.Registry1.Nameb� C
��` � G~(� MacBase�$ ��C�	 Registry1� Registry� � �� �x � T� �� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� T� � �� � �� �! T�	 �� � � Forms\� � �� H�:��� �C�
 THIS.Valueb� C����* T�
 �C� � �  �	 � � �  � � � �� �C�
 THIS.Valueb� N����* T�
 �C� � �  �	 � � � � � � �� � %�C�
 �
���� T� � ��
 �� � U  MACBASE THISFORM	 ADDOBJECT	 OREGISTRY	 REGISTRY1 THIS REGISTRYAPP REGISTRYKEY NAME LCREGISTRYLOCATION LUVALUE GETSTRINGVALUE HKEY_CURRENT_USER GETNUMVALUE VALUE�, %�C� THISFORM.Registry1.Nameb� C
��T � G~(� MacBase� T� �C� Registry�N�� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� � T� � �� � �� �! T� �� � � Forms\� � �� H���� �C�
 THIS.Valueb� C��Y�% ��C� �	  � � � C� �
 �� � �� �C�
 THIS.Valueb� N����# ��C� �	  � � � � �
 � � �� � U  MACBASE	 OREGISTRY THIS REGISTRYAPP THISFORM REGISTRYKEY NAME LCREGISTRYLOCATION SETSTRINGVALUE HKEY_CURRENT_USER VALUE SETNUMVALUE9 % %��  � � C|�� �  � 	��2 � ��C�  � �� � U  THIS SETVALUEONDESTROY SAVEONCANCEL SETVALUE- 	 ��C��� %��  � ��& � ��C�  � �� � U  THIS GETVALUEONINIT GETVALUE getvalue,     �� setvalue�    �� Destroy    �� Initu    ��1 �A� A "�1� C A A "1A � ����A A 3 ��A "�1� C A A $1A � �Q�1A 3 Q� A 3 � � A 2                       �        	  c  %   2   �  �  E   6   �  :  K    )   �                       ���                              �K   %   �      �  <             �  U  �, %�C� THISFORM.Registry1.Nameb� C
��` � G~(� MacBase�$ ��C�	 Registry1� Registry� � �� �x � T� �� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� T� � �� � �� �! T�	 �� � � Forms\� � �� H�:��� �C�
 THIS.Valueb� C����* T�
 �C� � �  �	 � � �  � � � �� �C�
 THIS.Valueb� N����* T�
 �C� � �  �	 � � � � � � �� � %�C�
 �
���� T� � ��
 �� � U  MACBASE THISFORM	 ADDOBJECT	 OREGISTRY	 REGISTRY1 THIS REGISTRYAPP REGISTRYKEY NAME LCREGISTRYLOCATION LUVALUE GETSTRINGVALUE HKEY_CURRENT_USER GETNUMVALUE VALUE�, %�C� THISFORM.Registry1.Nameb� C
��T � G~(� MacBase� T� �C� Registry�N�� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� � T� � �� � �� �! T� �� � � Forms\� � �� H���� �C�
 THIS.Valueb� C��Y�% ��C� �	  � � � C� �
 �� � �� �C�
 THIS.Valueb� N����# ��C� �	  � � � � �
 � � �� � U  MACBASE	 OREGISTRY THIS REGISTRYAPP THISFORM REGISTRYKEY NAME LCREGISTRYLOCATION SETSTRINGVALUE HKEY_CURRENT_USER VALUE SETNUMVALUE- 	 ��C��� %��  � ��& � ��C�  � �� � U  THIS GETVALUEONINIT GETVALUEB 	 ��C���% %��  � � C|�� �  � 	��; � ��C�  � �� � U  THIS SETVALUEONDESTROY SAVEONCANCEL SETVALUE getvalue,     �� setvalue�    �� Init    �� DestroyX    ��1 �A� A "�1� C A A "1A � ����A A 3 ��A "�1� C A A $1A � �Q�1A 3 � � A 3 � Q� A 2                       �        	  c  %   2   ~  �  E   7   �  F  L    )                           Class      1      cgetvalueoninit
setvalueondestroy
registrykey
registryapp
saveoncancel
*getvalue 
*setvalue 
      �Height = 84
Width = 143
getvalueoninit = .T.
setvalueondestroy = .T.
Name = "registryoption"
Option1.Left = 5
Option1.Top = 5
Option1.Name = "Option1"
Option2.Left = 5
Option2.Top = 22
Option2.Name = "Option2"
      Pixels     ����    �  �                        �p   %   �        .   �          �  U  C, %�C� THISFORM.Registry1.Nameb� C
��` � G~(� MacBase�$ ��C�	 Registry1� Registry� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� � T� � �� � �� �! T� �� � � Forms\� � ��+ T� � �C� �	 �  � � � -� �	 �
 �� U  MACBASE THISFORM	 ADDOBJECT THIS REGISTRYAPP REGISTRYKEY NAME LCREGISTRYLOCATION VALUE	 REGISTRY1 GETBOOLEANVALUE HKEY_CURRENT_USERG, %�C� THISFORM.Registry1.Nameb� C
��T � G~(� MacBase� T� �C� Registry�N�� �l � T� �� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� � T� � �� � �� �! T� �� � � Forms\� � ��# ��C� �
  � � � � � � �	 �� U  MACBASE	 OREGISTRY THISFORM	 REGISTRY1 THIS REGISTRYAPP REGISTRYKEY NAME LCREGISTRYLOCATION SETBOOLEANVALUE HKEY_CURRENT_USER VALUE- 	 ��C��� %��  � ��& � ��C�  � �� � U  THIS GETVALUEONINIT GETVALUE.  %��  � � C|�	��' � ��C�  � �� � U  THIS SETVALUEONDESTROY SETVALUE getvalue,     �� setvalue    �� Init�    �� Destroy+    ��1 �AA "�1� C A A "1A �3 ��� A "�1� C A A $1A 23 � � A 3 �� A 2                       �        �  �     %   �  �  7   *     ]  >    )   �                       ����                              ��   %   2      �  �   �          �  U  �, %�C� THISFORM.Registry1.Nameb� C
��` � G~(� MacBase�$ ��C�	 Registry1� Registry� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� � T� � �� � �� �! T� �� � � Forms\� � �� H�"��� �C�
 THIS.Valueb� C��j�* T� �C� �	 �  � � � �  � �	 �
 �� �C�
 THIS.Valueb� N����* T� �C� �	 �  � � � � � �	 � �� � %�C� �
���� T� � �� �� � U  MACBASE THISFORM	 ADDOBJECT THIS REGISTRYAPP REGISTRYKEY NAME LCREGISTRYLOCATION LUVALUE	 REGISTRY1 GETSTRINGVALUE HKEY_CURRENT_USER GETNUMVALUE DISPLAYVALUE�, %�C� THISFORM.Registry1.Nameb� C
��T � G~(� MacBase� T� �C� Registry�N�� �l � T� �� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� � T� � �� � �� �! T� �� � � Forms\� � �� H�.��� �C�
 THIS.Valueb� C��q�% ��C� �
  � � � C� � �� �	 �� �C�
 THIS.Valueb� N����# ��C� �
  � � � � � � � �� � U  MACBASE	 OREGISTRY THISFORM	 REGISTRY1 THIS REGISTRYAPP REGISTRYKEY NAME LCREGISTRYLOCATION SETSTRINGVALUE HKEY_CURRENT_USER DISPLAYVALUE SETNUMVALUE� ��  �, %�C� THISFORM.Registry1.Nameb� C
��g � G~(� MacBase�$ ��C�	 Registry1� Registry� � �� � T� �� � �� %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� T� � �� �	 �� �! T�
 �� � � Forms\� �	 ��! ��  �� � �(������������, T� �C� �  �
 � � CC�  Z��  � � �� %�C� �
���� ��C � �� � �� � �� U  I MACBASE THISFORM	 ADDOBJECT	 OREGISTRY	 REGISTRY1 THIS REGISTRYAPP REGISTRYKEY NAME LCREGISTRYLOCATION MAXLISTCOUNT LCVALUE GETSTRINGVALUE HKEY_CURRENT_USER ADDITEM� ��  �, %�C� THISFORM.Registry1.Nameb� C
��[ � G~(� MacBase� T� �C� Registry�N�� �s � T� �� � �� � %�C� � ���� �. %�C� � RegistryApp��h�
 C� � �
	��� � T� � �� � �� �� � B� � � %�C� � ���� T� � �� � �� �! T�	 �� � � Forms\� � ��+ T�
 �C� � � � �	 � � � � � 6�� ��  ���(��
 ���� %�CC �  � � �
����2 ��C� �  �	 � � CC�  Z�CC �  � � �� � �� � �� U  I MACBASE	 OREGISTRY THISFORM	 REGISTRY1 THIS REGISTRYAPP REGISTRYKEY NAME LCREGISTRYLOCATION	 LNCOUNTER	 LISTCOUNT MAXLISTCOUNT LIST SETSTRINGVALUE HKEY_CURRENT_USER� 	 ��C��� T�  �-�� �� ���(�� � ��a �  %�C� � �CC � � � ���] � T�  �a�� !� � �� %��  
� CC� � ��
	��� � ��C� � �� � �� � U  LLITEMFOUND I THIS	 LISTCOUNT DISPLAYVALUE LISTITEM ADDITEM� 	 ��C��� T�  �-�� �� ���(�� � ��a �  %�C� � �CC � � � ���] � T�  �a�� !� � �� %��  
� CC� � ��
	��� � ��C� � �� � �� � U  LLITEMFOUND I THIS	 LISTCOUNT DISPLAYVALUE LISTITEM ADDITEM  ��C�  � �� ��C�  � �� U  THIS SETVALUE SETLIST& 	 ��C��� ��C�  � �� ��C�  � �� U  THIS GETLIST GETVALUE getvalue,     �� setvalue�    �� getlist    �� setlistu    �� ProgrammaticChange�	    �� Valid�
    �� Destroy�    �� Init�    ��1 �AA "�1� C A A "1A � ����A A 3 ��� A "�1� C A A #1A � �Q�1A 3 q �AA "�1� C A A "1A �AA A 4 q ��� A "�1� C A A $1A �r�!A A 3 � � �� A A A �aA 3 � � �� A A A �aA 3 � � 2 � � � 1                       �        �  v  #   2   �  �
  D   J   �
  t  g   c   �  �  �   o   �  �  �   {   �    �   ~   /  [  �    )                           !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      
mactextbox      registrytext     oregistrykey The name of the key in the registry to store this textbox's value in.
registryapp The name and registry path of the application that this textbox's data should be stored in. If left empty, the box attempts to get this value from the form's property.
getvalueoninit
setvalueondestroy
saveoncancel Determines if the control writes its value to the registry even if the cancel key waas pressed.
*getvalue Gets the value for the box from the registry using the RegistryApp and RegistryKey values. Called from init.
*setvalue Sets the specified key in he registry to the textbox's value. Called from Destroy.
     EPROCEDURE getvalue
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	THISFORM.AddObject("Registry1","Registry")
ELSE
	oRegistry = THISFORM.Registry1
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF

IF EMPTY(THIS.Registrykey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name

DO CASE
	CASE TYPE("THIS.Value") = "C"
		luValue = THISFORM.Registry1.GetStringValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, "")
	CASE TYPE("THIS.Value") = "N"
		luValue = THISFORM.Registry1.GetNumValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, 0)
ENDCASE

IF !EMPTY(luvalue) 
	THIS.value = luValue
ENDIF

ENDPROC
PROCEDURE setvalue
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	oRegistry = CREATEOBJECT("Registry")
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF



IF EMPTY(THIS.Registrykey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name

DO CASE
	CASE TYPE("THIS.Value") = "C"
		oRegistry.SetStringValue(oRegistry.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, ALLTRIM(THIS.Value))
	CASE TYPE("THIS.Value") = "N"
		oRegistry.SetNumValue(oRegistry.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, THIS.Value)
ENDCASE

ENDPROC
PROCEDURE Destroy
IF THIS.SetValueOnDestroy AND (LASTKEY() <> 27 OR THIS.SaveOnCancel)
	THIS.Setvalue()
ENDIF

ENDPROC
PROCEDURE Init
DODEFAULT()
IF THIS.GetvalueOnInit 
	THIS.GetValue()
ENDIF

ENDPROC
      Fgetvalueoninit = .T.
setvalueondestroy = .T.
Name = "registrytext"
      textbox      combobox     QPROCEDURE getvalue
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	THISFORM.AddObject("Registry1","Registry")
ELSE
	oRegistry = THISFORM.Registry1
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF

IF EMPTY(THIS.Registrykey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name

DO CASE
	CASE TYPE("THIS.Value") = "C"
		luValue = THISFORM.Registry1.GetStringValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, "")
	CASE TYPE("THIS.Value") = "N"
		luValue = THISFORM.Registry1.GetNumValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, 0)
ENDCASE

IF !EMPTY(luvalue) 
	THIS.value = luValue
ENDIF

ENDPROC
PROCEDURE setvalue
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	oRegistry = CREATEOBJECT("Registry")
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF



IF EMPTY(THIS.Registrykey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name

DO CASE
	CASE TYPE("THIS.Value") = "C"
		oRegistry.SetStringValue(oRegistry.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, ALLTRIM(THIS.Value))
	CASE TYPE("THIS.Value") = "N"
		oRegistry.SetNumValue(oRegistry.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, THIS.Value)
ENDCASE

ENDPROC
PROCEDURE Init
DODEFAULT()
IF THIS.GetvalueOnInit
	THIS.GetValue()
ENDIF

ENDPROC
PROCEDURE Destroy
DODEFAULT()
IF THIS.SetValueOnDestroy AND (LASTKEY() <> 27 OR THIS.SaveOnCancel)
	THIS.Setvalue()
ENDIF

ENDPROC
      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      Class      1      maccheckbox      registrycheckbox      Uregistryapp
registrykey
getvalueoninit
setvalueondestroy
*getvalue 
*setvalue 
     hPROCEDURE getvalue
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	THISFORM.AddObject("Registry1","Registry")
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF

IF EMPTY(THIS.Registrykey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name

THIS.Value = THISFORM.Registry1.GetBooleanValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, .F.)

ENDPROC
PROCEDURE setvalue
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	oRegistry = CREATEOBJECT("Registry")
ELSE
	oRegistry = THISFORM.Registry1
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF



IF EMPTY(THIS.Registrykey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name

oRegistry.SetBooleanValue(oRegistry.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, THIS.Value)
ENDPROC
PROCEDURE Init
DODEFAULT()
IF THIS.GetvalueOnInit
	THIS.GetValue()
ENDIF

ENDPROC
PROCEDURE Destroy
IF THIS.SetValueOnDestroy AND LASTKEY() <> 27 
	THIS.Setvalue()
ENDIF

ENDPROC
      Jgetvalueoninit = .T.
setvalueondestroy = .T.
Name = "registrycheckbox"
      checkbox      macbase.vcx      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      registrycombo      Pixels      Class      1      maccombobox      registrycombo      �registryapp
registrykey
maxlistcount The maximum number of list items the combo will save and retrieve from the registry.
*getvalue 
*setvalue 
*getlist 
*setlist 
     fPROCEDURE getvalue
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	THISFORM.AddObject("Registry1","Registry")
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF

IF EMPTY(THIS.Registrykey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name

DO CASE
	CASE TYPE("THIS.Value") = "C"
		luValue = THISFORM.Registry1.GetStringValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, "")
	CASE TYPE("THIS.Value") = "N"
		luValue = THISFORM.Registry1.GetNumValue(THISFORM.Registry1.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, 0)
ENDCASE

IF !EMPTY(luvalue) 
	THIS.DisplayValue = luValue
ENDIF

ENDPROC
PROCEDURE setvalue
IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	oRegistry = CREATEOBJECT("Registry")
ELSE
	oRegistry = THISFORM.Registry1
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF


IF EMPTY(THIS.Registrykey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name

DO CASE
	CASE TYPE("THIS.Value") = "C"
		oRegistry.SetStringValue(oRegistry.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, ALLTRIM(THIS.DisplayValue))
	CASE TYPE("THIS.Value") = "N"
		oRegistry.SetNumValue(oRegistry.hkey_current_user, lcRegistryLocation , THIS.RegistryKey, THIS.DisplayValue)
ENDCASE

ENDPROC
PROCEDURE getlist
LOCAL i

IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	THISFORM.AddObject("Registry1","Registry")
ENDIF

oRegistry = THISFORM.Registry1

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF

IF EMPTY(THIS.RegistryKey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name

FOR i = THIS.MaxListCount TO 1 STEP -1
	lcValue = oRegistry.GetStringValue(oRegistry.HKEY_CURRENT_USER, lcRegistryLocation, THIS.RegistryKey + ALLTRIM(STR(i)),"")
	IF !EMPTY(lcValue)
		THIS.Additem(lcValue, 1)
	ENDIF
ENDFOR


ENDPROC
PROCEDURE setlist
LOCAL i

IF !TYPE('THISFORM.Registry1.Name') = "C"
	SET CLASSLIB TO MacBase
	oRegistry = CREATEOBJECT("Registry")
ELSE
	oRegistry = THISFORM.Registry1
ENDIF

IF EMPTY(THIS.RegistryApp) 
	IF PEMSTATUS(THISFORM, "RegistryApp", 5) AND !EMPTY(THISFORM.RegistryApp)
		THIS.RegistryApp = THISFORM.RegistryApp
	ELSE
		* If the property was not filled out, and cannot be retrieved from the form, 
		* there is nothing more to do.
		RETURN
	ENDIF
ENDIF



IF EMPTY(THIS.Registrykey)
	THIS.RegistryKey = THIS.Name
ENDIF

lcRegistryLocation = THIS.RegistryApp + "Forms\" + THISFORM.Name


lnCounter = IIF(THIS.ListCount > THIS.MaxListCount, THIS.MaxListCount, THIS.ListCount)

FOR i = 1 TO lnCounter
	IF !EMPTY(THIS.List(i))
		oRegistry.SetStringValue(oRegistry.HKEY_CURRENT_USER, lcRegistryLocation, THIS.RegistryKey + ALLTRIM(STR(i)),ALLTRIM(THIS.List(i)))
	ENDIF
ENDFOR

ENDPROC
PROCEDURE ProgrammaticChange
DODEFAULT()
llItemFound = .F.

FOR i = 1 TO THIS.ListCount
	IF ALLTRIM(THIS.DisplayValue) == ALLTRIM(THIS.ListItem(i))
		llitemFound = .T.
		EXIT
	ENDIF
ENDFOR

IF !llItemFound AND !EMPTY(ALLTRIM(THIS.DisplayValue))
	THIS.AddItem(THIS.DisplayValue, 1)
ENDIF

ENDPROC
PROCEDURE Valid
DODEFAULT()
llItemFound = .F.

FOR i = 1 TO THIS.ListCount
	IF ALLTRIM(THIS.DisplayValue) == ALLTRIM(THIS.ListItem(i))
		llitemFound = .T.
		EXIT
	ENDIF
ENDFOR

IF !llItemFound AND !EMPTY(ALLTRIM(THIS.DisplayValue))
	THIS.AddItem(THIS.DisplayValue, 1)
ENDIF

ENDPROC
PROCEDURE Destroy
THIS.SetValue()
THIS.SetList()
ENDPROC
PROCEDURE Init
DODEFAULT()
THIS.GetList()
THIS.GetValue()
ENDPROC
      6Style = 0
maxlistcount = 10
Name = "registrycombo"
      macbase.vcx      macbase.vcx0 D   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _S0C0UCUU3 657282051H  �  �  7            �  �7          a  W              n               WINDOWS _REK10GEBH 653938119.  >  Q  ^  o  �                                                           WINDOWS RESERVED   653938119�  	   	  -	  >	  O	                                                           WINDOWS _REK10GYF0 629043736�	  �	  �	  
  
  #
                                                           WINDOWS RESERVED   629043736�
  �
  �
  �
  �
  �
                                                           WINDOWS _S0C0UCUZD 629046583N  f  y  �  �  �        I-                                               WINDOWS _S0C0ULUNY 653938119  -  @  M  ^  o                                                           WINDOWS _S0C0ULUOS 653938119�  �      #  4                                                           WINDOWS _S0C0ULUPC 629043737�  �  �  �  �                                                             WINDOWS _S0C0ULUQ6 629043737o  �  �  �  �  �                                                           COMMENT RESERVED                        |      �                                                           WINDOWS _S6B0OTT0O 657283139B  �@  S@  B      �      �B  �9          #B  7  �@          >               WINDOWS _S6B0OV4IW 657283139�@  i  |  �  �7  UB                                                           WINDOWS _S6B0OV4JG 653218906>  �=  �=  �=  �=  �A                                                           COMMENT RESERVED                        0B      �                                                           WINDOWS _S7N0K8EBU 657283148�=  BB  �  �=      �6      <  x,            %  �          �  �           WINDOWS _S7N0K8ECO 657283148/  '/  :/  �6  =@  �<      �<  K                                               WINDOWS _S7N0K8ED8 655510349�  ;=  &=     N=  d=                                                           COMMENT RESERVED                        �      �                                                           WINDOWS _S6B0WS45J 661614950�(   6  6  �(      h5      �/  DD          �(  �(  �(          �(               COMMENT RESERVED                        �(      j(                                                           WINDOWS _S6U0MLL9U 661803163y  Y(     �      (      .  �I          c  p  �          U               WINDOWS _S6U0MMI39 653548848�  �  �  q  ]  �      �  �+                                               WINDOWS _S6U0MMI4D 653548848�  �  �  r  ^  
                                                           WINDOWS _S6U0MMI4X 661803163�  �  �  �  �  L      �  �*                                               WINDOWS _S6U0MMI5H 653548848�  �  �  �  �  7                                                           WINDOWS _S6U0MMI6B 657283111'    �  �  �  r                                                           WINDOWS _S6U0MMI6V 653548848a  N  9  (    �                                                           WINDOWS _S6U0MMI89 653548848�  �  t  f  R                                                              WINDOWS _S8Y0OO7AT 660429430�  �  �  �  �  �                                                           COMMENT RESERVED                        A                                                                 WINDOWS _S6P0PAXUR 673469291  �    O/      .      #>  �          �  �  76          �               WINDOWS _S9Z0R2OH8 661285314r@  _@  w7  f7  �/  ]A      7  �                                               WINDOWS _0030WGJ3I 673469291�/  �/  �/  {/  e/  �@                                                           COMMENT RESERVED                        �      �                                                           WINDOWS _02C0LNN1F 679241477�  ��  x�  �      �      ��  �          �  ��  �          Ǒ  Ց           WINDOWS _02C0LNN1P 679241477׫  ī  ��  ��  ��  m�                                                           WINDOWS _02C0LNN2J 679241477V�  C�  6�  �  �  ��                                                           WINDOWS _02C0LNN3E 679241477��  ��  ��  q�  W�  ڧ                                                           WINDOWS _02C0LNN3Y 679241477ç  ��  ��  ��  q�  �                                                           WINDOWS _02C0LNN3Z 679241477�  ��  �  ަ  Ħ  G�                                                           WINDOWS _02C0LNN48 6792414770�  �  �  ��  ޥ  ��                                                           WINDOWS _02C0LNN4I 679241477|�  i�  \�  K�  1�  ��                                                           WINDOWS _02C0LNN4J 679241477��  ��  }�  e�  K�  ��                                                           WINDOWS _02C0LNN4S 679241477�  ֣  ɣ  ��  ��  !�                                                           WINDOWS _02C0LNN52 679241477
�  ��  �  Ң  ��  f�                                                           WINDOWS _02C0LNN5C 679241477V�  C�  6�  %�  �  ��                                                           WINDOWS _02C0LNN5D 679241477��  }�  p�  X�  >�  �                                                           WINDOWS _02C0LNN5M 679241477ܠ  ɠ  ��  ��  ��  �                                                           WINDOWS _02C0LNN5W 679241477��  �  ݟ  ş  ��  Y�                                                           WINDOWS _02C0LNN5X 679241477I�  6�  )�  �  ��  ��                                                           WINDOWS _02C0LNN66 679241477j�  W�  J�  2�  �  Ɲ                                                           WINDOWS _02C0LNN6G 679241477��  ��  ��  ��  k�  �                                                           WINDOWS _02C0LNN6H 679241477ל  Ĝ  ��  ��  ��  2�                                                           WINDOWS _02C0LNN6Q 679241477"�  �  �  �  כ  ��                                                           WINDOWS _02C0LNN70 679241477{�  h�  [�  C�  (�  ֚                                                           WINDOWS _02C0LNN71 679241477ƚ  ��  ��  ��  z�  ��                                                           WINDOWS _02C0LNN7A 678973640�  љ  ��  ��  ��  Q�      ��  �                                               WINDOWS _02C0LNN7K 678973640�  ۗ  Ɨ  ��  ��  R�      �  N�                                               WINDOWS _02C0LNN7U 6789736406�  #�  �  ��  �  ��      e�  ��                                               WINDOWS _02C0LNN84 678973640~�  k�  V�  E�  4�  ߓ      ��  Ւ                                               WINDOWS _02C0LNN8E 679241477Œ  ��  ��  ��  ��  %�                                                           COMMENT RESERVED                        ��      ��                                                          *WINDOWS _S680ZK89D 679304571U  }  q  d      �      �o  �S          ?  L  �L          1              *COMMENT RESERVED                        $      �                                                           WINDOWS _S680ZK89D 683046969t�  ��  ��  g�      �      ³  ��          ��  ��  ��          ��               COMMENT RESERVED                        ��      ��                                                            ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      frmdebuttons      Pixels      Class      9      frmde      frmdebuttons      +Top = 420
Left = 288
Name = "Cmddelete"
      macbase.vcx      form      frmdebuttons      form      �Height = 134
Width = 346
DoCreate = .T.
AutoCenter = .T.
Caption = "About This Program"
MaxButton = .F.
MinButton = .F.
WindowType = 1
stretchable = .F.
Name = "aboutform"
     )PROCEDURE Init
lcLocalFile = SYS(16,2)

lcServerFile = "K:\data\vfp5app\" + JUSTFNAME(lcLocalfile)

IF !EMPTY(lcLocalFile) and FILE(lcLocalfile)
	lcLocalDatetime = DTOC(FDATE(lcLocalFile)) + " " + FTIME(lcLocalFile)
	THISFORM.txtLocal.value = lcLocalDateTime
	THISFORM.txtLocalFile.Value = lcLocalFile
ENDIF

IF !EMPTY(lcServerFile) and FILE(lcServerFile)
	lcServerDatetime = DTOC(FDATE(lcServerFile)) + " " + FTIME(lcServerFile)
	THISFORM.txtServer.value = lcServerdateTime
	THISFORM.txtServerFile.Value = lcServerFile
ENDIF

ENDPROC
      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      frmde      Pixels      Class      1      macform      frmde      form      macbase.vcx      ..\..\forms.vcx      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      form      retval
      uHeight = 287
Width = 552
DoCreate = .T.
KeyPreview = .T.
WindowType = 1
stretchable = .F.
Name = "frmdemodal"
      buttons.vcx      commandbutton      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      frmmodaldialog      Pixels      2Non data entry form to be used for user questions.      Class      3      maclabel      macbase.vcx      label      	Maclabel1      	aboutform      uAutoSize = .F.
Caption = "Local File Compiled:"
Height = 17
Left = 216
Top = 0
Width = 120
Name = "Maclabel1"
      maclabel      macbase.vcx      label      	Maclabel2      	aboutform      wAutoSize = .F.
Caption = "Server File Compiled:"
Height = 17
Left = 216
Top = 48
Width = 120
Name = "Maclabel2"
      
mactextbox      macbase.vcx      textbox      txtlocal      	aboutform      bHeight = 23
Left = 216
ReadOnly = .T.
TabStop = .F.
Top = 12
Width = 120
Name = "txtlocal"
      
mactextbox      macbase.vcx      textbox      	txtserver      	aboutform      cHeight = 23
Left = 216
ReadOnly = .T.
TabStop = .F.
Top = 60
Width = 120
Name = "txtserver"
      maccommandbutton      macbase.vcx      commandbutton      Maccommandbutton1      	aboutform      STop = 96
Left = 264
Cancel = .T.
Caption = "Close"
Name = "Maccommandbutton1"
      0PROCEDURE Click
THISFORM.Release()

ENDPROC
      ����    �   �                         �   %   S       h      b           �  U    ��C�  � �� U  THISFORM RELEASE Click,     ��1 � 1                       #       )   �                         maclabel      macbase.vcx      label      	Maclabel3      	aboutform      kAutoSize = .F.
Caption = "Local File:"
Height = 17
Left = 96
Top = 0
Width = 120
Name = "Maclabel3"
      maclabel      macbase.vcx      label      	Maclabel4      	aboutform      mAutoSize = .F.
Caption = "Server File:"
Height = 17
Left = 96
Top = 48
Width = 120
Name = "Maclabel4"
      
mactextbox      macbase.vcx      textbox      txtLocalfile      	aboutform      eHeight = 23
Left = 96
ReadOnly = .T.
TabStop = .F.
Top = 12
Width = 120
Name = "txtLocalfile"
      
mactextbox      macbase.vcx      textbox      txtServerFile      	aboutform      fHeight = 23
Left = 96
ReadOnly = .T.
TabStop = .F.
Top = 60
Width = 120
Name = "txtServerFile"
      	aboutform      macform      10      Class      Pixels      	aboutform      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      	Cmddelete      commandbutton      buttons.vcx      	cmddelete      JTop = 420
Left = 0
TabIndex = 301
locktobottom = .T.
Name = "Cmdadd"
      frmdebuttons      Cmdadd      commandbutton      buttons.vcx      cmdadd      bTop = 420
Left = 444
TabIndex = 307
locktobottom = .T.
locktoright = .T.
Name = "Cmdlookup"
      frmdebuttons      	Cmdlookup      commandbutton      buttons.vcx      	cmdlookup      aTop = 420
Left = 528
TabIndex = 307
locktobottom = .T.
locktoright = .T.
Name = "Cmdclose"
      frmdebuttons      Cmdclose      commandbutton      buttons.vcx      cmdclose      \Top = 420
Left = 216
Enabled = .F.
TabIndex = 304
locktobottom = .T.
Name = "Cmdundo"
      frmdebuttons      Cmdundo      commandbutton      buttons.vcx      cmdundo      �Height = 453
Width = 624
DoCreate = .T.
lookupform = 
parentfk = 
parentalias = 
basetablename = 
lastcurrentid = 0
mainaliaspk = 
confirmreleaseonclose = .T.
stretchable = .F.
mainalias = 
Name = "frmde"
      cmdok      Cmdok      SPROCEDURE RightClick
DO FORM DirtyBuffers WITH THISFORM.DataSessionID

ENDPROC
      \Top = 420
Left = 144
Enabled = .F.
TabIndex = 303
locktobottom = .T.
Name = "Cmdsave"
      frmdebuttons      Cmdsave      commandbutton      buttons.vcx      cmdsave      LTop = 420
Left = 72
TabIndex = 302
locktobottom = .T.
Name = "Cmdedit"
      frmdebuttons      Cmdedit      commandbutton      buttons.vcx      cmdedit      ����    �   �                            %   l       �      {           �  U  !  T�  � ������ ��C�  � �� U  THISFORM RETVAL RELEASE Click,     ��1 � 2                       ;       )   �                         GPROCEDURE Init
THIS.Visible = !EMPTY(THISFORM.ReportFile)

ENDPROC
      aTop = 420
Left = 372
TabIndex = 306
locktobottom = .T.
locktoright = .T.
Name = "Cmdprint"
      frmdebuttons      Cmdprint      commandbutton      buttons.vcx      cmdprint      *buildmenu 
     ����    �  �                        ��   %   �      G               �  U  �  ��  � � � %�� ��- � T� � � �a�� �" %�C� tcInstructionsb� C��f � T� � � ��  �� �� � T� � � ��  �� � %�C� �
��� � T� �	 �� �� � ��C� �
 �� U  TCINSTRUCTIONS
 TNPARENTID TLENABLEADDNEW THIS	 CMDADDNEW ENABLED THISFORM LBLINSTRUCTIONS CAPTION PARENTID REQUERYVIEWS%  T�  � �C�  � ��� ��C�  � �� U  THISFORM RETVAL RETURNFIELD RELEASE  ��C�  � �� U  THISFORM RELEASE Init,     �� cmdOk.Clickk    �� cmdCancel.Click�    ��1 � � A "1� 1A A � 3 Q� 3 � 1                       k        �  �        �        )   �                        !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      frmgetfromlist      Pixels      Class      3      
frmdemodal      form      Cmdok1     �PROCEDURE buildmenu

*!*	lcformItem = ALLTRIM(THISFORM.GenericConfirmItem)

*!*	lcPopupName = lcFormItem + "mnu"
*!*	lcPadName = lcFormItem + "pad"

*!*	DEFINE PAD (lcPadName) OF _MSYSMENU PROMPT lcFormItem COLOR SCHEME 3 
*!*	ON PAD (lcPadName) OF _MSYSMENU ACTIVATE POPUP (lcPopupName)

*!*	DEFINE POPUP (lcPopupName) MARGIN RELATIVE SHADOW COLOR SCHEME 4

*!*	DEFINE BAR 1 OF (lcPopupName) PROMPT "\<Add";
*!*		SKIP FOR TYPE("_SCREEN.ActiveForm.cmdAdd.Name") <> "C" OR _SCREEN.ActiveForm.cmdAdd.Enabled = .F.

*!*	DEFINE BAR 2 OF (lcPopupName) PROMPT "E\<dit";
*!*		SKIP FOR TYPE("_SCREEN.ActiveForm.cmdEdit.Name") <> "C" OR _SCREEN.ActiveForm.cmdEdit.Enabled = .F.

*!*	DEFINE BAR 3 OF (lcPopupName) PROMPT "\<Save";
*!*		SKIP FOR TYPE("_SCREEN.ActiveForm.cmdSave.Name") <> "C" OR _SCREEN.ActiveForm.cmdSave.Enabled = .F.

*!*	DEFINE BAR 4 OF (lcPopupName) PROMPT "\<Undo";
*!*		SKIP FOR TYPE("_SCREEN.ActiveForm.cmdUndo.Name") <> "C" OR _SCREEN.ActiveForm.cmdUndo.Enabled = .F.

*!*	DEFINE BAR 5 OF (lcPopupName) PROMPT "\<Delete";
*!*		SKIP FOR TYPE("_SCREEN.ActiveForm.cmdDelete.Name") <> "C" OR _SCREEN.ActiveForm.cmdDelete.Enabled = .F.

*!*	DEFINE BAR 6 OF (lcPopupName) PROMPT "\<Print";
*!*		SKIP FOR TYPE("_SCREEN.ActiveForm.cmdPrint.Name") <> "C" OR _SCREEN.ActiveForm.cmdPrint.Enabled = .F.

*!*	DEFINE BAR 7 OF (lcPopupName) PROMPT "\<Lookup";
*!*		SKIP FOR TYPE("_SCREEN.ActiveForm.cmdLookup.Name") <> "C" OR _SCREEN.ActiveForm.cmdLookup.Enabled = .F.


*!*	ON SELECTION BAR 1 OF (lcPopupName) _SCREEN.ActiveForm.Add()
*!*	ON SELECTION BAR 2 OF (lcPopupName) _SCREEN.ActiveForm.Edit()
*!*	ON SELECTION BAR 3 OF (lcPopupName) _SCREEN.ActiveForm.Save()
*!*	ON SELECTION BAR 4 OF (lcPopupName) _SCREEN.ActiveForm.Undo()
*!*	ON SELECTION BAR 5 OF (lcPopupName) _SCREEN.ActiveForm.Delete()
*!*	ON SELECTION BAR 6 OF (lcPopupName) _SCREEN.ActiveForm.Print()
*!*	ON SELECTION BAR 7 OF (lcPopupName) _SCREEN.ActiveForm.Lookup()


ENDPROC
PROCEDURE setbuttontooltips
IF !EMPTY(THIS.GenericConfirmItem)
	THIS.cmdAdd.ToolTipText = "Add a new " + THIS.GenericConfirmItem
	THIS.cmdEdit.ToolTipText = "Edit this " + THIS.GenericConfirmItem
	THIS.cmdSave.ToolTipText = "Save any changes made to this " + THIS.GenericConfirmItem
	THIS.cmdUndo.ToolTipText = "Discard any changes made to this " + THIS.GenericConfirmItem
	THIS.cmdLookup.ToolTipText = "Look up another " + THIS.GenericConfirmItem
	THIS.cmdDelete.ToolTipText = "Delete this " + THIS.GenericConfirmItem
ENDIF

	
ENDPROC
PROCEDURE Load
DODEFAULT()
THIS.BuildMenu()

ENDPROC
PROCEDURE Activate
DODEFAULT()
THISFORM.Buildmenu()
*!*	lcformItem = ALLTRIM(THISFORM.GenericConfirmItem)
*!*	lcPopupName = lcFormItem + "mnu"
*!*	SHOW POPUP (lcPopupName)
ENDPROC
PROCEDURE Deactivate
DODEFAULT()
*!*	lcformItem = ALLTRIM(THISFORM.GenericConfirmItem)

*!*	lcPopupName = lcFormItem + "mnu"
*!*	lcPadName = lcFormItem + "pad"

*!*	RELEASE PAD (lcPadName) OF _MSYSMENU  
*!*	*DEACTIVATE POPUP (lcPopupName)

ENDPROC
      7DoCreate = .T.
autoedit = .F.
Name = "frmdebuttons"
      	forms.vcx      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      
frmaddedit      Pixels      Class      1      
frmdemodal      
frmaddedit     �parentalias Holds the name of the view that represents the parent cursor to the main alias
parentfk The name of the field in the main alias that is the primary key in the parent alias.
basetablename The name of the base table of the main view. Used for getting a new primary key value from the ADDID() stored procedure.
mainaliaspk Holds the name of the field in the main alias that serves as the primary key.
      ����    �   �                         t   %   u       �      �           �  U    � DirtyBuffers�� � � U  DIRTYBUFFERS THISFORM DATASESSIONID
 RightClick,     ��1 �2                       H       )   �                         ����    �   �                         �i   %   n       �      |           �  U    T�  � �C� � �
�� U  THIS VISIBLE THISFORM
 REPORTFILE Init,     ��1 a2                       <       )   �                         ����    �   �                         D   %   Q       g      a           �  U    B��  � �� U  THISFORM RETVAL Unload,     ��1 � 2                       *       )   �                         ����    �   �                         �   %   S       h      b           �  U    ��C�  � �� U  THISFORM RELEASE Click,     ��1 � 2                       %       )   �                         �Height = 279
Width = 552
DoCreate = .T.
Name = "frmgetfromlist"
cmdOk.Top = 240
cmdOk.Left = 384
cmdOk.Default = .T.
cmdOk.Name = "cmdOk"
cmdCancel.Top = 240
cmdCancel.Left = 468
cmdCancel.Cancel = .T.
cmdCancel.Name = "cmdCancel"
      	cmdcancel      buttons.vcx      commandbutton      frmgetfromlist      frmgetfromlist      lblInstructions      label      macbase.vcx      maclabel      frmgetfromlist     �PROCEDURE requeryviews
IF TYPE("THISFORM.CurrentID") <> "L"
	lnid = THISFORM.CurrentID
	REQUERY(THISFORM.MainAlias)
	IF !EMPTY(THISFORM.ParentAlias)
		lnid = EVAL(THISFORM.ParentFK)
		REQUERY(THISFORM.ParentAlias)
	ENDIF
ENDIF

THIS.AfterRequeryViews()

ENDPROC
PROCEDURE Init
LPARAMETERS tnParentID, tnChildID

DO CASE
	* No parent ID was passed
	CASE TYPE("tnParentID") = "L"
		MESSAGEBOX("The form was called with incorrect number of parameters.", 16, THISFORM.Caption)
		RETURN .F.

	* A parent ID was passed, but no child ID was passed, so assume this is an "ADD" operation
	CASE TYPE("tnChildID") = "L"
		APPEND BLANK IN THISFORM.MainAlias
		REPLACE (THISFORM.ParentFK) WITH tnParentID IN (THISFORM.MainAlias)
		lnid = tnParentID
		REQUERY(THISFORM.ParentAlias)

		THIS.AfterAdd()
		IF !EMPTY(THISFORM.BaseTableName)
			lnMainPK = ADDID(THISFORM.BaseTableName)
			REPLACE (THISFORM.MainAliasPK) WITH lnMainPK IN (THISFORM.MainAlias)
			THISFORM.CurrentID = lnMainPK
		ENDIF

	* A parent id and a child id was passed, this is an "EDIT" operation
	OTHERWISE
		THISFORM.CurrentID = tnChildID
		THISFORM.RequeryViews()
ENDCASE

ENDPROC
PROCEDURE cmdok.Click
IF THISFORM.BeforeSave() AND THISFORM.Save()
	THISFORM.RetVal = EVAL(THISFORM.MainAliasPK)
	THISFORM.Release()
ENDIF

ENDPROC
PROCEDURE cmdcancel.Click
THISFORM.RevertAll()
THISFORM.Release()

ENDPROC
      �DoCreate = .T.
WindowType = 1
Name = "frmaddedit"
cmdok.Top = 252
cmdok.Left = 384
cmdok.Name = "cmdok"
cmdcancel.Cancel = .T.
cmdcancel.Name = "cmdcancel"
      form      ..\..\forms.vcx      breturnfield The field whose value should be passed back when the ok button is clicked.
parentid
      THeight = 290
Width = 362
DoCreate = .T.
WindowType = 1
Name = "frmmodaldialog"
      
Cmdcancel1      3      FPROCEDURE Click
THISFORM.RetVal = -1
THISFORM.Release()

ENDPROC
      	cmdAddNew      commandbutton      
frmdemodal     8���                              �   %   �      �     �          �  U  �  T�  �C��]��$ T� �� K:\data\vfp5app\C�  ���� %�C�  �
� C�  0	��� � T� �CC�  �X*�  C�  �Y�� T� � � �� �� T� � � ��  �� � %�C� �
� C� 0	��� � T� �CC� �X*�  C� �Y�� T� � � �� �� T� �	 � �� �� � U
  LCLOCALFILE LCSERVERFILE LCLOCALDATETIME THISFORM TXTLOCAL VALUE TXTLOCALFILE LCSERVERDATETIME	 TXTSERVER TXTSERVERFILE Init,     ��1 !B��11A ��11A 2                             )                          ����    �  �                        m�   %   �           �          �  U    B��  � �� U  THIS RETVAL@  ��  � � %��  ���9 � ��C� � � �� �� � � � � U  NKEYCODE NSHIFTALTCTRL THISFORM ACTIVECONTROL SETFOCUS CMDOK CLICK
  ��  � U 
 TNPARENTIDj  %�C�  � � C�  � 	��T � %�C�  � ��4 � B�a�� �P � ��C�  � �� B�-�� � �c � B�-�� � U  THISFORM
 BEFORESAVE VALIDATEALLCONTROLS SAVEALL UNDO Unload,     �� KeyPressM     �� Init�     �� save�     ��1 � 3 � � A 3 q 2 �q � � q A � q A 1                       &         D   �      	   �   �           �      )   �                        5PROCEDURE Unload
RETURN THISFORM.RetVal

ENDPROC
      ,Top = 252
Left = 276
Name = "Cmdcancel1"
      .PROCEDURE Click
THISFORM.Release()
ENDPROC
      commandbutton      buttons.vcx      frmmodaldialog      (Top = 252
Left = 192
Name = "Cmdok1"
      frmmodaldialog      macform      
frmdemodal      	Cmdcancel      commandbutton      buttons.vcx      	cmdcancel      Pixels     PROCEDURE Init
LPARAMETERS tcInstructions, tnparentid, tlEnableAddNew

IF tlEnableAddNew
	THIS.cmdAddNew.Enabled = .T.
ENDIF

IF TYPE("tcInstructions") = "C"
	THISFORM.lblInstructions.Caption = tcInstructions
ELSE
	THISFORM.lblInstructions.Caption = ""
ENDIF

IF !EMPTY(tnParentID)
	THISFORM.ParentID = tnParentID
ENDIF

THISFORM.RequeryViews()

ENDPROC
PROCEDURE cmdOk.Click
THISFORM.retval = EVAL(THISFORM.ReturnField)
THISFORM.Release()

ENDPROC
PROCEDURE cmdCancel.Click
THISFORM.Release()
ENDPROC
      frmmodaldialog      form      macbase.vcx      maccommandbutton      macbase.vcx      retval
      cmdok      �FontBold = .T.
WordWrap = .T.
Caption = "lblInstructions"
Height = 24
Left = 12
Top = 12
Width = 516
ForeColor = 0,0,255
Name = "lblInstructions"
      jTop = 240
Left = 12
Height = 23
Width = 72
Caption = "Add new..."
Enabled = .F.
Name = "cmdAddNew"
      +Top = 252
Left = 468
Name = "Cmdcancel"
      
frmdemodal      macform      Class      
frmdemodal      macbase.vcx      'Top = 252
Left = 384
Name = "Cmdok"
     �PROCEDURE Unload
RETURN THIS.Retval

ENDPROC
PROCEDURE KeyPressLPARAMETERS nKeyCode, nShiftAltCtrl
IF nKeyCode = 13
	THISFORM.ActiveControl.SetFocus()
	THISFORM.cmdOk.Click
ENDIF
ENDPROC
PROCEDURE Init
LPARA tnParentID
ENDPROC
PROCEDURE save
IF THISFORM.BeforeSave() AND THISFORM.ValidateAllControls()
	IF THISFORM.SaveAll()
		RETURN .T.
	ELSE
		THISFORM.Undo()
		RETURN .F.
	ENDIF
ELSE
	RETURN .F.
ENDIF
ENDPROC
     <���    #  #                        ��   %         �  (   Z          �  U  � & %�C� THISFORM.CurrentIDb� L��} � T�  �� � �� ��C� � ��� %�C� � �
��y � T�  �C� � ��� ��C� � ��� � � ��C� � �� U  LNID THISFORM	 CURRENTID	 MAINALIAS PARENTALIAS PARENTFK THIS AFTERREQUERYVIEWS ��  � � H� �x� �C�
 tnParentIDb� L��� �M ��C�8 The form was called with incorrect number of parameters.�� � �x�� B�-�� �C�	 tnChildIDb� L��S� �� � �� >�� � ��� � ����  �� T� ��  �� ��C� � ��� ��C�	 �
 �� %�C� � �
��O� T� �C� � � �� >�� � ��� � ���� �� T� � �� �� � 2�x� T� � �� �� ��C� � �� � U 
 TNPARENTID	 TNCHILDID THISFORM CAPTION	 MAINALIAS PARENTFK IN LNID PARENTALIAS THIS AFTERADD BASETABLENAME LNMAINPK ADDID MAINALIASPK	 CURRENTID REQUERYVIEWSE  %�C�  � � C�  � 	��> � T�  � �C�  � ��� ��C�  � �� � U  THISFORM
 BEFORESAVE SAVE RETVAL MAINALIASPK RELEASE  ��C�  � �� ��C�  � �� U  THISFORM	 REVERTALL RELEASE requeryviews,     �� Init    �� cmdok.ClickF    �� cmdcancel.Click�    ��1 a� 1!� A A � 3 � � ��q �� �� � � 1A�A � � A 3 �Q� A 3 � � 2                               #  �         �  -  ,   %   S  }  3    )   #                       X���    ?  ?                        3   %   ,      �     �          �  U    U  % %�C�  � �
���$ T�  � � ��
 Add a new �  � ��$ T�  � � ��
 Edit this �  � ��8 T�  � � �� Save any changes made to this �  � ��; T�  � � ��! Discard any changes made to this �  � ��* T�  � � �� Look up another �  � ��& T�  � � �� Delete this �  � �� � U	  THIS GENERICCONFIRMITEM CMDADD TOOLTIPTEXT CMDEDIT CMDSAVE CMDUNDO	 CMDLOOKUP	 CMDDELETE 	 ��C��� ��C�  � �� U  THIS	 BUILDMENU 	 ��C��� ��C�  � �� U  THISFORM	 BUILDMENU 	 ��C��� U  	 buildmenu,     �� setbuttontooltips3     �� Load�    �� Activate�    ��
 Deactivate    ��1 �1 1AA���aA 4 � � 3 � � 5 � 9                       �        �  �	  -      �	  
  9      9
  �
  >      �
  �  E    )   ?                       �lookupform The name of a form used as a look up for the main entity of this form
parentfk The name of the field in the main alias that holds the foreign key to that item's parent table. Example: "lvInvoice.CustomerID"
parentalias Holds the name of a cursor that is the parent to the main alias of this form. Optional.
requerychildrenonactivate A flag to tell this form that it should requery its children tables the next time it is activated in case there were changes made by other forms
basetablename The name of the base table that the main view alias is based on. Used for retreiving the next primary key value during an add.
lastcurrentid Holds the id of the previous record when adding a new record. Used in case where the user cancels out of an add, so the old record can be opened again.
addingrecord Is set by the form's add method to signify that the form is in "Add" mode.
showcoordinatedmenu Set to .T. if this form should build a menu containing add, edit, delete functions, etc.
firsteditfield The fullname containership reference to a control that should receive focus after clickingthe edit or add button. Ex: "THISFORM.Pageframe1.Page1.txtName"
mainaliaspk Holds the name of the field in the main alias that serves as the primary key.
*setchildaliases Hooked from Init method. To be used to fill out THIS.ChildAliases[]
*afterinit Hooked from init. Runs after all parent class init code runs
*setcaption Uses this.GenericConfirmItem and THIS.SpecificConfirmItem to build a meaningful form caption. Called from init, and RequeryViews
*requerychildviews Requeries all of the views specified in THIS.ChildViews[]
*setbuttontooltips 
*beforedelete 
*afterdelete 
     ���                               9   %   �      �  
  �          �  U  �  ��  � %�C� � �
��| � %�C� � �
��N �! T�  �C� � �� - C� � ��� �h � T�  �C� � ��� � T� � ��  �� � U 	 LCCAPTION THIS GENERICCONFIRMITEM SPECIFICCONFIRMITEM THISFORM CAPTIONc  T�  �� � �� �� ���(�C� � ���\ � %�CC � � � �
��X � ��CC � � � ��� � �� U  LNID THISFORM	 CURRENTID I CHILDALIASES2  %��  � ��+ � ��C�  � �� T�  � �-�� � U  THIS REQUERYCHILDRENONACTIVATE REQUERYCHILDVIEWS1  %��  � ��* � %�C�  � 
��& � �� � � U  THISFORM CONFIRMRELEASEONCLOSE CONFIRMRELEASE� & %�C� THISFORM.CurrentIDb� L��� � T�  �� � �� ��C� � ��� ��C� � �� %�C� � �
��� � T�  �C� � ��� ��C� � ��� � � ��C� � �� ��C� �	 �� U
  LNID THISFORM	 CURRENTID	 MAINALIAS REQUERYCHILDVIEWS PARENTALIAS PARENTFK THIS
 SETCAPTION AFTERREQUERYVIEWS� ��  � � %�C� � 
��~�9 T�  ��, Do you want to save the changes you made to �� H�c �� �$ �C� � �
� CCC� � Λ�
	��� � T�  ��  CC� � Λ� ?�� �C� � �
��� � T�  ��  � � � ?�� 2�� � T�  ��  � this record?�� � T� �C�  �#� � �x�� H��z� �� ���=� B�C� � �� �� ���b� ��C� � �� B�a�� �� ���z� B�-�� � � U	  LCCONFIRMMESSAGE LNANSWER THISFORM ISBUFFERCLEAN THIS SPECIFICCONFIRMITEM GENERICCONFIRMITEM SAVE UNDO\ %�C�  � � C�  � 	��F� %�C�  � ��-�) %�C� THISFORM.cmdUndo.Nameb� C��g � T�  � � �-�� �) %�C� THISFORM.cmdSave.Nameb� C��� � T�  � � �-�� �) %�C� THISFORM.cmdEdit.Nameb� C��� � T�  � � �a�� �( %�C� THISFORM.cmdAdd.Nameb� C�� � T�  � � �a�� �+ %�C� THISFORM.cmdDelete.Nameb� C��`� T�  �	 � �a�� �+ %�C� THISFORM.cmdLookup.Nameb� C���� T�  �
 � �a�� �* %�C� THISFORM.cmdPrint.Nameb� C���� T�  � � �a�� � %�� � 
��� ��C�  � �� � ��C�  � �� ��C�  � �� T� � �-�� �B� ��C�  � �� � �U� B�-�� � U  THISFORM
 BEFORESAVE VALIDATEALLCONTROLS SAVEALL CMDUNDO ENABLED CMDSAVE CMDEDIT CMDADD	 CMDDELETE	 CMDLOOKUP CMDPRINT THIS AUTOEDIT DISABLEALLCONTROLS REFRESH
 SETCAPTION ADDINGRECORD UNDO> ��  � ��C� � �� %�� � ��R � T� � �� � �� ��C� � �� T� � �-�� � %�� � 
��*� ��C� �	 ��) %�C� THISFORM.cmdUndo.Nameb� C��� � T� �
 � �-�� �) %�C� THISFORM.cmdSave.Nameb� C��� � T� � � �-�� �) %�C� THISFORM.cmdEdit.Nameb� C��*� T� � � �a�� �( %�C� THISFORM.cmdAdd.Nameb� C��g� T� � � �a�� �+ %�C� THISFORM.cmdDelete.Nameb� C���� T� � � �a�� �+ %�C� THISFORM.cmdLookup.Nameb� C���� T� � � �a�� �* %�C� THISFORM.cmdPrint.Nameb� C��&� T� � � �a�� � � ��C� � �� U  LLREVERTINGFROMADD THIS	 REVERTALL ADDINGRECORD THISFORM	 CURRENTID LASTCURRENTID REQUERYVIEWS AUTOEDIT DISABLEALLCONTROLS CMDUNDO ENABLED CMDSAVE CMDEDIT CMDADD	 CMDDELETE	 CMDLOOKUP CMDPRINT REFRESH�8 %�C�  � �
�
 C�  � +
	�
 C�  � 
	� C�  � 	����) %�C� THISFORM.cmdUndo.Nameb� C��r � T�  � � �a�� �) %�C� THISFORM.cmdSave.Nameb� C��� � T�  � � �a�� �) %�C� THISFORM.cmdEdit.Nameb� C��� � T�  � � �-�� �( %�C� THISFORM.cmdAdd.Nameb� C��+� T�  � � �-�� �+ %�C� THISFORM.cmdDelete.Nameb� C��k� T�  � � �-�� �+ %�C� THISFORM.cmdLookup.Nameb� C���� T�  �	 � �-�� �* %�C� THISFORM.cmdPrint.Nameb� C���� T�  �
 � �-�� � ��C�  � �� %�C� � �
���� T� �C� � ���& %�C� oFirstControl.Nameb� C���� %�C� � � f� PAGE���� T� �� � � �� T� � � � �� �� � ��C� � �� � � ��� B�-�� � U  THISFORM	 MAINALIAS
 BEFOREEDIT CMDUNDO ENABLED CMDSAVE CMDEDIT CMDADD	 CMDDELETE	 CMDLOOKUP CMDPRINT ENABLEALLCONTROLS THIS FIRSTEDITFIELD OFIRSTCONTROL PARENT	 BASECLASS LNPAGEORDER	 PAGEORDER
 ACTIVEPAGE SETFOCUS� %��  � �	 C�  � 
	��# � B�-�� � %�C�  � �
��K�* T� ��	 Select a �  � �	  to edit.�� %�� � ��� �! ��  � �(� �� � �	 �a�� �� � ��  � �(� �� �-��a�� �% %�CC� lnNewRecordb� U� L�
��8� %�� � ��� ��C�  �
 �� �4� T� �	 �� �� ��C� � �� ��C� � �� � �G� B�-�� � ���G ��C�; No lookup form is specified in the Form.LookupForm property�x�� B�-�� � U  THISFORM CONFIRMRELEASEONCLOSE CONFIRMRELEASE
 LOOKUPFORM LCLOOKUPINSTRUCTIONS GENERICCONFIRMITEM THIS SENDCURRENTIDTOLOOKUP LNNEWRECORD	 CURRENTID ADD REQUERYVIEWS REFRESH�  ��  � �- T�  ��  Are you sure you want to delete �� H�E �� � �C� � �
��u � T�  ��  CC� � Λ� ?�� �C� � �
��� � T�  ��  � � � ?�� �C� � �
��� � T�  ��  � this record?�� � T� �C�  �$� � �x�� B�� ��� U  LCCONFIRMMESSAGE LNANSWER THIS SPECIFICCONFIRMITEM GENERICCONFIRMITEM THISFORM�  %�C�  � 
�	 C�  � 
��% � B�-�� �  %�C�  � +
�
 C�  � 
	��� � ��  � �� %�C�  � �  � ��� � H��  � �� %�C�  � +��� � #��  � �6� � T�  � �C�  � ��� ��C�  � �� � � ��C�  � �� U	  THISFORM BEFOREDELETE CONFIRMDELETE	 MAINALIAS UPDATETABLE	 CURRENTID MAINALIASPK REFRESH AFTERDELETE1 ��  � T� � �a�� T� � �� � �� %�C� � 
��A � B�-�� � �� � �� >�� � ���C� �
 �	 �� T� � �C� � ��� ��C� � �� %�C�  �
��� � >�� � ����  �� %�C� � ���� � T� ��  �� ��C� � ��� � � %�C� � 
��� ��C� � �� �*� ��C� � �� ��C� � �� � U 
 TNPARENTID THIS ADDINGRECORD LASTCURRENTID	 CURRENTID	 BEFOREADD THISFORM	 MAINALIAS MAINALIASPK ADDID BASETABLENAME REQUERYCHILDVIEWS PARENTFK PARENTALIAS LNID AFTERADD UNDO EDIT REFRESH�  ��  � � ��C� � �� ��C� � �� ��C� � �� H�? �� � �C� tnInitialPKb� N��{ � %�C� � 
��w � B�-�� � ��  � ��� � ��C � � � �� 2�� � T� �	 ��  �� ��C� �
 �� � ��C� � �� U  TNINITIALPK
 TNPARENTID THISFORM SETCHILDALIASES
 SETCAPTION THIS SETBUTTONTOOLTIPS LOOKUP ADD	 CURRENTID REQUERYVIEWS	 AFTERINIT
 setcaption,     �� requerychildviews     �� Activate�    �� Release�    �� requeryviewsc    �� confirmrelease�    �� save�    �� undo�    �� edit�    �� lookupl    �� confirmdelete�    �� delete'    �� adds    �� Initt    ��1 q 33� "A A 3 ��AA A 3 � � A 3 !A A A 3 a� � 1!� A A � � 3 � "�� A�1�� �A �� � � q q A A 2 ��A �A �A �A �A �A �A � A � � � � � A � q A 2 q � 1� � A � �A �A �A �A �A �A �A A � 4 ��A �A �A �A �A �A �A � 1!a�1aA � A A � q A 3 �q A 2�� �A R� � � � A � q A � qq A 3 � �� 1�1�1�A �� 3 �q A � q� !� A Q� A A � 3 q � 1"q A � �Q� 1!� � A A "� � � � A 3 � � � � � �!q A � � A � 2                               4  �        �  _        }  �  "         $  *   )   I  �  :   @   �  `  U   d   {    z   �   .  x  �   �   �  �  �   �   �    �   �   -  �  �   �   �  @    �   [  �!  .   )                          !�PROCEDURE setcaption
Local lcCaption

* Only set the caption if the form has the information needed
IF !EMPTY(THIS.GenericConfirmItem)
	* If it has both generic and specific items, I can build a caption like:
	* "Customers- John Smith"
	IF !EMPTY(THIS.SpecificConfirmItem)
		lcCaption = ALLTRIM(THIS.GenericConfirmItem) + "- " + EVAL(THIS.SpecificConfirmItem)
	ELSE
		* Otherwise, just build one that says "Customers"
		lcCaption = ALLTRIM(THIS.GenericConfirmItem) 
	ENDIF
	THISFORM.Caption = lcCaption
ENDIF

ENDPROC
PROCEDURE requerychildviews
lnid = THISFORM.CurrentID
FOR i = 1 TO ALEN(THISFORM.ChildAliases)
	IF !EMPTY(THISFORM.ChildAliases[i])
		REQUERY(THISFORM.ChildAliases[i])
	ENDIF
ENDFOR

ENDPROC
PROCEDURE Activate
IF THIS.RequeryChildrenOnActivate
	THIS.RequeryChildViews()
	THIS.RequeryChildrenOnActivate = .F.
ENDIF

ENDPROC
PROCEDURE Release
IF THISFORM.ConfirmReleaseOnClose
	IF !THISFORM.ConfirmRelease()
		NODEFAULT
	ENDIF
ENDIF 

ENDPROC
PROCEDURE requeryviews
IF TYPE("THISFORM.CurrentID") <> "L"

	lnid = THISFORM.CurrentID
	REQUERY(THISFORM.MainAlias)
	THISFORM.RequeryChildViews()
	IF !EMPTY(THISFORM.ParentAlias)
		lnid = EVAL(THISFORM.ParentFK)
		REQUERY(THISFORM.ParentAlias)
	ENDIF
ENDIF

THIS.SetCaption()
THIS.AfterRequeryViews()

ENDPROC
PROCEDURE confirmrelease
LOCAL lcConfirmMessage, lnAnswer

IF !THISFORM.IsBufferClean()
	lcConfirmMessage = "Do you want to save the changes you made to "
	DO CASE
		CASE !EMPTY(THIS.SpecificConfirmItem) AND !EMPTY(ALLTRIM(EVAL(THIS.SpecificConfirmItem)))
			lcConfirmMessage = lcConfirmMessage + ALLTRIM(EVAL(THIS.SpecificConfirmItem)) + "?"
		CASE !EMPTY(THIS.GenericConfirmItem)
			lcConfirmMessage = lcConfirmMessage + THIS.GenericConfirmItem + "?"
		OTHERWISE
			lcConfirmMessage = lcConfirmMessage + "this record?"
	ENDCASE

	lnAnswer = MESSAGEBOX(lcConfirmMessage, 3+32, THISFORM.GenericConfirmItem)
	DO CASE 
		CASE lnAnswer = 6
			RETURN THISFORM.Save()
		CASE lnAnswer = 7
			* I am calling Undo() instead of RevertAll() because this method might be called by Lookup()
			THISFORM.Undo()
			RETURN .T.
		CASE lnAnswer = 2
			RETURN .F.
	ENDCASE
ENDIF
ENDPROC
PROCEDURE save
IF THISFORM.BeforeSave() AND THISFORM.ValidateAllControls()
	IF THISFORM.SaveAll()
		IF TYPE('THISFORM.cmdUndo.Name') = "C"
			THISFORM.cmdUndo.Enabled = .F.
		ENDIF
		IF TYPE('THISFORM.cmdSave.Name') = "C"
			THISFORM.cmdSave.Enabled = .F.
		ENDIF
		IF TYPE('THISFORM.cmdEdit.Name') = "C"
			THISFORM.cmdEdit.Enabled = .T.
		ENDIF
		IF TYPE('THISFORM.cmdAdd.Name') = "C"
			THISFORM.cmdAdd.Enabled = .T.
		ENDIF
		IF TYPE('THISFORM.cmdDelete.Name') = "C"
			THISFORM.cmdDelete.Enabled = .T.
		ENDIF
		IF TYPE('THISFORM.cmdLookup.Name') = "C"
			THISFORM.cmdLookup.Enabled = .T.
		ENDIF
		IF TYPE('THISFORM.cmdPrint.Name') = "C"
			THISFORM.cmdPrint.Enabled = .T.
		ENDIF
		IF !THIS.AutoEdit
			THISFORM.DisableAllControls()
		ENDIF
		THISFORM.Refresh()
		THISFORM.SetCaption()
		THIS.AddingRecord = .F. && In case the form was in "add" mode
	ELSE
		THISFORM.Undo()
	ENDIF
ELSE
	RETURN .F.
ENDIF
ENDPROC
PROCEDURE undo
LOCAL llRevertingFromAdd


THIS.RevertAll()

IF THIS.AddingRecord && If the form was in add mode, set the id to the last currentid, and requery.
	THISFORM.CurrentID = THISFORM.LastCurrentID
	THISFORM.RequeryViews()
	THIS.AddingRecord = .F. 
ENDIF

IF !THIS.AutoEdit
	THIS.DisableAllControls()
	IF TYPE('THISFORM.cmdUndo.Name') = "C"
		THISFORM.cmdUndo.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdSave.Name') = "C"
		THISFORM.cmdSave.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdEdit.Name') = "C"
		THISFORM.cmdEdit.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdAdd.Name') = "C"
		THISFORM.cmdAdd.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdDelete.Name') = "C"
		THISFORM.cmdDelete.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdLookup.Name') = "C"
		THISFORM.cmdLookup.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdPrint.Name') = "C"
		THISFORM.cmdPrint.Enabled = .T.
	ENDIF
ENDIF
THIS.Refresh()


ENDPROC
PROCEDURE edit
IF !EMPTY(THISFORM.MainAlias) AND !EOF(THISFORM.MainAlias) AND !BOF(THISFORM.MainAlias) AND THISFORM.BeforeEdit()
	IF TYPE('THISFORM.cmdUndo.Name') = "C"
		THISFORM.cmdUndo.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdSave.Name') = "C"
		THISFORM.cmdSave.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdEdit.Name') = "C"
		THISFORM.cmdEdit.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdAdd.Name') = "C"
		THISFORM.cmdAdd.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdDelete.Name') = "C"
		THISFORM.cmdDelete.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdLookup.Name') = "C"
		THISFORM.cmdLookup.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdPrint.Name') = "C"
		THISFORM.cmdPrint.Enabled = .F.
	ENDIF

	THISFORM.EnableAllControls()
	IF !EMPTY(THIS.FirstEditField)
		oFirstControl = EVAL(THIS.FirstEditField)
		IF TYPE("oFirstControl.Name") = "C"
			IF UPPER(oFirstControl.Parent.BaseClass) = "PAGE"
				lnPageOrder = oFirstControl.Parent.PageOrder
				oFirstControl.Parent.Parent.ActivePage = lnPageOrder
			ENDIF
			oFirstControl.SetFocus()
		ENDIF
	ENDIF
ELSE
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE lookup
IF THISFORM.ConfirmReleaseOnClose AND !THISFORM.ConfirmRelease()
	RETURN .F.
ENDIF

IF !EMPTY(THISFORM.LookupForm)
	lcLookupInstructions = "Select a " + THISFORM.GenericConfirmItem + " to edit."
	IF THIS.SendCurrentIDToLookup
		DO FORM (THISFORM.LookupForm) TO lnNewRecord WITH lcLookupInstructions, THIS.CurrentID, .T.
	ELSE
		DO FORM (THISFORM.LookupForm) TO lnNewRecord WITH lcLookupInstructions, .F., .T.
	ENDIF

	IF !INLIST(TYPE("lnNewRecord"), "U", "L")
		* The lookup form can initiate an add operation by returning a negative id number
		IF lnNewRecord < 0
			THISFORM.Add()
		ELSE
			THIS.CurrentID = lnNewRecord
			THIS.RequeryViews()
			THIS.Refresh()
		ENDIF
	ELSE
		RETURN .F.
	ENDIF
ELSE
	MESSAGEBOX("No lookup form is specified in the Form.LookupForm property")
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE confirmdelete
LOCAL lcConfirmMessage, lnAnswer

lcConfirmMessage = "Are you sure you want to delete "
DO CASE
	CASE !EMPTY(THIS.SpecificConfirmItem)
		lcConfirmMessage = lcConfirmMessage + ALLTRIM(EVAL(THIS.SpecificConfirmItem)) + "?"
	CASE !EMPTY(THIS.GenericConfirmItem)
		lcConfirmMessage = lcConfirmMessage + THIS.GenericConfirmItem + "?"
	CASE !EMPTY(THIS.SpecificConfirmItem)
		lcConfirmMessage = lcConfirmMessage + "this record?"
ENDCASE

lnAnswer = MESSAGEBOX(lcConfirmMessage, 4+ 32, THISFORM.GenericConfirmItem)

RETURN lnAnswer = 6

ENDPROC
PROCEDURE delete
IF !THISFORM.BeforeDelete() OR !THISFORM.ConfirmDelete()
	RETURN .F.
ENDIF

IF !EOF(THISFORM.MainAlias) AND !BOF(THISFORM.MainAlias)
	DELETE IN (THISFORM.MainAlias)
	IF THISFORM.UpdateTable(THISFORM.MainAlias)
		SKIP IN (THISFORM.MainAlias)
		IF EOF(THISFORM.MainAlias)
			GO BOTTOM IN (THISFORM.MainAlias)
		ENDIF
		THISFORM.CurrentID = EVAL(THISFORM.MainAliasPK)
		THISFORM.Refresh()
	ENDIF
ENDIF

THISFORM.AfterDelete()

ENDPROC
PROCEDURE add
LPARA tnParentID

THIS.Addingrecord = .T.
THIS.LastCurrentID = THIS.CurrentID

IF !THIS.BeforeAdd()
	RETURN .F.
ENDIF

APPEND BLANK IN (THISFORM.MainAlias)
REPLACE (THIS.MainAliasPK) WITH ADDID(THISFORM.BaseTableName)
THISFORM.CurrentID = EVAL(THISFORM.MainAliasPK)
THISFORM.RequeryChildViews()

IF !EMPTY(tnParentID)
	REPLACE (THISFORM.ParentFK) WITH tnParentID
	IF USED(THISFORM.ParentAlias)
		lnID = tnParentID
		REQUERY(THISFORM.ParentAlias)
	ENDIF
ENDIF

IF !THISFORM.AfterAdd()
	THISFORM.Undo()
ELSE
	THISFORM.Edit()
	THISFORM.Refresh()
ENDIF

ENDPROC
PROCEDURE Init
LPARA tnInitialPK, tnParentID
* If no parameters are passed, the form calls the Lookup method to find a record to 
* position on. 

* If the first parameter is passed and is a positive number, that parameter
* is interpreted as the primary key of the record to be edited.

* If the first parameter passed is a negative number, the form automatically 
* goes into add mode by calling the Add() method. If a second parameter is passed,
* it is passed on to the add method and interpreted as the value to be inserted 
* in the ParentFK field.

THISFORM.SetChildAliases()
THISFORM.SetCaption()
THIS.SetButtonToolTips()

DO CASE 
	CASE TYPE("tnInitialPK") <> "N"
		IF !THISFORM.Lookup()
			RETURN .F.
		ENDIF
	CASE tnInitialPK < 0
		THISFORM.Add(tnParentID)
	OTHERWISE
		THISFORM.CurrentID = tnInitialPK
		THISFORM.RequeryViews()
ENDCASE

THIS.AfterInit()

ENDPROC
      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      	frmwizard      Pixels      Wizard Form class      Class      27      macform      	frmwizard      VTop = 336
Left = 12
Height = 2
Width = 539
SpecialEffect = 0
Name = "Macshape1"
      	frmwizard      	Macshape1      shape      macbase.vcx      macshape      ����    �   �                         �   %   S       h      b           �  U    ��C�  � �� U  THISFORM RELEASE Click,     ��1 � 2                       %       )   �                         0PROCEDURE Click
THISFORM.Release()

ENDPROC
      MTop = 348
Left = 204
Cancel = .T.
Caption = "Cancel"
Name = "cmdCancel"
      	frmwizard      	cmdCancel      commandbutton      macbase.vcx      maccommandbutton      ����    �   �                         ��   %   P       e      _           �  U    ��C�  � �� U  THISFORM BACK Click,     ��1 � 2                       "       )   �                         -PROCEDURE Click
THISFORM.Back()

ENDPROC
      LTop = 348
Left = 300
Caption = "\<Back"
Enabled = .F.
Name = "cmdBack"
      	frmwizard      cmdBack      commandbutton      macbase.vcx      maccommandbutton      ����    �   �                         ��   %   P       e      _           �  U    ��C�  � �� U  THISFORM NEXT Click,     ��1 � 2                       "       )   �                         -PROCEDURE Click
THISFORM.Next()

ENDPROC
      LTop = 348
Left = 372
Caption = "\<Next"
Default = .T.
Name = "cmdNext"
      	frmwizard      cmdNext      commandbutton      macbase.vcx      maccommandbutton      ����    �   �                         ��   %   p       �                 �  U  %  %�C�  � �� � ��C�  � �� � U  THISFORM FINISH RELEASE Click,     ��1 � A 3                       E       )   �                         PPROCEDURE Click
IF THISFORM.Finish()
	THISFORM.Release()
ENDIF


ENDPROC
      ATop = 348
Left = 480
Caption = "Finis\<h"
Name = "cmdFinish"
      	frmwizard      	cmdFinish      commandbutton      macbase.vcx      maccommandbutton      vFontBold = .T.
FontSize = 11
Caption = "Step 10"
Height = 24
Left = 24
Top = 12
Width = 60
Name = "Maclabel1"
      frmwizard.pf.Page10      	Maclabel1      label      macbase.vcx      maclabel      JHeight = 36
Left = 24
Top = 36
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page10      Lblinstructions1      label      macbase.vcx      lblinstructions      =Caption = "Step 9"
Left = 12
Top = 12
Name = "Maclabel1"
      frmwizard.pf.Page9      	Maclabel1      label      macbase.vcx      maclabel      KHeight = 36
Left = 132
Top = 12
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page9      Lblinstructions1      label      macbase.vcx      lblinstructions      uFontBold = .T.
FontSize = 11
Caption = "Step 8"
Height = 24
Left = 12
Top = 12
Width = 48
Name = "Maclabel1"
      frmwizard.pf.Page8      	Maclabel1      label      macbase.vcx      maclabel      JHeight = 36
Left = 12
Top = 48
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page8      Lblinstructions1      label      macbase.vcx      lblinstructions      uFontBold = .T.
FontSize = 11
Caption = "Step 7"
Height = 24
Left = 12
Top = 12
Width = 48
Name = "Maclabel1"
      frmwizard.pf.Page7      	Maclabel1      label      macbase.vcx      maclabel      JHeight = 36
Left = 12
Top = 36
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page7      Lblinstructions1      label      macbase.vcx      lblinstructions      uFontBold = .T.
FontSize = 11
Caption = "Step 6"
Height = 24
Left = 12
Top = 12
Width = 48
Name = "Maclabel1"
      frmwizard.pf.Page6      	Maclabel1      label      macbase.vcx      maclabel      JHeight = 36
Left = 12
Top = 36
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page6      Lblinstructions1      label      macbase.vcx      lblinstructions      \FontBold = .T.
FontSize = 11
Caption = "Step 5"
Left = 12
Top = 12
Name = "Maclabel1"
      frmwizard.pf.Page5      	Maclabel1      label      macbase.vcx      maclabel      JHeight = 36
Left = 12
Top = 36
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page5      Lblinstructions1      label      macbase.vcx      lblinstructions      uFontBold = .T.
FontSize = 11
Caption = "Step 4"
Height = 24
Left = 24
Top = 12
Width = 60
Name = "Maclabel1"
      frmwizard.pf.Page4      	Maclabel1      label      macbase.vcx      maclabel      JHeight = 36
Left = 24
Top = 36
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page4      Lblinstructions1      label      macbase.vcx      lblinstructions      uFontBold = .T.
FontSize = 11
Caption = "Step 3"
Height = 24
Left = 24
Top = 12
Width = 48
Name = "Maclabel1"
      frmwizard.pf.Page3      	Maclabel1      label      macbase.vcx      maclabel      JHeight = 36
Left = 24
Top = 36
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page3      Lblinstructions1      label      macbase.vcx      lblinstructions      uFontBold = .T.
FontSize = 11
Caption = "Step 2"
Height = 24
Left = 24
Top = 12
Width = 48
Name = "Maclabel1"
      frmwizard.pf.Page2      	Maclabel1      label      macbase.vcx      maclabel      JHeight = 36
Left = 24
Top = 36
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page2      Lblinstructions1      label      macbase.vcx      lblinstructions      uFontBold = .T.
FontSize = 11
Caption = "Step 1"
Height = 24
Left = 12
Top = 12
Width = 48
Name = "Maclabel1"
      frmwizard.pf.Page1      	Maclabel1      label      macbase.vcx      maclabel      JHeight = 36
Left = 12
Top = 48
Width = 300
Name = "Lblinstructions1"
      frmwizard.pf.Page1      Lblinstructions1      label      macbase.vcx      lblinstructions     #ErasePage = .T.
PageCount = 10
BorderWidth = 0
Top = 12
Left = 12
Width = 540
Height = 312
Tabs = .F.
Name = "pf"
Page1.Name = "Page1"
Page2.Name = "Page2"
Page3.Caption = "Page3"
Page3.Name = "Page3"
Page4.Caption = "Page4"
Page4.Name = "Page4"
Page5.Caption = "Page5"
Page5.Name = "Page5"
Page6.Caption = "Page6"
Page6.Name = "Page6"
Page7.Caption = "Page7"
Page7.Name = "Page7"
Page8.Caption = "Page8"
Page8.Name = "Page8"
Page9.Caption = "Page9"
Page9.Name = "Page9"
Page10.Caption = "Page10"
Page10.Name = "Page10"
      	frmwizard      pf      	pageframe      macbase.vcx      macpageframe      %stepcount
*next 
*back 
*finish 
     b���    I  I                           %   �      �     �          �  U  f  ���  � ��_ � ��C�� �� ��C�� �  � �� T�  � � ��� �� �� T�  �	 � ��� ��� �� U
  THISFORM PF
 GONEXTPAGE FIRSTFIELDSETFOCUS CURRENTPAGE CMDNEXT ENABLED
 ACTIVEPAGE	 PAGECOUNT CMDBACKf  ���  � ��_ � ��C�� �� ��C�� �  � �� T�  � � ��� �� �� T�  �	 � ��� ��� �� U
  THISFORM PF GOPREVIOUSPAGE FIRSTFIELDSETFOCUS CURRENTPAGE CMDNEXT ENABLED
 ACTIVEPAGE	 PAGECOUNT CMDBACK_  T�  �� � ��� �� ��  �(��
��X � T� �� PageCC� Z��� ��C � � � � �� �� U  LNREMOVESTARTPAGE THISFORM	 STEPCOUNT I LCREMOVEPAGE PF REMOVEOBJECT next,     �� back    �� Init�    ��1 � ��A 4 � ��A 3 Br�AA 2                       �         �   �        �  x      )   I                       �PROCEDURE next
WITH THISFORM.pf
	.GoNextPage()
	THISFORM.FirstFieldSetFocus(.CurrentPage)
	THISFORM.cmdNext.Enabled = (.ActivePage <> .PageCount)
	THISFORM.cmdBack.Enabled = (.ActivePage <> 1)
ENDWITH


ENDPROC
PROCEDURE back
WITH THISFORM.pf
	.GoPreviousPage()
	THISFORM.FirstFieldSetFocus(.CurrentPage)
	THISFORM.cmdNext.Enabled = (.ActivePage <> .PageCount)
	THISFORM.cmdBack.Enabled = (.ActivePage <> 1)
ENDWITH

ENDPROC
PROCEDURE Init

lnRemoveStartPage = THISFORM.Stepcount + 1

FOR i = lnRemoveStartPage TO 10
	lcRemovePage = "Page" + ALLTRIM(STR(i))
	THISFORM.pf.RemoveObject(lcRemovePage)
ENDFOR

ENDPROC
      cHeight = 384
Width = 564
DoCreate = .T.
Caption = "Wizard"
stepcount = 10
Name = "frmwizard"
      form      macbase.vcx      macform      macbase.vcx      form      Pixels      frmde      �Height = 453
Width = 624
DoCreate = .T.
lookupform = 
parentfk = 
parentalias = 
basetablename = 
lastcurrentid = 0
mainaliaspk = 
confirmreleaseonclose = .T.
stretchable = .F.
mainalias = 
Name = "frmde"
     !�PROCEDURE setcaption
Local lcCaption

* Only set the caption if the form has the information needed
IF !EMPTY(THIS.GenericConfirmItem)
	* If it has both generic and specific items, I can build a caption like:
	* "Customers- John Smith"
	IF !EMPTY(THIS.SpecificConfirmItem)
		lcCaption = ALLTRIM(THIS.GenericConfirmItem) + "- " + EVAL(THIS.SpecificConfirmItem)
	ELSE
		* Otherwise, just build one that says "Customers"
		lcCaption = ALLTRIM(THIS.GenericConfirmItem) 
	ENDIF
	THISFORM.Caption = lcCaption
ENDIF

ENDPROC
PROCEDURE requerychildviews
lnid = THISFORM.CurrentID
FOR i = 1 TO ALEN(THISFORM.ChildAliases)
	IF !EMPTY(THISFORM.ChildAliases[i])
		REQUERY(THISFORM.ChildAliases[i])
	ENDIF
ENDFOR

ENDPROC
PROCEDURE Init
LPARA tnInitialPK, tnParentID
* If no parameters are passed, the form calls the Lookup method to find a record to 
* position on. 

* If the first parameter is passed and is a positive number, that parameter
* is interpreted as the primary key of the record to be edited.

* If the first parameter passed is a negative number, the form automatically 
* goes into add mode by calling the Add() method. If a second parameter is passed,
* it is passed on to the add method and interpreted as the value to be inserted 
* in the ParentFK field.

THISFORM.SetChildAliases()
THISFORM.SetCaption()
THIS.SetButtonToolTips()

DO CASE 
	CASE TYPE("tnInitialPK") <> "N"
		IF !THISFORM.Lookup()
			RETURN .F.
		ENDIF
	CASE tnInitialPK < 0
		THISFORM.Add(tnParentID)
	OTHERWISE
		THISFORM.CurrentID = tnInitialPK
		THISFORM.RequeryViews()
ENDCASE

THIS.AfterInit()

ENDPROC
PROCEDURE add
LPARA tnParentID

THIS.AddingRecord = .T.
THIS.LastCurrentID = THIS.CurrentID

IF !THIS.BeforeAdd()
	RETURN .F.
ENDIF

APPEND BLANK IN (THISFORM.MainAlias)
REPLACE (THIS.MainAliasPK) WITH ADDID(THISFORM.BaseTableName)
THISFORM.CurrentID = EVAL(THISFORM.MainAliasPK)
THISFORM.RequeryChildViews()

IF !EMPTY(tnParentID)
	REPLACE (THISFORM.ParentFK) WITH tnParentID
	IF USED(THISFORM.ParentAlias)
		lnID = tnParentID
		REQUERY(THISFORM.ParentAlias)
	ENDIF
ENDIF

IF !THISFORM.AfterAdd()
	THISFORM.Undo()
ELSE
	THISFORM.Edit()
	THISFORM.Refresh()
ENDIF

ENDPROC
PROCEDURE delete
IF !THISFORM.BeforeDelete() OR !THISFORM.ConfirmDelete()
	RETURN .F.
ENDIF

IF !EOF(THISFORM.MainAlias) AND !BOF(THISFORM.MainAlias)
	DELETE IN (THISFORM.MainAlias)
	IF THISFORM.UpdateTable(THISFORM.MainAlias)
		SKIP IN (THISFORM.MainAlias)
		IF EOF(THISFORM.MainAlias)
			GO BOTTOM IN (THISFORM.MainAlias)
		ENDIF
		THISFORM.CurrentID = EVAL(THISFORM.MainAliasPK)
		THISFORM.Refresh()
	ENDIF
ENDIF

THISFORM.AfterDelete()

ENDPROC
PROCEDURE confirmdelete
LOCAL lcConfirmMessage, lnAnswer

lcConfirmMessage = "Are you sure you want to delete "
DO CASE
	CASE !EMPTY(THIS.SpecificConfirmItem)
		lcConfirmMessage = lcConfirmMessage + ALLTRIM(EVAL(THIS.SpecificConfirmItem)) + "?"
	CASE !EMPTY(THIS.GenericConfirmItem)
		lcConfirmMessage = lcConfirmMessage + THIS.GenericConfirmItem + "?"
	CASE !EMPTY(THIS.SpecificConfirmItem)
		lcConfirmMessage = lcConfirmMessage + "this record?"
ENDCASE

lnAnswer = MESSAGEBOX(lcConfirmMessage, 4+ 32, THISFORM.GenericConfirmItem)

RETURN lnAnswer = 6

ENDPROC
PROCEDURE lookup
IF THISFORM.ConfirmReleaseOnClose AND !THISFORM.ConfirmRelease()
	RETURN .F.
ENDIF

IF !EMPTY(THISFORM.LookupForm)
	lcLookupInstructions = "Select a " + THISFORM.GenericConfirmItem + " to edit."
	IF THIS.SendCurrentIDToLookup
		DO FORM (THISFORM.LookupForm) TO lnNewRecord WITH lcLookupInstructions, THIS.CurrentID, .T.
	ELSE
		DO FORM (THISFORM.LookupForm) TO lnNewRecord WITH lcLookupInstructions, .F., .T.
	ENDIF

	IF !INLIST(TYPE("lnNewRecord"), "U", "L")
		* The lookup form can initiate an add operation by returning a negative id number
		IF lnNewRecord < 0
			THISFORM.Add()
		ELSE
			THIS.CurrentID = lnNewRecord
			THIS.RequeryViews()
			THIS.Refresh()
		ENDIF
	ELSE
		RETURN .F.
	ENDIF
ELSE
	MESSAGEBOX("No lookup form is specified in the Form.LookupForm property")
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE edit
IF !EMPTY(THISFORM.MainAlias) AND !EOF(THISFORM.MainAlias) AND !BOF(THISFORM.MainAlias) AND THISFORM.BeforeEdit()
	IF TYPE('THISFORM.cmdUndo.Name') = "C"
		THISFORM.cmdUndo.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdSave.Name') = "C"
		THISFORM.cmdSave.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdEdit.Name') = "C"
		THISFORM.cmdEdit.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdAdd.Name') = "C"
		THISFORM.cmdAdd.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdDelete.Name') = "C"
		THISFORM.cmdDelete.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdLookup.Name') = "C"
		THISFORM.cmdLookup.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdPrint.Name') = "C"
		THISFORM.cmdPrint.Enabled = .F.
	ENDIF

	THISFORM.EnableAllControls()
	IF !EMPTY(THIS.FirstEditField)
		oFirstControl = EVAL(THIS.FirstEditField)
		IF TYPE("oFirstControl.Name") = "C"
			IF UPPER(oFirstControl.Parent.BaseClass) = "PAGE"
				lnPageOrder = oFirstControl.Parent.PageOrder
				oFirstControl.Parent.Parent.ActivePage = lnPageOrder
			ENDIF
			oFirstControl.SetFocus()
		ENDIF
	ENDIF
ELSE
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE undo
LOCAL llRevertingFromAdd


THIS.RevertAll()

IF THIS.AddingRecord && If the form was in add mode, set the id to the last currentid, and requery.
	THISFORM.CurrentID = THISFORM.LastCurrentID
	THISFORM.RequeryViews()
	THIS.AddingRecord = .F. 
ENDIF

IF !THIS.AutoEdit
	THIS.DisableAllControls()
	IF TYPE('THISFORM.cmdUndo.Name') = "C"
		THISFORM.cmdUndo.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdSave.Name') = "C"
		THISFORM.cmdSave.Enabled = .F.
	ENDIF
	IF TYPE('THISFORM.cmdEdit.Name') = "C"
		THISFORM.cmdEdit.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdAdd.Name') = "C"
		THISFORM.cmdAdd.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdDelete.Name') = "C"
		THISFORM.cmdDelete.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdLookup.Name') = "C"
		THISFORM.cmdLookup.Enabled = .T.
	ENDIF
	IF TYPE('THISFORM.cmdPrint.Name') = "C"
		THISFORM.cmdPrint.Enabled = .T.
	ENDIF
ENDIF
THIS.Refresh()


ENDPROC
PROCEDURE save
IF THISFORM.BeforeSave() AND THISFORM.ValidateAllControls()
	IF THISFORM.SaveAll()
		IF TYPE('THISFORM.cmdUndo.Name') = "C"
			THISFORM.cmdUndo.Enabled = .F.
		ENDIF
		IF TYPE('THISFORM.cmdSave.Name') = "C"
			THISFORM.cmdSave.Enabled = .F.
		ENDIF
		IF TYPE('THISFORM.cmdEdit.Name') = "C"
			THISFORM.cmdEdit.Enabled = .T.
		ENDIF
		IF TYPE('THISFORM.cmdAdd.Name') = "C"
			THISFORM.cmdAdd.Enabled = .T.
		ENDIF
		IF TYPE('THISFORM.cmdDelete.Name') = "C"
			THISFORM.cmdDelete.Enabled = .T.
		ENDIF
		IF TYPE('THISFORM.cmdLookup.Name') = "C"
			THISFORM.cmdLookup.Enabled = .T.
		ENDIF
		IF TYPE('THISFORM.cmdPrint.Name') = "C"
			THISFORM.cmdPrint.Enabled = .T.
		ENDIF
		IF !THIS.AutoEdit
			THISFORM.DisableAllControls()
		ENDIF
		THISFORM.Refresh()
		THISFORM.SetCaption()
		THIS.AddingRecord = .F. && In case the form was in "add" mode
	ELSE
		THISFORM.Undo()
	ENDIF
ELSE
	RETURN .F.
ENDIF
ENDPROC
PROCEDURE confirmrelease
LOCAL lcConfirmMessage, lnAnswer

IF !THISFORM.IsBufferClean()
	lcConfirmMessage = "Do you want to save the changes you made to "
	DO CASE
		CASE !EMPTY(THIS.SpecificConfirmItem) AND !EMPTY(ALLTRIM(EVAL(THIS.SpecificConfirmItem)))
			lcConfirmMessage = lcConfirmMessage + ALLTRIM(EVAL(THIS.SpecificConfirmItem)) + "?"
		CASE !EMPTY(THIS.GenericConfirmItem)
			lcConfirmMessage = lcConfirmMessage + THIS.GenericConfirmItem + "?"
		OTHERWISE
			lcConfirmMessage = lcConfirmMessage + "this record?"
	ENDCASE

	lnAnswer = MESSAGEBOX(lcConfirmMessage, 3+32, THISFORM.GenericConfirmItem)
	DO CASE 
		CASE lnAnswer = 6
			RETURN THISFORM.Save()
		CASE lnAnswer = 7
			* I am calling Undo() instead of RevertAll() because this method might be called by Lookup()
			THISFORM.Undo()
			RETURN .T.
		CASE lnAnswer = 2
			RETURN .F.
	ENDCASE
ENDIF
ENDPROC
PROCEDURE requeryviews
IF TYPE("THISFORM.CurrentID") <> "L"

	lnid = THISFORM.CurrentID
	REQUERY(THISFORM.MainAlias)
	THISFORM.RequeryChildViews()
	IF !EMPTY(THISFORM.ParentAlias)
		lnid = EVAL(THISFORM.ParentFK)
		REQUERY(THISFORM.ParentAlias)
	ENDIF
ENDIF

THIS.SetCaption()
THIS.AfterRequeryViews()

ENDPROC
PROCEDURE Release
IF THISFORM.ConfirmReleaseOnClose
	IF !THISFORM.ConfirmRelease()
		NODEFAULT
	ENDIF
ENDIF 

ENDPROC
PROCEDURE Activate
IF THIS.RequeryChildrenOnActivate
	THIS.RequeryChildViews()
	THIS.RequeryChildrenOnActivate = .F.
ENDIF

ENDPROC
     ���                               9   %   �      �  
  �          �  U  �  ��  � %�C� � �
��| � %�C� � �
��N �! T�  �C� � �� - C� � ��� �h � T�  �C� � ��� � T� � ��  �� � U 	 LCCAPTION THIS GENERICCONFIRMITEM SPECIFICCONFIRMITEM THISFORM CAPTIONc  T�  �� � �� �� ���(�C� � ���\ � %�CC � � � �
��X � ��CC � � � ��� � �� U  LNID THISFORM	 CURRENTID I CHILDALIASES�  ��  � � ��C� � �� ��C� � �� ��C� � �� H�? �� � �C� tnInitialPKb� N��{ � %�C� � 
��w � B�-�� � ��  � ��� � ��C � � � �� 2�� � T� �	 ��  �� ��C� �
 �� � ��C� � �� U  TNINITIALPK
 TNPARENTID THISFORM SETCHILDALIASES
 SETCAPTION THIS SETBUTTONTOOLTIPS LOOKUP ADD	 CURRENTID REQUERYVIEWS	 AFTERINIT1 ��  � T� � �a�� T� � �� � �� %�C� � 
��A � B�-�� � �� � �� >�� � ���C� �
 �	 �� T� � �C� � ��� ��C� � �� %�C�  �
��� � >�� � ����  �� %�C� � ���� � T� ��  �� ��C� � ��� � � %�C� � 
��� ��C� � �� �*� ��C� � �� ��C� � �� � U 
 TNPARENTID THIS ADDINGRECORD LASTCURRENTID	 CURRENTID	 BEFOREADD THISFORM	 MAINALIAS MAINALIASPK ADDID BASETABLENAME REQUERYCHILDVIEWS PARENTFK PARENTALIAS LNID AFTERADD UNDO EDIT REFRESH�  %�C�  � 
�	 C�  � 
��% � B�-�� �  %�C�  � +
�
 C�  � 
	��� � ��  � �� %�C�  � �  � ��� � H��  � �� %�C�  � +��� � #��  � �6� � T�  � �C�  � ��� ��C�  � �� � � ��C�  � �� U	  THISFORM BEFOREDELETE CONFIRMDELETE	 MAINALIAS UPDATETABLE	 CURRENTID MAINALIASPK REFRESH AFTERDELETE�  ��  � �- T�  ��  Are you sure you want to delete �� H�E �� � �C� � �
��u � T�  ��  CC� � Λ� ?�� �C� � �
��� � T�  ��  � � � ?�� �C� � �
��� � T�  ��  � this record?�� � T� �C�  �$� � �x�� B�� ��� U  LCCONFIRMMESSAGE LNANSWER THIS SPECIFICCONFIRMITEM GENERICCONFIRMITEM THISFORM� %��  � �	 C�  � 
	��# � B�-�� � %�C�  � �
��K�* T� ��	 Select a �  � �	  to edit.�� %�� � ��� �! ��  � �(� �� � �	 �a�� �� � ��  � �(� �� �-��a�� �% %�CC� lnNewRecordb� U� L�
��8� %�� � ��� ��C�  �
 �� �4� T� �	 �� �� ��C� � �� ��C� � �� � �G� B�-�� � ���G ��C�; No lookup form is specified in the Form.LookupForm property�x�� B�-�� � U  THISFORM CONFIRMRELEASEONCLOSE CONFIRMRELEASE
 LOOKUPFORM LCLOOKUPINSTRUCTIONS GENERICCONFIRMITEM THIS SENDCURRENTIDTOLOOKUP LNNEWRECORD	 CURRENTID ADD REQUERYVIEWS REFRESH�8 %�C�  � �
�
 C�  � +
	�
 C�  � 
	� C�  � 	����) %�C� THISFORM.cmdUndo.Nameb� C��r � T�  � � �a�� �) %�C� THISFORM.cmdSave.Nameb� C��� � T�  � � �a�� �) %�C� THISFORM.cmdEdit.Nameb� C��� � T�  � � �-�� �( %�C� THISFORM.cmdAdd.Nameb� C��+� T�  � � �-�� �+ %�C� THISFORM.cmdDelete.Nameb� C��k� T�  � � �-�� �+ %�C� THISFORM.cmdLookup.Nameb� C���� T�  �	 � �-�� �* %�C� THISFORM.cmdPrint.Nameb� C���� T�  �
 � �-�� � ��C�  � �� %�C� � �
���� T� �C� � ���& %�C� oFirstControl.Nameb� C���� %�C� � � f� PAGE���� T� �� � � �� T� � � � �� �� � ��C� � �� � � ��� B�-�� � U  THISFORM	 MAINALIAS
 BEFOREEDIT CMDUNDO ENABLED CMDSAVE CMDEDIT CMDADD	 CMDDELETE	 CMDLOOKUP CMDPRINT ENABLEALLCONTROLS THIS FIRSTEDITFIELD OFIRSTCONTROL PARENT	 BASECLASS LNPAGEORDER	 PAGEORDER
 ACTIVEPAGE SETFOCUS> ��  � ��C� � �� %�� � ��R � T� � �� � �� ��C� � �� T� � �-�� � %�� � 
��*� ��C� �	 ��) %�C� THISFORM.cmdUndo.Nameb� C��� � T� �
 � �-�� �) %�C� THISFORM.cmdSave.Nameb� C��� � T� � � �-�� �) %�C� THISFORM.cmdEdit.Nameb� C��*� T� � � �a�� �( %�C� THISFORM.cmdAdd.Nameb� C��g� T� � � �a�� �+ %�C� THISFORM.cmdDelete.Nameb� C���� T� � � �a�� �+ %�C� THISFORM.cmdLookup.Nameb� C���� T� � � �a�� �* %�C� THISFORM.cmdPrint.Nameb� C��&� T� � � �a�� � � ��C� � �� U  LLREVERTINGFROMADD THIS	 REVERTALL ADDINGRECORD THISFORM	 CURRENTID LASTCURRENTID REQUERYVIEWS AUTOEDIT DISABLEALLCONTROLS CMDUNDO ENABLED CMDSAVE CMDEDIT CMDADD	 CMDDELETE	 CMDLOOKUP CMDPRINT REFRESH\ %�C�  � � C�  � 	��F� %�C�  � ��-�) %�C� THISFORM.cmdUndo.Nameb� C��g � T�  � � �-�� �) %�C� THISFORM.cmdSave.Nameb� C��� � T�  � � �-�� �) %�C� THISFORM.cmdEdit.Nameb� C��� � T�  � � �a�� �( %�C� THISFORM.cmdAdd.Nameb� C�� � T�  � � �a�� �+ %�C� THISFORM.cmdDelete.Nameb� C��`� T�  �	 � �a�� �+ %�C� THISFORM.cmdLookup.Nameb� C���� T�  �
 � �a�� �* %�C� THISFORM.cmdPrint.Nameb� C���� T�  � � �a�� � %�� � 
��� ��C�  � �� � ��C�  � �� ��C�  � �� T� � �-�� �B� ��C�  � �� � �U� B�-�� � U  THISFORM
 BEFORESAVE VALIDATEALLCONTROLS SAVEALL CMDUNDO ENABLED CMDSAVE CMDEDIT CMDADD	 CMDDELETE	 CMDLOOKUP CMDPRINT THIS AUTOEDIT DISABLEALLCONTROLS REFRESH
 SETCAPTION ADDINGRECORD UNDO� ��  � � %�C� � 
��~�9 T�  ��, Do you want to save the changes you made to �� H�c �� �$ �C� � �
� CCC� � Λ�
	��� � T�  ��  CC� � Λ� ?�� �C� � �
��� � T�  ��  � � � ?�� 2�� � T�  ��  � this record?�� � T� �C�  �#� � �x�� H��z� �� ���=� B�C� � �� �� ���b� ��C� � �� B�a�� �� ���z� B�-�� � � U	  LCCONFIRMMESSAGE LNANSWER THISFORM ISBUFFERCLEAN THIS SPECIFICCONFIRMITEM GENERICCONFIRMITEM SAVE UNDO� & %�C� THISFORM.CurrentIDb� L��� � T�  �� � �� ��C� � ��� ��C� � �� %�C� � �
��� � T�  �C� � ��� ��C� � ��� � � ��C� � �� ��C� �	 �� U
  LNID THISFORM	 CURRENTID	 MAINALIAS REQUERYCHILDVIEWS PARENTALIAS PARENTFK THIS
 SETCAPTION AFTERREQUERYVIEWS1  %��  � ��* � %�C�  � 
��& � �� � � U  THISFORM CONFIRMRELEASEONCLOSE CONFIRMRELEASE2  %��  � ��+ � ��C�  � �� T�  � �-�� � U  THIS REQUERYCHILDRENONACTIVATE REQUERYCHILDVIEWS
 setcaption,     �� requerychildviews     �� Init�    �� add�    �� delete�    �� confirmdeleteD    �� lookup�    �� edit�	    �� undo�    �� save�    �� confirmrelease�    �� requeryviews�    �� Release    �� Activaten    ��1 q 33� "A A 3 ��AA A 3 � � � � � �!q A � � A � 3 q � 1"q A � �Q� 1!� � A A "� � � � A 3 �q A � q� !� A Q� A A � 3 � �� 1�1�1�A �� 3 �q A 2�� �A R� � � � A � q A � qq A 3 ��A �A �A �A �A �A �A � 1!a�1aA � A A � q A 3 q � 1� � A � �A �A �A �A �A �A �A A � 4 ��A �A �A �A �A �A �A � A � � � � � A � q A 2 � "�� A�1�� �A �� � � q q A A 2 a� � 1!� A A � � 3 !A A A 3 � � A 2                               4  �        �  _     #   y  �  ;   ;   �  �
  Z   K   �
  �  n   X   �  '  �   r   B  �  �   �   �  ?  �   �   Z  �  �   �      {    �   �  �   /  �   �   @!  ?    _!  �!  G   )                          �lookupform The name of a form used as a look up for the main entity of this form
parentfk The name of the field in the main alias that holds the foreign key to that item's parent table. Example: "lvInvoice.CustomerID"
parentalias Holds the name of a cursor that is the parent to the main alias of this form. Optional.
requerychildrenonactivate A flag to tell this form that it should requery its children tables the next time it is activated in case there were changes made by other forms
basetablename The name of the base table that the main view alias is based on. Used for retreiving the next primary key value during an add.
lastcurrentid Holds the id of the previous record when adding a new record. Used in case where the user cancels out of an add, so the old record can be opened again.
addingrecord Is set by the form's add method to signify that the form is in "Add" mode.
showcoordinatedmenu Set to .T. if this form should build a menu containing add, edit, delete functions, etc.
firsteditfield The fullname containership reference to a control that should receive focus after clickingthe edit or add button. Ex: "THISFORM.Pageframe1.Page1.txtName"
mainaliaspk Holds the name of the field in the main alias that serves as the primary key.
*setchildaliases Hooked from Init method. To be used to fill out THIS.ChildAliases[]
*afterinit Hooked from init. Runs after all parent class init code runs
*setcaption Uses this.GenericConfirmItem and THIS.SpecificConfirmItem to build a meaningful form caption. Called from init, and RequeryViews
*requerychildviews Requeries all of the views specified in THIS.ChildViews[]
*setbuttontooltips 
*beforedelete 
*afterdelete 
      frmde      macform      1      Class      Pixels      frmde      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
    %           �  P   ]  O�P(S  �1 ��  � � � %�C� glpathb� C��9 � T� �� h:\�� � %�C� ���` � T� �� PRINTER�� �u � T� �� �� � %�C� Issuer�
��� � Q�  �� � Issuer�� � %�C� TMRs�
��� � Q�  �� � TMRs�� � %�C� Counties�
��� Q�  �� � Counties�� � G(� (� Code� %�C� Misc�
��N� Q�  �� � Misc�� � %�C� Legal�
��� Q�  �� � Legal�� � %�C�
 tnIssueridb� N���� T� ��  �� ��� �	 GetIssuer(� � %�C�
 lnIssueridb� N���� B�-�� � � E�	 �� id�� �� E� �� Issuer��	 � ��% %�C�	 � � Counties� Code�
��y�/ R,��% Could not find Cnty in Counties.dbf, �� �" T�� �C�	 � � 2A� a� -6�� T�� ��  �� F� � ��C�� ��� T� �CC�� � M��8���F +�C � �� � M� C� /� COMMENTS	� C� /�	 MACCRETED	���� T�� ��� CC� /��� T� �� ���) %�C� /� ECO� �� 	� C� �
	���� T�� ��� � � �� � �	 7�� � %�C� f� PRINTER��F� %�� ���� ?� TMReady(!"9���� �� ?� TMReady(!9���� � T�� ���� %�C� � �
��B� ?� accreted(!9���� � �*� %��9� -���� T�9� ���� T�9� �� Report Preview�� T�9� �a�� T� �a�� ��� T� �-�� � ?� TMReady����� T�� ���� %�C� � �
��� ?� accreted����� � %�� ��&� T�9� �-�� � � U 
 TNISSUERID TCOUTPUT TLPROMPT GLPATH LCOUTPUT CODE COUNTIES
 LNISSUERID	 GETISSUER ISSUER ID TMRS CNTY
 LSCHOOLRPT TYPE ALLMEMOS	 STRUCTURE I TAX MISC TEXT NOLDPAGE TMREADY	 MACCRETED ACCRETED VISIBLE WINDOWSTATE CAPTION LLREMOVESCREEN� �A � A� � A b�A AqA ��A BqA R�A �� � Q�q A A 2�R�A "� r � �b���A A � �� �� �A � 1�A � � �� � � � A a� 1qA � � A A 3                 0    m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                              WINDOWS _00J0NGG14 674461433      /  F      ]                                (                       WINDOWS _00J0T0BR4 683242606�      �  �  �  �                                                           WINDOWS _00J0WFNYW 683242606}      �  �  �  �                                                           WINDOWS _0190MDOIL 683242606N      \  j  y  �                                                           WINDOWS _00J0NGG15 6832426061  G  _  k            I  �                  �                           WINDOWS _00J0NGG1E 674460802�  �  �      .      �  '                                               WINDOWS _00J0NGG1F 674461053F  X  r  �  �  �        �                                               WINDOWS _00J0NGG1G 674461053   %   ?   N   `   t       �   �"                                               WINDOWS _00J0NGG1H 674460802�$  �$  �$  �$  �$  %                                                           WINDOWS _00J0NGG1I 674461053�%  �%  �%  �%  �%  �%                                                           WINDOWS _00J0NGG1J 674461053I&  Y&  s&  �&  �&  �&                                                           WINDOWS _00J0NGG1O 675765331'  &'  @'  L'  ]'  q'      �)  �*                                               WINDOWS _00J0NGG1P 674453268�+      
,  ,  ',  M,                                                           WINDOWS _00J0NGG1Q 674525980y,      �,  �,  �,  �,      +-  q-                                               WINDOWS _00J0NGG1R 674453268Q.      _.  m.  |.  �.                                                           WINDOWS _00J0NGG1S 674525980�.      �.  �.  �.  /      �/  �/                                               WINDOWS _00J0NGG1T 674458627�0      �0  �0  �0  �0                                                           WINDOWS _00J0NGG1U 674525980%1      41  C1  P1  v1      �1  2                                               WINDOWS _0120ONBCS 675765184�2      3  3  (3  N3                                                           WINDOWS _0120ONBCT 675765184~3      �3  �3  �3  �3                                                           WINDOWS _00J0U0JPP 67636454104  B4  \4  k4  �4  �4                                                           WINDOWS _00J0U0JPS 6763645415   5  :5  G5  X5  l5                                                           WINDOWS _00J0W00NG 675044952�5  �5  6  6  )6  =6      �6  V7                                               WINDOWS _00J0W00NH 675044952f8  v8  �8  �8  �8  �8                                                           WINDOWS _00J0W00NI 6750449529  9  49  D9  X9  l9      �9  :                                               WINDOWS _01B0YKSDU 682774286�:  ;  (;  =;  P;  d;      �;  =<                                               COMMENT RESERVED                                *=                                                            =S                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      dataenvironment      dataenvironment      Dataenvironment      LLeft = 154
Top = 361
Width = 520
Height = 200
Name = "Dataenvironment"
      cursor      cursor      Cursor1      Dataenvironment      �Left = 10
Top = 20
Width = 90
Height = 90
Alias = "issuer"
Database = h:\mac.dbc
CursorSource = "issuer"
Name = "Cursor1"
      cursor      cursor      Cursor2      Dataenvironment      �Left = 150
Top = 20
Width = 90
Height = 90
Alias = "typeissu"
Database = h:\mac.dbc
CursorSource = "typeissu"
Name = "Cursor2"
      cursor      cursor      Cursor3      Dataenvironment      �Left = 290
Top = 20
Width = 90
Height = 90
Alias = "bondcard"
Database = h:\mac.dbc
CursorSource = "bondcard"
Name = "Cursor3"
      4      2      frmgetfromlist      ..\vcx\forms.vcx      form      frmGetIssuer     �Height = 370
Width = 659
Desktop = .T.
DoCreate = .T.
Caption = "Choose Issuer"
Name = "frmGetIssuer"
cmdok.Top = 336
cmdok.Left = 492
cmdok.TabIndex = 5
cmdok.Name = "cmdok"
cmdcancel.Top = 336
cmdcancel.Left = 576
cmdcancel.TabIndex = 6
cmdcancel.Name = "cmdcancel"
cmdAddNew.Top = 336
cmdAddNew.Left = 12
cmdAddNew.TabIndex = 7
cmdAddNew.Name = "cmdAddNew"
lblinstructions.TabIndex = 8
lblinstructions.Name = "lblinstructions"
     oPROCEDURE searchissuer
lcTypedvalue = ALLTRIM(THIS.txtIssuerName.Value)

DO CASE
	CASE LEN(lcTypedvalue) = 0
	CASE LEN(lcTypedvalue) = 4 AND ISDIGIT(RIGHT(lcTypedvalue, 1))
		IF SEEK(lcTypedvalue, "Issuer","Issuer")
			THISFORM.RetVal = Issuer.ID
			THISFORM.Release()
		ELSE
			MESSAGEBOX("Issuer code is not found.", 48, "TMR")
		ENDIF

	OTHERWISE
		SELECT ALLTRIM(Issuer.Desc1) + " " + ALLTRIM(Issuer.Desc2) + " " + ;
				ALLTRIM(Issuer.Desc3) + " " + ALLTRIM(Issuer.Desc4) AS AllName, ;
				Code, Type, id, OldName, Grp1 ;
			FROM Issuer WHERE Desc1 = lcTypedvalue ;
			OR UPPER(OldName) = lcTypedvalue ;
			ORDER BY Desc1, Desc2 ;
			INTO CURSOR QueryResultsTmp
		SELE QueryResults
		ZAP
		APPEND FROM DBF("QueryResultsTmp")
		IF RECCOUNT("QueryResults") > 0
			GO TOP IN QueryResults
			THISFORM.grdIssuer.SetFocus()
		ELSE
			WAIT WINDOW "No issuer found..." NOWAIT
		ENDIF
		THISFORM.txtIssuerCount.Value = RECCOUNT("QueryResults")
		THISFORM.Refresh()
ENDCASE

ENDPROC
PROCEDURE setfilter
SELE QueryResults

IF !EMPTY(TypeIssu.Code) AND THISFORM.chkSetFilter.Value
	SET FILTER TO Type = TypeIssu.Code 
ELSE
	SET FILTER TO
ENDIF
 
 
GO TOP
THISFORM.Refresh()

ENDPROC
PROCEDURE issuercolor
LPARA lcGrp

DO CASE
	CASE lcGrp = "G"
		lnColor = RGB(0,255,0)
	OTHERWISE
		lnColor = 0	
ENDCASE


RETURN lnColor
ENDPROC
PROCEDURE typecolor
LPARA lcType

DO CASE
	CASE lcType = "1S"
		lnColor = 255
	OTHERWISE
		lnColor = 0
ENDCASE

RETURN lnColor
ENDPROC
PROCEDURE Load
DODEFAULT()
CREATE CURSOR QueryResults (Code C(4), ;
							Type C(2), ;
							AllName C(140), ;
							OldName C(120),;
							ID I, ;
							Grp1 C(3))
						
							
SET SAFETY OFF

ENDPROC
PROCEDURE KeyPress
LPARAMETERS nkeycode,nshiftaltctrl
IF nKeyCode = 13
	IF THISFORM.ActiveControl = THISFORM.grdIssuer
		thisform.cmdok.click()
		nodefault
	ENDIF
ENDIF

ENDPROC
PROCEDURE cmdok.Click
IF !EMPTY(QueryResults.ID)
	THISFORM.RetVal = QueryResults.Id
	THISFORM.Release()
ELSE
	MESSAGEBOX("Please select an issuer before continuing, or click Cancel.", 48, "TMR")
ENDIF

ENDPROC
     ����    �  �                        �   %   �      �  H   o          �  U  0 T�  �C� � � ��� H�" �)� �C�  >� ��5 �! �C�  >�� CC�  �R�	��� �! %�C�  � Issuer� Issuer���� � T� � �� � �� ��C� � �� �� �. ��C� Issuer code is not found.�0� TMR�x�� � 2�)�� o� Issuer�C� �	 ��  C� �
 ��  C� � ��  C� � ��Q� �� ��� ��� ��� ��� ����	 �  �
 C� f�  ����	 ���
 ���� QueryResultsTmp� F� � S� �C� QueryResultsTmp&�� %�C� QueryResultsN� ����	 #� )� ��C� � � �� ��� R,:�� No issuer found...�� �! T� � � �C� QueryResultsN�� ��C� � �� � U  LCTYPEDVALUE THIS TXTISSUERNAME VALUE THISFORM RETVAL ISSUER ID RELEASE DESC1 DESC2 DESC3 DESC4 ALLNAME CODE TYPE OLDNAME GRP1 QUERYRESULTSTMP QUERYRESULTS	 GRDISSUER SETFOCUS TXTISSUERCOUNT REFRESH`  F�  �  %�C� � �
�
 � � � 	��9 � G(�� � � �� �G � G(� � #)� ��C� � �� U  QUERYRESULTS TYPEISSU CODE THISFORM CHKSETFILTER VALUE TYPE REFRESHa  ��  � H� �Q � ��  � G��< � T� �C� ��� �^�� 2�Q � T� �� �� �	 B�� �� U  LCGRP LNCOLORY  ��  � H� �I � ��  � 1S��4 � T� ����� 2�I � T� �� �� �	 B�� �� U  LCTYPE LNCOLORz 	 ��C���h h�� QueryResults� � C���� � C���� � C����� � C��x�� � I� � C���� G.� U  QUERYRESULTS CODE TYPE ALLNAME OLDNAME ID GRP1R  ��  � � %��  ���K � %�� � � � ��G � ��C� � � �� �� � � U  NKEYCODE NSHIFTALTCTRL THISFORM ACTIVECONTROL	 GRDISSUER CMDOK CLICK�  %�C�  � �
��3 � T� � ��  � �� ��C� � �� �� �P ��C�; Please select an issuer before continuing, or click Cancel.�0� TMR�x�� � U  QUERYRESULTS ID THISFORM RETVAL RELEASE searchissuer,     ��	 setfilter>    �� issuercolor�    ��	 typecolorc    �� Load�    �� KeyPress�    �� cmdok.Click&    ��1 Q� 11� � �A � �	q A ��� � �A � A 3 q !� a A S � 3 q � !a� � A � 2 q � 1� � � A � 2 � �c 3 � qA A A 3 11� � A 2                       �        
  �  $   #   �  \  2   ,   |  �  ?   5   
  �  K   9   �  �  X   A   �  d  b    )   �                        9*searchissuer 
*setfilter 
*issuercolor 
*typecolor 
      
mactextbox      ..\vcx\macbase.vcx      textbox      txtIssuerName      frmGetIssuer      dFormat = "k!"
Height = 23
Left = 12
TabIndex = 1
Top = 48
Width = 156
Name = "txtIssuerName"
      �PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 13
	THISFORM.SearchIssuer()
	NODEFAULT
ENDIF

ENDPROC
     ���    �   �                         �O   %   �       �      �           �  U  4  ��  � � %��  ���- � ��C� � �� �� � U  NKEYCODE NSHIFTALTCTRL THISFORM SEARCHISSUER KeyPress,     ��1 � � A A 2                       z       )   �                         
mactextbox      ..\vcx\macbase.vcx      textbox      txtCUSIP      frmGetIssuer      nFormat = "k!"
Height = 23
Left = 564
MaxLength = 6
TabIndex = 3
Top = 48
Width = 84
Name = "txtCUSIP"
     �PROCEDURE Valid
lcCUSIP = ALLTRIM(THIS.Value)
IF LEN(lcCUSIP) = 6
	SELE Issuer.ID FROM Issuer, BondCard, DebtSvs ;
		WHERE DebtSvs.ParentID = BondCard.ID ;
		AND BondCard.ParentID = Issuer.ID ;
		AND DebtSvs.CUSIP6 = lcCUSIP ;
		INTO CURSOR QueryResultsTmp
	
	IF _TALLY > 0
		THISFORM.RetVal = QueryResultsTmp.id
		THISFORM.Release()
	ELSE
		MESSAGEBOX("CUSIP6 not found", 64, "TMR")
		RETURN 0
	ENDIF
ENDIF

ENDPROC
     4���                              �_   %   �      �     �          �  U   T�  �C� � ��� %�C�  >���� �p o� Issuer� BondCard� DebtSvs�� � ���� � � � � � � � � 	� � � �  	���� QueryResultsTmp� %�� � ��� � T�
 � ��	 � �� ��C�
 � �� �� �% ��C� CUSIP6 not found�@� TMR�x��	 B�� �� � � U  LCCUSIP THIS VALUE ISSUER ID BONDCARD DEBTSVS PARENTID CUSIP6 QUERYRESULTSTMP THISFORM RETVAL RELEASE Valid,     ��1 !11� � Q� A A 2                       �      )                           
mactextbox      ..\vcx\macbase.vcx      textbox      
txtRegNumb      frmGetIssuer      pFormat = "k!"
Height = 23
Left = 456
MaxLength = 5
TabIndex = 2
Top = 48
Width = 60
Name = "txtRegNumb"
     �PROCEDURE Valid
lcRegNumb = ALLTRIM(THIS.Value)
IF LEN(lcRegNumb) = 5
	SELE Issuer.ID FROM Issuer, BondCard ;
		WHERE BondCard.ParentID = Issuer.id ;
		AND BondCard.RegNUmb = lcRegNumb ;
		INTO CURSOR QueryResultsTmp
	
	IF _TALLY > 0
		THISFORM.RetVal = QueryResultsTmp.id
		THISFORM.Release()
	ELSE
		MESSAGEBOX("Reg Number not found", 64, "TMR")
		RETURN 0
	ENDIF
ENDIF

	

ENDPROC
     ���    �  �                           %   �      �     �          �  U  �  T�  �C� � ��� %�C�  >���� �T o� Issuer� BondCard�� � ���� � � � � � � �  	���� QueryResultsTmp� %�� � ��� � T�	 �
 �� � �� ��C�	 � �� �� �) ��C� Reg Number not found�@� TMR�x��	 B�� �� � � U 	 LCREGNUMB THIS VALUE ISSUER ID BONDCARD PARENTID REGNUMB QUERYRESULTSTMP THISFORM RETVAL RELEASE Valid,     ��1 !1D1� � �� A A 4                       �      )   �                        maclabel      ..\vcx\macbase.vcx      label      	Maclabel1      frmGetIssuer      vCaption = "\<Issuer name or number"
Height = 15
Left = 12
Top = 36
Width = 132
TabIndex = 9
Name = "Maclabel1"
      maclabel      ..\vcx\macbase.vcx      label      	Maclabel2      frmGetIssuer      eCaption = "CUSIP"
Height = 15
Left = 564
Top = 36
Width = 36
TabIndex = 10
Name = "Maclabel2"
      maclabel      ..\vcx\macbase.vcx      label      	Maclabel3      frmGetIssuer      jCaption = "Reg Number"
Height = 15
Left = 456
Top = 36
Width = 96
TabIndex = 11
Name = "Maclabel3"
      macgrid      ..\vcx\macbase.vcx      grid      	grdIssuer      frmGetIssuer     |ColumnCount = 4
Height = 204
Left = 12
Panel = 1
ScrollBars = 3
TabIndex = 4
Top = 120
Width = 636
Name = "grdIssuer"
Column1.ControlSource = "QueryResults.Code"
Column1.Width = 46
Column1.Name = "Column1"
Column2.ControlSource = "QueryResults.Type"
Column2.Width = 34
Column2.DynamicForeColor = "THISFORM.TypeColor(QueryResults.Type)"
Column2.Name = "Column2"
Column3.ControlSource = "QueryResults.AllName"
Column3.Width = 487
Column3.DynamicForeColor = ""
Column3.DynamicFontBold = 'Grp1="G"'
Column3.Name = "Column3"
Column4.ControlSource = "QueryResults.oldname"
Column4.Width = 180
Column4.Name = "Column4"
      �PROCEDURE createindextags
INDEX ON AllName TAG AllName
INDEX ON Code TAG Code
INDEX ON Type TAG Type

ENDPROC
PROCEDURE DblClick
THISFORM.cmdOk.Click()

ENDPROC
     L���    3  3                        9   %   �       �      �           �  U  -  & ��  ���  � & �� ��� � & �� ��� � U  ALLNAME CODE TYPE  ��C�  � � �� U  THISFORM CMDOK CLICK createindextags,     �� DblClickr     ��1 � � � 3 2                       i         �   �       )   3                        header      header      Header1      frmGetIssuer.grdIssuer.Column1      $Caption = "Code"
Name = "Header1"
      textbox      textbox      Text1      frmGetIssuer.grdIssuer.Column1      YBorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "Text1"
      >PROCEDURE DblClick
THIS.Parent.Parent.DblClick()

ENDPROC
      ����    �   �                         �   %   ^       v      p           �  U    ��C�  � � � �� U  THIS PARENT DBLCLICK DblClick,     ��1 12                       3       )   �                         header      header      Header1      frmGetIssuer.grdIssuer.Column2      $Caption = "Type"
Name = "Header1"
      textbox      textbox      Text1      frmGetIssuer.grdIssuer.Column2      YBorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "Text1"
      >PROCEDURE DblClick
THIS.Parent.Parent.DblClick()

ENDPROC
      ����    �   �                         �   %   ^       v      p           �  U    ��C�  � � � �� U  THIS PARENT DBLCLICK DblClick,     ��1 12                       3       )   �                         header      header      Header1      frmGetIssuer.grdIssuer.Column3      &Caption = "Issuer"
Name = "Header1"
      textbox      textbox      Text1      frmGetIssuer.grdIssuer.Column3      YBorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "Text1"
      >PROCEDURE DblClick
THIS.Parent.Parent.DblClick()

ENDPROC
      ����    �   �                         �   %   ^       v      p           �  U    ��C�  � � � �� U  THIS PARENT DBLCLICK DblClick,     ��1 12                       3       )   �                         header      header      Header1      frmGetIssuer.grdIssuer.Column4      (Caption = "Old Name"
Name = "Header1"
      textbox      textbox      Text1      frmGetIssuer.grdIssuer.Column4      YBorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "Text1"
      
mactextbox      ..\vcx\macbase.vcx      textbox      txtIssuerCount      frmGetIssuer      sBorderStyle = 0
Left = 372
ReadOnly = .T.
SpecialEffect = 1
TabIndex = 12
Top = 336
Name = "txtIssuerCount"
      maclabel      ..\vcx\macbase.vcx      label      	Maclabel4      frmGetIssuer      gCaption = "Count:"
Height = 15
Left = 331
Top = 338
Width = 37
TabIndex = 13
Name = "Maclabel4"
      maccombobox      ..\vcx\macbase.vcx      combobox      	cboFilter      frmGetIssuer      �ColumnCount = 2
ColumnWidths = "400,24"
RowSourceType = 6
RowSource = "typeissu.Desc, Code"
Height = 23
Left = 12
Top = 96
Width = 372
Name = "cboFilter"
      fPROCEDURE InteractiveChange
IF THISFORM.chkSetFilter.Value
	THISFORM.SetFilter()
ENDIF

ENDPROC
     ���    �   �                         u   %   �       �      �           �  U  '  %��  � � ��  � ��C�  � �� � U  THISFORM CHKSETFILTER VALUE	 SETFILTER InteractiveChange,     ��1 1� A 2                       [       )   �                         maclabel      ..\vcx\macbase.vcx      label      	Maclabel5      frmGetIssuer      =Caption = "Filter"
Left = 12
Top = 84
Name = "Maclabel5"
      maccheckbox      ..\vcx\macbase.vcx      checkbox      chkSetFilter      frmGetIssuer      ^Top = 96
Left = 396
Height = 16
Width = 72
Caption = "Set Filter"
Name = "chkSetFilter"
      <PROCEDURE InteractiveChange
THISFORM.SetFilter()
ENDPROC
      ����    �   �                         �   %   U       v      p           �  U    ��C�  � �� U  THISFORM	 SETFILTER InteractiveChange,     ��1 � 1                       1       )   �                         maccommandbutton      ..\vcx\macbase.vcx      commandbutton      cmdPrintAll      frmGetIssuer      `Top = 336
Left = 96
Height = 23
Width = 84
Caption = "Print Current"
Name = "cmdPrintAll"
      iPROCEDURE Click
DO PrintTMR WITH QueryResults.Id, "Printer", .T.
*THISFORM.PrintForm()
				
ENDPROC
      ����    �   �                            %   n       �      }           �  U  "  �  �� � �� Printer��a�� U  PRINTTMR QUERYRESULTS ID Click,     ��1 �3                       ^       )   �                         !Arial, 0, 9, 5, 15, 12, 32, 3, 0
0 !   m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Class                                                                                               WINDOWS _RYZ0QK3NJ 657282444H  �  �  7      �                      i  `              �  v           COMMENT RESERVED                        �      �                                                           WINDOWS _RZS0VTJJG 6572824519      )      <      �  �.          Z  Q  �          �  g           COMMENT RESERVED                        �      �                                                           WINDOWS _S6B0RARNC 657282458{  �    j      7      g  O%          �  �              �  �           COMMENT RESERVED                        �      �                                                           WINDOWS _S680ZFTOW 657282475�-  �+  �+  �-      �+      ,  ?&          �-  �-              .  �-           COMMENT RESERVED                        .      -.                                                           WINDOWS _S681108P5 657282516H*  �5  o5  `*      P6      �6  D!          B%  ?*              �)  �)           COMMENT RESERVED                        �)      �)                                                           WINDOWS _S680ZSHY6 657282522$  \)  G)  �      %      �(  S           �  �              �  =           COMMENT RESERVED                        �                                                                 WINDOWS _S680ZH3XI 657282531�$  g  �  '      0$      `$  �          �$  �$              �$               COMMENT RESERVED                        �$      �$                                                           WINDOWS _S680ZESNL 6572825383  4)  o)  q*      �,      �4  �          �-  6&              �+  �4           COMMENT RESERVED                        64      �4                                                           WINDOWS _S680ZDR5B 657282544V.  6  !4  �.      5      :5  �          �-  �              �-  �3           COMMENT RESERVED                        f      �3                                                           WINDOWS _S7W0O83LH 662067382�
  r	  �	  s
      �	      
  �          �
  �
              �
               COMMENT RESERVED                        �
      �
                                                           WINDOWS _S6N0Q0TED 662073193�5      '3      $6      3  �          �3  �*              |-  �3           COMMENT RESERVED                        n-      n.                                                           WINDOWS _S7W0O7BXB 662073346-  [-  F-  0-      �5      53  �          -  -              �+               COMMENT RESERVED                        �,      �,                                                           WINDOWS _S7W0O29W0 662074135l  )  �  �      �#      C#  a          �  �              �               COMMENT RESERVED                        �      z                                                           WINDOWS _S6Q0MRA1B 662198010d+  �,  �+  |+      E4      �I  �          W+  �(  �1          �*  �*           COMMENT RESERVED                        �*      �*                                                           WINDOWS _S6Q0N4O03 662198018;(  �(  �(  S(      g(      �F             &  -&  50          5#               COMMENT RESERVED                        !#      �"                                                           WINDOWS _RVE0UM8EF 662198026A	  �"  �"  Y	      n'  �  O;  u          +	  8	  7          	  y"           COMMENT RESERVED                        �      �                                                            Lt                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00     q���    X  X                        �   %   �      �     �          �  U    %�C�  � +
�
 C�  � 
	���$ ��  � �(� �� � �C�  � ���" T� �C� THIS.Parent.�  � ��� %�C� lnNewIDb� L��� T�	 �� � �� ��C�  � ��� T�
 �CW�� F��  � �� -�� � ��
 F��
 �� %�C�  � �
��� � ��C� � �� � ��C� � �� ��C�  � �� � � U  THIS
 CHILDALIAS EDITFORM THISFORM	 CURRENTID CHILDALIASPK LNNEWID OGRID LINKEDGRIDNAME LNID LNSELECT ID REFRESH SETFOCUS	 AFTEREDIT�  %�C�  � �
�	 C�  � �	��z �" T� �C� THIS.Parent.�  � ��� T� �� � ��) T�  � �� Edit the highlighted � �� � U  THIS LINKEDGRIDNAME TOOLTIPTEXT OGRID LCCONFIRMITEM GENERICCONFIRMITEM Click,     �� Refresh�    ��1 A!�� � � � � 1� A � � A A 2 �!�A 2                       �          �      )   X                       #���    
  
                        ?   %   c      �     �          �  U  v  %�C�  � �
�	 C�  � �	��o �" T� �C� THIS.Parent.�  � ��� T� �� � �� T�  � ��
 Add a new � �� � U  THIS LINKEDGRIDNAME TOOLTIPTEXT OGRID LCCONFIRMITEM GENERICCONFIRMITEM�  ��  � �(� �� � � %�C� lnNewIDb� L��� � T� �� � �� ��C�  � ��� T� �CW�� F��  � �� -�� � ��
 F�� �� %�C�  �	 �
��� �" T�
 �C� THIS.Parent.�  �	 ��� ��C�
 � �� ��C�
 � �� � ��C�  � �� � U  THIS ADDFORM THISFORM	 CURRENTID LNNEWID LNID
 CHILDALIAS LNSELECT ID LINKEDGRIDNAME OGRID REFRESH SETFOCUS AFTERADD Refresh,     �� Click�     ��1 �!�A 3 ��� � � � � 1!� � A � A 2                       �           �  	    )   
                        !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      cmddeletefromgrid      ogrid^
deleterecord^
      Pixels      Class      1      maccommandbutton      cmddeletefromgrid      buttons.vcx      commandbutton      `Height = 24
Width = 24
Picture = ..\bmp\delete.bmp
Caption = ""
Name = "cmdpicdeletechild"
      iPROCEDURE Click
oGrid = EVALUATE("THIS.Parent." + THIS.LinkedGridName)
oGrid.DeleteChild()

ENDPROC
      cmdpicdeletechild      cmddeletefromgrid      1      Class      Pixels      cmdpicdeletechild      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      macbase.vcx      commandbutton      ,PROCEDURE Click
THISFORM.Add()

ENDPROC
      macbase.vcx      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      cmdpiceditchild      macbase.vcx      commandbutton      Pixels      1      6Cancel = .T.
Caption = "Cancel"
Name = "cmdcancel"
      	cmdcancel      maccommandbutton      1      Class      %Reverts all changes and releases form      Pixels      	cmdcancel      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      Class      1      macbase.vcx      commandbutton      buttons.vcx      CCancel = .T.
Caption = "Close"
TabIndex = 36
Name = "cmdclose"
      �PROCEDURE Init
DODEFAULT()
IF EMPTY(THIS.ToolTipText)
	THIS.ToolTipText = "Save changes and close this form"
ENDIF

ENDPROC
PROCEDURE Click
IF THIS.BeforeClose()
	THISFORM.Release()
ENDIF

ENDPROC
     ���    �   �                         �(   %   �       �      �           �  U  2 " T�  �C� THIS.Parent.� � ��� ��C�  � �� U  OGRID THIS LINKEDGRIDNAME	 EDITCHILD Click,     ��1 !� 2                       \       )   �                         cmdeditchild      cmdpiceditchild      commandbutton      commandbutton      cmdok      Pixels      E*beforeclose Put custom code here to run before the form is closed.
      cmdclose      maccommandbutton      1      Class      &Check for dirty buffer and closes form      Pixels      cmdclose      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      Class      cmdok      1      macbase.vcx      commandbutton      cmdprint      (Caption = "Delete"
Name = "cmddelete"
      -PROCEDURE Click
THISFORM.Delete()
ENDPROC
      ����    �   �                         f�   %   O       d      ^           �  U    ��C�  � �� U  THISFORM ADD Click,     ��1 � 2                       !       )   �                         	cmddelete      maccommandbutton      1      Class      Calls form's delete method.      Pixels      	cmddelete      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      !Saves all changes and closes form      cmdundo     Q���    8  8                        ^j   %   x      �  H   �          �  U  �  %�C�  � �
��� � T� ��  � � �� %�C� +
��� � %��  � 
� C�  � ��� � �� �� %�C � � � ��� � H�� ����� %�C� +��� � #�� �6� � ��C�  � �	 �� ��C�  �	 �� ��C�  � �
 �� B�a�� �� � B�-�� � � � � B�-�� U  THIS LINKEDGRIDNAME CALIAS OGRID RECORDSOURCE LCONFIRMDELETE CONFIRMDELETE THISFORM UPDATETABLE REFRESH SETFOCUS6 H� �� � �CC�  � ��
��_ �= T� ��  Are you sure you want to delete CC�  � Λ� ?�� �CC�  � ��
��� �@ T� ��% Are you sure you want to delete this C�  � �� ?�� 2�� �9 T� ��, Are you sure you want to delete this record?�� �  %�C� �$� Delete�x��� � B�a�� �/� B�-�� � U  THIS SPECIFICDELETEITEM CMESSAGE GENERICDELETEITEMf ) %�C� this.parent.C�  � �b� O��P �' T�  � �C� this.parent.C�  � ���� �_ � B�-�� � U  THIS LINKEDGRIDNAME OGRID  T�  � ���� U  THIS OGRID�  %�C�  � �
�	 C�  � �	��| �" T� �C� THIS.Parent.�  � ��� T� �� � ��+ T�  � �� Delete the highlighted � �� � U  THIS LINKEDGRIDNAME TOOLTIPTEXT OGRID LCCONFIRMITEM GENERICCONFIRMITEM� 	 ��C��� %�C�  � ���� � %�C�  � �
��p �B T�  � �� Delete the highlighted C�  � ��  from the list�� �� �9 T�  � ��) Delete the highlighted item from the list�� � � U  THIS TOOLTIPTEXT GENERICDELETEITEM�  T�  � �a��' %�C� � � C� � 	� C� � 	��d � ��C� � �� ��C� � �� T�  � �-�� B�a�� �� � ��C� � �� T�  � �-�� B�-�� � U  THISFORM
 LOCKSCREEN THIS
 GETGRIDREF BEFOREDELETE DELETERECORD AFTERDELETE RELEASEGRIDREF deleterecord,     �� confirmdelete�    ��
 getgridref    �� releasegridref�    �� Refresh�    �� Init�    �� Click~    ��1 11�� Q� � A � q � q A A A A r 2 � Q�Q� �A q � q A 3 �q� q A 3 � 3 �!�A 3 � !1!� �A A 2 � q� � � q � � � q A 3                       (        L       %   ;  �  +   +   �    3   -   /  
  7   3   %  A
  K   <   ]
  d  _    )   8                       ���    �   �                         ~   %   �       �      �           �  U  2 " T�  �C� THIS.Parent.� � ��� ��C�  � �� U  OGRID THIS LINKEDGRIDNAME ADDCHILD Click,     ��1 !� 2                       [       )   �                        ���    �   �                         �A   %   �       �      �           �  U  2 " T�  �C� THIS.Parent.� � ��� ��C�  � �� U  OGRID THIS LINKEDGRIDNAME DELETECHILD Click,     ��1 !� 2                       ^       )   �                         ����    �   �                         ��   %   P       e      _           �  U    ��C�  � �� U  THISFORM UNDO Click,     ��1 � 2                       "       )   �                         ����    �   �                         ��   %   P       e      _           �  U    ��C�  � �� U  THISFORM SAVE Click,     ��1 � 1                               )   �                         ����    �   �                         H�   %   Q       f      `           �  U    ��C�  � �� U  THISFORM PRINT Click,     ��1 � 2                       #       )   �                         ����    �   �                         ��   %   n       �      }           �  U  %  %�C�  � �� � ��C�  � �� � U  THISFORM SAVE RELEASE Click,     ��1 � A 2                       A       )   �                        -���                              ~)   %   �       �      �           �  U    T�  � �C� � �
�� U  THIS VISIBLE THISFORM
 LOOKUPFORM  ��C�  � �� U  THISFORM LOOKUP Init,     �� Clickn     ��1 a2 � 2                       :         V   i       )                           ODelete button linked to a bound grid. Instructions for use are in init method.      commandbutton      macbase.vcx      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      cmdeditchild      Pixels      gPROCEDURE Click
oGrid = EVALUATE("THIS.Parent." + THIS.LinkedGridName)
oGrid.EditChild()

ENDPROC
      ^Height = 24
Width = 24
Picture = ..\bmp\modify.bmp
Caption = ""
Name = "cmdpiceditchild"
      maccommandbutton      (Caption = "\<Print"
Name = "cmdprint"
      .PROCEDURE Click
THISFORM.Print()

ENDPROC
      maccommandbutton      1      Class      Pixels      cmdprint      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      /Caption = "Ok"
Default = .T.
Name = "cmdok"
      Class      ����    �   �                         D   %   R       g      a           �  U    ��C�  � �� U  THISFORM DELETE Click,     ��1 � 1                       "       )   �                         Class      1      1     '���                              ��   %   �       �      �           �  U    ��C�  � �� U  THISFORM EDIT  T�  � �� � 
�� U  THIS VISIBLE THISFORM AUTOEDIT Click,     �� InitP     ��1 � 2 A2                                 ;   ^       )                           �Height = 23
Width = 74
Caption = "Delete"
TabIndex = 12
linkedgridname = 
lconfirmdelete = .T.
genericdeleteitem = 
specificdeleteitem = 
editmodeenabled = .F.
Name = "cmddeletefromgrid"
      maccommandbutton      cmdeditchild      @Caption = "Edit"
editmodeenabled = .F.
Name = "cmdeditchild"
      commandbutton      macbase.vcx      1      LPROCEDURE Click
IF THISFORM.Save()
	THISFORM.Release()
ENDIF

ENDPROC
      macbase.vcx      commandbutton      macbase.vcx      commandbutton      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      	cmdlookup      Pixels      kCalls the form specified in FORM.LookupForm, and uses the return value to REQUERY the current form's views.      1      maccommandbutton      	cmdlookup      cmdsave      1      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      cmdaddchild      Pixels      |Calls the form specified in its EditForm property, passes it the parent form's CurrentID, REQUERYs the child view on return.      Class      maccommandbutton      cmdaddchild      Pixels      Pixels      macbase.vcx      commandbutton      commandbutton      &Caption = "E\<dit"
Name = "cmdedit"
      iPROCEDURE Click
THISFORM.Edit()
ENDPROC
PROCEDURE Init
THIS.Visible = !THISFORM.AutoEdit

ENDPROC
      macbase.vcx      &Caption = "\<Save"
Name = "cmdsave"
      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      cmdpicaddchild      Class      1      cmdaddchild      cmdpicaddchild      commandbutton      buttons.vcx      cmdadd      Pixels      Pixels      Class      Class      cmdedit      maccommandbutton      1      Class      Calls form's edit method.      Pixels      cmdedit      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      maccommandbutton      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
      cmdundo     ����    n  n                        _L   %   �         
             �  U  R 	 ��C��� %�C�  � ���K �0 T�  � ��  Save changes and close this form�� � U  THIS TOOLTIPTEXT%  %�C�  � �� � ��C� � �� � U  THIS BEFORECLOSE THISFORM RELEASE Init,     �� Click�     ��1 � !A 3 � A 2                       x         �   �       )   n                       }editform The name of the form to be used to edit the child records.
childalias The cursor whose record will be edited. Used to REQUERY after the edit is done.
linkedgridname the name of a grid in the same container that displays data from the child alias
childaliaspk The name of the primary key field in the child alias
*afteredit HOok method to run after the edit operation
     Maddform Form to be used to add the child record. The form is passed the value of the parent record's PK.
linkedgridname Name of the grid in the same container as this button that display child records.
childalias Name of the child alias that this button is adding records to.
*afteradd Hook method to run after the add operation
      maccommandbutton      cmdadd      fPROCEDURE Click
oGrid = EVALUATE("THIS.Parent." + THIS.LinkedGridName)
oGrid.AddChild()

ENDPROC
      Calls the form's Add method      Class      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      Calls the form's undo method.      commandbutton      cmdsave      >Caption = "Add"
editmodeenabled = .F.
Name = "cmdaddchild"
      +PROCEDURE Click
THISFORM.Save()
ENDPROC
      Calls the form's save method.      !Arial, 0, 9, 5, 15, 12, 16, 3, 0
      &Caption = "\<Undo"
Name = "cmdundo"
      -PROCEDURE Click
THISFORM.Undo()

ENDPROC
      commandbutton      macbase.vcx      ZHeight = 24
Width = 24
Picture = ..\bmp\new.bmp
Caption = ""
Name = "cmdpicaddchild"
      maccommandbutton      macbase.vcx      $Caption = "\<Add"
Name = "cmdadd"
      -Caption = "\<Lookup..."
Name = "cmdlookup"
      tPROCEDURE Init
THIS.Visible = !EMPTY(THISFORM.Lookupform)
ENDPROC
PROCEDURE Click
THISFORM.Lookup()

ENDPROC
     Flinkedgridname Name of grid in the same container that delete button deletes records for.
lconfirmdelete Set to .T. if user is asked to confirm before deleting. 
ogrid Temporarily stores an object reference to the grid.
genericdeleteitem Optional. used to name the entity to be deleted when confirming the delete. ex:this.genericdeletitem = "member" yields 'are you sure you want ot delete this member?'
specificdeleteitem (optional) Fill in with the field name to show in the confirm delete messagebox> ex: this.specificdeleteitem = memb.fname + " " + memb.lname yields "Are you sure you want to delete John Smith?"
*deleterecord 
*beforedelete Put code to run here before delete code is run
*afterdelete Put code here to run after delete is determined successful.
*confirmdelete Asks the user if she is sure about the deletion. For custom confirmation, just write over and return .T. from this method.
*getgridref uses linkedgridname property to set get an object reference to the grid and store it in this.ogrid.
*releasegridref Releases the object reference stored in this.ogrid
     oPROCEDURE deleterecord
IF !EMPTY(THIS.LinkedGridName)
	calias = this.oGrid.RecordSource
	IF !EOF(cAlias)
		if !THIS.lConfirmDelete or THIS.ConfirmDelete()
			DELETE IN (cAlias)
			IF THISFORM.UpdateTable(cAlias)
				SKIP 1 IN (calias)
				IF EOF(calias)
					GO BOTTOM IN (cAlias)
				ENDIF
				THIS.oGrid.REFRESH()
				THIS.Refresh()
				THIS.oGrid.SETFOCUS() && To update grid's pointer and dynamic properties
				RETURN .T.
			ELSE
				RETURN .F.
			ENDIF
		ENDIF
	ENDIF
ENDIF

RETURN .F. && If any of the above conditions fail
ENDPROC
PROCEDURE confirmdelete
DO CASE
	CASE !EMPTY(ALLTRIM(THIS.SpecificDeleteItem))
		cMessage = 'Are you sure you want to delete ' + ALLTRIM(EVAL(THIS.SpecificDeleteItem)) + '?'
	CASE !EMPTY(ALLTRIM(THIS.GenericDeleteItem))
		cMessage = 'Are you sure you want to delete this ' + ALLTRIM(THIS.GenericDeleteItem) + '?'
	OTHERWISE
		cMessage = 'Are you sure you want to delete this record?'
ENDCASE


IF MESSAGEBOX(cMessage,4+32,"Delete") = 6
	RETURN .T.
ELSE
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE getgridref
IF TYPE('this.parent.' + ALLTRIM(this.linkedgridname)) = "O" 
	this.ogrid = EVAL('this.parent.' + ALLTRIM(this.linkedgridname))
ELSE
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE releasegridref
this.ogrid = .NULL.

ENDPROC
PROCEDURE Refresh
*!*	IF THIS.GetGridRef()
*!*		calias = this.oGrid.RecordSource
*!*		
*!*		IF RECCOUNT(cAlias) = 0 OR EOF(cAlias) OR BOF(cAlias)
*!*			THIS.Enabled = .F.
*!*		ELSE
*!*			THIS.Enabled = .T.
*!*		ENDIF
*!*	ENDIF

*!*	THIS.ReleaseGridRef()

IF !EMPTY(THIS.LinkedGridName) AND EMPTY(THIS.ToolTipText)
	oGrid = EVAL("THIS.Parent." + THIS.LinkedGridName)
	lcConfirmItem = oGrid.GenericConfirmItem
	THIS.ToolTipText = "Delete the highlighted " + lcConfirmItem
ENDIF

ENDPROC
PROCEDURE Init
* this button is to be used in conjunction with a databound grid
* The only property that needs to be set is the name of the grid
* in the same container as the button. The button evaluates the grid's 
* recordsource, confirms the delete, and updates the cursor afterward.

* Note- this button should only be used on cursors with 
* table buffering enabled. When used on cursors with row
* buffering, I have been able to produce update conflict errors
* with certain combinations of deleting and navigating in the grid

DODEFAULT()
IF EMPTY(THIS.ToolTipText) 
	IF !EMPTY(THIS.GenericDeleteItem)
		THIS.ToolTiptext = "Delete the highlighted " + ALLTRIM(THIS.GenericDeleteItem) + " from the list"
	ELSE
		THIS.ToolTiptext = "Delete the highlighted item from the list"
	ENDIF
ENDIF	
ENDPROC
PROCEDURE Click
THISFORM.Lockscreen = .T.
IF THIS.GetGridRef() and THIS.BeforeDelete() and THIS.DeleteRecord()
	THIS.AfterDelete()
	THIS.ReleaseGridRef()
	THISFORM.LockScreen = .F.
	RETURN .T.
ELSE
	THIS.ReleaseGridRef()
	THISFORM.LockScreen = .F.
	RETURN .F.
ENDIF


ENDPROC
     PROCEDURE Click
IF !EOF(THIS.ChildAlias) AND !BOF(THIS.ChildAlias)
	DO FORM (THIS.EditForm) WITH THISFORM.CurrentID, EVAL(THIS.ChildAliasPK) TO lnNewID
	oGrid = EVAL("THIS.Parent." + THIS.LinkedGridname)

	IF TYPE("lnNewID") <> "L"
		lnid = THISFORM.CurrentID
		REQUERY(THIS.ChildAlias)
		lnSelect = SELECT()
		SELE (THIS.ChildAlias)
		LOCATE FOR id = lnNewID
		SELECT (lnSelect)
		IF !EMPTY(THIS.LinkedGridName)
			oGrid.Refresh()
		ENDIF
		oGrid.SetFocus()
		THIS.AfterEdit()
	ENDIF
ENDIF
ENDPROC
PROCEDURE Refresh
IF !EMPTY(THIS.LinkedGridName) AND EMPTY(THIS.ToolTipText)
	oGrid = EVAL("THIS.Parent." + THIS.LinkedGridName)
	lcConfirmItem = oGrid.GenericConfirmItem
	THIS.ToolTipText = "Edit the highlighted " + lcConfirmItem
ENDIF

ENDPROC
     �PROCEDURE Refresh
IF !EMPTY(THIS.LinkedGridName) AND EMPTY(THIS.ToolTipText)
	oGrid = EVAL("THIS.Parent." + THIS.LinkedGridName)
	lcConfirmItem = oGrid.GenericConfirmItem
	THIS.ToolTipText = "Add a new " + lcConfirmItem
ENDIF
	
ENDPROC
PROCEDURE Click
DO FORM (THIS.AddForm) WITH THISFORM.CurrentID TO lnNewID
IF TYPE("lnNewID") <> "L"
	lnid = THISFORM.CurrentID
	REQUERY(THIS.ChildAlias)
	lnSelect = SELECT()
	SELE (THIS.ChildAlias)
	LOCATE FOR id = lnNewID
	SELECT (lnSelect)
	IF !EMPTY(THIS.LinkedGridName)
		oGrid = EVAL("THIS.Parent." + THIS.LinkedGridname)
		oGrid.Refresh()
		ogrid.SetFocus()
	ENDIF
	THIS.AfterAdd()
ENDIF

ENDPROC
0    m                   PLATFORM   C                  UNIQUEID   C	   
               TIMESTAMP  N   
               CLASS      M                  CLASSLOC   M!                  BASECLASS  M%                  OBJNAME    M)                  PARENT     M-                  PROPERTIES M1                  PROTECTED  M5                  METHODS    M9                  OBJCODE    M=                 OLE        MA                  OLE2       ME                  RESERVED1  MI                  RESERVED2  MM                  RESERVED3  MQ                  RESERVED4  MU                  RESERVED5  MY                  RESERVED6  M]                  RESERVED7  Ma                  RESERVED8  Me                  USER       Mi                                                                                                                                                                                                                                                                                          COMMENT Screen                                                                                              WINDOWS _S8G0JFUWP 657475719      /  F      ]                                �                       WINDOWS _S8G0JFUWQ 660831888�  �  �  �      �      j  �                  �                           WINDOWS _S8G0JP4MD 658990693�  �  �  �                                                               WINDOWS _S8G0JP4ME 657475949�      �  �  �                                                             WINDOWS _S8G0JP4MF 657475949L      [  j  w  �                                                           WINDOWS _S8G0JP4MG 657475949�          #  C                                                           WINDOWS _S8G0JP4MH 657475949p        �  �  �                                                           WINDOWS _S8G0JP4MI 657476174      *  8  G  g                                                           WINDOWS _S8G0JP4MJ 657475949�      �  �  �  �                                                           WINDOWS _S8G0JP4MN 657476231G      U  c  r  �                                                           WINDOWS _S8G0JP4MO 657475949�      �  �  �                                                             WINDOWS _S910RJPYC 658990693t      �  �  �  �                                                           WINDOWS _S910RJPYD 658990693�      �        3                                                            WINDOWS _S8G0JVEQQ 658990693�   �   �   �   �   �                                                            WINDOWS _S8K0MZOW3 657741171R!  d!  �!  �!  �!  �!                                                           COMMENT RESERVED                                "                                                            "?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VERSION =   3.00      dataenvironment      dataenvironment      Dataenvironment      Name = "Dataenvironment"
      1      1      macform      ..\common\vcx\macbase.vcx      form      Form1      �DataSession = 1
Height = 273
Width = 587
DoCreate = .T.
Caption = "Dirty Buffers"
MinHeight = 250
MinWidth = 563
Name = "Form1"
     `PROCEDURE createdirtylist
LOCAL i, j, lnFieldCount, lnModifiedRecord, lcAlias, lnSelect

lnSelect = SELECT()
IF !USED("DirtyBuffers")
	CREATE CURSOR DirtyBuffers (CursorName C(20), FieldName C(20), CurValue C(30), OldValue C(30), RecordNo I)
ELSE
	ZAP IN DirtyBuffers
ENDIF


lnCursorCount = AUSED(laTables)

FOR i = 1 TO lnCursorCount
	lcAlias = laTables[i,1]
	WAIT WINDOW "Checking cursor- " + lcAlias NOWAIT
	lnFieldCount = AFIELDS(laFields, lcAlias)
	DO CASE
		CASE CURSORGETPROP("Buffering", lcAlias) = 1
			LOOP
		CASE CURSORGETPROP("Buffering", lcAlias) = 2 OR CURSORGETPROP("Buffering", lcAlias) = 3 && Row Buffering
			* If the GetFldState string is not all 1s or all 3s, one or more fields has been changed.
			IF GETFLDSTATE(-1, lcAlias) <> REPLICATE("1", LEN(GETFLDSTATE(-1, lcAlias)))
				FOR j = 1 TO lnFieldCount
					lcFieldName = laFields[j,1]
					IF !INLIST(GETFLDSTATE(j, lcAlias), 1, 3)
						m.CursorName = lcAlias
						m.FieldName = FIELD(j, lcAlias)
						m.CurValue = TRANSFORM(EVAL(lcAlias + "." + lcFieldName))
						m.OldValue = TRANSFORM(OLDVAL(lcFieldName, lcAlias))
						m.RecordNo = RECNO(lcAlias)
						INSERT INTO DirtyBuffers FROM MEMVAR
					ENDIF
				ENDFOR
			ENDIF
		CASE CURSORGETPROP("Buffering", lcAlias) = 4 OR CURSORGETPROP("Buffering", lcAlias) = 5 && table buffering
			* Get the first, if any, modified record.
			lnModifiedRecord = GETNEXTMODIFIED(0, lcAlias) 
			IF lnModifiedRecord <> 0
				* Loop through all modified records
				DO WHILE lnModifiedRecord <> 0
					GO lnModifiedRecord IN (lcAlias)
					FOR j = 1 TO lnFieldCount
						lcFieldName = laFields[j,1]
						IF !INLIST(GETFLDSTATE(j, lcAlias), 1, 3)
							m.CursorName = lcAlias
							m.FieldName = FIELD(j, lcAlias)
							m.CurValue = TRANSFORM(EVAL(lcAlias + "." + lcFieldName))
							m.OldValue = TRANSFORM(OLDVAL(lcFieldName, lcAlias))
							m.RecordNo = RECNO(lcAlias)
							INSERT INTO DirtyBuffers FROM MEMVAR
						ENDIF
					ENDFOR
					lnModifiedRecord = GETNEXTMODIFIED(lnModifiedRecord, lcAlias)
				ENDDO
			ENDIF
	ENDCASE
ENDFOR
GO TOP IN DirtyBuffers

WAIT CLEAR
SELECT (lnSelect)

ENDPROC
PROCEDURE setgridrecordsource
THISFORM.grdBuffers.RecordSource = "DirtyBuffers"
THISFORM.grdBuffers.Column1.ControlSource = "CursorName"
THISFORM.grdBuffers.Column2.ControlSource = "FieldName"
THISFORM.grdBuffers.Column3.ControlSource = "CurValue"
THISFORM.grdBuffers.Column4.ControlSource = "Oldvalue"
THISFORM.grdBuffers.Column5.ControlSource = "RecordNo"

ENDPROC
PROCEDURE Init
LPARA tnDataSession
IF !EMPTY(tnDataSession)
	SET DATASESSION TO (tnDataSession)
ENDIF

THISFORM.txtDataSession.value = SET("DATASESSION")

THIS.CreateDirtyList()
THIS.SetGridRecordSource()

ENDPROC
PROCEDURE Load
NODEFAULT

ENDPROC
PROCEDURE Destroy
IF USED("DirtyBuffers")
	USE IN DirtyBuffers
ENDIF
ENDPROC
     ����    �  �                        �V   %           L   z          �  U   ��  � � � � � � T� �CW�� %�C� DirtyBuffers�
��� �Y h�� DirtyBuffers� � C���� � C����	 � C����
 � C���� � I� �� � S� � � T� �C�� �y�� ��  ���(�� ���� T� �C �  �� ��  R,:�� Checking cursor- � �� T� �C�� � ��� H�0���  �C�	 Buffering� ����T� .�: �C�	 Buffering� ��� C�	 Buffering� ������' %�C���� �C� 1CC���� �>Q���� �� ���(�� ��~� T� �C � �� �� %�CC� � ����
��z� T�� �� �� T�� �C� � /�� T��	 �CC� � .� �_�� T��
 �CC� � �__�� T�� �C� O�� r�� DirtyBuffers�� � �� �: �C�	 Buffering� ��� C�	 Buffering� ������ T� �C� � ��� %�� � ���� +�� � ���� #�� ��� �� �� ���(�� ���� T� �C � �� �� %�CC� � ����
���� T�� �� �� T�� �C� � /�� T��	 �CC� � .� �_�� T��
 �CC� � �__�� T�� �C� O�� r�� DirtyBuffers�� � �� T� �C� � ��� � � � ��	 #� )� R�
 F�� �� U  I J LNFIELDCOUNT LNMODIFIEDRECORD LCALIAS LNSELECT DIRTYBUFFERS
 CURSORNAME	 FIELDNAME CURVALUE OLDVALUE RECORDNO LNCURSORCOUNT LATABLES LAFIELDS LCFIELDNAME�  T�  � � �� DirtyBuffers��  T�  � � � ��
 CursorName�� T�  � � � ��	 FieldName�� T�  � � � �� CurValue�� T�  � � � �� Oldvalue�� T�  � � � �� RecordNo�� U	  THISFORM
 GRDBUFFERS RECORDSOURCE COLUMN1 CONTROLSOURCE COLUMN2 COLUMN3 COLUMN4 COLUMN5d  ��  � %�C�  �
��# � G�(��  �� �  T� � � �C� DATASESSIONv�� ��C� � �� ��C� � �� U  TNDATASESSION THISFORM TXTDATASESSION VALUE THIS CREATEDIRTYLIST SETGRIDRECORDSOURCE  �� U  *  %�C� DirtyBuffers���# � Q�  � � U  DIRTYBUFFERS createdirtylist,     �� setgridrecordsource�    �� Init    �� Load�    �� Destroy�    ��1 �� ��� � A #rQQ� A �rqQ�� A�qaA A A �2"qQ�� A�qaA A 1A A A A � R � 3 �����3 q � A � � 3 A 3 �� A 1                       �     7   �  �	  A   >   
  �
  J   F   �
    V   H   !  U  Z    )   �                        **createdirtylist 
*setgridrecordsource 
      macgrid      ..\common\vcx\macbase.vcx      grid      
grdBuffers      Form1     �ColumnCount = 5
DeleteMark = .F.
Height = 192
Left = 12
Panel = 1
RecordSource = ""
ScrollBars = 2
Top = 36
Width = 552
resizewithbottom = .T.
resizewithright = .T.
resizecolumns = .T.
Name = "grdBuffers"
Column1.ColumnOrder = 2
Column1.ControlSource = ""
Column1.Width = 102
Column1.Name = "Column1"
Column2.ColumnOrder = 3
Column2.ControlSource = ""
Column2.Width = 102
Column2.Name = "Column2"
Column3.ColumnOrder = 4
Column3.ControlSource = ""
Column3.Width = 146
Column3.Name = "Column3"
Column4.ColumnOrder = 5
Column4.ControlSource = ""
Column4.Width = 146
Column4.Name = "Column4"
Column5.ColumnOrder = 1
Column5.Width = 32
Column5.Name = "Column5"
      header      header      Header1      Form1.grdBuffers.Column1      %Caption = "Alias"
Name = "Header1"
      textbox      textbox      Text1      Form1.grdBuffers.Column1      YBorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "Text1"
      header      header      Header1      Form1.grdBuffers.Column2      %Caption = "Field"
Name = "Header1"
      textbox      textbox      Text1      Form1.grdBuffers.Column2      YBorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "Text1"
      header      header      Header1      Form1.grdBuffers.Column3      ,Caption = "Buffer Value"
Name = "Header1"
      textbox      textbox      Text1      Form1.grdBuffers.Column3      YBorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "Text1"
      header      header      Header1      Form1.grdBuffers.Column4      .Caption = "Original Value"
Name = "Header1"
      textbox      textbox      Text1      Form1.grdBuffers.Column4      YBorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "Text1"
      header      header      Header1      Form1.grdBuffers.Column5      !Caption = "#"
Name = "Header1"
      textbox      textbox      Text1      Form1.grdBuffers.Column5      YBorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "Text1"
      cmdclose      ..\common\vcx\buttons.vcx      commandbutton      	Cmdclose1      Form1      RTop = 240
Left = 492
locktobottom = .T.
locktoright = .T.
Name = "Cmdclose1"
      
mactextbox      ..\common\vcx\macbase.vcx      textbox      txtDataSession      Form1      WHeight = 23
Left = 12
ReadOnly = .T.
Top = 12
Width = 36
Name = "txtDataSession"
      !Arial, 0, 9, 5, 15, 12, 32, 3, 0
.\ searchstring.scx searchstring.sct c:\docume~1\erik\locals~1\temp\ dwnk004c.fxp ..\common\vcx\ macbase.vcx macbase.vct ..\common\mnx\editshortcut.mpr editshortcut.mpx ..\common\vcx\macbase.prg macbase.fxp ..\common\bmp\ top.bmp previous.bmp next.bmp bottom.bmp new.bmp delete.bmp modify.bmp registry.vcx registry.vct forms.vcx forms.vct ..\tmr\prg\printtmr.prg printtmr.fxp ..\common\scx\ getissuer.scx getissuer.sct buttons.vcx buttons.vct ..\tools\ dirtybuffers.scx dirtybuffers.sct 	)   :                 :  �                  �  i�  %   E           i�  x�  R   a           x�  �� R   m            �� ?� %   �            ?� Q� %   �           Q� �� �   �           �� �� �   �           �� � �   �           � Y� �   �           Y� � �             � m  �             m  [ �             [ 8	 R   %          8	 �^ R   2          �^ � R   ?          � �x R   I           �x � %   k          	� �� x  �          �� � x  �          � !� R   �          !� �+ R   �          	�+ �6 �  �          �6 Y �  �          