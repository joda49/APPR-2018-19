source('lib/libraries.r', encoding = 'UTF-8')

# Uvozimo zemljevid Sveta
# source("https://raw.githubusercontent.com/jaanos/APPR-2018-19/master/lib/uvozi.zemljevid.r")
source("lib/uvozi.zemljevid.r") #Nastavi pravo datoteko

svet <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                        "ne_50m_admin_0_countries") %>% fortify()


# Zemljevid sveta skrčimo na zemljevid Evrope
europe <- filter(svet, CONTINENT == "Europe")
europe <- filter(europe, long < 55 & long > -35 & lat > 30 & lat < 85)

europe <- filter(europe, NAME != "Jersey")
europe <- filter(europe, NAME != "Russia")
europe <- filter(europe, NAME != 'Ukraine')
europe <- filter(europe, NAME != 'Belarus')
europe <- filter(europe, NAME != 'Moldova')

# Drzave v zemljevidu Evrope
drzave <- unique(europe$NAME) 
drzave <- as.data.frame(drzave, stringsAsFactors=FALSE) 
names(drzave) <- "Drzava"

skupaj <- left_join(drzave, zaposlenost_2018, by='Drzava')

zemljevid_zaposlenost <- ggplot() + geom_polygon(data=left_join(europe, skupaj, by=c("NAME"="Drzava")),
                                                 aes(x=long, y=lat, group=group, fill=Procent)) +
  geom_line() +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  guides(fill=guide_colorbar(title="Procent zaposlenosti")) +
  ggtitle("Zaposlenost mladih v 2018") +
  labs(x = " ") +
  labs(y = " ") +
  scale_fill_gradient(low = "grey", high = "blue",
                      space = "Lab", na.value = "#e0e0d1", guide = "black",
                      aesthetics = "fill")



#Graf zaposlenosti

graf_zaposlenost <- ggplot(data = filter(zaposlenost_vse, Drzava == 'Slovenia' | Drzava == 'Switzerland' | Drzava == 'Austria' | Drzava == 'Croatia' | Drzava == 'Hungary' | Drzava == 'Germany' | Drzava == 'Netherlands' | Drzava == 'Norway'| Drzava == 'Iceland' | Drzava == 'Bulgaria' | Drzava == 'Romania' | Drzava == 'Portugal' | Drzava == 'Spain' | Drzava == 'EU' | Drzava == 'Italy' | Drzava == 'United Kingdom'),
                           mapping = aes(x=Leto, y=Procent, color=Spol, Group=Drzava)) +
  geom_line() +
  facet_wrap(Drzava~., ncol = 4)

