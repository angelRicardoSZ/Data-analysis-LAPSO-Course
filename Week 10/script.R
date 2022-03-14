setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 10")

rm(list=ls()) 

library(ggplot2)

##  Gramatica de graficos

#           Theme       # tinta 

#           Coordinate #  Escalas
    
#           Statistics 

#           Facets      separar datos por paneles

#           Geometria    puede ser un punto, diagrama de caja y brazos
                         # linea, curva de densidad
#           Aesthetic

#           Data


ggplot(mtcars, aes(x=hp,y=mpg)) + geom_point(color="red")


ggplot(mtcars, aes(x=hp,y=mpg, color=cyl)) + geom_point()


ggplot(mtcars, aes(x=hp,y=mpg,color=factor(cyl))) + geom_point()


#  Mas geometrias 

ggplot(mtcars, aes(x=hp,y=mpg)) + 
    geom_point() +
    geom_abline(slope = 10, intercept = 5) +
    geom_vline(xintercept=150, color="DarkMagenta", size=2) +
    geom_hline(yintercept = 20)


ggplot(diamonds,aes(x=cut, y=price, color=factor(cut))) +
    geom_point()


ggplot(diamonds, aes(x=carat, y=price)) +
    geom_point(alpha=0.3, shape=".")


ggplot(diamonds, aes(x=price)) +
    geom_histogram()



ggplot(diamonds, aes(x=price)) +
    geom_histogram(aes(y=..density..))    


ggplot(diamonds, aes(x=price, fill=cut)) +
    geom_histogram(aes(y=..density..))   

# curva de densidad
ggplot(diamonds, aes(x=price)) +
    geom_density()

#  diagrama de barras
ggplot(mtcars, aes(cyl, fill=factor(cyl))) +
geom_bar()


#  boxplot
ggplot(diamonds, aes(x=cut, y=price)) +
    geom_boxplot()

#  Hacer zoom 
ggplot(diamonds,aes(x=carat, y=price)) +
    geom_point(alpha) +
    lims(x= c(0,2.5), y=c(0,10000))


ggplot(diamonds,aes(x=depth, y=carat)) +
    geom_point(alpha=0.6)
# misma escala 
ggplot(diamonds,aes(x=depth, y=carat)) +
    geom_point(alpha=0.6) +
    coord_equal()
    
ggplot(diamonds,aes(x=carat, y=price, color=cut)) +
    geom_point(alpha=0.6) +
    stat_smooth() +
    facet_grid(clarity~cut)


#  estadisticos
#  linea de regresion 
ggplot(mtcars,aes(x=hp, y=mpg)) +
    geom_point() +
    stat_smooth(method = "lm")


ggplot(mtcars,aes(x=hp, y=mpg, color=factor(cyl))) +
    geom_point() +
    stat_smooth(se=F)

### temas
ggplot(mtcars, aes(x=hp, y=mpg, color=factor(cyl))) +
    geom_point() +
    stat_smooth()+
    theme_minimal()  # theme minimal es para hacer mas simples las lineas




