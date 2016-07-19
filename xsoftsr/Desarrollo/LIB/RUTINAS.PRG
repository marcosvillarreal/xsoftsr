Procedure Kalculator(_CprocOrigen,_NLineOrigen,_CVarEntra)
Local _Vpic
nrow = 2 ; ncol = 50
PanKal = Savescreen(nrow,ncol,nrow+14,ncol+23)
colorantes = setcolor()

_ventana = 'r1'+strzero(nrow,2)+strzero(ncol,2)+strzero(nrow+14,2)+strzero(ncol+23,2)
set colo to &colod_
@ nrow,ncol clea to nrow+14,ncol+23
ventana(_ventana,'&colod_')
_qcolo_ = 'W+'+Alltrim(subs(colod_+space(30),2,30))
DevPos(nrow+1 ,ncol+1) ; DevOut('ÛßßßßßßßßßßßßßßßßßßßßÛ','&_qcolo_')
DevPos(row()+1,ncol+1) ; DevOut('Û                    Û','&_qcolo_')
DispBox(row()+1,ncol+1,row()+11,ncol+22,'ÛÛÛÛÛÛÛÛÛ','&_qcolo_')
DevPos(nrow+4,ncol+3)  ; DevOut(' * ','&colod_')
DevPos(nrow+4,ncol+8)  ; DevOut(' / ','&colod_')
DevPos(nrow+4,ncol+13) ; DevOut(' T ','&colod_')
DevPos(nrow+4,ncol+18) ; DevOut(' C ','&colod_')

DevPos(nrow+6,ncol+3)  ; DevOut(' 7 ','&colod_')
DevPos(nrow+6,ncol+8)  ; DevOut(' 8 ','&colod_')
DevPos(nrow+6,ncol+13) ; DevOut(' 9 ','&colod_')
DevPos(nrow+6,ncol+18) ; DevOut(' - ','&colod_')

DevPos(nrow+8,ncol+3)  ; DevOut(' 4 ','&colod_')
DevPos(nrow+8,ncol+8)  ; DevOut(' 5 ','&colod_')
DevPos(nrow+8,ncol+13) ; DevOut(' 6 ','&colod_')
DevPos(nrow+8,ncol+18) ; DevOut(' + ','&colod_')

DevPos(nrow+10,ncol+3)  ; DevOut(' 1 ','&colod_')
DevPos(nrow+10,ncol+8)  ; DevOut(' 2 ','&colod_')
DevPos(nrow+10,ncol+13) ; DevOut(' 3 ','&colod_')
DevPos(nrow+10,ncol+18) ; DevOut('Bsp','&colod_')

DevPos(nrow+12,ncol+3) ; DevOut(' 0 ','&colod_')
DevPos(nrow+12,ncol+8) ; DevOut('  .  ','&colod_')
DevPos(nrow+12,ncol+16); DevOut(' '+chr(17)+'ÄÙ ','&colod_')
Cursor_no()
tecla=13 ;_Vpic = '' ; _Resultado = 0 ; _teclant = 13

Do while Tecla<>27
   tecla= inkey(0)
   Tone(100,1)
   Do case
      case (tecla>=48 .and. tecla<=57) .or. tecla=Asc('.')
           _Vpic  = _Vpic + chr(tecla) ; _Valor = Val(_Vpic) ; Picher(_Valor)
      case tecla= 8    && backspace
           _Vpic = Left(_Vpic,Len(_Vpic)-1) ; _Valor = Val(_Vpic) ; Picher(_Valor)
      case tecla=Asc('C') .or. tecla=Asc('c')
           _Resultado = 0          ; _Vpic = ''
           _Valor     = Val(_Vpic) ; Picher(_Valor)
      case tecla=Asc('*') .or. tecla=Asc('/') .or. tecla=Asc('-') .or. tecla=Asc('+')
           _macro     = chr(tecla)  ; _Vpic = ''
           _Valor     = iif(_macro='/'.and._Valor=0,1,_Valor)
           _Res1      = '_Resultado'+_Macro+'_Valor'
           _Resultado = &_Res1      ; _Valor = 0
           Picher(_Resultado)
           _teclant = tecla
      Case tecla=13
           Do case
               case _teclant=Asc('*') .or. _teclant=Asc('/') .or. _teclant=Asc('-') .or. _teclant=Asc('+')
               _macro     = chr(_teclant) ; _Vpic = ''
               _Valor     = iif(_macro='/'.and._Valor=0,1,_Valor)
               _Res1      = '_Resultado'+_Macro+'_Valor'
               _Resultado = &_Res1        ; _Valor = 0
               Picher(_Resultado)
           EndCase
      Case tecla=Asc('T') .or. tecla=Asc('t')
           if len(trim(_CVarEntra))<>0
              _Vart  = _CVarEntra
              &_Vart = _Resultado
           endif
           exit
   Endcase
Enddo
Cleartec()
If (Tecla=Asc('T') .or. tecla=Asc('t')) .and. Len(Trim(_CVarEntra))<>0
   Keyboard chr(13)
Endif
Cursor_si()
Restscreen(nrow,ncol,nrow+14,ncol+23,PanKal)
setcolor(colorantes)
Return

Function Picher(_Vvalor)
Local resto
resto = _Vvalor - Int(_Vvalor)
_At = iif(Len(ALLtrim(Str(resto)))<=3,16,18-(Len(ALLtrim(Str(resto)))-2))
_pict = '999999999999999999' ;_pict = stuff(_pict,_At,1,'.') ; _pict = '@ '+_pict
DevPos(nrow+2,ncol+2) ; DevOut(Transform(_Vvalor,'&_pict'),'&colod_')
Return .t.

function vericuit
PARAMETER m_cuit
local _cuit,i,_digito,j,suma,resto,dv,sale
if lastkey()=5 ; return .t. ; endif
_cuit=''
sale = .f.
for i=1 to len(m_cuit)
    if subs(m_cuit,i,1)$'0123456789' ; _cuit=_cuit+subs(m_cuit,i,1) ; endif
next
if len(_cuit)<>11 ; do errores with 'LA CUIT ES INVALIDA ...' ; return .f. ; endif
_digito=val(right(_cuit,1))
j=2 ; suma=0 ; dv=0
for i=10 to 1 step -1
    suma = suma + val(subs(_cuit,i,1)) * j
    j = j + 1
    if j=8 ; j=2 ; endif
next
resto=mod(suma,11)
if resto=0
   dv=0
else
   dv=11 - resto
   if dv=10 ; dv=9 ; endif
endif

if len(alltrim(m_cuit))<>13
    if .not. '-'$m_cuit
       m_cuit=left(m_cuit,2)+'-'+subs(m_cuit,3,8)+'-'+strzero(_digito,1)
    endif
    do errores with 'LA CUIT ES INVALIDA ...'
    return .f.
endif

sale= if(_digito=dv,.t.,.f.)
if .not. sale
    do errores with 'LA CUIT ES INVALIDA ...'
endif
return sale

Function AbmDuctil(OpDuctil,DoDuctil)
save scree to PanDuctil
_CopDuctil = Len(OpDuctil)
_OpD1 = 0
Do while .t.
   queprogram = 'AbmDuctil'+procname()
   _OPD1=MENU(02,00,14,00+len(OpDuctil[1])+2,OpDuctil,single,_CopDuctil,'PanDuctil',_opd1,.f.)
   If _opd1=0
      exit
   elseif DoDuctil[_opd1]<>'NADA'
          _QDoexe = DoDuctil[_opd1]
          Do &_QDoexe
          exit
   endif
enddo
Resto Screen From PanDuctil
Return .t.

Function Desactiva
Parameters _key,q_procedure
If pcount()=1
  Set key _key to
else
  Set key _key to &q_procedure
endif
Return .t.

Function Say_mes(me_s,_f1,_c1)
Set colo to &colob_
@ _f1,_c1 say MesArg(me_s)
Set colo to &colog_
Return .t.

function diaarg
parameter fec
dia := {'Domingo','Lunes','Martes','Mi‚rcoles','Jueves','Viernes','S bado'}
return (dia[dow(fec)])

function cuenta_madre(_esbienuso,_queorden)
  local _regis,_nivel
  sele plancue
  set order to 3
  _regis=recno()
  _nivel=nivel
  do while .not. bof() .and. nivel>=_nivel
     skip -1
  enddo
  _esbienuso=iif('BIENES DE USO'$nombre,.t.,.f.)
   go _regis
   set order to _queorden
return .t.

function veo_arbol
parameter m_seccion,fc,cc,fn,cn,fid,cid,ffd,cfd,_mcol
ultarea=select()
colodb_ = colog_
set colo to &colodb_
sele seccion
set order to 1
seek m_seccion
if .not. found()
   set order to 3
   save scree
   m_col=iif(pcount()<10,cid,_mcol)
   go top
   raya       = 'ÂÄ'
   declare campo[1],n_cpo[1]
   campo[1]='cuenta'
   n_cpo[1]='    SECCIONES'
   cleartec()
   keyboard chr(09)+CHR(24)
   set colo to &colou_
   dbedit(fid,cid,ffd,cfd,campo,'vafnc','',n_cpo,' ','³',' ')
   resto scree
endif
if lastkey()=27 .or. nivel<1
   sale=.f.
else
   sale=.t.
   m_seccion=seccion->numero
   set colo to &colob_
   @ fc,cc say numero
   @ fn,cn say left(nombre,cfd-cn+1)
endif
set colo to &colog_
cleartec()
select(ultarea)
return sale

function vafnc
parameter mode,fld_ptr
lini=row()
coli=col()
if nivel<>0
   SET COLO TO &coloi_
   @ row(),(m_col+nivel*4)-1 say ' '
endif
set colo to &colob_
@ row(),m_col+nivel*4 say subst(nombre,1)
if nivel<>0
   SET COLO TO &coloi_
   @ row(),1+m_col+nivel*4 say subs(trim(nombre)+space(1),2,len(trim(nombre))+1)
endif
set colo to &colon_
INKEY(0)
q_return=1
do case
   case lastkey()=13 .and. nivel>0 && enter
        set order to 3
        q_return=0
   case lastkey()>=48 .and. lastkey()<=255  && escribir
        f2=21
        c1=3
        keyboard chr(lastkey())
        abuscar=space(35)
        set colo to &colog_
        sale=existe(0,'seccion',f2+2,c1+1,f2+2,c1+1,0,'N',45,'numero',1,.f.,'nombre')
        if sale
           set order to 3
           abuscar=nombre
        else
           set order to 3
           return 2
        endif
        cursor_no()
        set order to 2
        seek_dato(trim(abuscar),.t.)
        set colo to &colon_
        @ f2+2,c1+1 say space(35)
        set colo to &colodb_
        if eof()
           go top
        endif
        set order to 3
        cleartec()
        keyboard chr(13)+chr(13)
        set colo to
        q_return=2
   case lastkey()=27 && esc
        set order to 3
        q_return=0
endcase
keyboard chr(lastkey())
return q_RETURN

function listo_arbol
parameter _secini,_secfin,fid,cid,ffd,cfd,_area,_orden,_campo,_ncampo,_mcol
_area=iif(pcount()<7,'seccion',_area)
_orden=iif(pcount()<8,3,_orden)
ultarea=select()
colodb_ = colog_
set colo to &colodb_
sele &_area
set order to _orden
m_col=iif(pcount()<11,cid,_mcol)
go top
raya       = 'ÂÄ'
declare campo[1],n_cpo[1]
campo[1]=iif(pcount()<9,'cuenta',_campo)
n_cpo[1]=iif(pcount()<10,'    SECCIONES',_ncampo)
linea_ayuda= '     [HOME] Comienzo    [END] Fin      [ENTER] Contin£a   [ESC] Aborta      '
set colo to &coloi_
@ 24,02 say linea_ayuda
set colo to &colodb_
cleartec()
keyboard chr(09)+CHR(24)
dbedit(fid,cid,ffd,cfd,campo,'lafnc','',n_cpo,' ','³',' ')
set colo to &colog_
select(ultarea)
return .t.

function lafnc
parameter mode,fld_ptr
local _muestro,_colmuestro
lini=row()
coli=col()
if nivel<>0
   SET COLO TO &coloi_
   @ row(),(m_col+nivel*4)-1 say ' '
endif
set colo to &colob_
@ row(),m_col+nivel*4 say left(nombre,1)
if nivel<>0
   SET COLO TO &coloi_
   _muestro=len(trim(nombre))+1
   _colmuestro=1+m_col+nivel*4
   if _muestro+_colmuestro>=cfd
      _muestro=cfd - _colmuestro+1
   endif
   @ row(),_colmuestro say subs(alltrim(nombre)+space(1),2,_muestro)
endif
set colo to &colon_
INKEY(0)
q_return=1
do case
   case lastkey()>=48 .and. lastkey()<=255  && escribir
        f2=ffd-2
        c1=cid
        keyboard chr(lastkey())
        abuscar=space(35)
        set colo to &colog_
        sale=existe(0,'seccion',f2+2,c1+1,f2+2,c1+1,0,'N',25,'numero',1,.f.,'nombre')
        if sale
           set order to 3
           abuscar=nombre
        else
           set order to 3
           return 2
        endif
        cursor_no()
        set order to 2
        seek_dato(trim(abuscar),.t.)
        set colo to &colon_
        @ f2+2,c1+1 say space(35)
        set colo to &colodb_
        if eof()
           go top
        endif
        set order to 3
        cleartec()
        keyboard chr(13)+chr(13)
        set colo to
        q_return=2
   case lastkey()=13  && enter
        if len(alltrim(_secini))=0
           go top
           _secini=clave
           set colo to &colob_
           @ fid,cid+1 say 'DESDE : '+left(nombre,30)
           set colo to &colodb_
        endif
        if len(alltrim(_secfin))=0
           go bott
           _secfin=clave
           set colo to &colob_
           @ fid+1,cid+1 say 'HASTA : '+left(nombre,30)
           set colo to &colodb_
        endif
        q_return=0
   case lastkey()=27 && esc
        q_return=0
   case lastkey()=1
        if clave>_secfin .and. len(alltrim(_secfin))<>0
           do errores with 'Debe ser Menor que Final'
           cursor_no()
           return 1
        endif
        _secini=clave
        set colo to &colob_
        @ fid,cid+1 say 'DESDE : '+left(nombre,30)
        set colo to &colodb_
   case lastkey()=6
        if clave<_secini
           do errores with 'Debe ser Mayor que inicial'
           cursor_no()
           return 1
        endif
        _secfin=clave
        set colo to &colob_
        @ fid+1,cid+1 say 'HASTA : '+left(nombre,30)
        set colo to &colodb_
endcase
keyboard chr(lastkey())
return q_RETURN



function cleartec
clear typeahead
keyboard chr(32)
inkey()
return .t.

FUNCTION R_LOCK
PARAMETERS aguanto
PRIVATE aguanto,siempre,pantaux,ttt
aguanto=iif(pcount()=0,2,aguanto)
if rlock()
   RETURN (.T.)
endif
siempre=aguanto
save scre to pantaux
do ARCENUSO with .f.
do while aguanto>=0
  if rlock()
     rest scre from pantaux
     ??chr(7)
     RETURN (.T.)
  endif
  ttt=inkey(.5)
  aguanto=iif(siempre<>0,(aguanto-.5),aguanto)
enddo
rest scre from pantaux
RETURN (.F.)

FUNCTION USAR
PARAMETERS file, ex_use, a_lias, espera
PRIVATE forever,pantaux
espera =iif(pcount()<4,0,espera)
a_lias =iif(pcount()<3,file,a_lias)
if ex_use
   use &file EXCLUSIVE alias &a_lias NEW           && NEW asigna el proximo area
else
   use &file alias &a_lias NEW
endif
if .not. neterr()
   RETURN (.T.)
endif
save scre to pantaux
do ARCENUSO with .t.,file
forever = (espera = 0)
do while (forever .OR. espera > 0)
   if ex_use
      use &file EXCLUSIVE alias &a_lias NEW
   else
      use &file alias &a_lias NEW
   endif
   if .not.neterr()
      rest scre from pantaux
      ??chr(7)
      RETURN (.T.)
   endif
   inkey(1)
   if lastkey()=27
      exit
   endif
   espera = espera - 1
enddo
rest scre from pantaux
RETURN (.F.)

FUNCTION APPEBLAN
PARAMETERS espera
PRIVATE forever,pantaux
appe blan
if .not.neterr()
   RETURN (.T.)
endif
save scre to pantaux
do ARCENUSO with .t.
forever=(espera=0)
do while (forever.or.espera>0)
   appe blan
   if .not.neterr()
      ??chr(7)
      rest scre from pantaux
      RETURN (.T.)
   endif
   inkey(.5)
   espera=espera-.5
enddo
rest scre from pantaux
RETURN (.F.)

PROCEDURE ARCENUSO
PARAMETERS archi
Ventana('r210171661H112181260','w')
ayuda23(11,34,60,'E S P E R E','w+*')
set colo to &colon_
@ 14,21 say iif(archi,'EL ARCHIVO '+rtrim(FILE)+' ESTA EN USO...','EL REGISTRO ESTA SIENDO USADO...')
RETURN

FUNCTION RED
PARAMETERS var
if var>=0
   var=(var + 0.005) * 100
else
   var=(var - 0.005) * 100
endif
var=int(var)/100
RETURN var

FUNCTION RED2
PARAMETERS var
if var>=0
   var=(var + 0.0005) * 1000
else
   var=(var - 0.0005) * 1000
endif
var=int(var)/1000
RETURN var

function aborra
parameter arreglo,posicion
private m_elemento,_tipo
m_elemento=arreglo[1]
adel(arreglo,posicion)
_tipo=type('m_elemento')
if _tipo='N'
        m_elemento=0
elseif _tipo='C'
        if m_elemento='v_imagen'
           m_elemento=imagen
        else
           m_elemento=space(len(arreglo[1]))
        endif
elseif _tipo='D'
        m_elemento=ctod('  -  -  ')
elseif _tipo='L'
        m_elemento=.f.
endif
afill(arreglo,m_elemento,len(arreglo))
return(.t.)

FUNCTION RIGH
PARAMETERS var,num
RETURN subs(var,len(var)-num+1,num)

FUNCTION MESARG
PARAMETERS xmes
PRIVATE mesenlet
mesenlet=subs('Enero    Febrero  Marzo    Abril    Mayo     Junio    Julio    Agosto   SetiembreOctubre  NoviembreDiciembre',(xmes-1)*9+1,9)
RETURN mesenlet

PROCEDURE ERRORES
PARAMETERS mensa,cartel
cartel=iif(pcount()<2,'E  R  R  O  R',cartel)
maxcar=41
mensa=subs(mensa,1,maxcar)
save scre to pantaux
cursor_no()
ventana('r209171761H111181160H115181560I31117    D31161    I31517    D31561    ','&colon_')
set colo to &colob_*
@ 10,33 say cartel
set colo to &colon_
colerr=19+(42-len(mensa))/2
@ 13,colerr say mensa
@ 16,19 say 'Apriete cualquier tecla para continuar...'
inkey(0)
poner_cursor()
rest scre from pantaux
RETURN

PROCEDURE AVISAR
PARAMETERS mensa,confi,ok
if pcount()=1
   confi=2
   ok=1
endif
maxcar=35
mensa=subs(mensa,1,maxcar)
ventana('r209201758H111211157H115211557I31120    D31158    I31520    D31558    ','&colon_')
set colo to &colon_
@ 10,30 say 'Rutina  en  Proceso'
colerr=21+(38-len(mensa))/2
@ 13,21 SAY SPACE(35)
@ 13,colerr say mensa
if confi=1
   ok=2
   do confisn with 16,28,'Confirma',ok
endif
@ 16,28 say 'Un momento por favor...'
RETURN

PROCEDURE ELIJO
PARAMETERS num,nom,CAMPOA,CAMPON,linea,campoa2,_dejoescribir,_esexacta
cursor_no()
skip
campoa2=iif(pcount()<6,campoa,campoa2)
_esexacta=iif(pcount()<8,.f.,_esexacta)
if !_esexacta
   _coniex='(subs(&CAMPOA,1,len(trim(nom)))<>trim(nom))'
else
   _coniex='&CAMPOA<>nom'
endif
_dejoescribir=iif(pcount()<7,.t.,_dejoescribir)
linea  =iif(pcount()<5,11,linea)
*if (eof() .or. subs(&CAMPOA,1,len(trim(nom)))<>trim(nom)) .and. _dejoescribir
if (eof() .or. &_coniex) .and. _dejoescribir
   skip -1
   num=&CAMPON
   nom=&CAMPOA
   poner_cursor()
   return
else
   skip -1
endif

save scre to comoantes
set exact off
recini=recno()
opini=1
maxl=10
maxele=maxl
if maxl+linea+3>22
   inil=08
else
   inil = iif(linea<3,3,linea)
endif
ultl=inil+maxl-1
inic  = 74 - len(&campoa2)
lenvar= len(&campoa2)
if inic <1
   inic = 5
   lenvar = 60
endif
_busco=''
electo=1
store .f. to hayup,haydo
recini=str(recno())
set colo to &coloi_
_ventana='x1'+strzero(inil-1,2)+strzero(inic-4,2)+strzero(ultl+3,2)+strzero(inic+lenvar+2,2)
ventana(_ventana,'&coloi_')
@ inil,inic-2 to ultl,inic-2
@ ultl+1,inic-2 to ultl+1,inic+lenvar+1

linac=inil
skip -1
do miro_arriba
do elijo_1_1
do while .t.
   SET COLO TO &colob_
   @ inil,inic-3 say iif(hayup,'',' ')
   @ ultl,inic-3 say iif(haydo,'',' ')
   SET COLO TO &colob_
   do muestro_eleccion
   set colo to &coloi_
   a=inkey(0)
   keys='003-005-007-008-013-018-024-027-022'
   do while .not. (strzero(a,3)$keys.or.(a>=32 .and. a<=255))
      a=inkey(0)
   enddo
   do case
      case a=7
           _busco=''
           set colo to &colob_
           @ ultl+2,inic say left(_busco+space(80),lenvar-1)
           set colo to &coloi_
      case a=8
           _busco=iif(len(_busco)>1,left(_busco,len(_busco)-1),'')
           set colo to &colob_
           @ ultl+2,inic say left(_busco+space(80),lenvar-1)
           set colo to &coloi_
      case a>=32 .and. a<=255  .and. _dejoescribir && busco por letra
           nom=iif(_busco='','',nom)
           _busco=_busco+upper(chr(a))
           set colo to &colob_
           @ ultl+2,inic say left(_busco+space(80),lenvar-1)
           set colo to &coloi_
           recini=str(recno())
           seek _busco
           if .not. eof()
              recini=str(recno())
              electo=1
              linac=inil
              do muestro_eleccion
              skip -1
              do miro_arriba
              do elijo_1_1
            else
              go &recini
            endif
      case a=13 .or. a=27 .or. a=22
           rest scre from comoantes
           num=&CAMPON
           nom=&CAMPOA
           set colo to &colon_
           poner_cursor()
           RETURN
      case a=5
           do muestro_eleccion
           electo=electo-1
           skip -1
           *if bof().or.substr(&CAMPOA,1,len(trim(nom)))<>trim(nom)
           if bof().or.&_coniex
              if bof()
                 go top
              else
                 skip
              endif
              electo=electo+1
           endif
           if electo=0
              recini=str(recno())
              linac=inil
              skip -1
              do miro_arriba
              do elijo_1_1
              electo=1
           endif
      case a=24
           do muestro_eleccion
           skip
           electo=electo+1
           *if substr(&CAMPOA,1,len(trim(nom)))<>trim(nom) .or. eof()
           if &_Coniex .or. eof()
              skip -1
              electo=electo-1
           endif
           if electo>maxl
              recini=str(recno())
              skip -(maxl-1)
              linac=inil
              skip -1
              do miro_arriba
              do elijo_1_1
              electo=maxl
           endif
      case a=18
           if electo=1
              if hayup
                 skip -(maxl-1)
                 if bof()
                    go top
                 endif
                 avanzo_eleccion(1)
                 recini=str(recno())
                 linac=inil
                 skip -1
                 do miro_arriba
                 do elijo_1_1
                 electo=1
              endif
           else
              do muestro_eleccion
              skip -(electo-1)
              electo=1
              SET COLO TO &colob_
              do muestro_eleccion
              set colo to &coloi_
           endif
      case a=3
           if electo=maxele
              if haydo
                 skip maxl-1
                 avanzo_eleccion(-1)
                 skip -(maxl-1)
                 if bof()
                    go top
                 endif
                 avanzo_eleccion(1)
                 linac=inil
                 skip -1
                 do miro_arriba
                 do elijo_1_1 with .f.
                 skip -1
                 electo=maxele
              endif
           else
              do muestro_eleccion
              skip maxele-(electo)
              electo=maxele
              SET COLO TO &colob_
              do muestro_eleccion
              set colo to &coloi_
           endif
   endcase
enddo
return

function avanzo_eleccion
parameter cuanto
*do while substr(&CAMPOA,1,len(trim(nom)))<>trim(nom) .and. .not. eof() .and. .not. bof()
do while &_coniex .and. .not. eof() .and. .not. bof()
   skip cuanto
enddo
return(.t.)

procedure elijo_1_1
parameter vuelvo
if pcount()=0
   vuelvo=.t.
endif
maxele=0
do while linac<=ultl
   *if substr(&CAMPOA,1,len(trim(nom)))=trim(nom) .and. .not. eof()
   if !&_coniex .and. .not. eof()
      @ linac,inic say &CAMPOA2
      maxele=maxele+1
      skip
   else
      @ linac,inic say space(lenvar)
   endif
   linac=linac+1
enddo
*if substr(&CAMPOA,1,len(trim(nom)))=trim(nom) .and. .not. eof()
if !&_coniex .and. .not. eof()
   haydo=.t.
else
   haydo=.f.
endif
if vuelvo
   go &recini
endif
return

procedure muestro_eleccion
   @ inil+electo-1,inic say &CAMPOA2
retu

procedure miro_arriba
*if bof().or. substr(&CAMPOA,1,len(trim(nom)))<>trim(nom)
if bof().or. &_coniex
   hayup=.f.
   if bof()
      go top
   else
      skip
   endif
else
   hayup=.t.
   skip
endif
return

PROCEDURE INIC_IMPRE
PARAMETERS tipo_letra,largo_hoja,ambosdispositivos,es_pantalla
PRIVATE xiop
ulta=select()
m_lpt = iif(len(alltrim(tabla->lpt_g)) =0,'lpt1',tabla->lpt_g)
brillam=.f.
if pcount() < 3
   ambosdispositivos = .t.
   xiop=1
   brillam=.t.
endif
xiop=iif(ambosdispositivos,1,2)
if pcount()<4
   es_pantalla = .f.
endif
cursor_no()
cleartec()
queimpresora = 1
ventana('s016402170r115392069','w')
veomonitor(brillam,ambosdispositivos)
queimpresora=veoimpresora(.not. brillam,queimpresora,ambosdispositivos,xiop)
do while lastkey()<>13 .and. lastkey()<>27 .and. lastkey()<>6
   _xxfinlis=.f.
   inkey(0)
   if lastkey()=9 .or. lastkey()=19 .or. lastkey()=4
      brillam=iif(xiop=1,.f.,.t.)
      xiop     =iif(xiop=1,2,1)
      veomonitor(brillam,ambosdispositivos)
      queimpresora=veoimpresora(.not. brillam,queimpresora,ambosdispositivos,xiop)
   elseif lastkey()=6
      _xxfinlis=.t.
   endif
enddo
set colo to &colon_
cursor_si()
if lastkey()=27
   select(ulta)
   break
endif
if es_pantalla
  set colo to *&colob_
  @ 17,56 say 'IMPRESORA'
  set colo to &colon_
  set conso off
  dispo=2
  select(ulta)
  return
endif
if xiop=1
  set colo to *&colob_*
  @ 17,43 say 'MONITOR'
  set colo to &colon_
  dispo=1
  m_hoja=1
  topelin=65
  cerrarlis=.f.
  pri_hoja=.t.
  set conso off
  set device to print
  set print on
  dispositivo='sal'+strzero(m_terminal,2)+strzero(m_hoja,3)+'.dat'
  set printer to &dispositivo
else
  set colo to *&colob_
  @ 17,56 say 'IMPRESORA'
  set colo to &colon_
  set conso off
  if sideways
     set device to print
     set print on
     dispositivo='sal'+strzero(m_terminal,2)+'000.dat'
     set printer to &dispositivo
  endif
  if queimpresora = 2 .and. .not. sideways
     set printer to &m_lpt
     set device to print
     set print on
  endif
endif

if xiop=2
  dispo=2
  topelin=65
  if .not. sideways
     ??chr(27)+'@'
     ??CHR(27)+"C"+CHR(largo_hoja)
     ??chr(tipo_letra)
  endif
endif
select(ulta)
RETURN

function veomonitor
parameters brilla,ambosdispositivos
if ambosdispositivos
   iif(brilla,setcolor('&colob_'),setcolor('&colon_'))
   @ 16,41 say 'ÛßßßßßßßßßÛ '
   @ 17,41 say 'Û Monitor Û '
   @ 18,41 say 'ÛÜÜÜÜÜÜÜÜÜÛ '
   @ 19,41 say '  ÜÜÛÛÛÜÜ   '
endif
return .t.

function veoimpresora
parameters brilla,queimpresora,ambosdispositivos,xiop
iif(brilla,setcolor('&colob_'),setcolor('&colon_'))
@ 16,53 say '  ÚÄÄÄÄÄÄÄÄÄ¿  '
@ 17,53 say '  ³Impresora³  '
@ 18,53 say '  ÜÜÜÜÜÜÜÜÜÜÜ  '
@ 19,53 say ' ÛÛÛÛÛÛÛÛÛÛÛÛÛþ'
set colo to &coloi_
if xiop=2
   keyboard chr(5)
   declare _1[len(imp_nombre)],_2[len(imp_nombre)]
   afill(_1,20) ; afill(_2,53)
   _queimp = val(subs(m_lpt,4,1))
   _queimp = iif(_queimp>len(imp_nombre),1,_Queimp)
   _scrmnto=savescreen(20,53,20,53+len(imp_nombre[1])+2)
   _queimp=menu_to(_queimp,imp_nombre,_1,_2,len(imp_nombre),'&coloi_',.t.,.t.,.f.)
   restscreen(20,53,20,53+len(imp_nombre[1])+2,_scrmnto)
   if lastkey()=3 .or. lastkey()=18 .or. lastkey()=19 .or. lastkey()=4
      cleartec()
      keyboard chr(9)
      if .not. ambosdispositivos
         keyboard chr(9)
      endif
   endif
   if _queimp<>0 ;   m_lpt = imp_puerto[_queimp] ; endif
else
    queimpresora = 2
endif
return queimpresora

PROCEDURE TITULOS
parameters pag,tipo_letra,titulo,ancho,salto,canlin,si3linea,chrm,_centro
canlin=0
maxti = 80
if pcount()<8
   chrm=''
endif
_centro = iif(pcount()<9,0,_centro)
if .not. sideways
    _ffactor=iif(ancho<=180,1,2)
    segundalinea=replicate('ÿ',15)+replicate('Ä',maxti-30)+replicate('ÿ',15)
    primerlinea = replicate(' ',42*_ffactor)
    If _ffactor<>2
       primerlinea = stuff(primerlinea,int(21*_ffactor-len(trim(titulo[1]))/2),len(trim(titulo[1])),trim(titulo[1]))
    else
       primerlinea = stuff(primerlinea,int(34-len(trim(titulo[1]))/2),len(trim(titulo[1])),trim(titulo[1]))
    endif
    apartir = (maxti-len('ÿ'+titulo[2]+'ÿ'))/2
    if apartir < 1
       apartir = 1
    endif
    if len(trim(titulo[2]))<>0
       segundalinea = stuff(segundalinea,apartir,len('ÿ'+titulo[2]+'ÿ'),'ÿ'+titulo[2]+'ÿ')
    else
       segundalinea=''
    endif
else
    primerlinea = trim(titulo[1])
    if len(trim(titulo[2]))<>0
       segundalinea =titulo[2]
    else
       segundalinea=''
    endif
endif

tercerlinea =''
if si3linea
*   tercerlinea = 'FECHA: '+dtoc(date())+replicate(' ',maxti-30)+'PAGINA :'+strzero(pag,4)
    tercerlinea = 'FECHA: '+dtoc(date())+' '+time()+replicate(' ',maxti-39)+'PAGINA :'+strzero(pag,4)
endif

   if salto
      if dispo=2
         if queimpresora=2
            eject
         else
            ? chr(12)
         endif
      else
         cerralis=.f.
         edi_lis()
      endif
   endif
   pri_hoja=.f.
   if .not. sideways
      ?? chr(18)
      ?? chr(27)+'P'
   endif
   if .not. sideways
      @ prow(),pcol() say chr(27)+chr(69)+chr(14)+trim(primerlinea)+chr(27)+chr(70)
      if len(trim(segundalinea))<>0
         @ prow()+1,0 say chr(27)+chr(69)+segundalinea+chr(27)+chr(70)
         canlin=canlin+1
      endif
      if len(trim(tercerlinea))<>0
         @ prow()+1,0 say chr(27)+chr(69)+tercerlinea+chr(27)+chr(70)
         canlin=canlin+1
      endif
      ?? chr(tipo_letra)
   else
      @ prow(),pcol() say trim(primerlinea)
      if len(trim(segundalinea))<>0
         @ prow()+1,0 say segundalinea
         canlin=canlin+1
      endif
      if len(trim(tercerlinea))<>0
         @ prow()+1,0 say tercerlinea
         canlin=canlin+1
      endif
   endif
   if pcount() > 7
      ?? chrm
   endif
   for it=3 to len(titulo)
       If it <=_centro
          _len = len(titulo[it])
          apartir = iif(_len>=80,(80-_len)/2,(88-_len)/2)
          apartir = iif(apartir < 1,1,apartir)
          _linea = replicate('ÿ',apartir)+titulo[it]
          @ prow()+1,0 say chr(27)+chr(69)+_linea+chr(27)+chr(70)
       else
          ? titulo[it]
       endif
       canlin = canlin + 1
   next it
   pag=pag+1
RETURN

PROCEDURE CERRAR_LISTADO
parameter ancho,sacar,line_fin,es_pantalla
private alista
ulta=select()
ancho = iif(pcount()=0,80,ancho)
sacar = iif(pcount()<=1,.f.,sacar)
line_fin = iif(pcount()<3,replicate('Ä',ancho),line_fin)
es_pantalla=iif(pcount()<4,.f.,es_pantalla)
if dispo = 2
   if ancho<>0
      ? line_fin
   endif
   if queimpresora<>1 .and. .not. es_pantalla
      eject
   elseif .not. es_pantalla
      ? chr(12)
   endif
   cleartec()
   set printer to
   set printer off
   if sideways
      m_lpt = iif(len(alltrim(tabla->lpt_g))=0,'lpt1',tabla->lpt_g)
      set device to screen
      set conso on
      set colo to &colon_
      @ 17,00 clea to 23,37
      @ 17,00 say ''
      cmd = 'sideways '+dispositivo
      ! &cmd
      select(ulta)
      return
   endif
   if queimpresora = 1
      m_lpt = iif(len(alltrim(tabla->lpt_g))=0,'lpt1',tabla->lpt_g)
      cmd = 'type '+dispositivo+' > '+m_lpt
      ! &cmd
      set device to screen
      set conso on
      set colo to &colon_
   endif                                   && en el server
   if queimpresora=2 .and. es_pantalla
      m_lpt = iif(len(alltrim(tabla->lpt_g))=0,'lpt1',tabla->lpt_g)
      cmd = 'type '+dispositivo+' > '+m_lpt
      ! &cmd
   endif
   set device to screen
   set conso on
else
   cerrarlis=.t.
   if ancho<>0
      ? line_fin
   endif
   if _Xxfinlis
     _Xxfinlis=.f.
     edi_lis(.t.)
   else
     edi_lis()
   endif
   ? chr(26)
   set print off
   set printer to
   set device to screen
   set conso on
endif
set softseek off
cursor_si()
select(ulta)
RETURN

FUNCTION EDI_LIS
parameter abro
abro=iif(pcount()<1,.f.,abro)
private alista
hoja_actual=m_hoja
? chr(26)
set print off
set printer to
set device to screen
set conso on
pagina_arriba=.f.
pagina_abajo=.f.
_qtecla=0

do while .t.

   if .not. _xxfinlis
      if abro
         do explota with 00,00,24,79,1,10
         @ 22,01 to 22,78
         abro=.f.
      endif
      @ 23,1 clea to 23,78
      SET COLO TO &colob_
      @ 23,28 say 'AGUARDE UN INSTANTE ...'
      set colo to &colon_
   elseif _Xxfinlis
      do avisar with 'Generando P gina '+alltrim(transform(m_hoja+1,'999999'))
   endif

   if .not. _xxfinlis
      listado=memoread('&dispositivo')
      encabe=subs(listado,1,400)
      encabe=strtran(encabe,CHR(14),space(19))
      encabe=strtran(encabe,CHR(15),'')
      encabe=strtran(encabe,CHR(18),'')
      encabe=strtran(encabe,CHR(27)+'M','')
      encabe=strtran(encabe,CHR(27)+'P','')
      encabe=strtran(encabe,CHR(27)+chr(69),'')
      encabe=strtran(encabe,CHR(27)+chr(70),'')
      *   encabe=strtran(encabe,CHR(27)+'@','')
      *   encabe=strtran(encabe,CHR(27)+'C'+chr(72),'')
      listado = stuff(listado,1,400,encabe)
      listado = strtran(listado,CHR(14),'')
   endif

   if m_hoja=1 .and. .not. _Xxfinlis
      do explota with 00,00,24,79,1,10
      @ 22,01 to 22,78
   endif

   if .not. _xxfinlis
      SET COLO TO &colob_
      @ 23,5 say ' [Esc] Aborta  [Enter] Contin£a [F10] Imprime '+CHR(26)+' '+CHR(27)+'   '+CHR(24)+' '+CHR(25)+' PgUp PgDn'
      set colo to &colon_
   endif

   cortar_listado=.f.
   if .not. _Xxfinlis
      cleartec()
      cursor_no()
      cant_lineas=mlcount(listado,ancho)
      *   set key -9 to imprimo_pantalla
      *   cursor_si()
      keyboard chr(32)
      memoedit(listado,1,1,21,78,.f.,'YMEMO',ancho+2,2)
   endif

   set key -9 to

   if cortar_listado
      set print off
      set printer to
      set device to screen
      set conso on
      break
   endif

   if pagina_arriba
      pagina_arriba=.f.
      hoja_actual=hoja_actual-1
      dispositivo='sal'+strzero(m_terminal,2)+strzero(hoja_actual,3)+'.dat'
      loop
   endif

   if pagina_abajo
      pagina_abajo=.f.
      hoja_actual=hoja_actual+1
      dispositivo='sal'+strzero(m_terminal,2)+strzero(hoja_actual,3)+'.dat'
      loop
   endif

   if .not. _Xxfinlis
      @ 23,1 clea to 23,78
      SET COLO TO &colob_
      @ 23,28 say 'AGUARDE UN INSTANTE ...'
      set colo to &colon_
   endif

   set softseek off
   set conso off
   set device to print
   set print on
   m_hoja=m_hoja+1
   dispositivo='sal'+strzero(m_terminal,2)+strzero(m_hoja,3)+'.dat'
   set printer to &dispositivo
   cursor_si()
   exit
enddo

RETURN(.t.)


FUNCTION ymemo
PARAMETERS mmode, line, col
PRIVATE ret_val
ret_val = 32
*_ROW = ROW()
*_COL = COL()

*@ 00,20 SAY MMODE
*@ 00,30 SAY LASTKEY()
*@ 00,40 say _qtecla pict '9999'


if (_qtecla=0 .or. lastkey()=0) .and. .not. strzero(_qtecla,2)$'27-13-18'
*   @ 00,50 say 'MI INKEY'
   inkey(0)
*else
*   @ 00,50 say 'SU INKEY'
endif

*@ _row,_col say ''

_qtecla=lastkey()

IF mmode <> 0  &&.or. lastkey()=27 .or. _qtecla=27
        keystroke = iif(_qtecla=27,27,lastkey())
        do case
        case keystroke = 27
           cortar_listado=.t.
           return(27)
        otherwise
           return 0
        endcase
else
        keystroke = iif(strzero(_qtecla,2)$'27-24-05-13-18',_qtecla,lastkey())
        do case
        case keystroke=-9
           do imprimo_pantalla
           _qtecla=0
           cleartec()
           keyboard chr(5)
        case keystroke = 27
           cortar_listado=.t.
           keyboard chr(27)
        case keystroke = 5
           keyboard chr(5)
        case keystroke=24 .or. keystroke=3 .or. keystroke=30
           if line>=cant_lineas-19
              do while lastkey()=24 .or. lastkey()=3 .or. lastkey()=30
                 do errorbeep
                 cleartec()
*                 @ 00,50 say '?? INKEY'
                 inkey(0)
                 _qtecla=lastkey()
              enddo
*              @ _row,_col say ''
              if lastkey() = 13
                 ret_val=0
                 if hoja_actual<m_hoja
                    pagina_abajo=.t.
                 endif
                 if cerrarlis .and. .not. pagina_abajo
                   do errorbeep
                   _qtecla=0
                   cleartec()
                   keyboard chr(5)
                 else
                   keyboard chr(23)
                 endif
              endif
              if lastkey() = 18
                 if hoja_actual<>01
                    pagina_arriba=.t.
                    keyboard chr(23)
                 else
                    do errorbeep
                    _qtecla=0
                    cleartec()
                    keyboard chr(5)
                 endif
              endif
              if lastkey()=27 .or. lastkey()=5
                 key_board(iif(lastkey()=13 .or. lastkey()=18,23,lastkey()),1)
              endif
              *return lastkey()
           else
              keyboard chr(keystroke)
           endif
        case keystroke = 13
           ret_val=0
           if hoja_actual<m_hoja
              pagina_abajo=.t.
           endif
           if cerrarlis .and. .not. pagina_abajo
              do errorbeep
              _qtecla=0
               cleartec()
               keyboard chr(5)
           else
              keyboard chr(23)
           endif
        case keystroke = 18
           if hoja_actual<>01
              pagina_arriba=.t.
              keyboard chr(23)
           else
              do errorbeep
              _qtecla=0
               cleartec()
               keyboard chr(5)
           endif
        case keystroke=19 && izq
             key_board(8,col()+1)
        case keystroke=4  && der
             _cuantos=(78-col())/2
             _cuantos=iif(_cuantos=int(_cuantos),_cuantos,_cuantos+1)
             key_board(9,_cuantos+1)
        endcase
ENDIF
*@ 00,20 SAY MMODE
*@ 00,30 SAY LASTKEY()
*@ 00,40 say _qtecla pict '9999'
*@ 00,50 say 'SU INKEY'
*@ _ROW,_COL SAY ''
RETURN ret_val



procedure imprimo_pantalla
save scree
do inic_impre with 15,72,.f.,.t.
do cerrar_listado with ancho,.f.,'',.t.
dispo=1
resto scree
return

FUNCTION ABORT_LIST
? ' *******LISTADO ABORTADO POR EL USUARIO !!!********'
? chr(26)
set print off
set printer to
set device to screen
set conso on
RETURN (.T.)

PROCEDURE PIDO_NOMBRE
PARAMETERS lineacod,colcod,lineanom,colnom,tamanio_codigo,campo_codigo,codigo,campoa,campon,_tipo,tamanio_nombre,_final,_imagen
store .f. to salir,_bandera
do while .not. salir
  set order to 2
  go bott
  NOMBUS=space(len(&campoa))
  _tipo=iif(pcount()<10,'N',_tipo)
  tamanio_nombre=iif(pcount()<11,len(nombus),tamanio_nombre)
  _final =iif(pcount()<12,.f.,_final)
  _imagen=iif(pcount()<13,campoa,_imagen)
  @ lineacod,colcod say space(tamanio_codigo)
  @ lineanom,colnom say ''
  set colo to &coloi_
  NOMBUS=acceptat(lineanom,colnom,tamanio_nombre)
  set colo to &colon_
  if NOMBUS=space(tamanio_nombre)
     salir=.t.
     codigo=iif(_tipo='N',0,space(tamanio_codigo))
     @ lineanom,colnom say space(tamanio_nombre)
     if _final
        RETURN
     endif
  endif
  NOMBUS=upper(NOMBUS)
  @ lineanom,colnom say substr(NOMBUS,1,tamanio_nombre)
  SEEK trim(NOMBUS)
  if eof()
     do errores with 'No existe '+campo_codigo+'..'
     loop
  endif
  codigo_i=recno()
  do elijo with codigo_i,NOMBUS,campoa,campon,lineanom,_imagen
  if _tipo='N' .or. (type('codigo_i')='C' .and. _tipo<>'N')
     codigo=codigo_i
  else
    codigo=NOMBUS
  endif
  set order to 1
  salir=.t.
enddo
RETURN

FUNCTION ACCEPTAT
parameters row,col,tamanio,string,ocultar
If pcount()<4
   string = ''
Endif
If pcount()<5
   ocultar=.f.
Endif

set colo to &colob_
antes_at=savescreen(row,col-1,row+1,col+tamanio)
@ row,col-1 say '¯'
@ row,col+tamanio say '®'

set colo to &coloi_
@ row,col say space(tamanio)
@ row,col say string
char = ''
do while .t.
   char=inkey(0)
   do case
      case char=13 .or. char=05 .or. char=24
           string=string+space(tamanio-len(string))
           exit
      case char=27
           string=space(tamanio)
           exit
      case char > 31 .and. char < 170
           if len(string)>=tamanio
              loop
           endif
           string=string+chr(char)
           @ row(),col() say iif(ocultar,'é',upper(chr(char)))
      case (char=8 .or. char=19) .and. len(string)>0
           @ row(),col()-1 say ' '
           @ row(),col()-1 say ''
           string=substr(string,1,len(string)-1)
      case char=03
           keyboard chr(32)
   endcase
enddo
set colo to &colon_
restscreen(row,col-1,row+1,col+tamanio,antes_at)
set colo to &colog_
return string

FUNCTION xmemo
PARAMETERS mmode, line, col
PRIVATE ret_val
ret_val = 0

IF mmode <> 0
        keystroke = lastkey()
        if keystroke = 22
           tog_insert()
           ret_val = 32
        endif
ENDIF
RETURN ret_val

FUNCTION tog_insert
 READINSERT(.NOT. READINSERT())
 CURSOR_No()
 show_insert()
 CURSOR_SI()
RETURN 0

FUNCTION show_insert
 @ 06,65 SAY IF(READINSERT(), "Insertar", "        ")
RETURN 0

PROCEDURE EXPLOTA
PRIVATE V1,H1,V2,H2,T,HST,VST,VV1,VV2,HH1,HH2
parameters V1,H1,V2,H2,T,tiempo
cursor_no()
vv1=v1 ; vv2=v2 ;hh1=h1 ;hh2=h2 ;h1=h1+((h2-h1)/2) ; v1=v1+((v2-v1)/2) ; H2=H1 ; v2=v1
hst=(hh2-hh1)/15 ; vst=(vv2-vv1)/15
do while h1>hh1 .and. v1>vv1 .and. h2<hh2 .and. v2<vv2
   @ v1,h1 clea to v2,h2
   if t=0 ; @ v1,h1 to v2,h2 ; else ; @ v1,h1 to v2,h2 double ; endif
   v1=v1-1 ; v2=v2+1 ; h1=h1-4 ; h2=h2+4
   if pcount()<=5 ; do tardar with 50 ; else ; do tardar with tiempo ; endif
enddo
@ vv1,hh1 clea to vv2,hh2
if t=0 ; @ vv1,hh1 to vv2,hh2 ; else ; @ vv1,hh1 to vv2,hh2 double
endif
poner_cursor()
return

PROCEDURE TARDAR
private a,et
parameters a
for et=0 to a
 if inkey()#0
    exit
 endif
next
return
RETURN

FUNCTION CURSOR_SI
set cursor on
estaba_cursor=esta_cursor
esta_cursor=.T.
RETURN (.T.)

FUNCTION CURSOR_NO
set cursor off
estaba_cursor=esta_cursor
esta_cursor=.f.
RETURN (.f.)

FUNCTION PONER_CURSOR
if estaba_cursor
   set cursor on
   esta_cursor=.T.
else
   set cursor off
   esta_cursor=.f.
endif
RETURN (.T.)

FUNCTION HORA
parameters _filh,_colh
  if pcount() < 2
     _filh = 00
     _colh = 65
  endif
  set colo to &colob_
  devpos(_filh,_colh)
  devout(time())
*  @ _filh,_colh say time()
  set colo to &colon_
  cursor_no()
RETURN (.T.)

FUNCTION MENU
PARAMETERS lini,coli,linf,colf,opciones,caja,cantop,pantalla,opele,pull

If Pull .and. opele=0
   set colo to &coloe_
   @ 01,PsiHori[o] say Upper(Strtran(MenHori[o],'~',''))
   set colo to &colon_
endif

m_lini = lini ; m_coli = coli
colf = coli + len(opciones[1]) ; m_colf = colf ; reg = 0
_derechos=space(100)
Store '' to _derevie,_dereop
SELE MENU_G
q_program = alltrim(queprogram) && _qsystem+alltrim(queprogram)
seek_dato(q_program,.f.)
if found() .and. q_program=rtrim(posicion)
   lini = lini + linea_i - 1 ;  coli = coli + col_i
   colf = coli + len(opciones[1]); _derechos=derechos
   reg = recno()
endif
paso = 1
linf = lini + cantop + 1
cursor_no()
save screen to p_dibujo
if opele=0
  if panmen[o]='*' .or. !pull
    * sombra(lini+1,coli+1,linf+1,colf+1)
     _ventana='r1'+strzero(lini,2)+strzero(coli,2)+strzero(linf,2)+strzero(colf,2)
     ventana(_ventana,'&colod_')
     for i=1 to cantop
         Set colo to &colod_
         vlmenu(opciones,lini,coli,i,paso)
     next
     t3dbox('¿','³','Ä','Ù',colod_,lini,coli,linf,colf)
     save scree to &pantalla
     if pull
        panmen[o]=savescreen(lini-1,coli,linf+1,colf+1)
     endif
     opele=1
  else
     opele=1
     restscreen(lini-1,coli,linf+1,colf+1,panmen[o])
     save scree to &pantalla
  endif
else
   restore scree from &pantalla
  * lini=lini+1
endif
prim=.t.
_coli = coli
_colf = colf
_lini = lini
_linf = linf
do while .t.
   opele=iif(opele=cantop+1,1,opele)
   opele=iif(opele=0,cantop,opele)
   set colo to &colon_
   vlmenu(opciones,_lini,_coli,opele,paso)
   a=inkey()
   Store .f. to _Ascan,_Valida
   do while !(_Valida .or. (a>47.and.a<122) .or. _Ascan)
      iif(Upper(Left(queprogram,9))<>'ABMDUCTIL',hora(),.T.)
      a=inkey()
      if (a=4.or.a=19).and.pull
         exit
      endif
      if pull
         _Ascan = iif(strzero(a,3)$TecHori,.t.,.f.)
      endif
      _Valida = iif(At(Strzero(a,3),'002-003-005-007-013-022-024-026-027-397-401')<>0,.t.,.f.)
   enddo
   if (a>47.and.a<122)
       for i=1 to cantop
           iposi=at('~',opciones[i])
           if upper(chr(a))=upper(substr(opciones[i],iposi+1,1))
              resto scree from &pantalla
              set colo to &colov_
              vlmenu(opciones,lini,coli,i,paso)
              opele=i
              if _operador<>1
                 leo_derechos(@_derevie,@_dereop)
              endif
              if strzero(_operador)$_dereop .and. _operador<>1 .and. len(alltrim(_derechos))<>0
                 do errores with 'Acceso Denegado ...'
                 loop
              endif
              return(opele) &&(_opreal[opele])
           endif
       next
   endif
   If pull .and. _Ascan
       oposi=at(strzero(a,3),TecHori)
       o=int(oposi/4)+1
      exit
   Endif
   do case
      case a=27
           return(0)
      case a=3
           exit
      case a=13
           if _operador<>1
              leo_derechos(@_derevie,@_dereop)
           endif
           if strzero(_operador)$_dereop .and. _operador<>1 .and. len(alltrim(_derechos))<>0
              do errores with 'Acceso Denegado ...'
              loop
           endif
           return(opele) &&(_opreal[opele])
      case a=4 .or. a=19
           o=iif(a=4,(o+1),(o-1))
           exit
      case a=5 .or. a=24
           multi=iif(a=5 .and. opele>1,-1,iif(a<>5 .and. opele<cantop,1,0))
           _cuantos=iif(left(opciones[opele+1*multi],1)<>'&',1,2)
           opele=iif(a=5,(opele-_cuantos),(opele+_cuantos))
      case a=2                              && ctrl + flecha derecha
           if _colf + 2 < 79
              _coli = _coli + 1
              _colf = _colf + 1
              resto screen from p_dibujo
           endif
           mlmenu(_lini,_coli,_linf,_colf,opciones,cantop,paso)
           save scree to &pantalla
      case a=7                              && ctrl + grabo opcion
           sele menu_g
           if reg<> 0
              go reg
           else
              appeblan()
           endif
           do while .not. r_lock()
           enddo
           repl posicion with q_program,linea_i with _lini - m_lini+1,col_i with _coli - m_coli
           Unlock
      case a=26                             && ctrl + flecha izquierda
           if _coli - 1 >= 1
              _coli = _coli - 1
              _colf = _colf - 1
              resto screen from p_dibujo
           endif
           mlmenu(_lini,_coli,_linf,_colf,opciones,cantop,paso)
           save scree to &pantalla
      case a=397                            && ctrl + flecha arriba
           if _lini - 1 > 2
              _lini = _lini - 1
              _linf = _linf - 1
              resto screen from p_dibujo
           endif
           mlmenu(_lini,_coli,_linf,_colf,opciones,cantop,paso)
           save scree to &pantalla
      case a=401                            && ctrl + flecha abajo
           if _linf + 2 < 24
              _lini = _lini + 1
              _linf = _linf + 1
              resto screen from p_dibujo
           endif
           mlmenu(_lini,_coli,_linf,_colf,opciones,cantop,paso)
           save scree to &pantalla
      case a=22 .and. _operador=1  && Inserta derechos
           do dereope
           resto scree from &pantalla
   endcase
   restore scree from &pantalla
enddo
o =iif(o<1,cantpop,iif(o>cantpop,1,o))
RETURN (0)

function vlmenu
parameters opciones,lini,coli,i,paso
       iposi=at('~',opciones[i])
       if left(opciones[i],1)<>'&'
          _opnue=STRTRAN(opciones[i],'+','')
          @ lini+(I*paso),coli+1 say STRTRAN(_opnue,'~','')+iif(at('+',opciones[i])=0,'',chr(16))
          set colo to &colom_
          @ lini+(I*paso),coli+1+iif(iposi=0,0,iposi-1) say substr(opciones[i],iposi+1,1)
          set colo to &colon_
       else
          @ lini+(I*paso),coli say 'Ã'+replicate('Ä',len(opciones[1])-1)+'´'
       endif
return(.t.)

function mlmenu
parameters _lini,_coli,_linf,_colf,opciones,cantop,paso
 sombra(_lini,_coli+1,_linf+1,_colf+1)
 _ventana='r1'+strzero(_lini,2)+strzero(_coli,2)+strzero(_linf,2)+strzero(_colf,2)
 ventana(_ventana,'&coloi_')
 for i=1 to cantop
     set colo to &coloi_
     vlmenu(opciones,_lini,_coli,i,paso)
 next
return(.t.)

procedure confisn
PARAMETERS lin,col,mensa,var,recuadro
PRIVATE lin,col,mensa,antes_confi
cleartec()
if pcount()<5
   recuadro=.f.
endif
antes_confi=savescreen(lin-1,col-2,lin+1,col+len(mensa)+15)
if recuadro
   set colo to &colob_
   @ lin-1,col-2 clea to lin+1,col+len(mensa)+15
   @ lin-1,col-2 to lin+1,col+len(mensa)+15
else
   set colo to &colon_
endif
@ lin,col say space(len(mensa)+14)
@ lin,col say mensa+' ? [ S¡ / No ]'
set colo to &colon_
do while .t.
 @ lin,col+len(mensa)+05 prom 'S¡'
 @ lin,col+len(mensa)+10 prom 'No'
 menu to var
 if var>0 .or. lastkey()=27
  exit
 endif
enddo
restscreen(lin-1,col-2,lin+1,col+len(mensa)+15,antes_confi)
set colo to &colon_
retu

function gomo
parameters fec,meses
mesanio='312831303130313130313031'
dia_leido=day(fec)
anio_leido=year(fec)
mes_leido=month(fec)
mes_leido=mes_leido+meses
if mes_leido > 12
   mes_leido=mes_leido-12
   anio_leido=anio_leido+1
   do while mes_leido > 12
      mes_leido=mes_leido-12
      anio_leido=anio_leido+1
   enddo
else
   if mes_leido<=0
      mes_leido=12
      anio_leido=anio_leido-1
   endif
endif
if dia_leido>val(substr(mesanio,mes_leido*2-1,2))
   dia_leido=val(substr(mesanio,mes_leido*2-1,2))
endif
fec=ctod(str(dia_leido,2)+'-'+str(mes_leido,2)+'-'+str(anio_leido,4))
return (fec)

FUNCTION EXISTE
parameters dato,area,fc,cc,fn,cn,tc,tt,anchobusca,_quecampo,_queorder,_ultimo,_imagen
local _Dato
if lastkey()=05
   return(.t.)
endif
ultarea=select()
sele &area
if pcount()<8
   tt='N'
   anchobusca = len(nombre)
endif
anchobusca = iif(pcount()=8,len(nombre),anchobusca)
_quecampo =iif(pcount()<10,'numero',_quecampo)
_queorder =iif(pcount()<11,1,_queorder)
_ultimo=iif(pcount()<12,.f.,_ultimo)
_imagen=iif(pcount()<13,'nombre',_imagen)

if (upper(area))$'ARTICULO'
   if len(alltrim(str(val(dato),8,0)))=len(alltrim(dato)) .and. len(alltrim(dato))<>0
      _queorder=4
      dato=strzero(val(dato),5,0)
   endif
endif
_dato=dato
color_e = setcolor()
if tt='N'
   if dato=0
      do pido_nombre with fc,cc,fn,cn,tc,'ese Registro',dato,'nombre',_quecampo,'N',anchobusca,_ultimo,_imagen
   endif
else
   if len(alltrim(dato))=0    &&.or. _queorder<>1
      do pido_nombre with fc,cc,fn,cn,tc,'ese Registro',dato,'nombre',_quecampo,'A',anchobusca,_ultimo,_imagen
   endif
endif
set order to _queorder
seek_dato(dato,.f.)
_haymas=.f.

if tt<>'N' .and. alltrim(upper(area))$'ARTICULO' .and. found() .and. lastkey()<>27
   if len(alltrim(_dato))<>0
      skip
      if alltrim(dato)=alltrim(&_quecampo) ; _haymas=.t. ; endif
      skip -1
   else
      _haymas=.f.
   endif
endif

if found() .and. .not. _haymas
   set colo to &colob_
   QUEPICT=iif(type('&_quecampo')='N',"'"+replicate('9',tc)+"'","'@!'")
   dato=&_quecampo
   @ fc,cc say &_quecampo pict &QUEPICT
   @ fn,cn say left(nombre,anchobusca)
   setcolor(color_e)
   select(ultarea)
   return(.t.)
elseif tt<>'N' .and. alltrim(upper(area))$'ARTICULO'
    seek_dato(alltrim(dato),.t.)
    _kkk=left(numero,len(alltrim(dato)))=left(dato,len(alltrim(Dato)))
    if _Queorder=4
       _kkk=codigo_fac=val(dato)
    endif
    if found() .and. _kkk
       codigo_i=recno()
       do elijo with codigo_i,alltrim(dato),'numero','nombre',fn,_imagen
       dato=&_quecampo
       setcolor(color_e)
       select(ultarea)
       return .t.
    else
       ?? chr(7)
       dato=space(8)
    endif
endif
setcolor(color_e)
select(ultarea)
RETURN (.f.)

FUNCTION MUESTRA
parameters dato,area,fc,cc,fn,cn,tc,_queorder,_quevariable
ultarea=select()
sele &area
tn=len(nombre)
if 77 - cn < tn
   tn = 76 - cn
endif
if pcount() < 8
   _queorder = 1
   _quevariable = 'numero'
Endif
ordenantes=indexord()
set order to _queorder
seek dato
if found()
   set colo to &colob_
   @ fc,cc say &_quevariable
   @ fn,cn say left(nombre,tn)
   set colo to &colog_
   set order to ordenantes
   select(ultarea)
   return(.t.)
else
   @ fc,cc say space(tc)
   @ fn,cn say space(tn)
endif
set order to ordenantes
set colo to &colog_
select(ultarea)
RETURN (.f.)

function fecha_ok
parameter fecha_test

  if fecha_test<m_prifec .or. fecha_test>m_ultfec
     set colo to &colon_
     do errores with 'Rango V lido '+dtoc(m_prifec)+' al '+dtoc(m_ultfec)
     set colo to &colog_
     return(.f.)
  endif

return(.t.)

function c_val
parameter dato,area,fc,cc,fn,cn,ultimo,tc,tn,ti,_quenumero,_queorder,dato2,_imagen
color_c = setcolor()
if lastkey()=05
   return(.t.)
endif
tc=iif(pcount()<8,5,tc)
tn=iif(pcount()<9,30,tn)
ti=iif(pcount()<10,'N',ti)
if pcount()<11 .and. ti='N'
   _quenumero='numero'
   _queorder=1
Elseif pcount() < 11 .and. (ti='A' .or. ti='C')
       _quenumero='nombre'
       _queorder = 2
endif
_imagen =iif(pcount()<12,'nombre',_imagen)
If _queorder >2 .and. (ti='C' .or. ti='A')
   dato= space(13-len(alltrim(dato)))+alltrim(dato)
Endif
existe(@dato,area,fc,cc,fn,cn,tc,ti,tn,_quenumero,_queorder,ultimo,_imagen)
sele &area
Set order to _queorder
If ti='N'
   If Ultimo .and. dato=0
      go bott
   Elseif .not. Ultimo .and. dato=0
          go top
   Endif
   dato = &_quenumero
Elseif ti='A' .or. ti='C'
       If Ultimo .and. len(alltrim(dato))=0
          go bott
       Elseif .not. Ultimo .and. len(alltrim(dato))=0
              go top
       Endif
       dato = &_quenumero
Endif
Seek_dato(dato,.f.)
if .not. found()
   set colo to &colon_
   do errores with 'No existe ese registro'
   set colo to &colorantes
   return(.f.)
else
   set colo to &colob_
   @ fc,cc say &_quenumero
   @ fn,cn say left(nombre,tn)
   set colo to &colog_
endif
if pcount()>=13
   dato2=dato
endif
return(.t.)

function ffecha_val
parameter echa,cuantosdias
if empty(echa)
    return(.f.)
endif
if pcount()=1
   cuantosdias = 0
endif
m_vto=echa + cuantosdias
return (.t.)

Function exidir(_exporta,cpath)
local cfile
npos  = rat('\',_exporta)
cfile = subst(_exporta,npos+1)
npos1 = rat('.',cfile)
cfile = iif(npos1<>0,left(cfile,npos1-1),cfile)
cpath = subst(_exporta,1,npos)
cpath = iif(len(trim(cpath))=0,'\'+curdir()+'\',cpath)
cpath = strtran(cpath,'\\','\')
Return .t.

function empaquetar
parameter nom_archivo
viedbf = nom_archivo+'.DBF'
viedbt = nom_archivo+'.DBT'
set order to 0
go top
if recno()<>1
   muestra_contador(10,10,'Empaqueto',viedbf,' ')
endif
cpath=''
exidir(viedbf,@cpath)
_Dbf_empaquetar=cpath+'auxi_pac.dbf'
_Dbt_empaquetar=cpath+'auxi_pac.dbt'
copy to &_dbf_empaquetar for cuenta_empaquetar(lastrec(),viedbf,'Empaqueto ')
use
erase &viedbf
if file('&viedbt')
   erase &viedbt
endif
rename &_dbf_empaquetar to &viedbf
if file('&_dbt_empaquetar')
   rename &_dbt_empaquetar to &viedbt
endif
return(.t.)

function cuenta_empaquetar
parameters totalrec,archivie,mens
if totalrec=0
   totalrec=1
endif
if recno()=1
   muestra_contador(10,10,mens,archivie,' ')
endif

if (mod(recno(),2)=0 .or. recno()=totalrec) &&.and. !eof()
   cuenta_por(recno(),totalrec,10,10)
endif
return(.t.)

function cuenta_por
parameters actualrecno,totalrecno,_f1,_c1
porce=int(((actualrecno/totalrecno)*100)/2)
@ _f1+6,_c1+4  say replicate(chr(219),porce)      &&   Û
@ _f1+2,_c1+48 say transform(totalrecno,"@z ####,###")
@ _f1+4,_c1+48 say transform(actualrecno,"@z ####,###")
return .t.

FUNCTION SOMBRA
parameters fila1,col1,fila2,col2

RETURN restscreen(fila1,col1,fila2,col2,;
                  transform(savescreen(fila1,col1,fila2,col2),;
                  replicate('x'+chr(7),(fila2-fila1+1) * (col2-col1+1))))

function ictrl
parameters quedevuelve,nom,indi,totalrec
private nom,indi,totalrec,porce

if .not. indexando
   return(quedevuelve)
endif

porce=0

if totalrec=0
   totalrec=1
endif

if recno()=1
   muestra_contador(10,10,'Indexando',Alias(Select()),'  Clave: '+indi)
endif

if (mod(recno(),2)=0 .or. recno()=totalrec) .and. !eof()
   cuenta_por(recno(),totalrec,10,10)
endif
if str((recno()/totalrec)*100,6,2)="100.00"
   @ 12,22 say "Grabando ¡ndice     "
   set colo to &colon_
endif
return(quedevuelve)

function ventana
parameters lineacomando,quecolor
if len(lineacomando) <> int(len(lineacomando)/10)*10
   return(.t.)
endif
if iscolor() .and. upper(quecolor)='W'
   quecolor=colon_
endif
j=1
colorantes = setcolor()
setcolor(quecolor)
do while j<= len(lineacomando)
    dibujo = subs(lineacomando,j,10)
    x1 = val(subs(dibujo,3,2)) ; y1 = val(subs(dibujo,5,2))
    x2 = val(subs(dibujo,7,2)) ; y2 = val(subs(dibujo,9,2))
    at1 = val(subs(dibujo,2,1)); at2 = at(upper(left(dibujo,1)),'TB')
    at3 = at(upper(left(dibujo,1)),'ID') ; at4 = at(left(dibujo,1),'EP')
    at5 = at(left(dibujo,1),'ep')
    do case
       case left(dibujo,1)$'S'          && sombras
            if at1=1
               @ x1,y1,x2,y2 box '°°°°°°°°°'
            else
               @ x1,y1,x2,y2 box '²²²²²²²²²'
            endif
       case left(dibujo,1)$'s'
            sombra(x1,y1,x2,y2)
       case upper(left(dibujo,1))$'XRVH'        && rectang.-vertical-horizont.
            if left(dibujo,1)$'xrvh'
               @ x1,y1,x2,y2 box '         '
            endif

            if subs(dibujo,2,1)='2' .and. upper(left(dibujo,1))='R'
               @ x1,y1,x2,y2 box 'ÉÍ»º¼ÍÈº'
            elseif subs(dibujo,2,1)='1' .and. upper(left(dibujo,1))='R'
               @ x1,y1,x2,y2 box 'ÚÄ¿³ÙÄÀ³'
            elseif subs(dibujo,2,1)='2' .and. upper(left(dibujo,1))='X'
               @ x1,y1,x2,y2 box 'ÉÍ»º¼ÍÈº'
               t3dbox('É','º','Í','È',quecolor,x1,y1,x2,y2)
            elseif subs(dibujo,2,1)='1' .and. upper(left(dibujo,1))='X'
               @ x1,y1,x2,y2 box 'ÚÄ¿³ÙÄÀ³'
               t3dbox('¿','³','Ä','Ù',quecolor,x1,y1,x2,y2)
            elseif subs(dibujo,2,1)='1' .and. upper(left(dibujo,1))='H'
               @ x1,y1 to x1,y2
            elseif subs(dibujo,2,1)='2' .and. upper(left(dibujo,1))='H'
               @ x1,y1 to x1,y2 double
            elseif subs(dibujo,2,1)='1' .and. upper(left(dibujo,1))='V'
               @ x1,y1 to x2,y1
            elseif subs(dibujo,2,1)='2' .and. upper(left(dibujo,1))='V'
               @ x1,y1 to x2,y1 double
            endif
       case upper(left(dibujo,1))='C'          && cruz
            if subs(dibujo,2,1)$'1234'
               @ x1,y1 say subs('ÅÎ×Ø',1*at1,1)
            endif
       case upper(left(dibujo,1))$'TB'         && tope - base
            do case
               case subs(dibujo,2,1)='1'
                    @ x1,y1 say subs('ÂÁ',1*at2,1)
               case subs(dibujo,2,1)='2'
                    @ x1,y1 say subs('ËÊ',1*at2,1)
               case subs(dibujo,2,1)='3'
                    @ x1,y1 say subs('ÒÐ',1*at2,1)
               case subs(dibujo,2,1)='4'
                    @ x1,y1 say subs('ÑÏ',1*at2,1)
            endcase
        case upper(left(dibujo,1))$'ID'        && izquierda - derecha
            do case
               case subs(dibujo,2,1)='1'
                    @ x1,y1 say subs('Ã´',1*at3,1)
               case subs(dibujo,2,1)='2'
                    @ x1,y1 say subs('Ì¹',1*at3,1)
               case subs(dibujo,2,1)='3'
                    @ x1,y1 say subs('Ç¶',1*at3,1)
               case subs(dibujo,2,1)='4'
                    @ x1,y1 say subs('Æµ',1*at3,1)
            endcase
       case left(dibujo,1)$'EP'         && esquina izquierda - derecha superior
            do case
               case subs(dibujo,2,1)='1'
                    @ x1,y1 say subs('Ú¿',1*at4,1)
               case subs(dibujo,2,1)='2'
                    @ x1,y1 say subs('É»',1*at4,1)
               case subs(dibujo,2,1)='3'
                    @ x1,y1 say subs('Ö·',1*at4,1)
               case subs(dibujo,2,1)='4'
                    @ x1,y1 say subs('Õ¸',1*at4,1)
            endcase
       case left(dibujo,1)$'ep'         && esquina izquierda - derecha inferior
            do case
               case subs(dibujo,2,1)='1'
                    @ x1,y1 say subs('ÀÙ',1*at5,1)
               case subs(dibujo,2,1)='2'
                    @ x1,y1 say subs('È¼',1*at5,1)
               case subs(dibujo,2,1)='3'
                    @ x1,y1 say subs('Ó½',1*at5,1)
               case subs(dibujo,2,1)='4'
                    @ x1,y1 say subs('Ô¾',1*at5,1)
            endcase
    endcase
    j = j + 10
enddo
setcolor(colorantes)
return(.t.)

function t3dbox
parameters t3arriba,t3vertical,t3raya,t3abajo,quecolor,x1,y1,x2,y2
colox_='W+'+alltrim(subs(quecolor,2,30))
set colo to &colox_
cTopLine := Replicate((t3raya),(y2-y1-1))
DevPos( x2,y1+1 ); DevOut( cTopLine )
DevPos( x1,y2 ); DevOut( t3arriba )
for ixg = 1 to (x2 - x1 - 1)
    DevPos( x1+ixg, y2 ); DevOut( t3vertical )
next
DevPos( x1+ixg, y2 ); DevOut( t3abajo )
set colo to &quecolor
return .t.


Function Seek_dato
Parameters que_Clave,E_stado
Set Softseek(E_stado)
Seek que_Clave
Set Softseek(.f.)
Return(.t.)

function exi_registro
parameters m_registro,_order
_order=iif(pcount()<2,1,_order)
if lastkey()<>5
   set order to _order
   seek_dato(m_registro,.f.)
   if found()
      set colo to &colon_
      do errores with 'Ya existe ese Registro ...'
      set colo to &colog_
      set order to 2
      return(.f.)
   endif
   set order to 2
endif
return(.t.)

function ayuda23
parameters fi_,co_,to_,cartel,color_
if pcount() <4
   color_ = coloe_
endif
@ fi_,co_ say space(to_ - co_)
set colo to &color_
@ fi_,co_ say upper(cartel)
set colo to &coloe_
return(.t.)

function masiva
parameters m_inter,m_precoi,quehago,ibrutos
local m_bruto,ulta
ulta=select()
m_bruto = m_precoi - m_inter
if quehago
   m_precoi = m_bruto * (1+(tablaiva->ivari)/100)
else
   m_precoi = m_bruto / (1+(tablaiva->ivari)/100)
endif
if ibrutos
   m_precoi = m_precoi + red( m_bruto * (tablaiva->ingbru/100) )
endif
m_precoi = m_precoi + m_inter
select(ulta)
return red(m_precoi)

function cerrarbase
parameters _file
DBSELECTAREA('&_file')
DBCLOSEAREA()
return .t.

function _achoice
parameters _1,_2,_3,_4,_opcion
 _coloantes = setcolor()
 save scree
 _queventana = 'r1'+strzero(_1-1,2)+strzero(_2,2)+strzero(_3+1,2)+strzero(_4+1,2)
 ventana(_queventana,'colon_')
 ai=achoice(_1,_2+1,_3,_4,_opcion)
 rest scree
 setcolor(_coloantes)
return ai

function crear
parameters _dbf,_name,_type,_dim,_dec,_sele
 DECLARE ADBF[len(_name)][4]
 FOR iz =1 to len(_name)
     adbf[iz][1] = _name[iz]
     adbf[iz][2] = _type[iz]
     adbf[iz][3] = _dim[iz]
     adbf[iz][4] = _dec[iz]
 Next
 SELECT 150
 DBCREATE('&_DBF',ADBF)
return .t.

function muestra_contador
parameters _f,_c,mens,archivie,_clav,_esarchivo
If pcount() <6
   _esarchivo = .f.
Endif
*sombra(_f+1,_c+1,_f+12,_c+58)
@ _f,_c say ''
@ row()+1,_c say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
@ row()+1,_c say iif(.not._esarchivo,'³    Tarea:                          Registros:          ³','³    Tarea:                           Archivos:          ³')
@ row()+1,_c say '³                                                        ³'
@ row()+1,_c say iif(.not._esarchivo,'³  Archivo:                             Actual:          ³','³                                       Actual:          ³')
@ row()+1,_c say '³ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ³'
@ row()+1,_c say '³ ³ °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ³ ³'
@ row()+1,_c say '³ ³ +---+----+----+----+----+----+----+----+----+----+ ³ ³'
@ row()+1,_c say '³ ³ 0  10   20   30   40   50   60   70   80   90  100 ³ ³'
@ row()+1,_c say '³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ³'
@ row()+1,_c say '³                                                        ³'
@ row()+1,_c say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
set colo to &colob_
@ _f+2,_c+12 say mens
@ _f+4,_c+12 say archivie
@ _f+10,_c+2 say _clav
set colo to &colon_
return .t.

function key_board
parameters tecla,cuantos
keyboard replicate(chr(tecla),cuantos)
return(.t.)

PROCEDURE BUSCANOM
busca_nom = .t.
keyboard chr(13)
RETURN

FUNCTION EXISTE_CO
private t1,t2,t3,f1,c1,che
parameters t1,t2,t3,f1,c1,che
if lastkey()=05
   return (.t.)
endif
if pcount() >5
   if t1=che
      return (.f.)
   endif
endif
if t1=0 .or. t1 > t2
   return (.f.)
elseif type('t3[t1]')='U'
   set colo to &colob_
   @ f1,c1 say 'NO EXISTE'
   set colo to &colog_
   return (.F.)
else
   set colo to &colob_
   @ f1,c1 say upper(t3[t1])
   set colo to &colog_
   return (.t.)
endif
* che = valor que no permito (para c.final en compras)

Procedure reg_tarje
set colo to &coloi_
@ 07,25,16,77 box '         '
@ 07,25 to 16,77
@ 08,27 say '  N§ de Tarjeta :'
@ 09,27 say 'N£mero de Cup¢n :'
@ 10,27 say 'N§/Nomb.Titular :'
@ 11,27 say '          Banco :'
@ 12,27 say '         Cuotas :'
@ 13,27 say '  Importe Total :'
@ 14,27 say ' Fecha de Carga :'
@ 15,27 say '    Vencimiento :'
do while .t.
   @ 08,45 get _t_numero valid .not. empty(_t_numero)
   @ 09,45 get _t_cupon
   @ 10,45 get _t_titular pict '@!'
   @ 11,45 get _t_banco  pict '@!'
   @ 12,45 get _t_cuotas pict '999'
   @ 13,45 say _t_importe pict '999,999,999.99'
   @ 14,45 say m_fecha
   @ 15,45 get _t_vence valid _t_vence >=m_fecha .or. lastkey()=5
   read
   exit
enddo
set colo to &colon_
RETURN

procedure dereope
sele operador
set order to 1
go bott
recco=numero
set order to 2
declare v_detalle[recco],v_registro[recco]
afill(v_detalle,space(30))
afill(v_registro,0)
cant_index=0
ii=1
regis_antes = 0
_derevie=''
_dereop=''
leo_derechos(@_derevie,@_dereop)
go top
do while .not. eof()
  if numero<>1
      if .not. strzero(numero,2)$_dereop
         v_detalle[ii] = '  '+nombre
      else
         v_detalle[ii] = 'û '+nombre
      endif
      v_registro[ii]= numero
      regis_antes = numero
      ii = ii + 1
  endif
  skip
enddo

max_leidos = ii - 1
if max_leidos = 0
   return
endif
declare v_selector[max_leidos]
afill(v_selector,space(30))
acopy(v_detalle,v_selector,1,max_leidos)

save scree
abortar = .f.
do cual_ope with abortar
if abortar
   return
endif

_derenue='@'+strzero(opele,2)

for ii=1 to max_leidos
   if at('û',v_selector[ii])<>0
      _derenue=_derenue+strzero(v_registro[ii],2)
   endif
next

_derenue=_derenue+'*'

if _derevie<>''
   _derechos=strtran(_derechos,_derevie,_derenue)
else
   _derechos=trim(_derechos)+trim(_derenue)
endif
sele menu_g
if reg=0
   appeblan()
   r_lock()
   repl posicion with queprogram,linea_i with _lini - m_lini,col_i with _coli - m_coli
   reg=recno()
else
   go reg
endif
r_lock()
repl derechos with _derechos
Unlock

return


procedure cual_ope
parameters abortar

cleartec()
ventana('x206191951','&coloi_')
set colo to &coloi_
@ 07,21 say  'ÄÄRESTRICCION DE ACESSOÄÄ'
@ 08,21 say  upper(STRTRAN(opciones[opele],'~',''))
@ 17,21 say  '[Enter]Selecta  [Esc] Fin    '
@ 18,21 say  '[Alt+T]Todos  [Alt+N] Ninguno'
set colo to &colon_

ai=0
do while lastkey()<>27
   set colo to &coloi_
   ai = achoice(10,20,15,50,v_selector,.t.,'funcope',ai+1,iif(ai<7,ai,6))
   set colo to &colon_
enddo
ch=1
do confisn with 21,20,'GRABO LOS CAMBIOS',ch,.t.
if ch=2 .or. lastkey()=27
    abortar=.t.
endif
resto scree
set colo to &colog_
return

function funcope
parameter mode,ele,f_row
cursor_si()
do case
   case lastkey()=13
        ipo=at('û',v_selector[ele])
        cleartec()
        if ipo=0
           cant_index=cant_index+1
           v_selector[ele]=stuff(v_selector[ele],1,1,'û')
           else
              v_selector[ele]=strtran(v_selector[ele],'û',' ')
              cant_index=cant_index-1
        endif
   case lastkey()=27
        return 0
   case lastkey() = 276
                for ia=1 to len(v_selector)
                  if at('û',v_selector[ia])=0
                     v_selector[ia] =stuff(v_selector[ia],1,1,'û')
                     cant_index=cant_index+1
                  endif
                next ia
   case lastkey() = 305
                for ia=1 to len(v_selector)
                  if at('û',v_selector[ia])<>0
                     v_selector[ia]=strtran(v_selector[ia],'û',' ')
                     cant_index=cant_index - 1
                  endif
                next ia
endcase
if mode=3
   cleartec()
   return 1
endif
RETURN 2

function leo_derechos(_derevie,_dereop)
icomi=at('@'+strzero(opele,2),_derechos)
_derevie=''
if icomi<>0
   _ivoy=icomi
   do while subs(_derechos,_ivoy,1)<>'*'
      _derevie=_derevie+subs(_derechos,_ivoy,1)
      _ivoy=_ivoy+1
   enddo
   _derevie=_derevie+'*'
endif
_dereop=strtran(_derevie,'@'+strzero(opele,2),'')
return .t.

Function Borrofile
parameter _file
If Upper(righ(alltrim(_file),3))='NTX'
   dbclearind()
Endif
If File('&_file')
   cmd = 'Del '+_file
   !&cmd
   Return .t.
Endif
Return .f.

function menu_to
parameters que_op,arr,fil,col,cuantas_opciones,_qcolor,verini,colgar,verfin
local _pripri,_qfil,_qcol,_lini,_coli
_qcolor = iif(pcount()<6,'&coloi_',_qcolor)
verini= iif(pcount()<7,.t.,verini)
verfin= iif(pcount()<9,.f.,verfin)
_colentre = setcolor()
que_op=iif(que_op=0,1,que_op)
colgar=iif(pcount()<8,.f.,colgar)

SET COLO TO &colob_
if verini .and. .not. colgar
   for x=1 to cuantas_opciones
       if arr[x]<>'  ' ; @ fil[x],col[x] say arr[x] ; endif
   next
endif

_scrmenuto=savescreen(fil[1]-1,col[1]-1,fil[cuantas_opciones]+1,col[1]+len(arr[1])+2)

_pripri=.t.
_qfil=iif(colgar,1,que_op) ; _qcol=iif(colgar,1,que_op)
_lini=fil[1]
_coli=col[1]
do while .t.
   set colo to &_qcolor
   @ fil[_qfil],col[_Qcol] say arr[que_op]+' '+chr(25)
   set colo to &colon_
   inkey(0)
   if colgar .and. (lastkey()=24 .or. lastkey()=32 .or. lastkey()=5) .and. _pripri
      @ fil[_qfil],col[_Qcol] say space(len(arr[1]))+'  '
      _corrige=iif(fil[1]+cuantas_opciones+1>24,(fil[1]+cuantas_opciones+1)-24,0)
      for ci=1 to Cuantas_opciones ; fil[ci]=_lini+(ci-1-_corrige) ; next
      _scrmenuto=savescreen(fil[1]-1,col[1]-1,fil[cuantas_opciones]+1,col[1]+len(arr[1])+2)
      _pripri=.f.
      @ fil[1]-1,col[1]-1 to fil[cuantas_opciones]+1,col[1]+len(arr[1])+2
      set colo to &colob_
      for x=1 to cuantas_opciones
          if arr[x]<>'  ' ; @ fil[x],col[x] say arr[x]+'  ' ; endif
      next
      set colo to &colon_
      @ fil[que_op],col[que_op] say arr[que_op]+' '+chr(25)
      _qfil=que_op ; _qcol=que_op
      loop
   endif
   do case
      case lastkey()=27
           que_op=0
           exit
      case lastkey()=13 .or. (lastkey()=19 .or. lastkey()=4) .or. (( lastkey()=05 .or. lastkey()=24 ) .and. .not. colgar)
           If que_op<>0
              SET COLO TO &colob_
              @ fil[que_op],col[que_op] say arr[que_op]+'  '
           endif
           if lastkey()=5
              keyboard chr(05)
           endif
           exit
      case lastkey()=32 .or. lastkey()=9 .or. ( lastkey()=24 .and. colgar)
           SET COLO TO &colob_
           @ fil[que_op],col[que_op] say arr[que_op]+'  '
           que_op=que_op+1
           if que_op>cuantas_opciones
              que_op=1
           endif
      case lastkey()=05 .and. colgar
           SET COLO TO &colob_
           @ fil[que_op],col[que_op] say arr[que_op]+'  '
           que_op=que_op-1
           if que_op<1
              que_op=cuantas_opciones
           endif
   endcase
   _qfil=que_op ; _qcol=que_op
enddo
if colgar
   restscreen(fil[1]-1,col[1]-1,fil[cuantas_opciones]+1,col[1]+len(arr[1])+2,_scrmenuto)
   if que_op<>0 .and. verfin
      @ _lini,_coli say arr[que_op]+'   '
   endif
endif
setcolor(_colentre)
return que_op

Function B_Articulo
parameters mcodigo,_ord1,_ord2
Dbsetorder((iif(len(mcodigo)<=8,_ord1,_ord2)))
m_cod = mcodigo
Seek m_cod
Return .t.

Function Ver_Feriados
parameters m_vto,m_vtoreal

if lastkey()=5
   return(.t.)
endif
if empty(m_vto)
   return(.f.)
endif

if .not.file('feriados.mem')
 feriados='0101 1304 0105 2505 2006 0907 1708 1210 0812 2512 3112 *'
 save to feriados all like feriados
endif
rest from feriados addi
m_vtoreal = m_vto

do while .t.
 ferxxj = righ(dtos(m_vtoreal),2)+subs(dtos(m_vtoreal),5,2)
 if dow(m_vtoreal)<>1 .and. dow(m_vtoreal)<>7 .and. (.not. ferxxj$feriados)
    exit
 endif
 m_vtoreal = m_vtoreal + 1
enddo

Return(.T.)

function t183
return(iif(lastkey()=18 .or. lastkey()=3,.f.,.t.))


PROCEDURE ErrorBeep
       TONE(100,1)
RETURN

function s_val
parameters fc,cc,fn,cn,m_variable,final,tc,area,quecampo,cartel,ti,m_varfin,_queorder
  color_s = setcolor()
  ti=iif(pcount() <11,'N',ti)
  set colo to &colon_
  sele &area
  if ti='N'
     SET ORDER TO 1
     if m_variable=0
        do pido_nombre with fc,cc,fn,cn,tc,cartel,m_variable,'NOMBRE','NUMERO','N',len(nombre),final
        if m_variable=0
           sele articulo
           set order to _queorder
           if final
              go bott
              m_variable=articulo->&quecampo
           else
              go top
              m_variable=articulo->&quecampo
           endif
           sele &area
        endif
     endif
  else
     SET ORDER TO 2
     if len(alltrim(m_variable))=0
        do pido_nombre with fc,cc,fn,cn,tc,cartel,m_variable,'NOMBRE','NUMERO','A',len(nombre),final
        m_variable=nombre
        if len(alltrim(m_variable))=0
           set order to 2
           if final
              go bott
           else
              go top
           endif
           m_variable=nombre
        endif
     endif
  endif

  sele &area

  if ti='N'
     set order to 1
  else
     set order to 2
  endif

  seek m_variable

  if .not. found()
     set colo to &colon_
     do errores with 'No existe... '+cartel
     set colo to &color_s
     return(.f.)
  endif
  set colo to colou_
  if ti='N'
     @ fc,cc say str(m_variable,tc)
  endif
  @ fn,cn say trim(nombre)
  if ti='N'
     set colo to &colob_
     @ fn+1,cn say replicate('Ä',4)
     @ fn+1,col() say chr(16)
     @ fn+1,cn say 'À'
     keyboard chr(13)
  endif
  set colo to &color_s
  If pcount()>11
     m_varfin = m_variable
  Endif
return(.t.)
