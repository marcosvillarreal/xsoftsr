Attribute VB_Name = "Procedimientos"
Option Explicit
Public Sub CargarOutline(out As Outline, Cod As String _
    , Descr As String, Db As Database _
    , cCod As String, cDescr As String _
    , cPadre As String, nTabla As String _
    , Filtro As String)
'Limpiar Outline
out.Clear
Dim rsLista As Recordset
Db.Execute ("DELETE * FROM ListaArbol") 'Limpiar Lista arbol
GenerarLista 0, Descr, 0, Db, Cod, cCod, _
    cDescr, cPadre, nTabla, Filtro
Set rsLista = Db.OpenRecordset("SELECT * FROM ListaArbol")
rsLista.MoveFirst
'Cargar el outline
    Do
        out.AddItem (rsLista!DescrElem)
        out.Indent(rsLista!Indice) = rsLista!Nivel
        rsLista.MoveNext
    Loop Until rsLista.EOF

End Sub
Private Sub GenerarLista(ByVal Nivel As Integer _
    , Descr As String, ByVal Ind As Long, _
    Db As Database, Cod As String, cCod As String, cDescr As String, _
    cPadre As String, nTabla As String, Filtro As String)
'A partir de una tabla de la forma _
    Cod _
    Descr _
    Padre _
genera una lista que puede ser representada facilmente como arbol por _
medio de un control outline.
'Parámetros:
    'Nivel, pasado en la primer llamada, como 0, es usado en las _
        llamadas recursivas, para crear los distintos niveles.
    'Descr, descripción de la hoja.
    'Ind, número indice del primer elemento, usado para determinar _
        cual es el elemento seleccionado a partir de la propiedad _
        listindex del outline. Es decir el elemento seleccionado _
        en el outline tiene un valor de listindex igual al indice _
        que corresponde a ese elemento en la tabla. (Este parámetro _
        se pasa como 0 en la primer llamada).
    'DB, base de datos abierta que contiene la tabla con estructura de _
        árbol, debe tener también una tabla ListaArbol (ver la orden _
        sql insert into, para ver los campos que posee)
    'Cod, código del elemento pasado actualmente.
    'cCod, nombre del campo que contiene el codigo en la tabla usada _
        como base.
    'cDescr, nombre del campo que posee la descripción. En el caso de _
        que la tabla no tenga un campo con descripción, es el mismo _
        que cCod.
    'cPadre, nombre del campo que tiene el cod de padre.
    'nTabla, nombre de la tabla a usar.
    'Filtro, filtro para nTabla

'Agregar elemento a tabla
Static I As Long
Dim Sql As String
I = Ind
Sql = "INSERT INTO ListaArbol(Cod,DescrElem,Nivel,Indice)" _
    & "VALUES('" & Cod & "','" & Descr & "'," _
    & Nivel & "," & Ind & ")"
Db.Execute Sql
Dim rsHijos As Recordset
Sql = "SELECT " & cCod & "," & cPadre & "," & cDescr & " FROM " & nTabla & _
    " WHERE " & cPadre & "='" & Cod & "'"
If Filtro <> "" Then
    Sql = Sql & " and " & Filtro
End If
Set rsHijos = Db.OpenRecordset(Sql)
If Not (rsHijos.BOF And rsHijos.EOF) Then
    Do
        I = I + 1
        GenerarLista Nivel + 1, rsHijos(cDescr), I, Db, _
            rsHijos(cCod), cCod, cDescr, cPadre, nTabla, ""
        rsHijos.MoveNext
    Loop Until rsHijos.EOF
End If
End Sub
Public Function UbiElemEnOut(out As Control, _
    TextoBuscado As String) As Integer
Attribute UbiElemEnOut.VB_Description = "Devuelve el índice del texto buscado en un outline, y -1 si no lo encuentra"
'
Dim Ind As Integer
Dim Encontrado As Boolean

Encontrado = False

For Ind = 0 To out.ListCount - 1
    If out.List(Ind) = TextoBuscado Then
        Encontrado = True
        Exit For
    End If
Next Ind

If Not Encontrado Then
    UbiElemEnOut = -1
Else
    UbiElemEnOut = Ind
End If

End Function

Public Sub ExpandOutline(out As Outline, _
    Optional Nivel As Variant, _
    Optional Comienzo As Variant, _
    Optional final As Variant)
'Expande un outline desde un comienzo hasta un fin, _
    y hasta un determinado nivel

'c Variables locales
Dim Inicio As Integer
Dim Fin As Integer
Dim Ind As Integer

If IsMissing(Comienzo) Then
    Inicio = 0
Else
    Inicio = Comienzo
End If
If IsMissing(final) Then
    Fin = out.ListCount - 1
Else
    Fin = final
End If

For Ind = Inicio To Fin
    If IsMissing(Nivel) Then
        out.Expand(Ind) = True
    Else
        If out.Indent(Ind) <= Nivel Then
            out.Expand(Ind) = True
        Else
            out.Expand(Ind) = False
        End If
    End If
Next Ind
End Sub
    
Public Sub MostrarErrorNumero(Numero As Long)
    MsgBox "Se ha producido el error #" & Numero & ". Comuníquese con su proveedor", vbCritical, "Error en aplicación"
End Sub
Public Sub CentrarForm(Frm As Form)
'Centrar formulario
    Frm.Move (Screen.Width - Frm.Width) / 2, (Screen.Height - Frm.Height) / 2
End Sub
Public Function Cad(Num As Variant) As String
Attribute Cad.VB_Description = "Convierte un número a cadena, sacando espacios extras que pudiera tener"
    Cad = Trim(Str(Num))
End Function
Public Function Redondear(ByVal Num As String, ByVal Dec As Integer) As String
    Dim PosPunto As Integer
    Dim PosCorte As Integer
    PosPunto = InStr(Num, ",") 'realizado porque no se si el punto es . o ,
    If PosPunto = 0 Then 'Si no encontro "," busca "."
        PosPunto = InStr(Num, ".")
    End If
    If PosPunto <> 0 Then
        If Dec > 0 Then
            PosCorte = PosPunto + Dec
        Else
            PosCorte = PosPunto - 1
        End If
        Redondear = Left(Num, PosCorte)
    Else
        Redondear = Num
    End If
End Function
Public Sub ValidarEntrada(caja As TextBox, ParamArray Param())
'Param(0) indica el tipo de control, 0 es control para _
    la entrada de un número, 1 es control para la entrada _
    de strings. _
    En el caso de string, debe llamarse a la función desde _
    el evento keypress, en el caso de números, desde lostfocus.
Select Case Param(0)
Case 0 'número
    'Param(1):valor máximo
    'Param(2):valor mínimo
    'Param(3):número de decimales
    Dim NumDeCaja As String 'guarda el número contenido _
        en la caja de texto
    NumDeCaja = Trim(Str(Val(caja)))
    NumDeCaja = Redondear(NumDeCaja, Param(3))
    If Val(NumDeCaja) < Param(2) Then
        NumDeCaja = Cad(Param(2))
    ElseIf Val(NumDeCaja) > Param(1) Then
        NumDeCaja = Cad(Param(1))
    End If
    caja = NumDeCaja
Case 1 'cadena
    'Param(1):codigo ascii del caracter presionado
    'Param(2):entero, tamaño máximo de cadena
    'Param(3):booleano,convertir a mayúsculas toda la entrada
    'Param(4):entero, caracteres permitidos a la cadena
        '0 dígitos
        '1 letras
        '2 letras y espacio
        '3 telefono:dígitos y -
        '4 direcciones:letras espacios y dígitos
    If Param(1) <> 8 Then 'No es backspace
        If Len(caja) < Param(2) Then 'si no alcanzo el tamaño máximo
            'Convertir a mayúsculas si lo solicita
            If Not IsMissing(Param(3)) Then
                If Param(3) Then Param(1) = Asc(UCase(Chr(Param(1))))
            End If
            
            Select Case Param(4) 'Indicar si el caracter es válido
            Case 0 'digitos
                Param(1) = IIf(EsDigito(Param(1)), Param(1), 0)
            Case 1 'letras
                Param(1) = IIf(EsLetra(Param(1)), Param(1), 0)
            Case 2 'letras y espacio
                Param(1) = IIf(EsLetra(Param(1)) Or EsEspacio(Param(1)), Param(1), 0)
            Case 3 'Telefono
                Param(1) = IIf(EsDigito(Param(1)) Or Param(1) = Asc("-"), Param(1), 0)
            Case 4 'Direcciones
                Param(1) = IIf(EsDigito(Param(1)) Or EsLetra(Param(1)) Or EsEspacio(Param(1)), Param(1), 0)
            End Select
        Else
            Param(1) = 0
        End If
    End If
End Select
End Sub
Public Function EsDigito(ByVal KeyAscii As Integer) As Boolean
    EsDigito = KeyAscii >= Asc("0") And KeyAscii <= Asc("9")
End Function
Public Function EsLetra(ByVal KeyAscii As Integer) As Boolean
    'Si la mayúscula es distinta de la minúscula, entonces es una _
        letra. No leo los valores en código ascii, ya que no se _
        que sucede con distintas páginas de código para letras _
        acentuadas
    EsLetra = IIf(UCase(Chr(KeyAscii)) <> LCase(Chr(KeyAscii)), True, False)
End Function
Public Function EsEspacio(ByVal KeyAscii As Integer) As Boolean
    EsEspacio = KeyAscii = Asc(" ")
End Function

Public Function Extension(ByRef NomArch As String) As String
   Dim ext As String
   Dim PosPunto As Integer
   Dim Ind As Integer
   ext = Right(NomArch, 4) 'busca la extensión en los últimos 4 _
      caracteres, ya que si existe la extensión, el punto debe _
      estar entre ellos
   For Ind = 3 To 1 Step -1 'Busca el punto desde atrás hacia adelante, para _
      evitar combinaciones ..tx, que son posibles en windows 95
      PosPunto = InStr(Ind, ext, ".")
      If PosPunto > 0 Then
         'Punto encontrado
         Extension = Mid(ext, PosPunto + 1)
         Exit For
      Else
         Extension = ""
      End If
   Next
End Function
Public Sub ValidaNumPos(CajaTexto As TextBox)
Dim valor As Double
valor = Val(CajaTexto)
If valor < 0 Then valor = valor * -1
CajaTexto = Redondear(Trim(Str(valor)), 6)
End Sub
Public Function ComasXPuntos(Cad As String) As String
Dim I As Integer
For I = 1 To Len(Cad)
    If Mid(Cad, I, 1) = "," Then
        Cad = Left(Cad, I - 1) & "." & Mid(Cad, I + 1)
    End If
Next I
ComasXPuntos = Cad
End Function
