
#_______________________________________________________#
#Script para calcular la distancia recorrida a partir de la velocidad inicial, tiempo y aceleración
#_______________________________________________________#

#Fórmula: d=Vi*t + (1/2)*a*(t^2)
#
#Donde:
#d: Distancia recorrida (m)
#Vi: Velocidad inicial (m/s)
#t: Tiempo (s)
#a: Aceleración (cte) (m/s^2)


#Definiendo variables. Cambiar los valores según lo necesario.

Vi = 2
t = 10
a = 1.5

#Creando fórmula
d=Vi*t + (1/2)*a*(t^2)

#Presentación del resultado

cat("Datos de entrada:\n")
cat("- Velocidad inicial:",Vi,"m/s\n")
cat("- Tiempo:",t,"s\n")
cat("- Aceleración:",a,"m/s^2\n\n")
cat("Distancia recorrida:",d,"m")



