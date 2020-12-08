# Carga bibliotecas relevantes
library(sf)
library(dplyr)
library(ggplot2)

# Define working directory, MODIFICAR SEGUN LOCALIZACION DE ARCHIVOS SHAPE
setwd("C:/Users/fathe/Documents/R/tarea3/")

# Carga archivo shp a dataframe df
df <- st_read("Areas_Pobladas.shp")
summary(df)

# Filtra columnas y las copia a nuevo dataframe
nunoa <- filter(df, comuna == "Ñuñoa")

# Define tema oscuro para ggplot
theme_set(theme_bw())

# Plotea dataframe nunoa
ggplot(data = nunoa) +
  geom_sf(color = "black", fill ="pink") +
  xlab("Longitud") + ylab("Latitud") +
  ggtitle("Mapa de zonas pobladas en Ñuñoa", subtitle = "Según datos de la BCN")
