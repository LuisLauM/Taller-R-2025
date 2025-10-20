# aggregate ---------------------------------------------------------------

mtcars

mtcars$cyl

aggregate(x = mtcars, by = list(mtcars$cyl), FUN = mean)

aggregate(x = mtcars, by = list(mtcars$cyl), FUN = sum)

aggregate(x = mtcars, by = list(mtcars$cyl), FUN = range)

mtcars$carb

aggregate(x = mtcars, by = list(mtcars$cyl, mtcars$carb), FUN = mean)

aggregate(x = mtcars, 
          by = list(Cilindrada = mtcars$cyl,  
                    n_carburadores = mtcars$carb), 
          FUN = mean)

?iris

aggregate(x = iris, by = list(Especies = iris$Species), mean)

head(iris)

dim(iris)

aggregate(x = iris[,-5], by = list(Especies = iris$Species), mean)



# Leer datos de Ejemplo: Desembarques
desembarques <- readxl::read_excel(path = "data/desembarques.xlsx", sheet = 1)
class(desembarques) <- "data.frame"

View(desembarques)

# Verificar la cantidad de filas por día
table(desembarques$fecha)

# Obtener ?ndice de columnas de especies
index <- grep(x = colnames(desembarques), pattern = "^spp")

# Compilar (sumar) desembarques por día
aggregate(x = desembarques[,index], by = list(desembarques$fecha), FUN = sum)

# Generar columna de mes-a?o
require(zoo)
desembarques$mes_ano <- as.yearmon(desembarques$fecha)

# Compilar (sumar) desembarques por mes-a?o
aggregate(x = desembarques[,index], by = list(desembarques$mes_ano), FUN = sum)


# merge -------------------------------------------------------------------

# Usar data frame iris con información morfométrica de algunas especies de lirios
iris

# Obtener valores únicos (sin duplicados) de la variable 'Species'
unique(iris$Species)

# crear un data frame con información adicional
# OJO: una de las variables (Species) tendrá como fin servir de columna pivote
datosSpp <- data.frame(Species = c("setosa", "versicolor", "virginica"),
                       especialista = c("Briggitthe", "Lynn", "Joaquina"),
                       precio = c(40, 50, 60))

# Realizar la combinación de ambas tablas usando Species como columna pivote
merge(x = datosSpp, y = iris, by = "Species")




# Integra variables de dos data frames, en base a una (o unas) variables de 
# combinaci?n

require(readxl)

# Leer base de datos de desembarques y embarcaciones
desembarques <- read_excel(path = "data/embarcaciones_desembarques.xlsx", 
                                   sheet = "Desembarques")

embarcaciones <- read_excel(path = "data/embarcaciones_desembarques.xlsx", 
                            sheet = "Embarcaciones")

# Combinar tablas de datos teniendo en cuenta que la columna pivote tiene 
# diferentes nombres en cada data.frame
dbCombinada <- merge(x = desembarques, y = embarcaciones, 
                     by.x = "matrícula", by.y = "MATRICULA", all.x = TRUE)

View(dbCombinada)



require(dplyr)

desembarques |> 
  
  left_join(
    y = embarcaciones, 
    by = c("matrícula" = "MATRICULA")
  )




























