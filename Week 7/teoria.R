# Manipulacion de cadenas de caracteres 
rm(list=ls()) 
# Para juntar cadenas de caracteres 
setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 7")

### PASTE()
cadena <- c("hola","amigo")

unido <-paste(cadena)

# Si queremos agregar un caracter a cada elemento 
paste(cadena,"angel",sep ="-")

# Ahora si queremos unir las dos oraciones 
paste(cadena,"angel",sep = "?",collapse = "/")

###  String es uno de los parquetes mas utilizados para
###  manipular cadenas de caracteres 

##  las funciones comienzan con la estructura str_
##  se puede usar str_sub para extraer partes de una cadena 
library(stringr)
library(foreign)
df <-  read.dbf("concentradohogar.dbf", as.is = TRUE)
head(df)
##  Ejemplo

    #extraer los primero 2 digitos de la variable folioviv de 
    # la base de datos de inegi y crear una columna con 
    # esos dos digiitos
df$ent <- str_sub(df$folioviv,1,2)

## Manipulacion de los espacios de las cadenas 
#   str_pad    sirve para poner espacios para que la cadena 
#   tenga una longitud determinada 

cadena <- c("arbol","dog","cat")

str_pad(cadena,5)
# si lo queremos espaciado 
str_pad(cadena,5,"both")

# str_trim hace lo contrario
cadena2 <- c("  dos ", "   cuatro ", "   one  ")
str_trim(cadena2,"right")

#  Existen funciones para cambiarentre mayusculas y minusculas 

cadenam <- "Una Cadena Con Mayusculas"

cadenam %>% str_to_upper()

cadenam %>% str_to_lower()

cadenam %>% str_to_title()


# Separar cadenas de caracteres 
##  str_split 
# separa la cadena en un patron especificado 
#  Regresa una lista, por lo que ponemos simplify=TRUE 
#  para obtener una matriz 
#   n determina el numero de elementos que debe separar 

cadena3 <- c("UNAM/CIDE/ITAM", "UAM/TEC/IBERO")
str_split(cadena3, pattern = "/", n=2)

str_split(cadena3, pattern = "/", simplify = T)


# Expresiones regulares
#  ^.[\d]+

# INICIO DE LA CADENA 
# ^ "^fa"      indica que tome lo que inicia con fa
#  FIN DE LA CADENA 
# $   "do$"    que termine con do 

#  CUALQUIER CARACTER 
#  .   "ar.a" puede ser arma ar7a maria Mariana

# Caracter alfabetico 
#  [A-z]  ejemplo "[A-z]re" identifica barrera pero no "ca4re"

#  Caracter alfanumerico 
# [A-z0-9]  "[A-z0-9]re"      identifica "barrera" y "ca4re"
#   pero no "d¡re"

#Alternado 
#   Syntaxis    (?:cad1|cad2) 
#   Ejemplo      "10(?:pm|am)"  Identifica 10pm o 10 am pero no 10kg

# identificar espacios 
# \s    ejemplo  "10\s"  identifica "10 vasos" pero no "551018"
#   es decir identifica 10 antes de un espacio


#  identificar una cadena especifica con un caracter mas de una vez
#  #+#  lo que esta a la izquierda es lo que puede 
#  estar una o mas veces 
#  ejemplo  "s+uma" identificara "suma", "massuma" pero no bruma

#  Alguno o ninguno 
#  "s*uma"  identifica "suma" y "uma"

#  Identificar un numero especifico de repeticiones
#{n}   ejemplo "a{4}"  identifica vaaaas pero no vaaas

# digito 
#  \equivalente a [0-9] 
#  "\d55" identifica "755"  pero no a55


#  str_detect  regresa un vector de logicos con TRUE en los casos
#  que el patron se encuentre en la cadena de caracteres 
#  y con FALSE en el caso contrario

# str_count regresa el numero de veces que se encontro el patron


# Ejemolo 

# queremos identificar en cuales elementos si tenemos telefonos
phones <- c("55 34 47 06 41",
            "5534854789",
            "edgar71@lapso-mx.org",
            "personal:5534412265 y oficina:8770502361")

busqueda <- "([0-9]{2}[- .]*){5}"  # numero del cero al nueve 
# dos veces, seguido por un guion, espacio o punto 
#  alguna o ninguna vez, y que se repita 5 veces ese patron


#Ahora se busca ese patron 
str_detect(phones, busqueda)

str_count(phones,busqueda)

# extraer caracteres con patron 
str_extract_all(phones,busqueda)


# reemplazar alguna cadena 

phonesanonymous <-str_replace_all(phones, busqueda, "XX-XX-XX-XX-XX")






