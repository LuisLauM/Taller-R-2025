
# Leer y ordenar ----------------------------------------------------------

# Cargar paquetes necesarios
require(readxl)
require(dplyr)
require(tidyr)

# Leer archivo de Excel
datos <- read_excel(
  # Definir ruta del archivo
  path = "data/messydata.xlsx",
  
  # Definir hoja (número: posición, caracter: nombre de la hoja)
  sheet = 1,
  
  # Definir rango de celdas a leer
  range = "B4:M18",
  
  # Indicar que NO se desea que se tome la primera línea leída como nombre de columnas
  col_names = FALSE
) |> 
  
  # Definir nombres de columnas
  setNames(
    nm = c("nombres", "edad_sexo",
           "g1_t1", "g1_t2", "g1_t3", "g1_t4",
           "g2_t1", "g2_t2", "g2_t3", "g2_t4",
           "lon", "lat")
  ) |> 
  
  # Mantener solo aquellas filas en donde...
  filter(
    # NO haya valores vacíos en la columna 'nombres'
    !is.na(nombres), 
    
    # La columna 'nombres' NO tenga el valor 'Promedio'
    nombres != "Promedio"
  ) |> 
  
  # Reorganizar columnas de grupo-tratamiento
  pivot_longer(
    # Definir columnas a reorganizar
    cols = g1_t1:g2_t4,
    
    # Definir el patrón de los valores en los nombres de dichas columnas
    names_pattern = "g(.)_t(.)",
    
    # Definir los nombres de las columnas nuevas
    names_to = c("grupo", "tratamiento"),
    
    # Definir el nombre de la columna que contendrá los valores
    values_to = "valor"
  ) |> 
  
  # Separar valores de la columna sexo-edad
  separate_wider_delim(
    # Definir columna a separar
    cols = edad_sexo,
    
    # Definir el caracter que separa los valores
    delim = "-",
    
    # Definir los nombres de las columnas nuevas
    names = c("edad", "sexo")
  ) |> 
  
  # Editar carcaterísticas de variables ya existentes
  mutate(
    # Convertir a numérico
    edad = as.numeric(edad),
    
    # Convertir a factor
    sexo = factor(x = sexo, levels = c("m", "f"), labels = c("Male", "Female")),
    grupo = factor(x = grupo, levels = 1:2, labels = c("I", "II")),
    tratamiento = factor(x = tratamiento, levels = 1:4)
  )

# Mostrar data.frame ordenado
datos 
View(datos)



# Gráficos rápidos --------------------------------------------------------

require(ggplot2)

# A partir del data.frame 'datos'...
datos |> 
  
  # Usando la interfaz ggplot...
  ggplot() +
  
  # Generar un boxplot
  geom_boxplot(
    mapping = aes(
      # La variable agrupadora en X (categórica)
      x = grupo, 
      
      # La variable de la que se desea obtener el boxplot
      y = valor, 
      
      # Variable categórica adicional para los colores
      fill = tratamiento
    )
  )
