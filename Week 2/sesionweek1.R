###################################################
###                                             ###
###  Curso An'alisis de datos con R             ###
###  Laboratorio de Proyectos Sociales          ###
###  Sesi'on 1                                  ###
###                                             ###
###################################################

### TEMARIO DE LA SESION

### 1. BASICOS
### 2. TIPOS DE OBJETOS
### 3. INTRODUCCION A LAS FUNCIONES
### 4. OPERADORES RELACIONALES
### 5. OPERADORES LOGICOS
### 6. SUBSELECCIONES
### 7. IMPORTAR BASES DE DATOS


### 1. BASICOS
getwd()
setwd("C:\\Users\\wabng\\Documents\\")


# Asignar
valor1 <- sqrt((7 + 8) ^ 3 )

# Impirmir
valor1

# Asignar resultados de operaciones
manzanas <- 8
naranjas <- 3
frutas <- manzanas + naranjas
frutas

# Asignar resultados de funciones
promedio<-mean(c(manzanas, naranjas))  # Convierte a vector y luego toma
# el promedio de los dos  elemento
promedio


#Tipo de datos
class(manzanas)
class(FALSE)

# Resultado de class(class(TRUE)) ???

# L'ogico
manzanas > naranjas
T
TRUE

manzanas < naranjas
F
FALSE

### 2. TIPOS DE OBJETOS
# Vector
var1 <- c(1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5)
var1

var1 + var1  # suma elemento a elemento 


1:12

1:10 + 1:5 # Entender c'omo recicla vectores suma hasta donde hay elementos
# comunes y luego vuelve a usar los elementos del otro vector


# Matrices
matrix()
matrix(data = 1:9, nrow = 3, ncol = 3, byrow = F) # BYROW CAMBIA LA FORMA DE LLENADO


# Data frame
data()  #  da una lista de todos las bases que hay precargados
data("Orange")
View(Orange)


#  crear un dataframe con un vector precargado 

df<-data.frame(var1,word=7:15,anio=rep(1,9))

View(df)
str(df)  # nos da la estructura del df

#Listas
list_a<-list(vector=var1, data=df, vector2=1:7)

list_a
list_a$data$word  # acceder al df  y luego a una columna
str(list_a)

### 3. INTRODUCCION A LAS FUNCIONES
install.packages("tidyr", ddependencies = TRUE)
?lm
args(lm)

### 4. OPERADORES RELACIONALES
# Comparaci'on de valores l'ogicos
TRUE == FALSE

# Comparaci'on de n'umeros
-6*14 != 17-101

# Comparaci'on de caracteres
"Abril" > "Mayo"
"usuario" == "usuaRio"
"llueve" <= "llueve mucho"

# Comparaci'on de l'ogico con num'erico
TRUE == 1


#Comparaci'on de l'ogicos
T > F

# Operadores al usar vectores

# Creamos dos vectores llamados "linkedin" y "facebook"
# que contienen las visitas diarias a nuestro perfil
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Quiero saber los dias populares
linkedin > 15

# Y los dias tranquilos
linkedin <= 5

# En que dias fue mas popular linkedin que facebook?
linkedin > facebook

# Construimos una matriz con los vectores que tenemos
visitas <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)

# Cuando nuestras visitas fueron igual a 13 en cualquier red social?
visitas == 13

# Cuando son menores o iguales a 14?
visitas <= 14

### 5. OPERADORES LOGICOS (and &, or |)
rm(list=ls())
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
ultimo <- tail(linkedin, 1)

# El ultimo valor es menor a 5 o mayor a 10?
ultimo < 5 | ultimo > 10

# El ultimo valor esta entre 15 (exclusivo) y 20 (inclusivo)?
ultimo > 15 & ultimo <= 20


rm(list=ls())
### 6. SUBSELECCIONES
data("mtcars")
vector <- mtcars$mpg

vector[3]
vector[3:5]
vector[c(3,7)]

vector <- vector[1:9]

vector>20
vector[vector>20]

vector
order(vector)
vector[order(vector)]
vector[c(7, 6, 5, 1, 2, 4, 3, 9, 8)]

### 6. IMPORTAR BASES DE DATOS
rm(list=ls())
df_albercas <- read.csv("albercas-publicas.csv",
                        stringsAsFactors = FALSE)

### Lean la "base-entMX.csv"
#
#
#
#
#
#
#
df_ent <- read.csv("base-entMX.csv",
                   stringsAsFactors = FALSE)

### Realiza una subselecci'on de las observaciones en
# donde la entidad "ent" sea igual a "Nacional" y las
# columnas 2,3,6,7 y 8
# ll'amalo df_ent2
#
#
#
#
#
#
#
df_ent2 <- df_ent[df_ent$ent == "Nacional", c(2,3,6,7,8)]

### Realiza una subselecci'on con los menores 
# de edad de 2010 del objeto anterior
# ll'amalo df_ent3
#
#
#
#
#
#
#
df_ent3 <- df_ent2[df_ent2$edad < 18 & df_ent2$anio == 2010,]

# Â¿Por qu'e a veces resulta repetitivo?
# Subselecci'on a partir de otro data frame
#
#
#
#
#
#
#
#
#
rm(list=ls())
df_estados <- read.csv("states.csv", stringsAsFactors = FALSE)
df_afinidad <- read.csv("states2.csv", stringsAsFactors = FALSE)

# Realiza una subselecci'on de los estados y anios
# en los que su 'indice de afinidad con Rusia sea
# mayor a 0.5, ll'amalo df_rusia_aliados
#
#
#
#
#
#
#
#
#
#
df_rusia_aliados <- df_estados[df_afinidad$affinityscore_russia > 0.9, ]
unique(df_rusia_aliados$state_name)