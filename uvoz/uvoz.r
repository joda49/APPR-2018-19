source('lib/libraries.r', encoding = 'UTF-8')

loc <- locale(encoding = 'UTF-8', decimal_mark = '.', grouping_mark = ',')

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

#Tabela 4

zaposlenost_2018 <- filter(zaposlenost_skupaj, Drzava != 'EU')
zaposlenost_2018 <- filter(zaposlenost_2018, Leto == '2018')
zaposlenost_2018 <- zaposlenost_2018[,-3]
zaposlenost_2018 <- zaposlenost_2018[,-1]

#Tabela 5

bdp <- read_csv('podatki/bdp.csv', col_names = c('Leto', 'Drzava', 'brisi', 'brisi1', 'bdppc'),
                locale=loc, na = c(':', ''), skip = 1)


bdp <- bdp[,-4]
bdp <- bdp[,-3]
bdp$Drzava <- gsub("^Germany.*", 'Germany', bdp$Drzava)
bdp$Drzava <- gsub("^European.*", 'EU', bdp$Drzava)


