source('lib/libraries.r', encoding = 'UTF-8')

#Regresija 

zaposlenost_EU <- filter(zaposlenost_skupaj, Drzava == 'EU')
zaposlenost_EU <- filter(zaposlenost_EU, Leto != 2008, Leto != 2009, Leto != 2010, Leto != 2011, Leto != 2012)
zaposlenost_EU <- zaposlenost_EU[,-3]

prileganje <- lm(data = zaposlenost_EU, Procent ~ Leto)

l <- data.frame(Leto=seq(2019, 2022, 1))
napoved <- mutate(l, Procent=predict(prileganje, l))

graf_regresija <- ggplot(zaposlenost_EU, aes(x=Leto, y=Procent)) +
  geom_smooth(method=lm, fullrange = TRUE, color = 'blue') +
  geom_point(data=napoved, aes(x=Leto, y=Procent), color = 'red', size=3) +
  geom_point() 


#Razvrščene skupine

bdp1 <-dcast(bdp, Drzava~Leto, value.var = 'bdppc')
bdp1 <-filter(bdp1, Drzava != 'EU')
bdp2 <- bdp1[,-12]
bdp2 <- bdp2[,-1]

n <- 6
fit <- hclust(dist(scale(bdp2)))
skupine <- cutree(fit, n)

cluster <- mutate(bdp1, skupine)
cluster <- cluster[,-2:-12]

#Zemljevid z cluster

# Drzave v zemljevidu Evrope
drzave <- unique(europe$NAME) 
drzave <- as.data.frame(drzave, stringsAsFactors=FALSE) 
names(drzave) <- "Drzava"

skupaj <- left_join(drzave, cluster, by='Drzava')

zemljevid_cluster <- ggplot() + geom_polygon(data=left_join(europe, skupaj, by=c("NAME"="Drzava")),
                                                 aes(x=long, y=lat, group=group, fill=factor(skupine))) +
  geom_line() +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  guides(fill=guide_colorbar(title="Procent zaposlenosti")) +
  ggtitle("Zaposlenost mladih v 2018") +
  labs(x = " ") +
  labs(y = " ") +
  scale_fill_brewer(palette = 'Spectral', na.value = '#e0e0d1')
