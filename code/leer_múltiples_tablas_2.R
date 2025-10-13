# OBJETIVO: Leer todos los archivos en la carpeta data/anc_envir y unirlos en 
# un solo data.frame

require(dplyr)
require(tidyr)
require(ggplot2)

list.files(
  path = "data/anc_catches/", 
  pattern = "\\.csv$", 
  full.names = TRUE
) |> 
  
  lapply(FUN = read.csv) |> 
  
  # lapply(FUN = colnames)
  
  bind_rows() |> 
  
  # summary()
  
  pivot_longer(
    cols = -date,
    names_to = "tipo",
    values_to = "valor"
  ) |> 
  
  # pull(tipo) |> unique() |> sort()
  
  pull(tipo) |> table()
  
  mutate(
    tipo = factor(
      x = tipo, 
      levels = LETTERS[1:15],
    )
  )
  