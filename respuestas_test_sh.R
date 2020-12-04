# Respuestas correctas:
#   
#   1. Inspeccione el head de la tabla 'resultados'.
# 
# head(resultados)
# 2. Inspeccione el head de la tabla 'locales'.
# 
# head(locales)
# 3. Construya una variable 'llave' para la tabla 'resultados' que siga la misma estructura de texto que la variable 'llave' de la tabla 'locales'. Para lograr esto, debe utilizar la funcion 'paste0(...)' y unir las variables correspondientes
# 
# resultados$llave <- paste0(resultados$local, ', ', resultados$comuna, ', ', resultados$region, ', ', resultados$pais)
# 4. Utilizando un 'left_join', genere una nueva tabla de nombre 'resultados_geo' a partir de las tablas 'resultados' y 'locales'. Recuerde que si las variables con las cuales va a unir las tables ('llave') tienen el mismo nombre, no es necesario definir el argumento 'by'.
# 
# resultados_geo <- left_join(resultados, locales)
# 5. Con la funcion View(...) inspeccione la tabla 'resultados_geo'. Una vez abierta la tabla en una nueva ventana, no la cierre para que pueda inspeccionarla durante las siguientes preguntas.
# 
# View(resultados_geo)
# 6. Cargue los limites comunales del archivo 'COMUNA_C17.shp' ubicado en la carpeta 'shapes' en un objeto de nombre 'shapes'
# 
# shapes <- st_read('shapes/COMUNA_C17.shp')
# 7. Elimine los tildes de la variable 'shapes$NOM_COMUNA'.
# 
# shapes$NOM_COMUNA <- chartr('ÁÉÍÓÚ', 'AEIOU', shapes$NOM_COMUNA)
# 8. Filtre el objeto 'shapes' dejando solo los casos en donde la variable 'NOM_COMUNA' se encuentren en 'resultados_geo$comuna'
# 
# shapes <- filter(shapes, NOM_COMUNA %in% resultados_geo$comuna)
# 9. Grafique los limites comunales, ponga un punto en cada mesa y coloreelo segun la variable 'rechazo_prop'. Recuerde realizar esta operacion en una linea, por ejemplo: ggplot(...) + geom_sf(...) + geom_point(...)
# 
# ggplot(data = shapes) + geom_sf() +geom_point(data = resultados_geo, aes(x = lon, y = lat, color = rechazo_prop))
# Registro de respuestas.
# 
# Yes;No