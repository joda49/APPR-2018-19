library(dplyr)
library(readr)
library(tidyr)
library(reshape2)

#Tabela 1

zaposlenost <- read.csv('podatki/zaposlenost_mladi.csv', encoding = 'UTF-8', na = c(':',''), 
                        col.names = c('Leto', 'Drzava', 'age', 'unit', 'Spol', 'popu', 'Procent'))
zaposlenost <- zaposlenost[,-6]
zaposlenost <- zaposlenost[,-4]
zaposlenost <- zaposlenost[,-3]

zaposlenost$Drzava <- gsub("^Germany.*", 'Germany', zaposlenost$Drzava)
zaposlenost$Drzava <- gsub("^European.*", 'EU', zaposlenost$Drzava)

#Tabela 2

zaposlenost_skupaj <- read.csv('podatki/zaposlenost_skupaj.csv', encoding = 'UTF-8', na = c(':',''), 
                        col.names = c('Leto', 'Drzava', 'age', 'unit', 'Spol', 'popu', 'Procent'))
zaposlenost_skupaj <- zaposlenost_skupaj[,-6]
zaposlenost_skupaj <- zaposlenost_skupaj[,-4]
zaposlenost_skupaj <- zaposlenost_skupaj[,-3]

zaposlenost_skupaj$Drzava <- gsub("^Germany.*", 'Germany', zaposlenost_skupaj$Drzava)
zaposlenost_skupaj$Drzava <- gsub("^European.*", 'EU', zaposlenost_skupaj$Drzava)

#Tabela 3

zaposlenost_vse <- rbind(zaposlenost, zaposlenost_skupaj)
