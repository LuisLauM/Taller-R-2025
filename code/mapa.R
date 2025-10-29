

# Mapa usando graphics ----------------------------------------------------

# Instalar ruisu
remotes::install_github("LuisLauM/ruisu")

# cargar paquetes
require(ruisu)
require(mapdata)

# Definir límites en ejes X y Y
xlim <- c(-85, -70)
ylim <- c(-20, -2)

# Definir parámetros gráficos generales
par(
  # Distancia entre caja del gráfico respecto a los bordes de la figura
  mar = c(2, 3, 1, 1), 
  
  # Indicar que deseo que NO haya un espacio al inicio y final de los límites en 
  # el gráfico
  xaxs = "i", yaxs = "i"
)


# Crear un gráfico en blanco (lienzo vacío)
plot(
  x = 1, 
  y = 1, 
  type = "n", 
  axes = FALSE, 
  xlab = NA, 
  ylab = NA, 
  xlim = xlim, 
  ylim = ylim
)  

# Añadir un polígono celeste representando el mar
polygon(
  x = rep(xlim, each = 2), 
  y = c(ylim, rev(ylim)), 
  border = FALSE, 
  col = "lightblue1"
)

# Añadir tierra
map(
  database = "worldHires", 
  add = TRUE, 
  fill = TRUE, 
  col = "wheat1", 
  lty = "blank"
)

# Añadir líneas de costa
map(
  database = "worldHires", 
  add = TRUE, 
  interior = FALSE
)

# Añadir puntos de puertos principales a manera de triángulitos rojos
with(
  data = harborData[harborData[,"importance"] == 1,], 
  points(x = lon, y = lat, pch = 17, col = "red")
)

# Añadir nombres de puertos principales a manera de triángulitos rojos
with(
  harborData[harborData[,"importance"] == 1,], 
  text(x = lon, y = lat, labels = name, pos = 4, offset = .5)
)

# Leer datos de coordenadas de ejemplo
read_excel(
  path = "data/coordenadas_YGranda.xlsx",
  sheet = 1
) |> 
  
  # Renombrar columnas
  rename(
    lon = ZONA_LONGITUD_REAL,
    lat = ZONA_LATITUD_REAL
  ) |> 
  
  # Añadir puntos
  with(points(lon, lat, pch = 19, cex = 0.1))



# Añadir etiquetas de ejes X y Y en formato de coordenada
addCoordsAxes(
  xParams = c(xlim, 5), 
  yParams = c(ylim, 2)
)

# Añadir borde de gráfico
box() 
