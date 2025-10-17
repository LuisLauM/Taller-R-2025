require(rerddap)

# Obtener información de la fuente
info(datasetid = "erdMBsstdmday_LonPM180")


# Descarga de un archivo único --------------------------------------------

# Ejecutar descarga
griddap(datasetx  = "erdMBsstdmday_LonPM180", 
        fields    = "sst",
        time      = c("2010-01-01", "2021-01-01"), 
        latitude  = c(-7, -3), 
        longitude = c(-83, -79),
        store     = disk("raw/erddap/"),
        read      = FALSE) 

# Ojo: existe siempre un límite de tamaño para una descarga (usualmente de 2 GB)


# Verificar descarga
require(terra)

rast(x = "raw/erddap/<nombrealeatorio>.nc") |> 
  
  plot()


# Descarga de múltiples archivos ------------------------------------------

fechas <- seq(from = as.Date("2010-1-1"), 
              to = as.Date("2021-1-1"), 
              by = "year")

for(i in seq(length(fechas) - 1)){
  
  outFile <- sprintf(fmt = "raw/erddap/%s.nc", 
                     format(x = fechas[i], format = "%Y"))
  
  if(file.exists(outFile)) next
  
  # Realizar descarga y almacenar información en un objeto
  info_descarga <- griddap(datasetx  = "erdMBsstdmday_LonPM180", 
                           fields    = "sst",
                           time      = as.character(c(fechas[i], fechas[i + 1] - 1)), 
                           latitude  = c(-15, -2), 
                           longitude = c(-85, -74),
                           store     = disk("raw/erddap/"),
                           read      = FALSE) 
  
  file.rename(from = info_descarga$summary$filename, to = outFile)
  
  Sys.sleep(3)
}


# Verificar descarga
require(terra)

rast(x = "raw/erddap/2015.nc") |> 
  
  plot()
