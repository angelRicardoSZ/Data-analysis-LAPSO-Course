## borra solo consola
ctrl + l 

setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 4")

## para ver los archivos :
 list.files()
##  WEEK 4 
##  Operadores y sub-seleccion

 T == F  # FALSE
 
 
 #  Comparacion de caracteres 
 "abril" > "mayo"  # ya que abril va antes de mayo
 
 "llueve" <= "llueve mucho"

 "usuario" == "usuaRio"  # false
 
 facebook <- c(17,7,5,16,8,13,14)
 linkedin <- c(16,9,13,5,2,17,14)

 # n rango 
 linkedin > 15  # pregunta 
 linkedin[linkedin > 15] # selecciona 
 
 linkedin > facebook  # compara elemento a elemento
 
 # crear matriz 
 visitas <- matrix(c(linkedin,facebook), nrow = 2, byrow = T)
 
 visitas
 
 # COMPARAR ALGUN CRITERIO CON LOS ELEMENTOS DE ALGUNA MATRIZ 
 visitas == 13
 visitas[visitas == 13]
 
 data("mtcars")
 vec <- mtcars$mpg
 vec
 
 vec <- vec[1:9]
 vec
 order(vec) # me da los indices 
 vec[order(vec)]  # me da los valores  numericos reales
 
 # importar basess de datos 
 rm(list = ls())  # limpiar memoria

 
 df_albercas <- read.csv("albercas-publicas.csv",
                         stringsAsFactors = F)
 head(df_albercas)  # nombre , direccion y coordenadas de la alberca
 
 df_ent <- read.csv("base-entMX.csv",
                         stringsAsFactors = F)
head(df_ent) 

df_ent2 <- df_ent[df_ent$ent == "Nacional",c(2,3,6,7,8)]  # Seleccionamos columnas y el criterio de que sea nacional 

df_ent3 <- df_ent2[df_ent2$edad < 18 & df_ent2$anio == 2010 ,]
head (df_ent3)       #  son las personas menores a 18 años y con fecha 2010

df_estados <- read.csv("states.csv",
                   stringsAsFactors = F)


df_afinidad <- read.csv("states2.csv",
                       stringsAsFactors = F)  # nos da un puntaje de los paises 

table(df_estados$state_name)  # nos da cuantos paises hay, ademas de cuantas veces aparece cada pais 

# conocer los paises que tiene un puntaje > 0.9 de afinidad con rusia, son los paises
# que votaron 90 % similar a Rusia
df_afinidad$affinityscore_russia > 0.9
df_rusia_aliados <- df_estados[df_afinidad$affinityscore_russia > 0.9,]

# Si solo queremos saber los paises que si lo cumplen 
unique(df_rusia_aliados$state_name) # en total son 134 paises  
head(df_rusia_aliados)
head(df_afinidad)
head(df_estados)