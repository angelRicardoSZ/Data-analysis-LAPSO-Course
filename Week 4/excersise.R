rm(list = ls())  # limpiar memoria

setwd("C:/Users/wabng/Documents/Data science/Curso LAPSO/Week 4")


# DEFINIMOS DOS VECTORES DE 5 ELEMENTOS CADA UNO 
poker_vector <- c(140, -50, 20, -120, 240)

roulette_vector <- c(-24, -50, 100, -350, 10)

total_daily <- poker_vector + roulette_vector

total_daily

total <- sum(total_daily)

total

poker_vector[3]

poker_midweek <- poker_vector[2:4]

poker_midweek


selection_vector <- poker_vector > 0
selection_vector

poker_winning_days <-poker_vector[selection_vector]  

poker_winning_days