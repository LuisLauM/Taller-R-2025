rm(list = ls()); gc(reset = TRUE)
# apply -------------------------------------------------------------------

# EJEMPLO 1
# Cargar datos de ejemplo 1
?beaver1

View(beaver1)

# Obtener valores medios por columna (Modo 1)
mean(beaver1[,1])
mean(beaver1[,2])
mean(beaver1[,3])
mean(beaver1[,4])

# Obtener valores medios por columna (Modo 2)
for(luis in seq(ncol(beaver1))){
  print(mean(beaver1[,luis]))
}

# Obtener valores medios por columna (Modo 3): función apply
apply(X = beaver1, MARGIN = 2, FUN = mean)

# Obtener valores medios por fila
apply(X = beaver1, MARGIN = 1, FUN = mean)

# EJEMPLO 2
miArreglo <- array(data = seq(200), dim = c(10, 5, 4))

prtint(miArreglo)

# Calcular promedios a nivel de la tercera dimensión
apply(X = miArreglo, MARGIN = c(1, 2), FUN = mean)

# Calcular promedios a nivel de la segunda dimensión
apply(X = miArreglo, MARGIN = c(1, 3), FUN = mean)

# Calcular promedios a nivel de la primera y segunda dimensión
apply(X = miArreglo, MARGIN = 3, FUN = mean)


# EJERCICIO 1
require(readxl)

tratamientos <- read_excel(path = "data/Tratamientos.xlsx", 
                           sheet = 1)

# Obtener promedios por fila
apply(X = tratamientos, MARGIN = 1, FUN = mean)

rowMeans(x = tratamientos)

# Obtener sumas por columnas
apply(X = tratamientos, MARGIN = 2, FUN = sum)

colSums(x = tratamientos)

# Calcular prueba de Shapiro-Wilk para tratamiento (columna) 1
shapiro.test(x = tratamientos$T1)

# Calcular prueba de Shapiro-Wilk sobre todos los tratamientos (columnas)
apply(X = tratamientos, MARGIN = 2, FUN = shapiro.test)

# Crear boxplots por cada tratamiento (columna)
par(mfrow = c(2, 3))
apply(X = tratamientos, MARGIN = 2, FUN = boxplot, ylim = c(0, 10))



# EJERCICIO 2

# Cargar datos de ejemplo 2
require(ncdf4)

ncFile <- nc_open(filename = "data/datosNC.nc")
sstData <- ncvar_get(nc = ncFile, varid = "SALINITY")
nc_close(nc = ncFile)

dim(sstData)

# Obtener mapa de TSM del día 15
image((sstData[,,15]), col = terrain.colors(1e3), asp = 1)

# Obtener mapa promedio mensual de SST
promedioMensual <- apply(X = sstData, MARGIN = c(1, 2), 
                         FUN = mean, na.rm = TRUE)

dim(promedioMensual)

image(promedioMensual, col = terrain.colors(1e3), asp = 1)

# Obtener mapa promedio para los primeros 15 días
promedio15dias <- apply(X = sstData[,,1:15], MARGIN = c(1, 2), 
                        FUN = mean, na.rm = TRUE)
image(promedio15dias, col = terrain.colors(1e3), asp = 1)


# Método extra
require(terra)

# Leer datos y cargarlos como un objeto SpatRaster
sstData_2 <- rast(x = "data/datosNC.nc") 

plot(sstData_2)

# Calcular promedio mensual de SST (como un objeto SpatRaster)
app(x = sstData_2, fun = mean, na.rm = TRUE) 

# Calcular promedio de los primeros 15 días de SST (como un objeto SpatRaster)
app(x = sstData_2[[1:15]], fun = mean, na.rm = TRUE) 



# tapply ------------------------------------------------------------------

# EJEMPLO 1
# Cargar datos de ejemplo
data("iris")

summary(iris)

# Obtener valores de mediana de Longitud de S?palos (Sepal.Length) para cada 
# especie (Modo 1)
median(iris$Sepal.Length[iris$Species == "setosa"])
median(iris$Sepal.Length[iris$Species == "versicolor"])
median(iris$Sepal.Length[iris$Species == "virginica"])

# Obtener valores de mediana de Longitud de S?palos (Sepal.Length) para cada 
# especie (Modo 2)
tapply(X = iris$Sepal.Length, 
       INDEX = iris$Species, 
       FUN = median)

# EJEMPLO 2
data("mtcars")

# Calcular promedios de valores de mpg según cyl y carb
tapply(X = mtcars$mpg, 
       INDEX = list(mtcars$cyl, mtcars$carb), 
       FUN = mean)

# EJEMPLO 3
data("airquality")

# Calcular promedios de valores de Ozone según mes (Month)
tapply(X = airquality$Ozone, INDEX = list(airquality$Month), FUN = mean, 
       na.rm = TRUE)

# Calcular pruebas de normalidad según mes (Month)
tapply(X = airquality$Ozone, INDEX = list(airquality$Month), FUN = shapiro.test)


# EJERCICIO 1
# Leer datos de Ejemplo 2: Planilla
positivos <- readxl::read_excel(path = "data/COVID-DB-Peru.xlsx", 
                                sheet = "positivos")

# Identificar valores (removiendo repeticiones) de dos variables
unique(positivos$EDAD)
unique(positivos$DEPARTAMENTO)

# Obtener edad promedio por departamento
tapply(X = positivos$EDAD, 
       INDEX = list(positivos$DEPARTAMENTO),
       FUN = mean, na.rm = TRUE)

# Obtener edad promedio por departamento y sexo
tapply(X = positivos$EDAD, 
       INDEX = list(positivos$DEPARTAMENTO, 
                    positivos$SEXO),
       FUN = mean, na.rm = TRUE)

# Obtener edad máxima por departamento y sexo
tapply(X = positivos$EDAD, 
       INDEX = list(positivos$DEPARTAMENTO, 
                    positivos$SEXO),
       FUN = max, na.rm = TRUE)

# Obtener edad promedio por departamento, sexo y método de diagnóstico
tapply(X = positivos$EDAD, 
       INDEX = list(positivos$DEPARTAMENTO, 
                    positivos$SEXO,
                    positivos$METODODX),
       FUN = mean, na.rm = TRUE)

# *** Truco ***: Funci?n 'with'
with(positivos, 
     tapply(X = EDAD, 
            INDEX = list(DEPARTAMENTO, 
                         SEXO,
                         METODODX),
            FUN = mean, na.rm = TRUE))

# Cantidad de individuos (conteo) por departamento y método de diagnóstico
# Modo 1 (usando tapply)
tapply(X = positivos$EDAD, 
       INDEX = list(positivos$DEPARTAMENTO, 
                    positivos$METODODX),
       FUN = length)

# Modo 2: Usando table
table(positivos$DEPARTAMENTO, 
      positivos$METODODX)


# lapply ------------------------------------------------------------------

# Ejecuta la funci?n indicada y devuelve una lista

# EJEMPLO 1: Obtener clases de cada variable dentro de un data.frame
# Leer datos de Ejemplo: Planilla
positivos <- readxl::read_excel(path = "data/COVID-DB-Peru.xlsx", 
                                sheet = "positivos") |> 
  
  as.data.frame()



View(positivos)

# Modo 1: Usando for
for(i in seq(ncol(positivos))){
  print(class(unlist(positivos[,i])))
}

apply(X = positivos, MARGIN = 2, FUN = class)

# Modo 2: Usando lapply
lapply(X = positivos, FUN = class)

# OJO: lapply ejecuta la operación para cada nivel de la lista (data.frame),
# apply convierte lo definido en una matriz o arreglo 

lapply(X = iris, FUN = class)

apply(X = iris, MARGIN = 2, FUN = class)


# EJEMPLO 2: Leer múltiples archivos de un mismo formato

listaArchivos <- list.files(path = "data/anc_envir/", pattern = ".csv", 
                            full.names = TRUE)

# Modo 1: Usando for
tablaTotal_1 <- NULL
for(i in listaArchivos){
  
  tabla <- read.csv(file = i)
  
  tablaTotal_1 <- rbind(tablaTotal_1, tabla)
}

# dim(tablaTotal_1)

# Modo 2: Usando lapply
tablaTotal_2 <- lapply(listaArchivos, read.csv)

# class(tablaTotal_2)
# 
# length(tablaTotal_2)

tablaTotal_2 <- do.call(what = rbind, args = tablaTotal_2)

# dim(tablaTotal_2)


# sapply ------------------------------------------------------------------

# Similar a lapply, con la salvedad de que sapply buscar? simplificar lo m?s 
# posible el resultado a la estructura más elemental

# lapply
lapply(X = positivos, FUN = class)

# sapply
sapply(X = positivos, FUN = class)

# sapply --> lapply
sapply(X = positivos, FUN = class, simplify = FALSE)


# mapply ------------------------------------------------------------------

?mapply

mapply(FUN = seq, from = c(1, 2, 3), to = c(10, 20, 30), by = 2)

mapply(FUN = seq, from = c(1, 2, 3), to = c(10, 20, 30), by = c(1, 2, 3))

# OJO
mapply(FUN = seq, from = c(1, 2, 3), to = c(10, 20, 60), by = c(1, 2, 3))
