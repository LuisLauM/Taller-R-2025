require(dplyr)

# Definir una cantidad de filas para data frame ejemplo
n <- 1e7


# Crear un data frame de ejemplo basado en variable de airquality ---------

# Definir un valor semilla (replicabilidad)
set.seed(333)

# Para cada columna de airquality
bigData <- lapply(airquality, sample, size = n, replace = TRUE)

# Convertir objeto resultante (lista) en un data frame
bigData <- as.data.frame(bigData)

# Añadir una variable con las primeras 5 letras 
bigData$tipo <- sample(x = LETTERS[1:5], size = n, replace = TRUE)


# Combinar dos data frames ------------------------------------------------

# Crear data frame ejemplo para cruzar datos
infoTipos <- data.frame(tipo = LETTERS[1:5],
                        mes = month.name[1:5],
                        costo = seq(from = 100, to = 500, by = 100))

# Combinar data frames usando 'merge'
combinacion_1 <- merge(x = bigData, y = infoTipos, by = "tipo")

# Combinar data frames usando 'left_join'
combinacion_2 <- left_join(x = bigData, y = infoTipos, by = "tipo")

# Mostrar resumen de ambos resultados
summary(combinacion_1)
summary(combinacion_2)


# Aplicar una función sobre datos agrupados -------------------------------

# Usando aggregate
agrupados_1 <- aggregate(x = bigData[,-7], 
                         by = list(Mes = bigData$Month), 
                         FUN = median, na.rm = TRUE)

# Usando group_by y summarise_all
agrupados_2 <- bigData %>% 
  
  select(-tipo) %>% 
  
  group_by(Month) %>% 
  
  summarise_all(median, na.rm = TRUE)
