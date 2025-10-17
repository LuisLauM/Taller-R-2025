rm(list = ls()); gc(reset = TRUE)

# Leer datos botánicos
datosBotanicos <- read.csv(file = "data/Botanical_DB.txt")
modelos <- rownames(mtcars)


# Concatenar cadenas (función paste) --------------------------------------

# Función paste

paste("Luis", "Wencheng", "Lau", "Medrano")

paste("Luis", "Wencheng", "Lau", "Medrano", sep = "--")

paste("Luis", "Wencheng", "Lau", "Medrano", sep = "")

paste0("Luis", "Wencheng", "Lau", "Medrano")


miNombre <- c("Luis", "Wencheng", "Lau", "Medrano")

paste(miNombre, "--[OK]")

paste0(miNombre, "--[OK]")

paste(miNombre, collapse = "--")

paste(miNombre, collapse = " ")

campos <- c("Nombres", "Apellidos", "Afiliación", "Curso")
llenado <- c("Luis Wencheng", "Lau Medrano", "Cousteau Consultant Group", "AlwaysR")

paste(campos, llenado, sep = ": ")

# Obtener el siguiente formato: Nombre común [Símbolo]
paste0(datosBotanicos$Common.Name, " [", 
       datosBotanicos$Symbol, "]")



# Concatenar cadenas (función sprintf) ------------------------------------

sprintf(fmt = "Nombres y apellidos: %s", "Wencheng Lau Medrano")

sprintf(fmt = "Nombres: %s, Apellidos: %s", 
        "Luis Wencheng", "Lau Medrano")

sprintf(fmt = "Número: %04d", 7)

sprintf("%04d", 70)

sprintf("%04d", 700)

sprintf("%04d", 7000)

sprintf("%04d", 70000)

sprintf("%.2f", pi)

sprintf("%.20f", pi)

sprintf("%10.4f", pi)




# Separar cadenas (función strsplit) --------------------------------------

strsplit(
  x = modelos, 
  split = "R"
)

strsplit(
  x = "Luis Wencheng Lau Medrano", 
  split = "\\."
) |> 
  
  unlist()



# Obtener vector de género de especies
nombresCientificos <- strsplit(
  x = datosBotanicos$Scientific.Name.with.Author, 
  split = " "
)

# Método 1
longitud <- length(nombresCientificos)
generos_1 <- NULL
for(i in seq(longitud)){
  
  nombreTemp <- nombresCientificos[[i]]
  
  generos_1 <- c(generos_1, nombreTemp[1])
}

head(generos_1)


# Método 2
generos_2 <- character(length = longitud)
for(i in seq(longitud)){
  
  nombreTemp <- nombresCientificos[[i]]
  
  generos_2[i] <- nombreTemp[1]
}

head(generos_2)


# Método 3
generos_3 <- sapply(X = nombresCientificos, FUN = "[", 1)

head(generos_3)



# Separar cadenas (función substr) ----------------------------------------

substr(
  x = modelos, 
  start = 1, 
  stop = 4
)

substr(
  x = modelos, 
  start = 4, 
  stop = 8
)


# Contar caracteres -------------------------------------------------------

# Funci?n nchar
?nchar

nchar(modelos)


# Detectar presencia de sub cadena ----------------------------------------

# Funci?n grep
?grep

grep(x = modelos, pattern = "Mazda")

grep(x = modelos, pattern = "Merc")

# Generar un vector con las posiciones en donde aparece un cadena
index <- grep(x = modelos, pattern = "Merc")

mtcars[index,]

# Funci?n grepl
index <- grep(x = modelos, pattern = "Merc")

mtcars[index,]

index <- grepl(x = modelos, pattern = "D")

mtcars[index,]

index <- grepl(x = modelos, pattern = "D", ignore.case = TRUE)

mtcars[index,]


# Reemplazar caracteres ---------------------------------------------------

nombre <- "Sofía Verónica Ñañez Agüero"

# Cambiar a min?sculas/may?sculas
tolower(nombre)
toupper(nombre)

# Reeemplazar caracteres espec?ficos por caracteres espec?ficos
chartr(x = tolower(nombre), 
       old = "áéíóúüñ", 
       new = "aeiouun")


# Reemplazar cadenas ------------------------------------------------------

?gsub

gsub(x = modelos, pattern = "Merc", replacement = "Meche")

gsub(x = modelos, pattern = "c", replacement = "$$$", ignore.case = TRUE)


###########################################################################
# REGULAR EXPRESSIONS -----------------------------------------------------
###########################################################################

# https://en.wikibooks.org/wiki/R_Programming/Text_Processing
# https://www.r-bloggers.com/regular-expressions-every-r-programmer-should-know/


# Verificar existencia de patrones en cadenas -----------------------------

nombresComunes <- datosBotanicos$Common.Name
nombresCientificos <- datosBotanicos$Scientific.Name.with.Author

# Identificar aquellos elementos que contengan 'maple' 
index <- grep(x = nombresComunes, pattern = "maple")

nombresComunes[index]


# Identificar aquellos elementos que EMPIECEN con 'maple' 
index <- grep(x = nombresComunes, pattern = "^maple")

nombresComunes[index]


# Identificar aquellos elementos que TERMINEN con 'maple' 
index <- grep(x = nombresComunes, pattern = "maple$")

nombresComunes[index]


# Identificar aquellos elementos que contengan ÚNICAMENTE con 'maple' 
index <- grep(x = nombresComunes, pattern = "^maple$")

nombresComunes[index]


# Identificar aquellos elementos que contengan 'maple' o empiecen con 'red' 
index <- grep(x = nombresComunes, pattern = "(maple)|(^red)")

nombresComunes[index]

# Identificar aquellos elementos que contengan 'maple' o empiecen con 'red' 
index <- grepl(x = nombresComunes, pattern = "(maple)|(^red)")

nombresComunes[index]

# Identificar aquellos elementos que contengan 'maple' y empiecen con 'red' 

# Método 1
index_1 <- grepl(x = nombresComunes, pattern = "maple")
index_2 <- grepl(x = nombresComunes, pattern = "^red")

nombresComunes[index_1 & index_2]

# Método 2
index <- grep(x = nombresComunes, pattern = "^red.*maple")
nombresComunes[index]

which(index_1 & index_2) # averiguar las posiciones en donde sucede esos casos



# Identificar aquellos elementos que contengan números
index <- grepl(x = nombresCientificos, pattern = "[[:digit:]]")

nombresCientificos[index]


# Identificar aquellos elementos que contengan números seguidos de una coma
index <- grepl(x = nombresCientificos, pattern = "[[:digit:]],")

nombresCientificos[index]

# Identificar aquellos elementos que contengan puntos
index <- grepl(x = nombresCientificos, pattern = "\\.")

nombresCientificos[index]

# Identificar aquellos elementos que contengan palabras entre paréntesis
index <- grepl(x = nombresCientificos, pattern = "\\(.*\\)")

nombresCientificos[index]


# Identificar aquellos elementos que contengan palabras de tres caracteres 
# Ejemplo: 'red', 'spp.', etc.

# Intento 0
index <- grepl(
  x = nombresComunes, 
  pattern = "[[:alpha:]]{3}", 
  ignore.case = TRUE
)

sum(index)

nombresComunes[index]


# Intento 1
index <- grepl(
  x = nombresComunes, 
  pattern = " [[:alpha:]]{3} ", 
  ignore.case = TRUE
)

sum(index)

nombresComunes[index]


# Intento 2
index <- grepl(
  x = nombresComunes, 
  pattern = "( [[:alpha:]]{3} )|(^[[:alpha:]]{3} )", 
  ignore.case = TRUE
)

sum(index)

nombresComunes[index]


# Intento 3
index <- grepl(
  x = nombresComunes, 
  pattern = "( [[:alpha:]]{3} )|(^[[:alpha:]]{3} )|( [[:alpha:]]{3}$)", 
  ignore.case = TRUE
)

sum(index)

nombresComunes[index]


# Extra -------------------------------------------------------------------

# Identificar aquellos elementos que contengan palabras de tres caracteres y
# reemplazar esas palabras por +++

gsub(
  x = nombresComunes[1:10],
  pattern = "( [[:alpha:]]{3} )|(^[[:alpha:]]{3} )|( [[:alpha:]]{3}$)", 
  replacement = "zzz",
  ignore.case = TRUE
)



# Ubicar posiones de patrones dentro de cadenas ---------------------------

head(modelos)

gregexpr(text = head(modelos), pattern = "a")

index <- gregexpr(text = head(modelos), pattern = "a")


