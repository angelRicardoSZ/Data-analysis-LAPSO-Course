rm(list = ls())  # limpiar memoria

setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 6")



#  Repaso de dplyr
#  Usar las 6 principales acciones de manipulacion de dataframes con 
#  pipas en dpylr

#   filter
#   select
#   summarize
#   count
#   mean
#   mutate
library(Hmisc)
library(dplyr)
library(foreign)
library(haven)
library(stringr)
#  install.packages('gapminder')
library(gapminder)

help(gapminder)

#  USANDO SELECT
#  Si solo queremos usar unas pocas variables 
head(gapminder)


year_country_gdp <- select(gapminder, year,country,gdpPercap)

head(year_country_gdp)

#  Ahora usando pipes 
year_country_gdp<- gapminder %>% select(year,country,gdpPercap)


#  Usando filter()
#  Si continuamos pero ahora solo con los paises europeos
#   podemos combinas select() y pipe()
year_country_gdp_euro <- gapminder %>%
    filter(continent=="Europe") %>%
    select(year,country,gdpPercap)

head(year_country_gdp_euro)

# Reto 1 
# Escribir un unico comando que produzca un df
# que contenga los valores africanos correspondientes
#  a lifeExp, country y year 

year_country_gdp_euro <- gapminder %>%
    filter(continent=="Africa") %>%
    select(year,country,lifeExp) 
head(year_country_gdp_euro)
head(gapminder)
str(gapminder)

str(gapminder %>% group_by(continent))
#   group_by y summarize
#   Esto nos permitirá crear nuevas variables usando funciones
#   que se aplican a cada uno de los
#   data frames específicos para cada continente.

#  Es decir, con group_by dividimos nuestro df original en varias
#   partes, a las que luego podemos aplicarle funciones con
#   Summarize

gdp_by_continent <- gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap=(mean(gdpPercap)))
head(gdp_by_continent)
# Esto nos ha permitido calcular la renta per capita media 
# para cada continente, pero puede ser todavia mucho mejor

#  CALCULAR LA ESPERANZA DE VIDA MEDIA POR PAIS
lifeExp_bycountry <- gapminder %>%
    group_by(country) %>%
    summarize(mean_lifeExp=(mean(lifeExp)))
head(lifeExp_bycountry)

# Ahora preguntamos el menor
lifeExp_bycountry %>% 
    filter(mean_lifeExp==min(mean_lifeExp)|mean_lifeExp==max(mean_lifeExp))
lifeExp_bycountry %>% 
    filter(mean_lifeExp==min(mean_lifeExp))

#   otra forma de hacer esto es usando la función 
#  arrange del paquete dplyr que distribuye las filas
#   de un df en función del orden de una o mas variables

#  Se puede usar desc() dentro de arrange()
# para ordenar de modo descendente.
lifeExp_bycountry %>%
    arrange(mean_lifeExp) %>%
    head(1)
 
lifeExp_bycountry %>%
    arrange(desc(mean_lifeExp)) %>%
    head(1)


# La funcion groupby mos permite agrupar en diferentes maneras
# con mas variables
# agrupando por año y continente 
gdp_by_continent_year <-gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gd=mean(gdpPercap))
    

gdp_pop_bycontinents_byyear <- gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
              sd_gdpPercap=sd(gdpPercap),
              mean_pop=mean(pop),
              sd_pop=sd(pop))

head(gdp_pop_bycontinents_byyear)


#  COUNT
gapminder %>%
    filter(year == 2002) %>%
    count(continent, sort = F)
# obtener el error estandar de la esperanza por continente

gapminder %>%
    group_by(continent) %>%
    summarize(se_pop = sd(lifeExp)/sqrt(n()))
#  Tambien se pueden encadenar juntas varias operaciones de resumen
#  Se calcula minimo, maximo, media y esperanza de vida para cada continente

gapminder %>%
    group_by(continent) %>%
    summarize(
        mean_le = mean(lifeExp),
        min_le =min(lifeExp),
        max_le=max(lifeExp)
        )
             

#  MUTATE
# Se pueden crear nuevas variables antes de resumir la informacion

# primero crea una nueva columna con el producto de dos columnas
# luego agrupa por continente y año
# Posteriormente obitene una nueva variable
#  llamada media la cual es la media 
# por continte por año, asi que en una fecha
# obtiene la media de los paises de un determinado 
# continente 
gdp_pop_bycontinents_byyear <- gapminder %>%
    mutate(gdp_billion=gdpPercap*pop/10^9) %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
              sd_gdpPercap=sd(gdpPercap),
              mean_pop=mean(pop),
              sd_pop=sd(pop),
              mean_gdp_billion=mean(gdp_billion),
              sd_gdp_billion=sd(gdp_billion))
    

#  Conectando mutate con filtrado logico
#  calcular renta per capita solo para gente con una esperanza
#   de vida por encima de 25 
gdp_pop_bycontinents_byyear_above25 <- gapminder %>%
    mutate(gdp_billion = ifelse(lifeExp > 25, gdpPercap * pop / 10^9, NA)) %>%
    group_by(continent, year) %>%
    summarize(mean_gdpPercap = mean(gdpPercap),
              sd_gdpPercap = sd(gdpPercap),
              mean_pop = mean(pop),
              sd_pop = sd(pop),
              mean_gdp_billion = mean(gdp_billion),
              sd_gdp_billion = sd(gdp_billion))


## actualizando sólo si se cumple una determinada condición
# para esperanzas de vida por encima de 40 años, el GDP que se espera en el futuro es escalado
gdp_future_bycontinents_byyear_high_lifeExp <- gapminder %>%
    mutate(gdp_futureExpectation = ifelse(lifeExp > 40, gdpPercap * 1.5, gdpPercap)) %>%
    group_by(continent, year) %>%
    summarize(mean_gdpPercap = mean(gdpPercap),
              mean_gdpPercap_expected = mean(gdp_futureExpectation))
#  Reto Avanzado
# Calcular la esperanza de vida media en 2002 de dos paises al azar
# para cada continente
# Luego distribuye los nombres en orden inverso 

# Aplica filtro 
# Agrupa por continente
#  selecciona de forma aleatoria 2 elementos

lifeExp_2countries_bycontinents <-gapminder %>%
    filter(year==2002) %>%
    group_by(continent) %>%
    sample_n(1) %>%
    summarize(mean_lifeExp=mean(lifeExp)) %>%
    arrange(desc(mean_lifeExp))

