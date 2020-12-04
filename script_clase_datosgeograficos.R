library(sf)
library(dplyr)
library(ggplot)

###########################################################################################################TABLA DE MESAS ELECTORALES----
#cargamos las mesas electorales
#Datos fueron compilados por Gonzalo Díaz (@gdiazc) aquí: https://docs.google.com/spreadsheets/d/1VvyP0VzwbLQn8_GK1UneTc2Zp4cFQrVN4wybPFQXArI/edit#gid=412975894
#mesas_pleb <- read.csv('plebiscito_2020_mesa.csv', encoding = 'UTF-8')
##mesas_pleb <- mesas_pleb %>% filter(region == 'METROPOLITANA DE SANTIAGO')
#colnames(mesas_pleb)
#mesas_pleb$local <- gsub("LOCAL.*", "", mesas_pleb$local)
#mesas_pleb$local <- trimws(mesas_pleb$local)
#unique(mesas_pleb$local)
#mesas_pleb$geo_loc <- paste0(mesas_pleb$local, ', ', mesas_pleb$comuna, ', REGION METROPOLITANA, CHILE')

#dejamos solo comunas urbanas
#comunas_urbanas <- read.csv('https://gist.githubusercontent.com/jsajuria/6e9e1654e27775997b5d6402372a06e8/raw/29b387a220192fcc63d6a00ffc2670ccd3f235c8/controles_comunas.csv',encoding = 'UTF-8')
#comunas_urbanas$comuna <- toupper(comunas_urbanas$comuna)
#comunas_urbanas$comuna <- chartr("ÁÉÍÓÚ", "AEIOU", comunas_urbanas$comuna)
#comunas_urbanas <- comunas_urbanas %>% filter(Rural == 0)
#mesas_pleb <- mesas_pleb %>% filter(comuna %in% comunas_urbanas$comuna)

###########################################################################################################GEOCODIFICAR MESAS ELECTORALES----
#Usamos la API de google maps para geolocalizar locales de votación
#para hacer esto tú mismx, necesitarás una API de Google Maps que puedes obtener registrándote en https://developers.google.com/maps/documentation/geocoding/overview
#library(ggmap)
#register_google(key = 'KEY_GOOGLE')
#geocoded_locales <- geocode(unique(mesas_pleb$geo_loc), output = 'all')
#lat <- unlist(lapply(geocoded_locales, function(x) x$results[[1]]$geometry$location$lat))
#lon <- unlist(lapply(geocoded_locales, function(x) x$results[[1]]$geometry$location$lng))
#precision <- unlist(lapply(geocoded_locales, function(x) x$results[[1]]$geometry$location_type))
#geocoded_locales_df <- tibble(local = unique(mesas_pleb$geo_loc),lat = lat,lon = lon, precision = precision)
#write.csv(geocoded_locales_df, 'geocoded_locales_df.csv', row.names = FALSE)

###########################################################################################################JUNTAMOS GEOCÓDIGOS A TABLA BASE----
locales_latlon <- read.csv('geocoded_locales_df.csv')

#hacemos join con la tabla grande
mesas_pleb <- left_join(mesas_pleb, locales_latlon, by = c("geo_loc" = "local"))
mesas_pleb$apruebo_prop <- mesas_pleb$apruebo/mesas_pleb$votantes
mesas_pleb$rechazo_prop <- mesas_pleb$rechazo/mesas_pleb$votantes
#write.csv(mesas_pleb, 'mesas_pleb.csv', row.names = FALSE)

###########################################################################################################MICRODATOS CENSO 2017----
#cargamos mapa microdatos censo 2017
micro_C17 <- st_read("microdatos_C17/Manzana_2017_2.shp")
micro_C17 <- micro_C17 %>% filter(PROVINCIA == "SANTIAGO")
micro_C17 <- st_transform(micro_C17, crs = 4326)
micro_C17$COMUNA <- chartr('ÁÉÍÓÚ', 'AEIOU', micro_C17$COMUNA)
colnames(micro_C17)

#mapa vacío
ggplot(data = micro_C17 %>% filter(COMUNA %in% c('SANTIAGO', 'PROVIDENCIA'))) +
  geom_sf()

#rellenamos por alguna variable
ggplot(data = micro_C17 %>% filter(COMUNA %in% 'MAIPU')) +
  geom_sf(aes(fill = TOTAL_PERS))

###########################################################################################################MESAS ELECTORALES----
#Ploteamos comunas seleccionadas
ggplot(data = micro_C17) +
  geom_sf()+
  geom_point(data = mesas_pleb, aes(x = lon, y = lat, color = rechazo_prop), size = 3)


