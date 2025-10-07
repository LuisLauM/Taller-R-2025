# ----------------------------------------------
# Script: hipotenusa.R
# Descripción: Calcula la longitud de la hipotenusa
# a partir de los dos catetos de un triángulo rectángulo.
# ----------------------------------------------

# Función que calcula la hipotenusa
hipotenusa <- function(cateto_a, cateto_b) {
  hipotenusa <- sqrt(cateto_a^2 + cateto_b^2)
  return(hipotenusa)
}



