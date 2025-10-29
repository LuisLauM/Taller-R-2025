require(sf)
require(qgisprocess)
require(readxl)
require(dplyr)

# Leer datos de ejemplo
datos <- read_excel(
  path = "data/coordenadas_YGranda.xlsx",
  sheet = 1
) |> 
  
  # Renombrar columnas
  rename(
    lon = ZONA_LONGITUD_REAL,
    lat = ZONA_LATITUD_REAL
  )

# Convertir datos a un objeto sf
datos_validos_sf <- datos |> 
  
  # Mantener aquellas filas sin NA en lon y lat
  filter(complete.cases(lon, lat)) |> 
  
  # Convertir df a objeto sf
  st_as_sf(
    # Indicar columnas de coordenadas
    coords = c("lon", "lat"),
    
    # Indicar sistema de coordenadas (4326: WGS84)
    crs = 4326
  )

datos_validos_sf

class(datos_validos_sf)

# st_layers(dsn = "data/shapefiles/PER-eez/eez.shp")
peru_eez <- st_read(
  dsn = "C:/Users/demersales1/Documents/shapefiles/PER-eez/eez.shp",
  layer = "eez"
)

peru_eez

plot(x = peru_eez)

plot(x = peru_eez[,1])

table(peru_eez$mrgid)



# Objetivo 01 -------------------------------------------------------------
# Obtener un subset con aquellos puntos que caen dentro de la EEZ-Perú

# A partir del df datos
datos_dentro_eez <- datos_validos_sf |> 
  
  # Filtrar solo aquellos puntos que caen dentro del polígono peru_eez
  st_filter(y = peru_eez[,1])

# Mostrar número de filas y columnas de tabla obtenida
dim(x = datos_dentro_eez)


# Graficar todos los puntos
plot(
  x = datos$lon, 
  y = datos$lat, 
  pch = 16,
  cex = 0.5,
  asp = 1
)

# Agregar bordes de la EEZ de Perú
plot(
  x = peru_eez[,1], 
  add = TRUE, 
  border = "dodgerblue2", 
  col = "transparent",
  lwd = 2
)

# Agregar puntos dentro de la EEZ en color verde
plot(
  x = datos_dentro_eez,
  add = TRUE,
  col = "forestgreen",
  pch = 16,
  cex = 0.5
)



# Objetivo 02 -------------------------------------------------------------
# Ubicar cuáles puntos están dentro (y cuáles fuera) de la EEZ-Perú 

datos_en_eez <- datos_validos_sf |> 
  
  # Cruzar puntos y polígono de peru_eez
  st_join(y = peru_eez[,1])

datos_en_eez

table(is.na(datos_en_eez$mrgid))



# Objetivo 03 -------------------------------------------------------------
# Generar un buffer a partir de un punto

set.seed(123)

datos_buffer_1 <- datos_validos_sf |> 
  
  # Mantener aquellas filas sin NA en lon y lat
  filter(complete.cases(lon, lat)) |> 
  
  slice(sample(x = seq(nrow(datos_validos_sf)), size = 50)) |>
  
  # Convertir df a objeto sf
  st_as_sf(
    # Indicar columnas de coordenadas
    coords = c("lon", "lat"),
    
    # Indicar sistema de coordenadas (4326: WGS84)
    crs = 4326
  ) |> 
  
  # Generar buffer definiendo distancia en metros
  st_buffer(dist = 5e4)


datos_buffer_1
  
plot(x = datos_buffer_1, col = "transparent")  


# Objetivo 03 -------------------------------------------------------------
# Generar un buffer a partir de un polígono

# st_layers(dsn = "data/shapefiles/gadm41_PER.gpkg")
peru_1 <- st_read(
  dsn = "data/shapefiles/gadm41_PER.gpkg", 
  layer = "ADM_ADM_0"
)

plot(x = peru_1)


# Método 1: usando solo sf
datos_buffer_2_1 <- peru_1 |> 
  
  st_buffer(dist = 5e4, joinStyle = 2)

plot(
  x = peru_1[,1], 
  col = "transparent", 
  reset = FALSE
)

plot(
  x = datos_buffer_2_1[,1], 
  col = "transparent", 
  add = TRUE, 
  border = "blue",
  lwd = 2
)


# Método 2: usando sf + qgisprocess
# https://docs.qgis.org/3.40/en/docs/user_manual/processing_algs/qgis/vectorgeometry.html#buffer
datos_buffer_2_2 <- qgis_run_algorithm(algorithm = "native:buffer", 
                                       INPUT = peru_1,
                                       DISTANCE = 5e4/(1852*60),
                                       DISSOLVE = TRUE,
                                       .quiet = TRUE) |> 
  
  qgis_extract_output() |> 
  
  st_read()

# Original
plot(
  x = peru_1[,1], 
  col = "transparent", 
  reset = FALSE
)

# sf + qgisprocess
plot(
  x = datos_buffer_2_2[1,1], 
  col = "transparent", 
  add = TRUE, 
  border = "tomato",
  lwd = 2
)

# sf
plot(
  x = datos_buffer_2_1[,1], 
  col = "transparent", 
  add = TRUE, 
  border = "blue",
  lwd = 2
)



# Objetivo 04 -------------------------------------------------------------
# Generar un buffer a partir de una línea

# st_layers(dsn = "data/shapefiles/peru_coastline.gpkg")
peru_1_coastline <- st_read(
  dsn = "data/shapefiles/peru_coastline.gpkg", 
  layer = "cortado"
)

plot(x = peru_1_coastline[1])

datos_buffer_3_1 <- peru_1_coastline |> 
  
  st_buffer(dist = 5e4)


# Original
plot(
  x = peru_1_coastline[1], 
  reset = FALSE
)

# sf 
plot(
  x = datos_buffer_3_1, 
  col = "transparent", 
  add = TRUE, 
  border = "blue",
  lwd = 2
)


# Método 2: usando sf + qgisprocess
datos_buffer_3_2 <- qgis_run_algorithm(algorithm = "native:buffer", 
                                       INPUT = peru_1_coastline[1],
                                       DISTANCE = 5e4/(1852*60),
                                       DISSOLVE = TRUE,
                                       .quiet = TRUE) |> 
  
  qgis_extract_output() |> 
  
  st_read()

# Original
plot(
  x = peru_1_coastline[1], 
  reset = FALSE,
  col = "black"
)

# sf + qgisprocess
plot(
  x = datos_buffer_3_2, 
  col = "transparent", 
  add = TRUE, 
  border = "tomato",
  lwd = 2
)

# sf
plot(
  x = datos_buffer_3_1, 
  col = "transparent", 
  add = TRUE, 
  border = "blue",
  lwd = 2
)


# Objetivo 05 -------------------------------------------------------------
# Averiguar qué puntos de 'datos_validos_sf' se encuentran dentro de las 5 mn

datos_eez_5mn <- datos_validos_sf |> 
  
  # Cruzar puntos y polígono de peru_eez
  st_join(y = peru_eez[,1]) |> 
  
# Cruzar puntos y polígono de 5mn
  st_join(y = datos_buffer_3_2)


# Crear una columna llamada 'eez_5mn' en donde sea TRUE en aquellas filas que:
# pertenezcan a la EEZ de Perú Y que caigan dentro de las 5 mn de distancia 
datos_eez_5mn$eez_5mn <- !is.na(datos_eez_5mn$mrgid) & !is.na(datos_eez_5mn$GID_0)

table(index)

plot(
  x = datos_validos_sf[,1], 
  pch = 16, 
  cex = 0.5,
  col = "black",
  reset = FALSE
)

plot(
  x = datos_eez_5mn[index,],
  pch = 16, 
  cex = 0.5,
  col = "firebrick2",
  add = TRUE
)


# Objetivo 06 -------------------------------------------------------------
# Crear un multipolígono de distancias 5, 10, 20 y 100 mn y evaluar qué puntos
# de datos_validos_sf caen dentro de cada 

