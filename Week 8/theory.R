# Manipulacion de cadenas de caracteres 
rm(list=ls()) 
# Para juntar cadenas de caracteres 
setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 8")

library(stringr)
library(foreign)
library(dplyr)

# Importar base 
df.albercas <- read.csv("albercas_publicas_US.csv", stringsAsFactors = T)

glimpse(df.albercas)

head(df.albercas)

# Queremos extraer el numero de la direccion que se encuentra en la variable adress

# Para ello se utiliza  

    # str_extract
    # y usando la expresion regular \\d+ (\\ significa \ en R)

df.albercas$numero <- str_extract(df.albercas$Address,"\\d+")

head(df.albercas)

# Ahora queremos recuperar el condado en donde se encuentra cada una de las direcciones

# \\b[^,]+$   identifica una palabra con borde de palabra (\\b) que  
# no tenga comas [^,] una o mas veces + y que se encuntre al final $

#  Encontrara todas las palabras buscando desde el final hasta donde haya coma

df.albercas$condado <- str_extract(df.albercas$Address, "\\b[^,]+$")

head(df.albercas)

df <- read.csv("Registro-asistencia.csv", stringsAsFactors = T)

head(df)

curps <- df$curp   #Seleccionamos los valores que deseamos examinar

busqueda <- "([A-Z]{4})([0-9]{6})(?:M|H)([A-Z]{5})([0-9]{2})"   #  declraramos el patron de busqueda

str_detect(curps,busqueda)  #  realizamos pruebas

c <- str_count(curps,busqueda)

table(c)  #  sirve para hacer un conteo 

df$curpbien <- str_extract_all(curps,busqueda)  # extraemos aquellos curps que estan bien escritos

curpscorrect


##  RESPUESTA CURSO
df$indic <- str_detect(df$curp,"[A-z]{4}[0-9]{6}[HhMm][A-z]{5}[0-9]{2}")
#  ahora aplicamos el filtro
df <- dplyr::filter(df, indic ==T)
#  ahora tomamos del curp el año 

df$year <- str_extract(df$curp,"[0-9]{6}")
# ahora pega, la heca de nacimiento, para ello toma los caracteres
#  3,4,5,6,7,8 de la columna de año, y los une
df$year2 <- paste(str_sub(df$nac, 3,4), str_sub(df$nac, 6,7), str_sub(df$nac, 9,10),
                  sep="")

# De esta manera ya se tienen los años por el curp, y los años que otorgo la persona
# Ahora se comparan para ver cuales coinciden.

df$yeartrue <-df$year==df$year2

df <- arrange(df, yeartrue)

head(df,20)

install.packages("survey", dependencies = TRUE)

library(survey)

srs_

install.packages("srvyr", dependencies = TRUE)

