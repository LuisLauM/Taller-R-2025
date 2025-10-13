
# OBJETIVO: Leer todos los archivos en la carpeta data/anc_envir y unirlos en 
# un solo data.frame


# Método 1 ----------------------------------------------------------------

# Leer archivos
archivo_01 <- read.csv(file = "data/anc_envir/anc-sst_2000.csv")
archivo_02 <- read.csv(file = "data/anc_envir/anc-sst_2001.csv")

# ...la vida entera...

archivo_16 <- read.csv(file = "data/anc_envir/anc-sst_2015.csv")

compilado_1 <- rbind.data.frame(archivo_01, archivo_02, archivo_16)

View(compilado_1)



# Método 2 ----------------------------------------------------------------

# Obtener un vector con las rutas de todos los archivos
archivos <- list.files(
  path = "data/anc_envir/", 
  pattern = "\\.csv$", 
  full.names = TRUE
)

# Crear un bucle para la lectura individual de cada archivo y su almacenamiento
# provisional como elementos de una lista
compilado_prov <- list()
for(i in seq_along(archivos)){
  compilado_prov[[i]] <- read.csv(file = archivos[i])
}

# Compilar todos los elementos
compilado_2 <- do.call(
  what = rbind.data.frame, 
  args = compilado_prov
)


# Método 3-1 --------------------------------------------------------------

# Obtener un vector con las rutas de todos los archivos
archivos <- list.files(
  path = "data/anc_envir/", 
  pattern = "\\.csv$", 
  full.names = TRUE
)

# Lectura individual de cada archivo y su almacenamiento provisional como 
# elementos de una lista
compilado_prov <- lapply(X = archivos, FUN = read.csv)

# Compilar todos los elementos
compilado_3_1 <- do.call(
  what = rbind.data.frame, 
  args = compilado_prov
)


# Método 3-2 --------------------------------------------------------------

# Obtener un vector con las rutas de todos los archivos
compilado_3_2 <- list.files(
  path = "data/anc_envir/", 
  pattern = "\\.csv$", 
  full.names = TRUE
) |> 
  
  # Lectura individual de cada archivo y su almacenamiento provisional como 
  # elementos de una lista
  lapply(FUN = read.csv) |> 

  # Compilar todos los elementos  
  do.call(
    what = rbind.data.frame
  )
