# Respuestas correctas:
#   
#   1. Cargue el csv 'Chile_core.csv' y guardelo en un objeto de nombre 'm'. Al cargar el csv, considere que la primera columna son los nombres de las filas.
# 

 m <- read.csv('Chile_core.csv', row.names = 1)
 
 
# 2. Converta su objeto 'm' en matriz, guardándolo nuevamente como 'm'.
 
# 

 m <- as.matrix(m)
 
 
# 3. Convierta 'm' en un grafo llamado 'g'. Los ejes deben ser ponderados y no-direccionados.

 g <- graph.adjacency(m, weighted = TRUE, mode = 'undirected')
 
# 4. Hay una guerra civil, y usted tiene que encontrar a alguien que le ayude a negociar la paz. ¿Qué medida de centralidad utiliza?
#   
 degree();eigen_centrality();betweenness();closeness()
 
 
# 5. La pandemia terminó y usted quiere ir a todas las fiestas. ¿Qué medida de centralidad usa para amigar personas estratégicamente?
#   
 
 degree();eigen_centrality();betweenness();closeness()
 
# 6. Imprima el grado de todos los nodos de g.
# 
degree(g)


# 7. Use el algoritmo de louvain para detectar comunidades en g. Guarde el resultado en el objeto com_g
# 
com_g <- cluster_louvain(g)


# 8. Imprima los nombres de la comunidad detectada número 1
# 
com_g[[1]]

# 9. Realice un plot simple de g
# 
 plot(g)

# 10. Ahora haga un plot de g sin etiquetas, con vertices de tamaño de acuerdo al grado (degree(g)), con vértices de color rojo y con ancho de eje ponderado de acuerdo al atributo E(g)$weight
# 
 plot(g, vertex.label = NA, vertex.size = degree(g), vertex.color = 'red', edge.width = E(g)$weight)
 
# Registro de respuestas.
# 
# Yes;No