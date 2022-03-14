setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 11")

library(rvest)

library(dplyr)

html <- read_html("https://admissions.calpoly.edu/prospective/profile.html") 
prim.t <- html %>%  html_nodes("table") %>% .[[2]] 
prim.t %>% html_table()


URL <- "https://www.amazon.com.mx/b/ref=s9_acss_bw_cg_CS_2b1_w?ie=UTF8&node=9784573011&pf_rd_m=A3TO6F13CSVUA4&pf_rd_s=merchandised-search-5&pf_rd_r=9XA9HKGT4TAED22RZW6A&pf_rd_t=101&pf_rd_p=c880d6e9-69fc-4402-acc0-2e3d6a3e84d5&pf_rd_i=9784530011"


titulos <- read_html(URL) %>% 
    html_nodes("h2.a-size-base.s-inline.s-access-title.a-text-normal") %>%
    html_text()
precios <- read_html(URL) %>% 
    html_nodes("span.a-size-base.a-color-price.s-price.a-text-bold") %>% html_text()
df <- data.frame(titulos)
df

df2 <- data.frame(precios)

head(df2)


URLs <- "https://deportes.mercadolibre.com.mx/bicicletas-ciclismo/bicicletas/_Desde_"

for (i in c(1,51)) {
    titulos <- read_html(paste(URLs, i, sep="")) %>% 
        html_nodes("span.main-title") %>%
        html_text()
    precios <- read_html(paste(URLs, i, sep="")) %>% 
        html_nodes("span.price__fraction") %>% html_text()
    df <- bind_rows(df, data.frame(titulos, precios))
    print(paste("Termina elemento ", i, sep=""))
}

rm(list=ls())