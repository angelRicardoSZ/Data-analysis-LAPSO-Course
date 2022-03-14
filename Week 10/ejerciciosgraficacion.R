setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 10")

rm(list=ls()) 

library(ggplot2)
# install.packages("ggrepel")
library(ggrepel)
#  Establecer el tamaño de los graficos
library(dplyr)
options(repr.plot.width = 9, repr.plot.height=5 )

# cargar base Iris 

data("iris")

#  Descripcion 

#   Sepal.Length: longitud del sépalo que es una variable contínua.
#   Sepal.Width : ancho del sépalo que es una variable contínua.
#   Petal.Length: longitud del pétalo que es una variable contínua.
#   Petal.Width: ancho del pétalo que es una variable contínua.
#   Species: que es una variable categórica.

head(iris)

#  La unidad de observación presente en cada fila de datos es una flor y sus medidas respéctivas



#  Estructura de capas 
#  ggplot(dataframe, aes(variables_por_mapear))+
#    geom_a_utilizar(características_del_geom)

#   Sepal vs Width  con Specie
ggplot(iris, aes(x=Sepal.Length,y=Sepal.Width,size=factor(Species)))+
    geom_point(alpha=0.6)


#  Un panel por cada especie
ggplot(iris, aes(x=Sepal.Length,y=Sepal.Width))+
    geom_point(alpha=0.6)+
facet_wrap(.~Species)

#   Con liena de regresion 

ggplot(iris, aes(x=Sepal.Length,y=Sepal.Width))+
    geom_point(alpha=0.6)+
    facet_wrap(.~Species)+
    stat_smooth()


ggplot(iris, aes(x=Sepal.Length,y=Sepal.Width))+
    geom_point(alpha=0.6)+
    facet_wrap(.~Species)+
    stat_smooth()+
    theme_minimal()


####   ECONOMICS 
data("economics")
head("economics")

#  Descripcion 
#   Las variables que tiene son:
    
#   date: con la fecha en formato date.
#   pop: con el número de habitantes en EUA en dicha fecha.
#   psavert: con la tasa de ahorro promedio en dicha fecha.
#   uemploy: con la cantidad de personas desempleadas en dicha fecha.



ggplot(economics, aes(x = date, y = unemploy/pop)) +
    geom_line()

# Vamos a añadir unos rectángulos que sombreen los periodos de recesión.
#  objeto "recess", contiene las fechas de inicio y de finalización de los periodos de recesión

recess <- data.frame(inicio=as.Date(c("1969-12-01","1973-11-01","1980-01-01",
                                      "1981-07-01","1990-07-01","2001-03-01")),
                     fin=as.Date(c("1970-11-01","1975-03-01","1980-07-01",
                                   "1982-11-01","1991-03-01","2001-11-01")))

recess

#  podemos utilizar información de dos dataframes distintos para graficar una misma visualización.

# Si queremos usar un dataframe distinto debemos especificar que no queremos que herede las características que definimos en la función ggplot(), ésto lo hacemos con inherit.aes=FALSE.


ggplot(df1, aes(x = var1, y = var2)) +
    geom_point(data = df2, aes(x = var3, y = var4,),
               inherit.aes = FALSE) +
    geom_line()


ggplot(economics, aes(x = date, y = unemploy/pop)) +
    geom_point(data = recess, aes(x = inicio, y = fin),
               inherit.aes = FALSE) +
    geom_line()

#  correcto
ggplot(economics, aes(x = date, y = unemploy/pop)) +
    geom_rect(data = recess,
              aes(xmin = inicio, xmax = fin, ymin = -Inf, ymax = +Inf),
              inherit.aes = FALSE, fill = "blue", alpha = 0.2) +
    geom_line()


#  Modificacion de limites
ggplot(economics, aes(x = date, y = unemploy/pop)) +
    geom_rect(data = recess,
              aes(xmin = inicio, xmax = fin, ymin = 0.02, ymax = 0.05),
              inherit.aes = FALSE, fill = "blue", alpha = 0.2) +
    geom_line()




# Replicar grafica de THE economist 

# Leemos el archivo 

base <- read.csv("EconomistData.csv")

# En primer lugar se graficara la variable CPI (X)
#  vs HDI (y)

#Se creal el objeto, EL CUAL ES UN GRAFICO, en el que 
# el color de la geometria depende de la region 
pc1 <- ggplot(base, aes(x=CPI, y=HDI, color=Region ))

#  Ahora se grafica 
pc1 + geom_point()

# Se agrega una linea de regresion no parametrica , si SE 

pc2 <- ggplot(base, aes(x=CPI, y=HDI, color=Region )) + stat_smooth(se =F,color="red")

pc2 + geom_point()


#  puntos sin relleno Shape=!
pc3 <- pc2 + geom_point(shape=1, size=2.5, stroke=1.25)

pc3

# Seleccionando algunas etiquetas 
etiquetas <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")
etiquetas


# FIltramos las entiidades que queremos
dplyr::filter(base, Country %in% etiquetas)
head(base)

basefiltrada <-dplyr::filter(base, Country %in% etiquetas)

head(basefiltrada)


#  Agregando laa geometria de texto 
pc4 <- pc3 +
    geom_text_repel(aes(label=Country),
                    color="gray20",
                    data = basefiltrada,
                    force = 10)

pc4


# Nombres de titulos


pc5 <- pc4 +
    scale_x_continuous(name = "Índice de Percepción de la Corrupción, 2011 (10=menos corrupto)",
                       limits = c(.9, 10.5),
                       breaks = 1:10) +
    scale_y_continuous(name = "Índice de Desarrollo Humano, 2011 (1=Mejor)",
                       limits = c(0.2, 1.0),
                       breaks = seq(0.2, 1.0, by = 0.1)) +
    scale_color_manual(name = "",
                       values = c("#24576D",
                                  "#099DD7",
                                  "#28AADC",
                                  "#248E84",
                                  "#F2583F",
                                  "#96503F")) +
    theme_minimal()+
    ggtitle("Corrupción y desarrollo humano")
pc5

install.packages("rvest", dependencies = TRUE)


