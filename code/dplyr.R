require(dplyr)
require(tidyr)

# El operador pipe %>% (Ctrl + Shift + M)


# EJERCICIO 1 -------------------------------------------------------------

# Leer archivo
messydata <- read_excel(path = "data/messydata.xlsx", sheet = 1, 
                        range = "B4:M18", col_names = FALSE)

# Generar nombres de columnas para variables de tratamiento-grupo
groupNames <- expand.grid(1:4, 1:2)
groupNames <- paste0("T", groupNames$Var1, "_G", groupNames$Var2)

# Modificar nombre de columnas
colnames(messydata) <- c("nombre", "edad_sexo", groupNames, "lon", "lat")

tidydata <- messydata %>%

  # Remover aquellas filas en donde la suma de presencias de NA sea igual a la
  # cantidad de columnas  
  filter_all(any_vars(!is.na(.))) %>% 
  
  # Remover las filas con información calculada
  filter(tolower(nombre) != "promedio") %>% 
  
  # Separar valores de variable edad_sexo en dos variables independientes
  separate_wider_delim(cols = edad_sexo, names = c("edad", "sexo"), delim = "-") %>% 
  
  # Reordenar tabla
  gather(key = "TG", value = "densidad", starts_with("T")) %>% 
  
  # Separar valores de variable TG
  separate_wider_delim(cols = TG, names = c("tratamiento", "grupo"), delim = "_") %>% 
  
  # Añadir edad categorizada
  mutate(edad_cat = cut(x = tidydata$edad, 
                        breaks = seq(from = 20, to = 60, by = 10)))
  
boxplot(densidad ~ edad_cat, data = tidydata)


# EJERCICIO 2 -------------------------------------------------------------

# Leer datos de Ejemplo: Desembarques
desembarques <- read_excel(path = "data/desembarques.xlsx", sheet = 1)

ejemplo_1 <- desembarques %>% 
  
  # Convertir fecha a clase Date
  mutate(fecha = as.Date(fecha)) %>% 
  
  # Indicar la variable de agrupación
  group_by(fecha) %>% 
  
  # Realizar agrupación sobre todas las columnas
  summarize_all(sum)

View(ejemplo_1)

ejemplo_2 <- mtcars %>% 
  
  # Indicar la variable de agrupación
  group_by(cyl, carb) %>% 
  
  # Realizar agrupación sobre todas las columnas
  summarize_all(mean)

View(ejemplo_2)


# EJERCICIO 3 -------------------------------------------------------------

# Leer base de datos de desembarques y embarcaciones
desembarques <- readxl::read_excel(path = "data/embarcaciones_desembarques.xlsx", 
                                   sheet = "Desembarques")

embarcaciones <- readxl::read_excel(path = "data/embarcaciones_desembarques.xlsx", 
                                    sheet = "Embarcaciones")

ejemplo_3 <- desembarques %>% 
  
  # Combinar variables de carcaterísticas de 'embarcación' a cada fila de 'desembarque'
  left_join(y = embarcaciones, by = c("matrícula" = "MATRICULA"))

