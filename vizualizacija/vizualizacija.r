source('lib/libraries.r', encoding = 'UTF-8')

## Uvozimo zemljevid Sveta
## source("https://raw.githubusercontent.com/jaanos/APPR-2018-19/master/lib/uvozi.zemljevid.r")
#source("lib/uvozi.zemljevid.r") #Nastavi pravo datoteko

#svet <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
#                        "ne_50m_admin_0_countries") %>% fortify()


## Zemljevid sveta skrčimo na zemljevid Evrope
#europe <- filter(svet, CONTINENT == "Europe")
#europe <- filter(europe, long < 55 & long > -35 & lat > 30 & lat < 85)

#europe <- filter(europe, NAME != "Jersey")
#europe <- filter(europe, NAME != "Russia")

## Drzave v zemljevidu Evrope
#drzave <- unique(europe$NAME) 
#drzave <- as.data.frame(drzave, stringsAsFactors=FALSE) 
#names(drzave) <- "Drzava"

#Graf zaposlenosti

graf_zaposlenost <- ggplot(data = filter(zaposlenost_vse, Drzava == 'Slovenia' | Drzava == 'Austria' | Drzava == 'Croatia'),
                           mapping = aes(x=Leto, y=Procent, color=Spol, Group=Drzava)) +
  geom_line() +
  facet_wrap(Drzava~., ncol = 4)

