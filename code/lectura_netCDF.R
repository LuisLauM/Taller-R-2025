
# Descargar archivos-ejemplo ----------------------------------------------

# Archivo 1
require(rerddap)

info(datasetid = "erdMBsstdmday_LonPM180")

archivo1 <- griddap(datasetx  = "erdMBsstdmday_LonPM180", 
                    fields    = "sst",
                    time      = c("2023-01-01T12:00:00Z", "2024-01-01T12:00:00Z"), 
                    latitude  = c(-15, -2), 
                    longitude = c(-85, -74),
                    store     = disk("raw/lectura/"),
                    read      = FALSE)

file.rename(from = archivo1$summary$filename, 
            to = "raw/2023_01 (enero 2023).nc")


# Archivo 2
require(reticulate)

entorno <- "DescargaCopernicus"

virtualenv_create(envname = entorno)

virtualenv_install(envname = entorno, packages = "copernicusmarine")

use_virtualenv(virtualenv = entorno, required = TRUE)

atributos_cms <- import(module = "copernicusmarine")

atributos_cms$subset(
  dataset_id        = "cmems_mod_glo_phy-thetao_anfc_0.083deg_P1D-m",
  variables         = list("thetao"),
  minimum_longitude = -85,
  maximum_longitude = -74,
  minimum_latitude  = -15,
  maximum_latitude  = -2,
  start_datetime    = "2023-03-01T00:00:00",
  end_datetime      = "2023-03-31T00:00:00",
  minimum_depth     = 0,
  maximum_depth     = 110,
  output_filename   = "raw/lectura/archivo2.nc",
  force_download    = TRUE
)

# Lectura rápida: terra ---------------------------------------------------

require(terra)

# Archivo 1
rast(x = "raw/2023_01 (enero 2023).nc")

rast(x = "raw/2023_01 (enero 2023).nc") |> plot()

rast(x = "raw/2023_01 (enero 2023).nc")[[1]] |> 
  
  plot(range = c(15, 30),
       fun = \(x){
         maps::map(add = T)
       },
       xlim = c(-85, -80),
       ylim = c(-6, -4))


rast(x = "raw/sst_peru_ejemplo1.nc", subds = "thetao", lyrs = 1:5)

# Archivo 2
rast(x = "raw/lectura/archivo2.nc")

rast(x = "raw/lectura/archivo2.nc") |> plot()

rast(x = "raw/lectura/archivo2.nc")[[1]] |> plot()



# Lectura avanzada: ncdf4 -------------------------------------------------

require(ncdf4)

# Cargar metadata de archivo
archivoNC <- nc_open(filename = "raw/lectura/archivo2.nc")

# Leer los datos (completos)
datosNC <- ncvar_get(nc = archivoNC, varid = "thetao")

# Cerrar metadatos
nc_close(nc = archivoNC)





# Mostrar dimensiones del arreglo de los datos
dim(datosNC)

# Obtener una lista XYZ
datosXYZ <- list(x = archivoNC$dim$longitude$vals,
                 y = archivoNC$dim$latitude$vals,
                 z = datosNC[,,1,1])

# Plot 1: Usando image
image(datosXYZ, asp = 1)

# Plot 2: Usando image.plot de paquete fields
fields::image.plot(datosXYZ, asp = 1)

# Plot 3: Usando método plot de terra
rast(x = datosXYZ) |> plot()

