VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "WNetResource"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'===============================================================================
'
'   WNetResource Class
'
'   This class wraps WNet's NETRESOURCE structure and takes a unique approach
'   towards working with Win32 input & output structures used for ANSI and WIDE
'   Win32 functions.  While most programs usually tend to favor making the ANSI
'   call, this class favors neither but supports both Ansi and Unicode
'   implimentations. This class also makes it possible to work with the WNet
'   functions without having to work with pointers (to or from).
'
'   The class can be used identical to how one would work with the structure,
'   but with a lot more ease! Just fill out the structure using the properties
'   and then pass the lpData member on input to a WNet function. This class can
'   handle output structure's too but the caller must first supply the WNet
'   function a pre-allocated byte array, and once filled, can bind it to this
'   class via the "Attach" method. While the string fields do make public those
'   members such as lpRemoteName (which does return a LPTSTR), the actual
'   string can be Let/Get via the "RemoteName" property (regardless of whether
'   the caller is using the Ansi or Unicode version).
'
'===============================================================================
'
'   Author:             Monte Hansen [monte@killervb.com]
'   Dependencies:       [M Common.Bas]; [M WNet.Bas]
'   Invitation:         There is an open invitation to comment on this code,
'                       report bugs or request revisions or enhancements.
'
'===============================================================================
'
'   ==  Copyright © 1998-2000 by Monte Hansen, All Rights Reserved Worldwide  ==
'
'   Monte Hansen  (The Author) grants a royalty-free right to use,  modify,  and
'   distribute this code  (The Code)  in compiled form,  provided that you agree
'   that The Author has no warranty,  obligations  or  liability  for  The Code.
'   You may distribute The Code among peers but may not sell it,  or  distribute
'   it on any electronic or physical media such  as  floppy  diskettes,  compact
'   disks, bulletin boards, web sites, and the like, without first obtaining The
'   Author's consent.
'
'   When distributing The Code among peers,  it is respectfully  requested  that
'   it be distributed as is,  but at no time shall it be distributed without the
'   copyright notice hereinabove.
'
'===============================================================================
Option Explicit

'===============================================================================
'   Constants
'===============================================================================
Private Const Module        As String = "WNetResource"

Private Const GMEM_FIXED = &H0
Private Const GMEM_ZEROINIT = &H40
Private Const GPTR = (GMEM_FIXED Or GMEM_ZEROINIT)

'===============================================================================
'   Enums
'===============================================================================

Public Enum NetResourceVersions             ' Defines Ansi or Unicode version
    OsDefined = 0
    IsAnsi = 1
    IsUnicode = 2
End Enum
    
Public Enum ResourceScopes                  ' Scope of enumerated resources
    RESOURCE_CONNECTED = 1
    RESOURCE_GLOBALNET = 2                  ' AKA PUBLICNET
    RESOURCE_REMEMBERED = 3
    RESOURCE_RECENT = 4
    RESOURCE_CONTEXT = 5
End Enum

Public Enum ResourceTypes                   ' Kind of resource to enumerate
    RESOURCETYPE_UNKNOWN = &HFFFF&
    RESOURCETYPE_ANY = &H0
    RESOURCETYPE_DISK = &H1
    RESOURCETYPE_PRINT = &H2
End Enum

Public Enum ResourceDisplayTypes
    RESOURCEDISPLAYTYPE_GENERIC = &H0
    RESOURCEDISPLAYTYPE_DOMAIN = &H1&
    RESOURCEDISPLAYTYPE_SERVER = &H2&
    RESOURCEDISPLAYTYPE_SHARE = &H3&
    RESOURCEDISPLAYTYPE_FILE = &H4&
    ' Version 4.0 and above:
    RESOURCEDISPLAYTYPE_GROUP = &H5&
    RESOURCEDISPLAYTYPE_NETWORK = &H6&
    RESOURCEDISPLAYTYPE_ROOT = &H7&
    RESOURCEDISPLAYTYPE_SHAREADMIN = &H8&
    RESOURCEDISPLAYTYPE_DIRECTORY = &H9&
    RESOURCEDISPLAYTYPE_TREE = &HA&
    RESOURCEDISPLAYTYPE_NDSCONTAINER = &HB&
End Enum

Public Enum ResourceUsages
    RESOURCEUSAGE_CONNECTABLE = &H1
    RESOURCEUSAGE_CONTAINER = &H2
    RESOURCEUSAGE_NOLOCALDEVICE = &H4
    RESOURCEUSAGE_SIBLING = &H8
    RESOURCEUSAGE_ATTACHED = &H10&
    RESOURCEUSAGE_ALL = RESOURCEUSAGE_CONNECTABLE Or RESOURCEUSAGE_CONTAINER Or RESOURCEUSAGE_ATTACHED
'    RESOURCEUSAGE_RESERVED = &H80000000
End Enum


'===============================================================================
'   Types
'===============================================================================
    
Private Type NETRESOURCE                    ' ANSI/WIDE safe for input
    dwScope             As Long
    dwType              As Long
    dwDisplayType       As Long
    dwUsage             As Long
    lpLocalName         As Long
    lpRemoteName        As Long
    lpComment           As Long
    lpProvider          As Long
End Type

'===============================================================================
'   Private Members
'===============================================================================

Private m_NetResource       As NETRESOURCE
' These 2 members are the same but they document the code better when
' defined seperately since they are used in different contexts.
Private m_NetResVersion     As NetResourceVersions  ' 1 for Ansi 2 for Unicode
Private m_Factor            As Long                 ' 1 for Ansi 2 for Unicode

Private m_LocalName         As String
Private m_RemoteName        As String
Private m_Comment           As String
Private m_Provider          As String

'===============================================================================
'   Declares
'===============================================================================
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)

Private Declare Function lstrcpyA Lib "kernel32" (ByVal lpString1 As Any, ByVal lpString2 As Any) As Long
Private Declare Function lstrcpyW Lib "kernel32" (ByVal lpString1 As Long, ByVal lpString2 As Long) As Long
Private Declare Function lstrlenA Lib "kernel32" (ByVal lpString As Any) As Long
Private Declare Function lstrlenW Lib "kernel32" (ByVal lpString As Long) As Long

Private Declare Function GlobalAlloc Lib "kernel32" (ByVal wFlags As Long, ByVal dwBytes As Long) As Long
Private Declare Function GlobalFree Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GlobalReAlloc Lib "kernel32" (ByVal hMem As Long, ByVal dwBytes As Long, ByVal wFlags As Long) As Long



Public Sub Attach(ByVal lpNetResource As Long, Optional ByVal NetResVersion As NetResourceVersions = OsDefined)
'===============================================================================
'   Attach - Binds this class instance to the supplied NETRESOURCE structure.
'
'   lpNetResource       Pointer to the NETRESOURCE structure to bind to.
'   NetResVersion       Optional. 0 for O/S defined, 1 for Ansi, 2 for Unicode.
'===============================================================================

    Dim lpString    As Long     ' work pointer
    Dim StringLen   As Long     ' length of NETRESOURCE string
    
    ' Destroy old structure data if class instance being reused
    Call Class_Terminate
    
    
    ' We need to know if we are storing ANSI or WIDE version
    Version = NetResVersion

    ' Copy the NETRESOURCE to our local version
    CopyMemory m_NetResource, ByVal lpNetResource, 32   ' = Len(NETRESOURCE)

    ' The last 4 fields are pointers to strings [TSTR's],
    ' and we want convert them to BSTR's.

    With m_NetResource
        
        ' Make local copies of TSTR's
        Me.LocalName = NetResPtrToString(.lpLocalName)
        Me.RemoteName = NetResPtrToString(.lpRemoteName)
        Me.Comment = NetResPtrToString(.lpComment)
        Me.Provider = NetResPtrToString(.lpProvider)
    
    End With
    
End Sub

Public Property Get Object() As WNetResource
Attribute Object.VB_UserMemId = 0
Attribute Object.VB_MemberFlags = "40"
'===============================================================================
'   Object - Default property. Returns pointer to THIS/SELF/ME. Needed for the
'   Tag property for the TreeView which doesn't export a "Set" property.
'===============================================================================
    Set Object = Me
End Property


Public Property Get lpData() As Long
'===============================================================================
'   lpData - Returns a pointer to the internal NETRESOURCE structure. Used to
'   pass to a WNet function.
'===============================================================================
    lpData = VarPtr(m_NetResource)
End Property




'===============================================================================
'   NETRESOURCE specific members; refer to the SDK for more information.
'===============================================================================




Public Property Get dwScope() As ResourceScopes
    dwScope = m_NetResource.dwScope
End Property
Public Property Let dwScope(NewValue As ResourceScopes)
    m_NetResource.dwScope = NewValue
End Property


Public Property Get dwType() As ResourceTypes
    dwType = m_NetResource.dwType
End Property
Public Property Let dwType(NewValue As ResourceTypes)
    m_NetResource.dwType = NewValue
End Property


Public Property Get dwDisplayType() As ResourceDisplayTypes
    dwDisplayType = m_NetResource.dwDisplayType
End Property
Public Property Let dwDisplayType(NewValue As ResourceDisplayTypes)
    m_NetResource.dwDisplayType = NewValue
End Property


Public Property Get dwUsage() As ResourceUsages
    dwUsage = m_NetResource.dwUsage
End Property
Public Property Let dwUsage(NewValue As ResourceUsages)
    m_NetResource.dwUsage = NewValue
End Property

Public Property Get lpLocalName() As Long
    lpLocalName = m_NetResource.lpLocalName
End Property


Public Property Get LocalName() As String
    LocalName = NetResPtrToString(m_NetResource.lpLocalName)
End Property
Public Property Let LocalName(NewValue As String)

    ' Convert BSTR to TSTR
    With m_NetResource

        If StrPtr(NewValue) = 0 Then            ' Handle NULL string case

            m_LocalName = vbNullString

        ElseIf m_NetResVersion = IsAnsi Then    ' Store as Ansi

            m_LocalName = StrConv(NewValue, vbFromUnicode)

        Else                                    ' Store as Unicode

            m_LocalName = NewValue

        End If

        .lpLocalName = StrPtr(m_LocalName)      ' save pointer to the string

    End With

End Property


Public Property Get lpRemoteName() As Long
    lpRemoteName = m_NetResource.lpRemoteName
End Property


Public Property Get RemoteName() As String
    RemoteName = NetResPtrToString(m_NetResource.lpRemoteName)
End Property
Public Property Let RemoteName(NewValue As String)
    
    ' Convert BSTR to TSTR
    With m_NetResource

        If StrPtr(NewValue) = 0 Then            ' Handle NULL string case

            m_RemoteName = vbNullString

        ElseIf m_NetResVersion = IsAnsi Then    ' Store as Ansi

            m_RemoteName = StrConv(NewValue, vbFromUnicode)

        Else                                    ' Store as Unicode

            m_RemoteName = NewValue

        End If

        .lpRemoteName = StrPtr(m_RemoteName)    ' save pointer to the string

    End With

End Property


Public Property Get lpComment() As Long
    lpComment = m_NetResource.lpComment
End Property


Public Property Get Comment() As String
    Comment = NetResPtrToString(m_NetResource.lpComment)
End Property
Public Property Let Comment(NewValue As String)
    
    ' Convert BSTR to TSTR
    With m_NetResource

        If StrPtr(NewValue) = 0 Then            ' Handle NULL string case

            m_Comment = vbNullString

        ElseIf m_NetResVersion = IsAnsi Then    ' Store as Ansi

            m_Comment = StrConv(NewValue, vbFromUnicode)

        Else                                    ' Store as Unicode

            m_Comment = NewValue

        End If

        .lpComment = StrPtr(m_Comment)          ' save pointer to the string

    End With

End Property


Public Property Get lpProvider() As Long
    lpProvider = m_NetResource.lpProvider
End Property


Public Property Get Provider() As String
    Provider = NetResPtrToString(m_NetResource.lpProvider)
End Property
Public Property Let Provider(NewValue As String)

    ' Convert BSTR to TSTR
    With m_NetResource

        If StrPtr(NewValue) = 0 Then            ' Handle NULL string case

            m_Provider = vbNullString

        ElseIf m_NetResVersion = IsAnsi Then    ' Store as Ansi

            m_Provider = StrConv(NewValue, vbFromUnicode)

        Else                                    ' Store as Unicode

            m_Provider = NewValue

        End If

        .lpProvider = StrPtr(m_Provider)        ' save pointer to the string

    End With

End Property


Public Property Get Version() As NetResourceVersions
'===============================================================================
'   Defines if the NETRESOURCE is in Ansi or Unicode.
'===============================================================================

    Version = m_NetResVersion
End Property
Public Property Let Version(NewValue As NetResourceVersions)
    
    Select Case NewValue
    Case IsUnicode, IsAnsi
        m_NetResVersion = NewValue
    Case OsDefined
        If IsWinNt() Then
            m_NetResVersion = IsUnicode
        Else
            m_NetResVersion = IsAnsi
        End If
            
    Case Else
        Err.Raise 380, Module
    End Select
    
    m_Factor = m_NetResVersion
    
End Property


Private Function lstrcpy(lpString1 As Long, lpString2 As Long) As Long
'===============================================================================
'   lstcpy - ANSI/WIDE wrapper.
'===============================================================================
    If m_NetResVersion = IsAnsi Then
        lstrcpy = lstrcpyA(ByVal lpString1, ByVal lpString2)
    Else
        lstrcpy = lstrcpyW(lpString1, lpString2)
    End If
End Function

Private Function ProperString(Value As String) As Byte()
'===============================================================================
'   Converts a string to ANSI if needed and returns it as a Byte array.
'===============================================================================
    ' Convert string to Ansi if we're using Ansi version of structure
    If m_NetResVersion = IsUnicode Then
        ProperString = Value
    Else
        ProperString = StrConv(Value, vbFromUnicode)
    End If
    
End Function

Private Function lstrLen(lpString As Long) As Long
'===============================================================================
'   lstLen - ANSI/WIDE wrapper.
'===============================================================================
    If m_NetResVersion = IsAnsi Then
        lstrLen = lstrlenA(ByVal lpString)
    Else
        lstrLen = lstrlenW(lpString)
    End If
End Function

Private Function NetResPtrToString(lpString As Long) As String
'===============================================================================
'   NetResPtrToString - Converts an LPTSTR in the NETRESOURCE structure to a
'   Unicode string.
'
'   NOTE: This code might appear a bit strange. Just keep in mind that we always
'   return a Unicode string, whereas it may be stored as Ansi.
'
'   lpString            Pointer to string to convert.
'
'   RETURNS             The converted string.
'===============================================================================

    If lpString = 0 Then Exit Function
    
    ' Size return buffer to fit
    If m_NetResVersion = IsUnicode Then
        ' size buffer to fit
        NetResPtrToString = String(lstrlenW(lpString), 0)
        ' copy the pointer string to return buffer
        CopyMemory ByVal StrPtr(NetResPtrToString), ByVal lpString, Len(NetResPtrToString) * 2
    Else
        ' size buffer to fit
        NetResPtrToString = String(lstrlenA(lpString) \ 2 + (lstrlenA(lpString) Mod 2), 0)
        ' copy the pointer string to return buffer
        CopyMemory ByVal StrPtr(NetResPtrToString), ByVal lpString, Len(NetResPtrToString) * 2
    End If
    
    ' Convert to Unicode if in Ansi, if needed
    If m_NetResVersion = IsAnsi Then
        NetResPtrToString = Left$(StrConv(NetResPtrToString, vbUnicode), lstrlenA(lpString))
    End If
    
End Function

Private Sub Class_Initialize()
    ' By default, let the operating system define the Win32 implementations.
    Me.Version = OsDefined
End Sub

Private Sub Class_Terminate()
'
End Sub
