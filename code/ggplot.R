require(ggplot2)


# Scatterplots ------------------------------------------------------------

# Figura básica 01

# Inicializar figura con 'ggplot'
ggplot() +
  
  # Definir tipo de gráfico
  # geom_point: scatterplot
  geom_point(
    # Definir tabla de datos
    data = mtcars, 
    
    # Definir parámetros que cambiarán según una variable
    mapping = aes(
      # Valores de eje X
      x = mpg, 
      
      # Valores de eje Y
      y = wt, 
      
      # Valores que definirán el tipo de punto
      shape = as.factor(cyl)
    )
  )


# Figura básica 02

# Inicializar figura con 'ggplot'
ggplot() +
  
  # Definir tipo de gráfico
  # geom_point: scatterplot
  geom_point(
    # Definir tabla de datos
    data = mtcars, 
    
    # Definir parámetros que cambiarán según una variable
    mapping = aes(
      # Valores de eje X
      x = mpg, 
      
      # Valores de eje Y
      y = wt
    ),
    
    # Definir un tipo de punto fijo
    # Para ver los tipos de puntos disponibles: ?points
    shape = 17
  )



# Figura básica 03

# Inicializar figura con 'ggplot'
ggplot() +
  
  # Definir tipo de gráfico
  # geom_point: scatterplot
  geom_point(
    # Definir tabla de datos
    data = mtcars, 
    
    # Definir parámetros que cambiarán según una variable
    mapping = aes(
      # Valores de eje X
      x = mpg, 
      
      # Valores de eje Y
      y = wt, 
      
      # Valores que definirán el color de puntos
      color = as.factor(cyl)
    )
  )


# Figura básica 04

# Inicializar figura con 'ggplot'
ggplot() +
  
  # Definir tipo de gráfico
  # geom_point: scatterplot
  geom_point(
    # Definir tabla de datos
    data = mtcars, 
    
    # Definir parámetros que cambiarán según una variable
    mapping = aes(
      # Valores de eje X
      x = mpg, 
      
      # Valores de eje Y
      y = wt
    ),
    
    # Definir un color de punto fijo
    color = "red"
  )



ggplot(data = mtcars, aes(x = mpg, y = wt)) +
  
  # shape: modifica tipo de punto
  geom_point(shape = 17)

ggplot(data = mtcars, aes(x = mpg, y = wt)) +
  
  # shape: define un tipo de punto para todos los puntos
  # color: define un color de punto para todos los puntos
  geom_point(shape = 17, color = "red")

# color (dentro de aes): define un color de punto que varía según la variable 
# cyl (tomando esta como una variable CUANTITATIVA numérica)
ggplot(data = mtcars, aes(x = mpg, y = wt, color = cyl)) +
  
  # shape: define un tipo de punto para todos los puntos
  geom_point(shape = 17)

# color (dentro de aes): define un color de punto que varía según la variable 
# cyl (tomando esta como una variable de tipo factor)
ggplot(data = mtcars, aes(x = mpg, y = wt, color = as.factor(cyl))) +
  
  # shape: define un tipo de punto para todos los puntos
  geom_point(shape = 17)

ggplot(data = mtcars, aes(x = mpg, y = wt)) +
  
  # shape: define un tipo de punto para todos los puntos
  # size: define un tamaño de punto para todos los puntos
  geom_point(shape = 17, size = 5)

# size (dentro de aes): define un tamaño de punto que varía según la variable wt
ggplot(data = mtcars, aes(x = mpg, y = wt, size = wt)) +
  
  # shape: define un tipo de punto para todos los puntos
  geom_point(shape = 17)

# size (dentro de aes): define un tamaño de punto que varía según la variable wt
ggplot(data = mtcars, aes(x = mpg, y = wt, size = qsec)) +
  
  # shape: define un tipo de punto para todos los puntos
  geom_point(shape = 17)



# Líneas ------------------------------------------------------------------
 
ggplot(data = mtcars, aes(x = mpg, y = wt)) +

  # 'geom_line' une los puntos con un criterio de izquierda a derecha y de 
  # arriba hacia abajo  
  geom_line()

# Análogo usando graphics
with(mtcars[order(mtcars$mpg),], plot(x = mpg, y = wt, type = "l"))


ggplot(data = mtcars, aes(x = mpg, y = wt)) +

  # 'geom_path' une los puntos respetando el orden en el que aparecen en 'data'
  geom_path()

# Análogo usando graphics
with(mtcars, plot(x = mpg, y = wt, type = "l"))


ggplot(data = mtcars, aes(x = mpg, y = wt)) +
  
  # 'linewidth' (fuera de aes): define un ancho de línea único 
  geom_line(linewidth = 2)

ggplot(data = mtcars, aes(x = mpg, y = wt)) +
  
  # 'color' (fuera de aes): define un color de línea único 
  geom_line(color = "blue")

# 'color' (dentro de aes): define un color de línea dependiente de una variable (am)
ggplot(data = mtcars, aes(x = mpg, y = wt, color = am)) +
  
  geom_line()

# Para averiguar qué parámetros son susceptibles de variar dentro y fuera de aes,
# revisar ?geom_line




# Puntos y líneas ---------------------------------------------------------
 
ggplot(data = mtcars, aes(x = mpg, y = wt)) +
  
  # Añadir puntos
  geom_point() +
  
  # Añadir líneas
  geom_line()
 
ggplot(data = mtcars, aes(x = mpg, y = wt)) +
  
  # Añadir puntos
  geom_point(color = "red") +
  
  # Añadir líneas
  geom_line(color = "blue")

# El orden sí importa
ggplot(data = mtcars, aes(x = mpg, y = wt)) +
  
  # Añadir líneas
  geom_line(color = "blue") +
  
  # Añadir puntos
  geom_point(color = "red") 


# Añadir emojis -----------------------------------------------------------

devtools::install_github("dill/emoGG")

require(emoGG)

ggplot(data = mtcars, aes(x = mpg, y = wt)) +
  
  # Añadir emojis a manera de puntos
  geom_emoji(emoji = "1f41f")



# Barras ------------------------------------------------------------------

ggplot(data = mtcars, aes(x = carb)) +

  # 'geom_bar': muestra el conteo de elementos dentro de la variable dada como x
  # OJO: Si la variable dada es ingresada como numérica, el eje x tendrá ese 
  # comportamiento
  geom_bar()

# Análogo (aproximado) en graphics
# OJO: 'barplot' NO asume un comportamiento numérico en su eje X
barplot(table(mtcars$carb))


ggplot(data = mtcars, aes(x = rownames(mtcars), y = wt)) +
  
  # 'geom_col': devuelve barras usando un enfoque de coordenadas (X y Y)
  # OJO: esta función requiere la definición de parámetros X y Y dentro de aes
  geom_col()



# Boxplot -----------------------------------------------------------------

ggplot(data = mtcars, aes(y = wt)) +
  
  geom_boxplot()

# Definir una variable de agrupamiento a nivel de parámetro X 
ggplot(data = mtcars, aes(x = as.factor(cyl), y = wt)) +
  
  geom_boxplot()

# Definir una variable de agrupamiento a nivel de parámetro X 
ggplot(data = mtcars, aes(y = wt, group = as.factor(cyl))) +
  
  geom_boxplot()

# Definir dos variables de agrupamiento a nivel de parámetros 'x' y 'group' 
ggplot(data = mtcars, aes(x = as.factor(gear), y = mpg, group = as.factor(am))) +
  
  geom_boxplot()



# Ejercicio 1: modificando diversos aspectos en ggplot 
require(dplyr)
require(tidyr)
require(ggplot2)

read.csv(file = "data/cpueTimeSeries.csv") %>%
  
  select(fecha, catch_spp1, catch_spp2) %>%
  
  rename(spp1 = catch_spp1, spp2 = catch_spp2) %>% 
  
  pivot_longer(cols = -fecha, names_to = "especie", values_to = "captura") %>% 
  
  ggplot(aes(x = as.Date(fecha), y = captura, color = as.factor(especie))) +
  
  geom_line(size = 2) +

  # Modificar etiquetas de eje X  
  scale_x_date(name = NULL, 
               date_breaks = "3 months", 
               date_labels = "%b %Y",
               limits = as.Date(c("2010-1-1", "2019-1-1")), 
               expand = c(0, 0),
               minor_breaks = NULL) +
  
  # Modificar etiquetas de eje Y
  scale_y_continuous(name = "Captura (t)", limits = c(0, 21e3), 
                     breaks = seq(from = 0, to = 21e3, by = 5e3),
                     expand = c(0, 0)) +
  
  labs(color = "Especie") +
  
  theme_bw() + 
  
  theme(legend.position = "top",
        axis.text.x = element_text(angle = 90))
  


# Ejercicio 2: Replicar el siguiente gráfico usando ggplot2
par(mar = c(9, 3, 1, 1))
barplot(height = mtcars$wt, names.arg = rownames(mtcars), las = 2,
        ylab = "Weight (1000 lbs)")
box()


datos <- data.frame(x = factor(x = rownames(mtcars), levels = rownames(mtcars)), 
                    y = mtcars$wt)
ggplot(data = datos, aes(x = x, y = y)) +
  
  geom_bar(stat = "identity", ) + 
  
  theme(axis.text.x = element_text(angle = 90)) +
  
  xlab(label = NULL) + ylab(label = "Weight (1000 lbs)")


# Arreglo de figuras (según variable)

read.csv(file = "data/cpueTimeSeries.csv") %>%
  
  select(fecha, catch_spp1, catch_spp2) %>%
  
  rename(spp1 = catch_spp1, spp2 = catch_spp2) %>% 
  
  pivot_longer(cols = -fecha, names_to = "especie", values_to = "captura") %>% 
  
  ggplot(aes(x = as.Date(fecha), y = captura)) +
  
  geom_line(size = 2) +
  
  facet_wrap(~as.factor(especie), # define la variable que servirá para seccionar la figura 
             nrow = 2, # junto a ncol, define aspectos del seccionamiento 
             scales = "free_y") # define si se desea que los límites de eje Y (o X, con 'free_x') dependan de los valores en cada subgrupo 


# Guardar figuras ---------------------------------------------------------

require(dplyr)

miFigura <- mtcars %>% 
  
  mutate(cyl = as.factor(cyl)) %>% 
  
  ggplot(aes(x = mpg, y = qsec, color = cyl, shape = cyl)) +
  
  geom_point(size = 3) +
  
  theme_bw() +
  
  theme(panel.grid.minor.y = element_blank(), 
        legend.background = element_blank(), 
        plot.background = element_blank(), 
        panel.background = element_blank(),
        legend.position = "top")

ggsave(plot = miFigura, device = png, filename = "figures/miprimerggplot.png", 
       scale = 0.8, width = 16, height = 9, dpi = 320)
