#Primero cargamos el archivo correspondiente: epa_http
#usando separado de espacio (Whitespace) para crear las columnas correctamente 
#library(readr) 							 
#epa_http <- read_table("C:/Users/anker/OneDrive/Escritorio/epa-http/epa-http.csv",  col_names = FALSE)
#View(epa_http)


#Para mayor comodidad cambiaremos el nombre de la DATASET -	dim(DFPRINCIPAL)-	dim(DFPRINCIPAL)y de las columnas respectivamente
DFPRINCIPAL <- epa_http
colnames(DFPRINCIPAL) <- c("IP", "TIEMPO", "TIPOPET", "URL", "PROTOCOLO", "CODRESPUESTA", "BYTERESPUESTA")


#PREGUNTA 01:¡Cuales son las dimensiones del dataset cargado (número de filas y columnas)?

#A:
dim(DFPRINCIPAL)
#RESPUESTA: 47.748 Filas      7 Columnas

#B:
DFPRINCIPAL$BYTERESPUESTA <- as.numeric(DFPRINCIPAL$BYTERESPUESTA)
mean(DFPRINCIPAL$BYTERESPUESTA, na.rm = TRUE)
#Respuesta: El valor medio es de [1] 7352.335


#PREGUNTA 2:De las diferentes IPs de origen accediendo al servidor, ¿cuántas pertenecen a una IP claramente educativa (que contenga ".edu")?
SUBDFPRINCIPAL_EDU <-DFPRINCIPAL[grep("\\.edu", DFPRINCIPAL$IP), ]
nrow(SUBDFPRINCIPAL_EDU)
# Respuesta: pertenecen claramente 6.524 Ips que contienen ".edu"

#PREGUNTA 3:De todas las peticiones recibidas por el servidor cual es la hora en la que hay mayor volumen de peticiones HTTP de tipo "GET"?
DFPRINCIPALTIPOGET <- DFPRINCIPAL[grepl("GET", DFPRINCIPAL$TIPOPET), ]
VECTORHORA <- substr(DFPRINCIPALTIPOGET$TIEMPO,5,6)
VECTORHORAUP <- table(VECTORHORA)
VECTORHORAFINAL <-sort(VECTORHORAUP,decreasing=TRUE)
View(VECTORHORAFINAL)
#Respuesta: A las 14 horas es la hora en la que hay mayor cantidad de volumen de peticiones

#PREGUNTA 4:De las peticiones hechas por instituciones educativas (.edu), ¿Cuantos bytes en total se han transmitido, en peticiones de descarga de ficheros de texto ".txt"?
SUBDFPRINCIPAL_EDU <-DFPRINCIPAL[grep("\\.edu", DFPRINCIPAL$IP), ]
SUBDFPRINCIPAL_TXT <- SUBDFPRINCIPAL_EDU[grepl("\\.txt", SUBDFPRINCIPAL_EDU$URL), ]
sum(SUBDFPRINCIPAL_TXT$BYTERESPUESTA,  na.rm = TRUE)
#Respuesta: Se transmitieron 2.705.408 bytes


#PREGUNTA 5:Si separamos la petición en 3 partes (Tipo, URL, Protocolo), usando str_split y el separador " " (espacio), ¿cuántas peticiones buscan directamente la URL = "/"?
# Cuando se cargó el archivo “epa-http.csv” se utilizó el delimitador “whitespace”, con lo cual se tuvo como resultado el siguiente código:
# library(readr)
# epa_http <- read_table("C:/Data Science/epa-http/epa-http.csv")
# View(epa_http)
#  Como resultado se obtuvo la información debidamente separada en columnas.
DFPRINCIPALURL <- DFPRINCIPAL[grepl("^/$", DFPRINCIPAL$URL), ] 
nrow(DFPRINCIPALURL)
#Respuesta: 2.382 PETICIONES buscan directamente la URL = "/"

#PREGUNTA 6:Aprovechando que hemos separado la petición en 3 partes (Tipo, URL, Protocolo)   ¿Cuántas peticiones NO tienen como protocolo "HTTP/0.2"?
DFPRINCIPALHTTP <- DFPRINCIPAL[!grepl("HTTP/0.2", DFPRINCIPAL$PROTOCOLO),]
nrow(DFHTTP)
#Respuesta : La cantidad de peticiones que NO tienen como protocolo "HTTP/0.2"  es de 47.747
