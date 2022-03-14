rm(list = ls())  # limpiar memoria

setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 6")
library(dplyr)


options(repr.plot.width = 5, repr.plot.height = 4)

##  La base de datos contiene informacion por semana para una muestra
#   de usuarios que jugaron Candy Crush pen 2014
#   Los datos son solo de un episodio, es decir de 15 niveles

#  Columnas 
#   player_id: un identificador único para cada jugador
#   dt: la fecha
#   level: el nivel del episodio, va de 1 a 15.
#   num_attempts: número de intentos del jugador en esa fecha.
#   num_success: número de intentos del nivel que resultaron en victoria para el jugador en ese nivel y fecha.


#  La unidad de observación presente en cada fila de datos es el jugador, por fecha y nivel, por lo que habrá una fila distinta para cualquier combinación de estas variables.

df <- read.csv("candy_crush.csv",stringsAsFactors = F)

# contaremos cuantos jugadores distintos tenemos
#  Ya que existen multiples apariciones de cada jugador se puede 
#  Usar la funcion Unique() que nos da un vector con los valores
#  unicos
#  Se puede utilizar dentro de la funcion length() para obtener el numero 
#  de elementos distintos

#  Tambien podemos ver los rangos de la fecha con range()
length(unique(df$player_id))


range(df$dt)


#  Nivel de dificultad 
dificulty <- df %>%
    mutate(dif=num_success/num_attempts)
head(dificulty)
## Por nivel
dificulty2 <- df %>% group_by(level) %>% summarize(pwin=(sum(num_success)/sum(num_attempts)))


highdificulty <- dificulty %>%
    filter(dif<.10)

head(highdificulty)
