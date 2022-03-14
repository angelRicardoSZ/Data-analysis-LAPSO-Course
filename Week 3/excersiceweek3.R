# Ejercicio intercativo 
install.packages("tidyr")


getwd()

setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 3")

rm(list=ls())  ##  borra todo del ambiente 


df_cotizacion <- read.csv("data_ch1.csv", stringsAsFactors = FALSE)

df_cd2 <- df_cotizacion[1:1000, c(1,2,5)] # primeras 1000 cotizaciones
# de las columnas 1 , y 5

vec_compra <- df_cotizacion$Open >= df_cotizacion$Close  

vec_compara <- sum(vec_compra, na.rm = TRUE)

vec_compara


#############################

# Numero de visitas por dia en las redes sociales
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)


#  Dias populares 
linkedin > 5 

linkedin > facebook

#  construimos una matriz con los datos que tenemos

visits <- matrix(c(linkedin, facebook), nrow = 2, byrow = T)
visits

# ¿Cuando nuestras visitas fueron igual en las dos redes
visits == 13


## Operadores logicos 
rm(list=ls())  ##  borra todo del ambiente 

ls()

linkedin <- c(16, 9, 13, 5, 2, 17, 14)

ultimo <- tail(linkedin,1)

ultimo

ultimo < 5 | ultimo > 10 

ultimo > 15  & ultimo <= 20


data("mtcars")
head(mtcars)

mpg <- mtcars$mpg

mpg

mpg[3]  # elemento

mpg[3:6]  # intervalo de valores

mpg[c(3,7)] # valores escecificos

mpg>20  # comparacion 
mpg[mpg>20] # dame solo las valores que lo cumplen

mpg[c(2,3,8,6,12,30)]




# IMPORTAR BASES DE DATOS

rm(list=ls())

