rm(list = ls())  # limpiar memoria

setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 5")


###################################################
###                                             ###
###  Curso An?lisis de datos con R              ###
###  Laboratorio de Proyectos Sociales          ###
###  Sesi?n 2                                   ###
###                                             ###
###################################################

### TEMARIO DE LA SESION

### 1. DESCRIBIR BASES DE DATOS
### 2. MODIFICAR BASES DE DATOS
### 3. MANIPULACION CON DPLYR
### 4. JUNTAR BASES 
### 5. MANIPULACION DE CADENAS DE CARACTERES

install.packages("Hmisc", dependencies = TRUE)   #  
install.packages("dplyr", dependencies = TRUE)   #  Manipulacion y manejo de bases de datos
library(Hmisc)
library(dplyr)
### 1. DESCRIBIR BASES DE DATOS

# Exploremos una base de datos con las funciones
# glimpse(), summary() y Hmisc::describe()

glimpse(Titanic)

summary(Titanic)

describe(Titanic)

# Importamos la base "basepryentMX.csv" y la asignamos a
# un objeto llamado "df"
#
#
#
#
#
#
#
df <- read.csv("pob-x-entidad.csv", stringsAsFactors = FALSE)

glimpse(df)
describe(df)
# Como no tiene cientos de vaiables, podemos aplicar otras 
# funciones para entender la base
head(df)  # el numero de personas de cada entidad por cada año  
summary(df)
describe(df)

# Para hacer conteos condicionales
# Primero selecciona los elementos mayores que el promedio 
m <-mean(df$pob)
greatm <-df[df$pob>m,]
# Luego los contamos
count(df, pob > m)  
### 2. MODIFICAR BASES DE DATOS
lessm <-df[df$pob<m,]
# Queremos crear una nueva variable para identificar
# las observaciones que se refieran a la poblaci'on
# Mayor de edad. Sus categor'ias son menor y mayor

# Para crear una nueva variable:    
#  df$NewVar <- if_else(df$edad >= x, "Mayor", "Menor")

df$mayor <- if_else(df$edad >= 18, "Mayor", "Menor")

glimpse(df)
head(df)
# Decidimos que preferimos que las categor'ias sean
# en lugar de "mayor" 1 y en lugar de "menor" 0

#  La estrutura general para decodificar es: 
#  df$ var <- recode (df$var,'1' = 7L, '2' =8L)
#  si se pone nuevo nombre de variable, entonces se crea una nueva columna
df$mayor <- recode(df$mayor, "Mayor"=1, "Menor"=0)
head(df)
### 3. MANIPULACION CON DPLYR
rm(list=ls())

# Importa la base de datos "concentradohogar.dbf"
# y as'ignalo a el objeto "df"
#
#
#
#
#
#
#
#
library(foreign)
df <-  read.dbf("concentradohogar.dbf", as.is = TRUE)
glimpse(df)

head(df)
# Selecciona las variables "sexo_jefe", "tam_loc", "gasto_mon",
# "educacion" y todas las variables que empiecen con "ing"
# as'ignalo a df2

df2 <- dplyr::select(df,sexo_jefe, tam_loc, gasto_mon, educacion, 
                     starts_with("ing"))
head(df2)
# Crea una variable que se llame "prop.edu" que sea igual al gasto en
# educaci'on entre el gasto monetario (gasto_mon); otra variable se debe llamar 
# loc y debe adoptar el valor "Rural" cuando el tamanio de localidad (tam_loc)
# sea igual a 4 y "Urbano" en el caso contrario

df2 <- mutate(df2, prop.edu=educacion/gasto_mon,
              loc=if_else(tam_loc=="4","Rural","Urbano"))
head(df2)

# Se generan NA para las observaciones que no tienen un gasto monetario
# Elimina las observaciones con NA en prop.edu. La funci'on para saber si
# es NA es is.na(). As'ignalo a df2
#
df3 <- dplyr::filter(df2, !is.na(prop.edu))  #  se eliminaron 58 observaciones
head(df2)
# Agrupa en df4 la base anterior por el sexo del jefe del hogar y
# la variable que identifica el 'ambito rural o urbano. Despu'es en df5 
# calcula el promedio de prop.edu por las categor'ias agrupadas.
# Llama a la nueva variable "prop.edu.promedio"
df4 <- group_by(df3,sexo_jefe, loc)
head(df4)
df5 <- summarise(df4, prop.edu.promedio = mean(prop.edu))

View(df5)

# Para entender mejor nuestro an'alisis, recodifica el sexo del
# jefe del hogar. Los 1 son "Hombre" y las 2 son "Mujer"
#
#
#
#
#
#
#
#
df5$sexo_jefe<-recode(df5$sexo_jefe, "1"="Hombre", "2"="Mujer")

View(df5)


# Podemos hacer lo mismo con la siguiente instrucci'on
#  usando la funcion pipa 
# usamos la funcion select, seleccionando 4 columnas 
#  luego se usa mutate para generar una nueva columna llamada 
#   prop.edu asi como otra que se llam locacion 
#   posteriormente se usa un filtro para quitar todos
#  los elementos con valores nulos, asi que el nuevo df 
#  ya no tiene valores nulos finalmente agrupamos por la columna sexo_jefe
# loc 
#   ya que se obtienen estos grupos separados entonces se hace el 
# calculo de la media por grupo 
dplyr::select(df, sexo_jefe, tam_loc, gasto_mon, educacion) %>%
    mutate(prop.edu = educacion/gasto_mon, 
           loc = if_else(tam_loc=="4", "Rural", "Urbano")) %>% 
    filter(!is.na(prop.edu)) %>% group_by(sexo_jefe, loc) %>%
    summarise(prop.edu.promedio = mean(prop.edu))

# Modif'icala de manera que saques informaci'on para
# los jefes de hogar que tengan m'as de 40 anios (edad_jefe)
#head(prueba)
dplyr::select(df, sexo_jefe , tam_loc, gasto_mon, educacion, edad_jefe) %>%
    filter(edad_jefe>40)  %>%
    mutate(prop.edu = educacion/gasto_mon, 
           loc = if_else(tam_loc=="4", "Rural", "Urbano")) %>% 
    filter(!is.na(prop.edu)) %>% group_by(sexo_jefe, loc) %>%
    summarise(prop.edu.promedio = mean(prop.edu))

#
#
#
#
#
#
dplyr::select(df, sexo_jefe, tam_loc, gasto_mon, educacion, edad_jefe) %>%
    filter(edad_jefe > 40) %>%
    mutate(prop.edu = educacion/gasto_mon, 
           loc = if_else(tam_loc=="4", "Rural", "Urbano")) %>% 
    filter(!is.na(prop.edu)) %>% group_by(sexo_jefe, loc) %>%
    summarise(prop.edu.promedio = mean(prop.edu))

# Ejercicio: Tomen la base de datos de educaci'on llamada 
# "base_edu_14.dta"
rm(list=ls())
library(haven)
df.edu <- read_dta("base_edu_14.dta")
glimpse(df.edu)
# 1) Extrae la proporcion de analfabetas del total de menores
# y mayores a nivel estatal, por sexo.
dplyr:: select(df.edu,edad, alfabetism,sexo,numren) %>%
    mutate(rango =if_else(edad >18,"Mayor","Menor")) %>%
    group_by(numren,sexo)
# 2) Determina cuantos menores de edad asisten a la escuela en
# cada una de las entidades, por sexo.
dplyr:: mutate(df.edu,edad,inasist = as.numeric(recode(asis_esc, "1"="0", "0"="1")),
               menor =if_else(edad >18,"Mayor","Menor"),
               estado = substr(folioviv,1,2))%>%
    group_by(estado,sexo,menor,inasist)  %>% summarise(cont=n()) %>%
    filter(inasist==0 & menor == "Menor" ) %>% ungroup() %>%
    select(estado, sexo, cont)  # Se debe desagrupar ya que 
# sino toma todo junto 

.
#
#
#  respuesta 
# primero genera una parametrizacion para los valores de alfabetismo 
#  lo mismo se hace para los menores de edad
#  para obtener el estado al que pertenecen, se toma en cuenta el folio
#  que aparece en la columnda de folioviv , pero solo se toman en cuenta los 
#  primeros 2 caracteres 
#   luego se usa un agrupamiento dandondos 128 combinacions 
#   Numero de estados X menores X Sexo (32 X 2 X 2)
#  luego summarize me perimite hacer una función a cada grupo 

df <- mutate(df.edu,  analf = as.numeric(recode(alfabetism, "1"="0", "2"="1")),
             menores=if_else(edad >= 18, "Mayor", "Menor"),
             estado=substr(folioviv, 1,2)) %>%
    group_by(estado, menores, sexo) %>% summarise(prop = mean(analf, na.rm = T))
View(df)

df <- mutate(df.edu, inasist = as.numeric(recode(asis_esc, "1"="0", "0"="1")),
             menores=if_else(edad >= 18, "Mayor", "Menor"),
             estado=substr(folioviv, 1,2)) %>%
    group_by(estado, menores, sexo, inasist) %>%
    summarise(cont=n()) %>% filter(inasist==0 & menores == "Menor" ) %>% ungroup() %>%
    select(estado, sexo, cont)
View(df)
# 3) determina el promedio de analfabetas por hogar en cada estado
df <- mutate(df.edu, analf = as.numeric(recode(alfabetism, "1"="0", "2"="1")),
             estado=substr(folioviv, 1,2)) %>%
    group_by(folioviv, foliohog, estado) %>%
    summarise(sum.analf=sum(analf, na.rm = T)) %>% ungroup() %>%
    group_by(estado)%>%
    summarise(prom.analf=mean(sum.analf, na.rm = T))
View(df)

### 4. JUNTAR BASES 
rm(list=ls())
df.1 <- read.csv("X.csv", stringsAsFactors = FALSE)
head(df.1)  # ID,EDAD,SEXO,CD
df.2 <- read.csv("Y.csv", stringsAsFactors = FALSE)
head(df.2)  # ID,ingreso,color,CD

# Inner join - Todas las variables, s?lo las observaciones en 
# los dos data frames. Cuando no especificas "by" busca
# las variables comunes en ambos data frame
# Inner_join   Join two tbls together
df.inner <- inner_join(df.1, df.2) # Une de acuerdo al id y cd
head(df.inner)
# Al usar by=c("id"),suffix=c(".1",".2")
# Se crea una columna para los valores distintos de 
# Caa tabla 
df.inner <- inner_join(df.1, df.2, by=c("id"), suffix=c(".1", ".2"))
head(df.inner)
# Left join - Pega a la base del primer argumento los datos 
# que encuentre en la base del segundo. Terminamos con el 
# n?mero de observaciones de la primera base y el numero de
# variables de ambas bases
df.left <- left_join(df.1, df.2)
df.left

# Si una observaci?n de la base en el primer argumente tiene
# dos resultados en la base del segundo argumento, en el
# resultado se duplica
df.left2 <- left_join(df.1, df.2, by=c("id"))
df.left2


# ?Son iguales?
setequal(left_join(df.1, df.2), 
         right_join(df.2, df.1))

# Leemos una tercera base
df.3 <- read.csv("W.csv", stringsAsFactors = FALSE)

# Full join - El resultado son todas las filas de ambas bases
# y todas las columnas
df.full <- full_join(df.1, df.3, by=c("id"))
df.full

rm(list=ls())
# Queremos pegar informacion a la base a nivel personas
# de su hogar (pegar a poblacion.dbf de concentradohogar.dbf)

df_pers <- read.dbf("poblacion.dbf", as.is = TRUE)
df_hogar <- read.dbf("concentradohogar.dbf", as.is= TRUE)

df_pers <- df_pers[,c(1:6, 25)]
df_hogar <- df_hogar[,c(1:13, 24)]

# Pegar a df_pers la base df_hogar por las variables
# folioviv y foliohog (llama al objeto df_comb)
#
#
#
#
#
#
#
#
df_comb <- left_join(df_pers, df_hogar, by=c("folioviv",
                                             "foliohog"))

# Calcula el ingreso corriente (ing_cor) de las
# personas que hablan una lengua indigena (hablaind)
#
#
#
#
#
#
#
#
#
group_by(df_comb, hablaind) %>% 
    summarise(prom_ing_cor = mean(ing_cor, na.rm = TRUE))

### 5. MANIPULACION DE CADENAS DE CARACTERES
library(stringr)
rm(list=ls())

df.albercas <- read.csv("albercas_publicas_US.csv", stringsAsFactors = TRUE)
df.albercas$numero <- str_extract(df.albercas$Address, "\\d+")
glimpse(df.albercas)
head(df.albercas)
df.albercas$condado <- str_extract(df.albercas$Address, "\\b[^,]+$")
glimpse(df.albercas)

rm(list=ls())
# Ejercicio: importar la base "Registro-asistencia.csv"
df <- read.csv("Registro-asistencia.csv", stringsAsFactors = FALSE)

# Checar cuales CURPs no est'an completos con la forma
# XXXX000000HXXXXX00 con H igual a H o M
# Filtrar las observaciones
# De los que esten completos, revisar si la fecha de nacimiento
# corresponde con el CURP

# para ello se usa str_detect, el cual nos permetira identificar
# si se encuentra algun elemento en la cadena de caracteres
df$indic <- str_detect(df$curp, "[A-z]{4}[0-9]{6}[HhMm][A-z]{5}[0-9]{2}")
df <- filter(df, indic==TRUE) # ahora solo seleccionamos los casos correctos
df$anio <- str_extract(df$curp, "[0-9]{6}") # ahora seleccionamos los años
df$anio2 <- paste(str_sub(df$nac, 3,4), str_sub(df$nac, 6,7), str_sub(df$nac, 9,10),
                  sep="")
df$indic <- df$anio == df$anio2 # comparamos la informacion
df <- arrange(df, indic)


#ejemplo de arrange
title <- c('Effective Java','Orientalism','False Impressions','How To Program Java','Making Software')
height <- c('123','197','177','238','245')
year <- c('2011','2011','3015','1999','1997')
books <-  data.frame(title,  height, year)

orderedBooks <- arrange(books, title)

