
# Clases importantes ------------------------------------------------------

# numeric (numéricos) 

1

1.456546

pi

# character (cadena de caracteres)

"hola"

"23"

# logical (valores lógicos)

TRUE

FALSE

# Date (fechas)

as.Date(x = "2022-05-07")

as.Date(x = "2022-5-7")

as.Date(x = "7/5/2022", format = "%d/%m/%Y")



# (Algunas) Operaciones disponibles entre clases --------------------------

# numeric (numéricos) 

# Operaciones aritméticas
1 + 2 

1.456546 + 2

1.456546 + 2.54654

pi + 2

pi - 2

pi * 2

pi / 2

pi ^ 2

sqrt(x = 2)

2 ^ (1/2)

2 ^ (1/3)

# Logaritmo de 2 en base 10
log(x = 2, base = 10)

# Logaritmo de 2 en base 5
log(x = 2, base = 5)

# Constante de euler (elevada a la 1)
exp(x = 1)

# Constante de euler elevada al cuadrado
exp(x = 2)

# Constante de euler elevada a la quinta
exp(x = 5)

# Operaciones lógicas

12 > 3

12 < 3

12 == 3

12 >= 3

12 <= 3

# character (cadena de caracteres)

# Pegar dos cadenas de caracteres separadas por un espacio
paste("hola", "23", "mundo")

# Pegar dos cadenas de caracteres sin un separador
paste0("hola", "23", "mundo")

# Pegar dos cadenas de caracteres sin un guion
paste("hola", "23", "mundo", sep = "-")

# logical (valores lógicos)

# Operaciones lógicas (Y)
FALSE & FALSE
FALSE & TRUE

# Operaciones lógicas (O)
FALSE | FALSE
TRUE | TRUE


# Date (fechas)

# Diferencia entre fechas
as.Date(x = "2022-05-10") - as.Date(x = "2022-05-7")

# Operaciones lógicas entre fechas
as.Date(x = "2022-05-10") > as.Date(x = "2022-05-7")

# Promedio de un vector de fechas
mean(c(as.Date(x = "2022-03-10"), as.Date(x = "2022-04-7"), as.Date(x = "2022-07-7")))


# Asignación y creación de objetos ----------------------------------------

# Vectores
numeros <- c(1, 7, 7, 4, 0, 2, 3)

secuencia_1 <- seq(from = 10, to = 100, by = 5)

secuencia_2 <- seq(from = 100, to = 10, by = -5)

secuencia_3 <- seq(from = 10, by = 5, length.out = 10)

secuencia_4 <- 1:13

repetidos_1 <- rep(x = 7, times = 10)

repetidos_2 <- rep(x = c(7, 3), times = 10)

repetidos_3 <- rep(x = c(7, 3), each = 10)

repetidos_4 <- rep(x = c(7, 3), times = c(10, 5))


# Data frames
tabla <- data.frame(numeros = 1:10,
                    palabras = rep(x = c("hola", "mundo"), times = 5),
                    fechas = a)


# Matrices
numeros <- seq(from = 0, to = 60, by = 3)

# Matriz de 3x7 ordenando los valores por columna
matrix(data = numeros, nrow = 7, ncol = 3)

# Matriz de 3x7 ordenando los valores por fila
matrix(data = numeros, nrow = 7, ncol = 3, byrow = TRUE)


# Leer desde archivo de texto ---------------------------------------------

?read.table

# Leer datos separados por comas csv
read.table(file = "data/muestreos_puerto.csv", header = TRUE, sep = ",")

# Leer y mostrar solo las primeras filas
muestreosPuerto <- read.table(file = "data/muestreos_puerto.csv", 
                              header = TRUE, sep = ",")

head(muestreosPuerto)

# Leer y evitar que haga cambios en los nombres de columnas
muestreosPuerto <- read.table(file = "data/muestreos_puerto.csv", 
                              header = TRUE, sep = ",", check.names = FALSE)

head(muestreosPuerto)


# Leer desde texto separado por comas (.csv) ------------------------------
muestreosPuerto2 <- read.csv(file = "data/muestreos_puerto.csv")

View(muestreosPuerto2)


# Leer desde Excel (.xlsx) ------------------------------------------------
# Cargar paquete para la lectura de información desde archivos en Excel
require(readxl)

# Leer archivo
listadoEmbarcaciones <- read_excel(path = "data/listado_embarcaciones.xlsx", sheet = 1)

# Mostrar la cabecera del data frame leído
print(listadoEmbarcaciones)

print(muestreosPuerto)

class(listadoEmbarcaciones)

class(muestreosPuerto)

# Cambiar clase de listadoEmbarcaciones y forzarla a que SOLO sea data.frame
class(listadoEmbarcaciones) <- 'data.frame'

class(listadoEmbarcaciones)


# Mostrar información importante sobre tablas de datos --------------------

# Resumen de las variables leídas
summary(muestreosPuerto2)

# Dimensiones de la tabla de datos
dim(listadoEmbarcaciones)

# Obtener longitud del vector letters
print(letters)
length(letters)


# Indexación y asignación -------------------------------------------------

# Obtener las columnas 1, 10 y 30 del objeto 'muestreosPuerto'
muestreosPuerto[,c(1, 10, 30)]

# Obtener las columnas 1, 10 y 30 del objeto 'muestreosPuerto'
muestreosPuerto[,c(1, 10, 30)]

# Del objeto letters, obtener los elementos 10, 13 y 20
print(letters)
letters[c(10, 13, 20)]

# Obtener un objeto llamado 'bombreBarcos' con la información de la primera columna
# del objeto 'listadoEmbarcaciones'
nombreBarcos <- listadoEmbarcaciones$EMBARCACION

# Obtener un objeto llamado 'eslora' con la información de la primera columna
# del objeto 'listadoEmbarcaciones'
eslora <- listadoEmbarcaciones$ESLORA


# Operaciones básicas -----------------------------------------------------

# Obtener el logaritmo en base 10 de los valores de 'eslora'
log(x = eslora, base = 10)

# Calcular la suma entre los valores de las columnas 30 y 33 de 'muestreosPuerto'
muestreosPuerto[,30] + muestreosPuerto[,33]

# Calcular la suma de los valores de la columna 28 de muestreosPuerto
sum(muestreosPuerto[,28])

# Calcular la suma de los valores de la columna 7 de listadoEmbarcaciones
sum(listadoEmbarcaciones[,7])
sum(listadoEmbarcaciones[,7], na.rm = TRUE)

# Calcular el promedio de los valores de la columna 7 de listadoEmbarcaciones
mean(listadoEmbarcaciones[,7], na.rm = TRUE)

# Calcular el rango de los valores de la columna 7 de listadoEmbarcaciones
range(listadoEmbarcaciones[,7], na.rm = TRUE)


# Indexación por nombre ---------------------------------------------------
# Obtener nombres de columnas
colnames(listadoEmbarcaciones)

# Obtener valores de columna 7: MANGA
listadoEmbarcaciones$MANGA

# Obtener valores de la columna 16: CAPBOD_TM
listadoEmbarcaciones$CAPBOD_TM


# Indexación lógica -------------------------------------------------------

# Indexar las filas en donde los valores de la columna 28 de 'muestreosPuerto'
# sean mayores a 100
indexador <- muestreosPuerto[,28] > 100
muestreosPuerto[indexador,]

# Indexar las filas en donde los valores de la columna 7 de 'listadoEmbarcaciones' 
# sean NA
is.na(c(1, 2, 7, 9, NA, 4))

is.na(x = listadoEmbarcaciones[,7])

respuesta <- listadoEmbarcaciones[is.na(listadoEmbarcaciones[,7]),]

View(respuesta)

# Indexar las filas donde 'listadoEmbarcaciones' NO sea NA y los valores sean 
# mayores a 3
indexador <- !is.na(listadoEmbarcaciones[,7]) & listadoEmbarcaciones[,7] > 3

listadoEmbarcaciones[indexador,]
