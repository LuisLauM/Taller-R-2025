
# Pasos previos -----------------------------------------------------------

require(reticulate)

# Instalar python (ejecutar SOLO SI es que NO está previamente instalado)
# install_python()

# Definir un nombre para nuestro entorno virtual python
entorno <- "DescargaCopernicus"

virtualenv_create(envname = entorno)

virtualenv_install(envname = entorno, packages = "copernicusmarine")

use_virtualenv(virtualenv = entorno, required = TRUE)

# El entorno virtual debería haberse creado en 
# C:/Usuarios/nombreususario/Documentos/.virtualenvs/

# Atributos del módulo 'copernicusmarine'
atributos_cms <- import(module = "copernicusmarine")

# Definir en atributos los nombres de usuario y contraseña
# atributos_cms$login("usuario", "contraseña")


# Descarga de archivo único -----------------------------------------------

# Definir atributos para la descarga
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
  maximum_depth     = 0.5,
  output_filename   = "raw/sst_peru_ejemplo1.nc",
  force_download    = TRUE
)

# Mostrar todas las opciones disponibles
atributos_cms$subset

# OJO: Para los nombres de las variables sí importan las mayúsculas-minúsculas

# Verificar descarga
require(terra)

rast(x = "raw/sst_peru_ejemplo1.nc") |> 
  
  plot()


# Descarga de múltiples archivos ------------------------------------------

fechas <- seq(from = as.Date("2023-1-1"), 
              to = as.Date("2023-12-31"), 
              by = "month")

for(i in seq(length(fechas) - 1)){
  atributos_cms$subset(
    dataset_id        = "cmems_mod_glo_phy-thetao_anfc_0.083deg_P1D-m",
    variables         = list("thetao"),
    minimum_longitude = -85,
    maximum_longitude = -74,
    minimum_latitude  = -15,
    maximum_latitude  = -2,
    start_datetime    = format(x = fechas[i], format = "%Y-%m-%dT00:00:00"),
    end_datetime      = format(x = fechas[i + 1] - 1, format = "%Y-%m-%dT00:00:00"),
    minimum_depth     = 0,
    maximum_depth     = 0.5,
    output_filename   = sprintf("raw/%s.nc", format(x = fechas[i], format = "%Y_%m (%B %Y)")),
    force_download    = TRUE
  ) 
}
