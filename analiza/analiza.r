source('lib/libraries.r', encoding = 'UTF-8')

#Regresija 

zaposlenost_EU <- filter(zaposlenost_skupaj, Drzava == 'EU')
zaposlenost_EU <- filter(zaposlenost_EU, Leto != 2008, Leto != 2009, Leto != 2010, Leto != 2011, Leto != 2012, )
zaposlenost_EU <- zaposlenost_EU[,-3]

prileganje <- lm(data = zaposlenost_EU, Procent ~ Leto)

l <- data.frame(Leto=seq(2019, 2022, 1))
napoved <- mutate(l, Procent=predict(prileganje, l))

graf_regresija <- ggplot(zaposlenost_EU, aes(x=Leto, y=Procent)) +
  geom_smooth(method=lm, fullrange = TRUE, color = 'blue') +
  geom_point(data=napoved, aes(x=Leto, y=Procent), color = 'red', size=3) +
  geom_point() 