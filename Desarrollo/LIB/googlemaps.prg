*------------------------------------------
*La Funcion GoogleStreetViewUnic utiliza un único marcador verde con una posición modificable
**------------------------------------------

FUNCTION GoogleStreetViewUnic
LPARAMETERS tcDestination,nlatitud,nlongitud
strlatitud = IIF(PCOUNT()<2,"-38.713083",STR(nlatitud,15,10))
strlongitud = IIF(PCOUNT()<3,"-52.286846",STR(nlongitud,15,10))


LOCAL loXML AS "MSXML2.ServerXMLHTTP.4.0"
LOCAL lcFullURL, lcResponse, lcRouteParameters
tcDestination          = EVL(tcDestination, "")

lcRouteParameters = "origin=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20") + ;
    "&destination=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20")

* Documentation at http://code.google.com/apis/maps/documentation/directions/)
* Build up the full URL with the required parameters
lcFullURL = "http://maps.googleapis.com/maps/api/directions/xml?" + lcRouteParameters + ;
    "&units=metrics&sensor=false&v=3.22"


* Test with all XML Versions
* Can also apply the info from http://support.microsoft.com/kb/278674/en-us
* to determine what version of MSXML is installed in the machine
TRY 
	loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.4.0") && Could use version 3.0, 4.0, 5.0, 6.0
CATCH
	TRY 
		loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.3.0") && Could use version 3.0, 4.0, 5.0, 6.0
	CATCH 
		TRY
			loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.5.0") && Could use version 3.0, 4.0, 5.0, 6.0
		CATCH
			TRY 
				loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0") && Could use version 3.0, 4.0, 5.0, 6.0
			CATCH 
			ENDTRY 
		ENDTRY 
	ENDTRY 
ENDTRY 



loXML.OPEN("POST", lcFullURL, .F.)
loXML.SetRequestHeader("Content-Type", "application/xml")
loXML.SEND("")
lcResponse = loXML.ResponseText

LOCAL lcAddress, lcHTML
lcAddress = STREXTRACT(lcResponse, "<end_address>", "</end_address>")
lcLocation = STREXTRACT(lcResponse, "<start_location>", "</start_location>")
lcLatitud = STREXTRACT(lcLocation, "<lat>", "</lat>")
lcLongitud = STREXTRACT(lcLocation, "<lng>", "</lng>")

strlatitud = IIF(not EMPTY(tcDestination),lcLatitud,strlatitud)
strlongitud = IIF(not EMPTY(tcDestination),lcLongitud,strlongitud)

TEXT TO lcHTML NOSHOW TEXTMERGE
<!DOCTYPE html>
<html>
  <head>
    <title>VFPSTEAM BI - VFPsMAPAS : Business Intelligence</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      
      }
      #outputDiv {
        position: absolute;
        bottom: 5px;
        left: 38%;
        margin-left: -180px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        opacity: 0.70;
      }
      #latitudDiv {
       position: absolute;
        height: 100%;
        margin: 0px;
        padding: 0px
      }
      }
      #longitudDiv {
       position: absolute;
        height: 100%;
        margin: 0px;
        padding: 0px
      }
    </style>    
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&language=es"></script>
    <script>
       var geocoder = null
		function initialize() {
         geocoder = new google.maps.Geocoder();
         var fenway = new google.maps.LatLng(<<strlatitud>>, <<strlongitud>>);
		  var mapOptions = {
             scaleControl: true,
             panControl:true,
             rotateControl:true,
    	      zoom: 16,
             mapTypeId: google.maps.MapTypeId.ROADMAP,
    	      center: fenway
  		  };
  		  latitudDiv.innerHTML = <<strlatitud>>
          longitudDiv.innerHTML = <<strlongitud>>
          var map = new google.maps.Map(document.getElementById('map-canvas'),
              mapOptions);

           geocoder.geocode( { 'latLng': fenway}, function(results, status) {

	        if (status == google.maps.GeocoderStatus.OK) {
			    map.setCenter(results[0].geometry.location);
               var image = 'http://www.vfpstylemenuframework.com/images/Marker_Outside_Chartreuse.png'; 
		        var marker = new google.maps.Marker({
			    map: map, icon: image, title: 'Mover para ver coordenadas',
			   	position: fenway
			  //position: results[0].geometry.location
               , draggable: true
			   });
			    var coord1  = results[0].geometry.location
			    var infoWin = new google.maps.InfoWindow({
               maxWidth: 350,
				content: '<span style="font-weight: bold; color: rgb(255, 102, 0);">Informaci&oacute;n</span>' + '<br>' + results[0].formatted_address + '<br>' + '<br>' + 'Coord. ' + coord1	
			   });
               google.maps.event.addListener(marker, 'drag' , function(event) {
               outputDiv.innerHTML = '<div style="text-align: center;"><small><span style="color: rgb(255, 102, 0); font-weight: bold; font-family: Courier New,Courier,monospace;">' + 'Latitud:' + event.latLng.lat() + '[x] Longitud:' + event.latLng.lng() + '[y]</span></small></div>';
               var cadena = '<span style="font-weight: bold; color: rgb(255, 102, 0);">Informaci&oacute;n</span>' + '<br><br>' + 'Latitud: ' + event.latLng.lat() + '<br> Longitud: ' + event.latLng.lng();
               infoWin.setContent (cadena);
               infoWin.open(map, marker);
               latitudDiv.innerHTML = event.latLng.lat();
        	   longitudDiv.innerHTML = event.latLng.lng();
        	   var yourLocation = new google.maps.LatLng(event.latLng.lat, event.latLng.lng);
              });
	        } else {
				alert("Se ha producido un fallo por: " + status);
			   }
		     });
        }   //Fin de funcion initialize()
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
  </head>
  <body>
    <div id="outputDiv"></div>
    <div id="latitudDiv"></div>
    <div id="longitudDiv"></div>
    <div id="map-canvas"> style="width: 592px; height: 523px;"></div>
  </body>
</html>
ENDTEXT


LOCAL lcFile
SET SAFETY OFF

lcRuta = SYS(5)+ "\tempsql\"+ALLTRIM(goapp.initcatalo)
IF VARTYPE(goapp.rutaaplicacion)$'C'
	lcRutaApli = IIF(LEN(ALLTRIM(goapp.rutaaplicacion))#0,goapp.rutaaplicacion,"")
	lcRutaApli = RTRIM(lcRutaApli) + IIF(RIGHT(lcRutaApli,1)="\" or LEN(LTRIM(lcRutaApli))=0,"","\") &&Si es vacio o tiene \. Mantiene lo mismo.
	lcRuta = IIF(LEN(LTRIM(lcRutaApli))#0,lcRutaApli+ "tempsql",lcRuta)	
ENDIF 
IF !DIRECTORY(lcRuta)
	MKDIR &lcRuta
ENDIF 
lcFile = ADDBS(lcRuta)+"mihtmlunicsist.html"

STRTOFILE(lcHTML, lcFile)
SET SAFETY ON 

* Show the StreetView
*RUN /N6 Explorer.EXE &lcFile.
RETURN lcFile

ENDFUNC 


*-----------------------------------
*-----------------------------------
*-----------------------------------
*Pasando una dirección retorna sus coordenadas (pasar por referencia 2 variables para latitud y longitud)
*-----------------------------------
*-----------------------------------
*-----------------------------------


FUNCTION ObtenerXY
* Show the StreetView
*RUN /N6 Explorer.EXE &lcFile.FUNCTION GoogleStreetViewMulti
LPARAMETERS tcDestination,clatitud,clongitud
tcDestination = IIF(PCOUNT()<1,"",tcDestination)

lCantParam = IIF(PCOUNT()<3,.f.,.t.)
IF NOT lCantParam
	oavisar.usuario('Faltan Parametros en la función ObtenerXY (cDireccion,@cLat,@cLong)')
	RETURN 
ENDIF 

IF EMPTY(LTRIM(tcDestination))
	RETURN 
ENDIF 

LOCAL loXML AS "MSXML2.ServerXMLHTTP.4.0"
LOCAL lcFullURL, lcResponse, lcRouteParameters
tcDestination          = EVL(tcDestination, "")

lcRouteParameters = "origin=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20") + ;
    "&destination=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20")

lcFullURL = "http://maps.googleapis.com/maps/api/directions/xml?" + lcRouteParameters + ;
    "&units=metrics&sensor=false&v=3.22"

TRY 
	loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.4.0") && Could use version 3.0, 4.0, 5.0, 6.0
CATCH
	TRY 
		loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.3.0") && Could use version 3.0, 4.0, 5.0, 6.0
	CATCH 
		TRY
			loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.5.0") && Could use version 3.0, 4.0, 5.0, 6.0
		CATCH
			TRY 
				loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0") && Could use version 3.0, 4.0, 5.0, 6.0
			CATCH 
			ENDTRY 
		ENDTRY 
	ENDTRY 
ENDTRY 

loXML.OPEN("POST", lcFullURL, .F.)
loXML.SetRequestHeader("Content-Type", "application/xml")
loXML.SEND("")
lcResponse = loXML.ResponseText
=SaveSql(lcResponse,"obtenerXY_"+tcDestination)
LOCAL lcAddress, lcHTML
lcAddress = STREXTRACT(lcResponse, "<end_address>", "</end_address>")
lcLocation = STREXTRACT(lcResponse, "<start_location>", "</start_location>")
lcLatitud = STREXTRACT(lcLocation, "<lat>", "</lat>")
lcLongitud = STREXTRACT(lcLocation, "<lng>", "</lng>")

clatitud = IIF(not EMPTY(tcDestination),lcLatitud,clatitud)
clongitud = IIF(not EMPTY(tcDestination),lcLongitud,clongitud)
tcDestination = lcAddress
RETURN

ENDFUNC 


*-----------------------------------
*-----------------------------------
*-----------------------------------
*GOOGLE COORDS: Pasando la cadena de coordenadas crea una ruta entre las mismas
*Ex: [{"Coord":{"Lat":-34.24,"Lng":-59.46},"Distance":""},{"Coord":{"Lat":-34.89,"Lng":-58.57},"Distance":""}];
*-----------------------------------
*-----------------------------------
*-----------------------------------


FUNCTION GoogleCoords
LPARAMETERS tcDestination,coords

LOCAL loXML AS "MSXML2.ServerXMLHTTP.4.0"
LOCAL lcFullURL, lcResponse, lcRouteParameters
tcDestination          = EVL(tcDestination, "")
lcRouteParameters = "origin=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20") + ;
    "&destination=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20")
lcFullURL = "http://maps.googleapis.com/maps/api/directions/xml?" + lcRouteParameters + ;
    "&units=metrics&sensor=false&v=3.22"
TRY 
	loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.4.0") && Could use version 3.0, 4.0, 5.0, 6.0
CATCH
	TRY 
		loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.3.0") && Could use version 3.0, 4.0, 5.0, 6.0
	CATCH 
		TRY
			loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.5.0") && Could use version 3.0, 4.0, 5.0, 6.0
		CATCH
			TRY 
				loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0") && Could use version 3.0, 4.0, 5.0, 6.0
			CATCH 
			ENDTRY 
		ENDTRY 
	ENDTRY 
ENDTRY 
loXML.OPEN("POST", lcFullURL, .F.)
loXML.SetRequestHeader("Content-Type", "application/xml")
loXML.SEND("")
lcResponse = loXML.ResponseText

LOCAL lcAddress, lcHTML
lcAddress = STREXTRACT(lcResponse, "<end_address>", "</end_address>")
lcLocation = STREXTRACT(lcResponse, "<start_location>", "</start_location>")

TEXT TO lcHTML NOSHOW TEXTMERGE
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<title>Produced by GMap4Any1 v.01.05.00</title>
<style type="text/css">
html, body, #map-canvas {height: 100%;margin: 0px;padding: 0px}
</style>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry"></script>
<script>
var map;
var infoWindow;
var hostnameRegexp = new RegExp("^https?://.+?/");
var directionsOverlays = [];
var rendererOptions = {draggable: false};
var directionsService = new google.maps.DirectionsService();
var stops = <<Coords>>
function initialize() {
	var centerPoint = new google.maps.LatLng(-38.7137069,-62.2627304);
	var mapOptions = {zoom: 15, center: centerPoint, mapTypeId: google.maps.MapTypeId.ROADMAP, streetViewControl: true}
	map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
	//var marker=new google.maps.Marker({position:centerPoint});
  //marker.setMap(map);
  //infowindow = new google.maps.InfoWindow({content:"Hello World!"});
  //infowindow.open(map,marker);	
  var trafficLayer = new google.maps.TrafficLayer();
  trafficLayer.setMap(map);
  calcRoute();
}
function calcRoute() {
	var start;
	var end;
	var chunk = [];
	start = stops.splice(0,1).shift();
	if(stops.length <= 8){
		if(stops.length > 1) chunk = stops.splice(0, stops.length-1);
		else chunk = [];
	}else{
		chunk = stops.splice(0,8);
	}
	end = stops.splice(0,1).shift();
	while(chunk.length > 0 || stops.length >= 0){
		var subStops = [];
		var subitemsCounter = 0;
		for (var j = 0; j < chunk.length; j++) {
			subitemsCounter++;
			subStops.push({
				location: new window.google.maps.LatLng(chunk[j].Coord.Lat, chunk[j].Coord.Lng),
				stopover: false
			});
			if (subitemsCounter == 8)
				break;
		}
		var request = {
		origin: new window.google.maps.LatLng(start.Coord.Lat, start.Coord.Lng),
		destination: new window.google.maps.LatLng(end.Coord.Lat, end.Coord.Lng),
		provideRouteAlternatives:true,
		avoidHighways:false,
		avoidTolls:true,
		avoidFerries:true,
		unitSystem: google.maps.UnitSystem.METRIC,
		waypoints: subStops,
		optimizeWaypoints:true,
		travelMode: google.maps.TravelMode.DRIVING};
		directionsService.route(request, function(response, status) {
			if (status == google.maps.DirectionsStatus.OK) {
				var directionsDisplay = createRenderer();
				directionsOverlays.push(directionsDisplay);
				directionsDisplay.setDirections(response);
		}});
		if (stops.length == 0)	break;
		start = end;
		if(stops.length <= 8){
			if(stops.length > 1) chunk = stops.splice(0, stops.length-1);
			else chunk = [];
		}else{
			chunk = stops.splice(0,8);
		}
		end = stops.splice(0,1).shift();
	}
}
function createRenderer() {
	var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
	directionsDisplay.setMap(map);
	directionsDisplay.setPanel(document.getElementById("directionsPanel"));
	google.maps.event.addListener(directionsDisplay, "directions_changed", function() {computeTotalDistance(directionsDisplay.getDirections());});
return directionsDisplay;
}
function computeTotalDistance(result) {
	var total = 0;
	var myroute = result.routes[0];
	for (var i = 0; i < myroute.legs.length; i++) {
		total += myroute.legs[i].distance.value;
	}
	total = total / 1000.0;
}
google.maps.event.addDomListener(window, "load", initialize);
</script>
</head>
<body>
	<div id="map-canvas" style="float:left;width:70%; height:100%"></div>
	<div id="directionsPanel" style="float:right;width:30%;height 100%"></div>
</body>
</html>
ENDTEXT
* Save the HTML to a local file on the disk
LOCAL lcFile
*lcFile = ADDBS(GETENV("TEMP")) + SYS(2015) + ".htm"
SET SAFETY OFF

lcRuta = SYS(5)+ "\tempsql\"+ALLTRIM(goapp.initcatalo)
IF VARTYPE(goapp.rutaaplicacion)$'C'
	lcRutaApli = IIF(LEN(ALLTRIM(goapp.rutaaplicacion))#0,goapp.rutaaplicacion,"")
	lcRutaApli = RTRIM(lcRutaApli) + IIF(RIGHT(lcRutaApli,1)="\" or LEN(LTRIM(lcRutaApli))=0,"","\") &&Si es vacio o tiene \. Mantiene lo mismo.
	lcRuta = IIF(LEN(LTRIM(lcRutaApli))#0,lcRutaApli+ "tempsql",lcRuta)	
ENDIF 
IF !DIRECTORY(lcRuta)
	MKDIR &lcRuta
ENDIF 
lcFile = ADDBS(lcRuta)+"mihtmlruta.html"

STRTOFILE(lcHTML, lcFile)

SET SAFETY ON 

* Show the StreetView
*RUN /N6 Explorer.EXE &lcFile.
RETURN lcFile
ENDFUNC 



*-----------------------------------
*-----------------------------------
*-----------------------------------
*Pasando coordenadas retorna direccion
*-----------------------------------
*-----------------------------------
*-----------------------------------


FUNCTION ObtenerDire
* Show the StreetView
*RUN /N6 Explorer.EXE &lcFile.FUNCTION GoogleStreetViewMulti
LPARAMETERS tcDestination,clatitud,clongitud
tcDestination = IIF(PCOUNT()<1,"",tcDestination)

lCantParam = IIF(PCOUNT()<3,.f.,.t.)
IF NOT lCantParam
	oavisar.usuario('Faltan Parametros en la función ObtenerDire (cDireccion,@cLat,@cLong)')
	RETURN 
ENDIF 

*!*	IF EMPTY(LTRIM(tcDestination))
*!*		RETURN 
*!*	ENDIF 

LOCAL loXML AS "MSXML2.ServerXMLHTTP.4.0"
LOCAL lcFullURL, lcResponse, lcRouteParameters
tcDestination          = EVL(tcDestination, "")

lcRouteParameters = "origin=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20") + ;
    "&destination=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20")


* Build up the full URL with the required parameters
lcFullURL = "http://maps.googleapis.com/maps/api/geocode/xml?latlng="+clatitud+","+clongitud+"&sensor=false&v=3.22"
* + lcRouteParameters + ;
    "&units=metrics&sensor=false"


* Test with all XML Versions
* Can also apply the info from http://support.microsoft.com/kb/278674/en-us
* to determine what version of MSXML is installed in the machine
TRY 
	loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.4.0") && Could use version 3.0, 4.0, 5.0, 6.0
CATCH
	TRY 
		loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.3.0") && Could use version 3.0, 4.0, 5.0, 6.0
	CATCH 
		TRY
			loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.5.0") && Could use version 3.0, 4.0, 5.0, 6.0
		CATCH
			TRY 
				loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0") && Could use version 3.0, 4.0, 5.0, 6.0
			CATCH 
			ENDTRY 
		ENDTRY 
	ENDTRY 
ENDTRY 


loXML.OPEN("POST", lcFullURL, .F.)
loXML.SetRequestHeader("Content-Type", "application/xml")
loXML.SEND("")
lcResponse = loXML.ResponseText

LOCAL lcAddress, lcHTML
lcAddress = STREXTRACT(lcResponse, "<end_address>", "</end_address>")
lcLocation = STREXTRACT(lcResponse, "<start_location>", "</start_location>")
lcLatitud = STREXTRACT(lcLocation, "<lat>", "</lat>")
lcLongitud = STREXTRACT(lcLocation, "<lng>", "</lng>")

lcCalle = STREXTRACT(lcResponse, "<address_component>", "</address_component>")
lcNro = STREXTRACT(lcResponse, "<long_name>", "</long_name>")


clatitud = IIF(not EMPTY(tcDestination),lcLatitud,clatitud)
clongitud = IIF(not EMPTY(tcDestination),lcLongitud,clongitud)
tcDestination = STREXTRACT(lcResponse, "<formatted_address>", "</formatted_address>")
RETURN

ENDFUNC 






***********************************
***********************************

*SOLO MARCADORES
*Enviar variable cmarks y latitud y longitud del centro

***********************************
***********************************

FUNCTION SoloMarks
LPARAMETERS tcDestination,cmarks,cenLat,cenLng

LOCAL loXML AS "MSXML2.ServerXMLHTTP.4.0"
LOCAL lcFullURL, lcResponse, lcRouteParameters
tcDestination          = EVL(tcDestination, "")

lcRouteParameters = "origin=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20") + ;
    "&destination=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20")

lcFullURL = "http://maps.googleapis.com/maps/api/directions/xml?" + lcRouteParameters + ;
    "&units=metrics&sensor=false&v=3.22"

TRY
	loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.4.0") && Could use version 3.0, 4.0, 5.0, 6.0
CATCH
	TRY 
		loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.3.0") && Could use version 3.0, 4.0, 5.0, 6.0
	CATCH 
		TRY
			loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.5.0") && Could use version 3.0, 4.0, 5.0, 6.0
		CATCH
			TRY 
				loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0") && Could use version 3.0, 4.0, 5.0, 6.0
			CATCH 
			ENDTRY 
		ENDTRY 
	ENDTRY 
ENDTRY 

loXML.OPEN("POST", lcFullURL, .F.)
loXML.SetRequestHeader("Content-Type", "application/xml")
loXML.SEND("")
lcResponse = loXML.ResponseText

LOCAL lcAddress, lcHTML
lcAddress = STREXTRACT(lcResponse, "<end_address>", "</end_address>")
lcLocation = STREXTRACT(lcResponse, "<start_location>", "</start_location>")

TEXT TO lcHTML NOSHOW TEXTMERGE
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Mapa de Rutas</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
	<style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      
      }
     </style>
<script src="http://maps.googleapis.com/maps/api/js"></script>
<script>
  function initialize() {
         geocoder = new google.maps.Geocoder();
         var fenway = new google.maps.LatLng(<<cenLat>>,<<cenLng>>);
		  var mapOptions = {scaleControl: true,panControl:true,rotateControl:true,zoom: 16,mapTypeId: google.maps.MapTypeId.ROADMAP,center: fenway};
  var map=new google.maps.Map(document.getElementById("map-canvas"),mapOptions);
  <<cmarks>>
  }
google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>

<body>
<div id="map-canvas" style="float:left;width:100%; height:100%"></div>
</body>

</html>
ENDTEXT

*


* Save the HTML to a local file on the disk
LOCAL lcFile
*lcFile = ADDBS(GETENV("TEMP")) + SYS(2015) + ".htm"
SET SAFETY OFF

lcRuta = SYS(5)+ "\tempsql\"+ALLTRIM(goapp.initcatalo)
IF VARTYPE(goapp.rutaaplicacion)$'C'
	lcRutaApli = IIF(LEN(ALLTRIM(goapp.rutaaplicacion))#0,goapp.rutaaplicacion,"")
	lcRutaApli = RTRIM(lcRutaApli) + IIF(RIGHT(lcRutaApli,1)="\" or LEN(LTRIM(lcRutaApli))=0,"","\") &&Si es vacio o tiene \. Mantiene lo mismo.
	lcRuta = IIF(LEN(LTRIM(lcRutaApli))#0,lcRutaApli+ "tempsql",lcRuta)	
ENDIF 
IF !DIRECTORY(lcRuta)
	MKDIR &lcRuta
ENDIF 
lcFile = ADDBS(lcRuta)+"mihtmlrutamarks.html"

STRTOFILE(lcHTML, lcFile)

SET SAFETY ON 

* Show the StreetView
*RUN /N6 Explorer.EXE &lcFile.
RETURN lcFile
ENDFUNC 





*-----------------------------------
*-----------------------------------
*-----------------------------------
*GOOGLECOORDS2 pasando la cadena de coordenadas COORDS y la cadena de marcadores y info windows CMARKS
*Crea una ruta entre las coordenadas, elimina los marcadores del tipo A,B,C...
*agrega marcadores comunes en cada direccion que poseen una InfoWindow con Nombre y Direccion
*-----------------------------------
*-----------------------------------
*-----------------------------------






FUNCTION GoogleCoords2
LPARAMETERS tcDestination,coords,cmarks

LOCAL loXML AS "MSXML2.ServerXMLHTTP.4.0"
LOCAL lcFullURL, lcResponse, lcRouteParameters
tcDestination          = EVL(tcDestination, "")

lcRouteParameters = "origin=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20") + ;
    "&destination=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20")


lcFullURL = "http://maps.googleapis.com/maps/api/directions/xml?" + lcRouteParameters + ;
    "&units=metrics&sensor=false&v=3.22"


TRY 
	loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.4.0") && Could use version 3.0, 4.0, 5.0, 6.0
CATCH
	TRY 
		loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.3.0") && Could use version 3.0, 4.0, 5.0, 6.0
	CATCH 
		TRY
			loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.5.0") && Could use version 3.0, 4.0, 5.0, 6.0
		CATCH
			TRY 
				loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0") && Could use version 3.0, 4.0, 5.0, 6.0
			CATCH 
			ENDTRY 
		ENDTRY 
	ENDTRY 
ENDTRY 


loXML.OPEN("POST", lcFullURL, .F.)
loXML.SetRequestHeader("Content-Type", "application/xml")
loXML.SEND("")
lcResponse = loXML.ResponseText

LOCAL lcAddress, lcHTML
lcAddress = STREXTRACT(lcResponse, "<end_address>", "</end_address>")
lcLocation = STREXTRACT(lcResponse, "<start_location>", "</start_location>")

TEXT TO lcHTML NOSHOW TEXTMERGE
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<title>Produced by GMap4Any1 v.01.05.00</title>
<style type="text/css">
html, body, #map-canvas {height: 100%;margin: 0px;padding: 0px}
</style>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry"></script>
<script>
var map;
var hostnameRegexp = new RegExp("^https?://.+?/");
var directionsOverlays = [];
var rendererOptions = {draggable: false};
var directionsService = new google.maps.DirectionsService();
var stops = <<Coords>>
function initialize() {
	var centerPoint = new google.maps.LatLng(-38.7137069,-62.2627304);
	var mapOptions = {zoom: 15, center: centerPoint, mapTypeId: google.maps.MapTypeId.ROADMAP, streetViewControl: true}
	map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
	<<cmarks>>
  var trafficLayer = new google.maps.TrafficLayer();
  trafficLayer.setMap(map);
  calcRoute();
}
function calcRoute() {
	var start;
	var end;
	var chunk = [];
	start = stops.splice(0,1).shift();
	if(stops.length <= 8){
		if(stops.length > 1) chunk = stops.splice(0, stops.length-1);
		else chunk = [];
	}else{
		chunk = stops.splice(0,8);
	}
	end = stops.splice(0,1).shift();
	while(chunk.length > 0 || stops.length >= 0){
		var subStops = [];
		var subitemsCounter = 0;
		for (var j = 0; j < chunk.length; j++) {
			subitemsCounter++;
			subStops.push({
				location: new window.google.maps.LatLng(chunk[j].Coord.Lat, chunk[j].Coord.Lng),
				stopover: false
			});
			if (subitemsCounter == 8)
				break;
		}
		var request = {
		origin: new window.google.maps.LatLng(start.Coord.Lat, start.Coord.Lng),
		destination: new window.google.maps.LatLng(end.Coord.Lat, end.Coord.Lng),
		provideRouteAlternatives:true,
		avoidHighways:false,
		avoidTolls:true,
		avoidFerries:true,
		unitSystem: google.maps.UnitSystem.METRIC,
		waypoints: subStops,
		optimizeWaypoints:true,
		travelMode: google.maps.TravelMode.DRIVING};
		directionsService.route(request, function(response, status) {
			if (status == google.maps.DirectionsStatus.OK) {
				var directionsDisplay = createRenderer();
				directionsOverlays.push(directionsDisplay);
				directionsDisplay.setDirections(response);
		}});
		if (stops.length == 0)	break;
		start = end;
		if(stops.length <= 8){
			if(stops.length > 1) chunk = stops.splice(0, stops.length-1);
			else chunk = [];
		}else{
			chunk = stops.splice(0,8);
		}
		end = stops.splice(0,1).shift();
	}
}
function createRenderer() {
	var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
	directionsDisplay.setMap(map);
	directionsDisplay.setOptions( { suppressMarkers: true } );
	directionsDisplay.setPanel(document.getElementById("directionsPanel"));
	google.maps.event.addListener(directionsDisplay, "directions_changed", function() {computeTotalDistance(directionsDisplay.getDirections());});
return directionsDisplay;
}
function computeTotalDistance(result) {
	var total = 0;
	var myroute = result.routes[0];
	for (var i = 0; i < myroute.legs.length; i++) {
		total += myroute.legs[i].distance.value;
	}
	total = total / 1000.0;
}
google.maps.event.addDomListener(window, "load", initialize);
</script>
</head>
<body>
	<div id="map-canvas" style="float:left;width:70%; height:100%"></div>
	<div id="directionsPanel" style="float:right;width:30%;height 100%"></div>
</body>
</html>
ENDTEXT


* Save the HTML to a local file on the disk
LOCAL lcFile
*lcFile = ADDBS(GETENV("TEMP")) + SYS(2015) + ".htm"
SET SAFETY OFF

lcRuta = SYS(5)+ "\tempsql\"+ALLTRIM(goapp.initcatalo)
IF VARTYPE(goapp.rutaaplicacion)$'C'
	lcRutaApli = IIF(LEN(ALLTRIM(goapp.rutaaplicacion))#0,goapp.rutaaplicacion,"")
	lcRutaApli = RTRIM(lcRutaApli) + IIF(RIGHT(lcRutaApli,1)="\" or LEN(LTRIM(lcRutaApli))=0,"","\") &&Si es vacio o tiene \. Mantiene lo mismo.
	lcRuta = IIF(LEN(LTRIM(lcRutaApli))#0,lcRutaApli+ "tempsql",lcRuta)	
ENDIF 
IF !DIRECTORY(lcRuta)
	MKDIR &lcRuta
ENDIF 
lcFile = ADDBS(lcRuta)+"mihtmlruta.html"

STRTOFILE(lcHTML, lcFile)

SET SAFETY ON 

* Show the StreetView
*RUN /N6 Explorer.EXE &lcFile.
RETURN lcFile
ENDFUNC 












*-----------------------------------
*-----------------------------------
*-----------------------------------
*GOOGLECOORDS3 pasando la cadena de coordenadas COORDS y la cadena de marcadores y info windows CMARKS
*Crea una ruta entre las coordenadas, elimina los marcadores del tipo A,B,C...
*agrega marcadores comunes en cada direccion que poseen una InfoWindow con Nombre y Direccion
*ADEMAS pasando cRuta con coordenadas, crea una Linea Roja que recorre esas Coordenadas
*AGREGO cParadas para los marcadores sobre la ruta cRuta
*-----------------------------------
*-----------------------------------
*-----------------------------------






FUNCTION GoogleCoords3
LPARAMETERS tcDestination,coords,cmarks,cRuta,cParadas,cVendedor

LOCAL loXML AS "MSXML2.ServerXMLHTTP.4.0"
LOCAL lcFullURL, lcResponse, lcRouteParameters
tcDestination          = EVL(tcDestination, "")

lcRouteParameters = "origin=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20") + ;
    "&destination=" + STRTRAN(UPPER(ALLTRIM(tcDestination)), " ", "%20")


lcFullURL = "http://maps.googleapis.com/maps/api/directions/xml?" + lcRouteParameters + ;
    "&units=metrics&sensor=false&v=3.22"


TRY 
	loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.4.0") && Could use version 3.0, 4.0, 5.0, 6.0
CATCH
	TRY 
		loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.3.0") && Could use version 3.0, 4.0, 5.0, 6.0
	CATCH 
		TRY
			loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.5.0") && Could use version 3.0, 4.0, 5.0, 6.0
		CATCH
			TRY 
				loXML = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0") && Could use version 3.0, 4.0, 5.0, 6.0
			CATCH 
			ENDTRY 
		ENDTRY 
	ENDTRY 
ENDTRY 


loXML.OPEN("POST", lcFullURL, .F.)
loXML.SetRequestHeader("Content-Type", "application/xml")
loXML.SEND("")
lcResponse = loXML.ResponseText

LOCAL lcAddress, lcHTML
lcAddress = STREXTRACT(lcResponse, "<end_address>", "</end_address>")
lcLocation = STREXTRACT(lcResponse, "<start_location>", "</start_location>")

TEXT TO lcHTML NOSHOW TEXTMERGE
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<title>Produced by GMap4Any1 v.01.05.00</title>
<style type="text/css">
html, body, #map-canvas {height: 100%;margin: 0px;padding: 0px}
</style>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry"></script>
<script>
var map;
var hostnameRegexp = new RegExp("^https?://.+?/");
var directionsOverlays = [];
var rendererOptions = {draggable: false};
var directionsService = new google.maps.DirectionsService();
var stops = <<Coords>>


function initialize() {

	var centerPoint = new google.maps.LatLng(-38.7137069,-62.2627304);
	var mapOptions = {zoom: 15, center: centerPoint, mapTypeId: google.maps.MapTypeId.ROADMAP, streetViewControl: true}
	map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
	<<cmarks>>
    var trafficLayer = new google.maps.TrafficLayer();
    trafficLayer.setMap(map);
    
	var myLatLng = {lat: -38.877337, lng: -62.083059};
	var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

	
    var pinColor = "1900ff";
		
    //http://www.lass.it/Web/viewer.aspx?id=4 (lista de imagenes/iconos)
	//https://medium.com/@barvysta/google-marker-api-lets-play-level-1-dynamic-label-on-marker-f9b94f2e3585 (como editar)
	var pinImages = new google.maps.MarkerImage("http://maps.google.com/mapfiles/ms/micons/blue.png");
	
	var markerIcon = {
	  url: 'http://maps.google.com/mapfiles/ms/micons/blue.png',
	  //scaledSize: new google.maps.Size(80, 80),
	  origin: new google.maps.Point(0, 0),
	  //anchor: new google.maps.Point(32,65),
	  labelOrigin: new google.maps.Point(15,8)
	};

 	<<cParadas>>
 	
 	var flightPlanCoordinates = <<cRuta>>;
	var flightPath = new google.maps.Polyline({
    path: flightPlanCoordinates,
    geodesic: true,
    strokeColor: '#9800ff',
    strokeOpacity: 1.0,
    strokeWeight: 2
	});
	flightPath.setMap(map)
		
  calcRoute();
}
	
function calcRoute() {
	var start;
	var end;
	var chunk = [];
	start = stops.splice(0,1).shift();
	if(stops.length <= 8){
		if(stops.length > 1) chunk = stops.splice(0, stops.length-1);
		else chunk = [];
	}else{
		chunk = stops.splice(0,8);
	}
	end = stops.splice(0,1).shift();
	while(chunk.length > 0 || stops.length >= 0){
		var subStops = [];
		var subitemsCounter = 0;
		for (var j = 0; j < chunk.length; j++) {
			subitemsCounter++;
			subStops.push({
				location: new window.google.maps.LatLng(chunk[j].Coord.Lat, chunk[j].Coord.Lng),
				stopover: false
			});
			if (subitemsCounter == 8)
				break;
		}
		var request = {
		origin: new window.google.maps.LatLng(start.Coord.Lat, start.Coord.Lng),
		destination: new window.google.maps.LatLng(end.Coord.Lat, end.Coord.Lng),
		provideRouteAlternatives:true,
		avoidHighways:false,
		avoidTolls:true,
		avoidFerries:true,
		unitSystem: google.maps.UnitSystem.METRIC,
		waypoints: subStops,
		optimizeWaypoints:true,
		travelMode: google.maps.TravelMode.DRIVING};
		directionsService.route(request, function(response, status) {
			if (status == google.maps.DirectionsStatus.OK) {
				var directionsDisplay = createRenderer();
				directionsOverlays.push(directionsDisplay);
				directionsDisplay.setDirections(response);
		}});
		if (stops.length == 0)	break;
		start = end;
		if(stops.length <= 8){
			if(stops.length > 1) chunk = stops.splice(0, stops.length-1);
			else chunk = [];
		}else{
			chunk = stops.splice(0,8);
		}
		end = stops.splice(0,1).shift();
	}
}
function createRenderer() {
	var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
	directionsDisplay.setMap(map);
	directionsDisplay.setOptions( { suppressMarkers: true } );
	directionsDisplay.setPanel(document.getElementById("directionsPanel"));
	google.maps.event.addListener(directionsDisplay, "directions_changed", function() {computeTotalDistance(directionsDisplay.getDirections());});
return directionsDisplay;
}
function computeTotalDistance(result) {
	var total = 0;
	var myroute = result.routes[0];
	for (var i = 0; i < myroute.legs.length; i++) {
		total += myroute.legs[i].distance.value;
	}
	total = total / 1000.0;
}
google.maps.event.addDomListener(window, "load", initialize);
</script>
</head>
<body>
	<div > <<cVendedor>> </div>
	<div id="map-canvas" style="float:left;width:70%; height:100%"></div>
	<div id="directionsPanel" style="float:right;width:30%;height 100%"></div>
</body>
</html>
ENDTEXT


* Save the HTML to a local file on the disk
LOCAL lcFile
*lcFile = ADDBS(GETENV("TEMP")) + SYS(2015) + ".htm"
SET SAFETY OFF

lcRuta = SYS(5)+ "\tempsql\"+ALLTRIM(goapp.initcatalo)
IF VARTYPE(goapp.rutaaplicacion)$'C'
	lcRutaApli = IIF(LEN(ALLTRIM(goapp.rutaaplicacion))#0,goapp.rutaaplicacion,"")
	lcRutaApli = RTRIM(lcRutaApli) + IIF(RIGHT(lcRutaApli,1)="\" or LEN(LTRIM(lcRutaApli))=0,"","\") &&Si es vacio o tiene \. Mantiene lo mismo.
	lcRuta = IIF(LEN(LTRIM(lcRutaApli))#0,lcRutaApli+ "tempsql",lcRuta)	
ENDIF 
IF !DIRECTORY(lcRuta)
	MKDIR &lcRuta
ENDIF 
lcFile = ADDBS(lcRuta)+"mihtmlruta.html"

STRTOFILE(lcHTML, lcFile)

SET SAFETY ON 

* Show the StreetView
*RUN /N6 Explorer.EXE &lcFile.
RETURN lcFile
ENDFUNC 