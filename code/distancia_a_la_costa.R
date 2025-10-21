
# Distancia a la costa: Método 0 ------------------------------------------

require(terra)
require(dplyr)

puntosRefCosta <- read.csv(file = "data/peru_pts.csv")

puntosEjemplo <- read.csv(file = "data/lonlat_pts.csv")

distancias <- distance(x = as.matrix(puntosEjemplo), 
                       y = as.matrix(puntosRefCosta), 
                       unit = "km", lonlat = TRUE)

dim(distancias)

# Distancia mínima en Km
distancias_metodo0 <- apply(X = distancias, MARGIN = 1, FUN = min)


# Gráfico de distancias

# Crear un lienzo vacío
plot(1, 1, type = "n", axes = FALSE, xlab = NA, ylab = NA, 
     xlim = c(-85, -70), ylim = c(-20, -2), asp = 1)


# Añadir lineas de costa 
maps::map(add = TRUE, interior = FALSE)

# Añadir bordes de figura
box()

# Añadir puntos
points(x = puntosEjemplo$lon, y = puntosEjemplo$lat, pch = 16)

# Tomar los datos de puntosRefCosta...
puntosRefCosta |> 
  
  # Calcular y seleccionar aquellas filas en donde se obtuvo la distancia menor
  slice(apply(X = distancias, MARGIN = 1, FUN = which.min)) |> 
  
  # Adjuntar coordenadas de puntosEjemplo
  bind_cols(puntosEjemplo) |> 
  
  # Dibujar segmentos entre cada punto y el punto en tierra en donde se alcanzó 
  # la mínima distancia
  apply(MARGIN = 1, 
        FUN = \(x, ...) lines(x = x[c(1, 3)], y = x[c(2, 4)], ...),
        col = "red")




# Distancia a la costa: Método 1 ------------------------------------------

require(terra)
require(sf)

coord_ref <- "+proj=longlat +datum=WGS84 +no_defs"

distancias_metodo1 <- distance(x = puntosEjemplo |> vect(crs = coord_ref),
                               y = puntosRefCosta |> vect(crs = coord_ref), 
                               unit = "km") |> 
  
  apply(MARGIN = 1, FUN = min)


# Gráfico de comparación entre Método 0 y Método 1

distancias_metodo1/distancias_metodo0

plot(x = distancias_metodo0, y = distancias_metodo1, asp = 1)
abline(a = 0, b = 1, col = "red")


# Distancia a la costa: Método 2 ------------------------------------------

require(rerddap)

# Ejecutar descarga
distcostaraster <- griddap(datasetx  = "dist2coast_1deg_ocean", 
                           fields    = "dist",
                           latitude  = c(-20, 0), 
                           longitude = c(-100, -70),
                           store     = disk("raw/"),
                           read      = FALSE) 

# Renombrar archivo
file.rename(from = distcostaraster$summary$filename, 
            to = "raw/dist_costa.nc")

# Leer netCDF con valores de distancia a la costa
distancias_metodo2 <- rast(x = "raw/dist_costa.nc") |> 
  
  # Extraer valores de distancia a la costa
  extract(y = puntosEjemplo) |> 
  
  # Obtener valores de la columna de distancia
  pull(dist)


# Gráfico de comprobación entre Método 0 y Método 1 

plot(x = distancias_metodo0, y = distancias_metodo2, asp = 1)
abline(a = 0, b = 1, col = "red")


# Distancia a la costa: Método 3 ------------------------------------------

# NOTAS:
# - Este método requiere de terra en su versión >=1.8-7
# - Si aún no se encuentra disponible en CRAN, puede descargarse desde Github:
#   remotes::install_github(repo = "rspatial/terra", force = TRUE)
# - Hasta la versión 1.8-7 (probada el 2025-01-07), este método es aún algo 
#   lento, por lo que NO se recomienda su uso para grandes cantidades de puntos.

require(terra)

# Check layers of Peruvian polygon dataset
sf::st_layers(dsn = "data/gadm41_PER.gpkg")

# Read main polygon of Peru
peru <- vect(x = "data/gadm41_PER.gpkg", 
             layer = "ADM_ADM_0")

# Convert lon/lat coordinates 
distancias_metodo3 <- read.csv(file = "data/lonlat_pts.csv") |> 
  
  # Convert to SpatVector object specifying the projection (WGS84)
  vect(crs = "EPSG:4326") |> 
  
  # Calculate distances in km
  distance(y = peru, unit = "km")



# Gráfico de comprobación entre Método 0 y Método 3
plot(x = distancias_metodo0, y = distancias_metodo3, asp = 1)
abline(a = 0, b = 1, col = "red")


# Gráfico de comprobación entre Método 2 y Método 3
plot(x = distancias_metodo2, y = distancias_metodo3, asp = 1)
abline(a = 0, b = 1, col = "red")
