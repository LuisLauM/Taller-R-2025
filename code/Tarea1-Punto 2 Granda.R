#Crear script que calcule velocidad final a partir de los datos:
# distanc :distancia recorrida
# acelera :aceleracion  
# vel_ini :velocidad inicial

MRUV <- function(distanc,acelera,vel_ini){
  vel_final = sqrt((vel_ini^2) + 2*(acelera*distanc))
  print(paste0("Velocidad final: ",round(vel_final,2)))
}

#Ejemplo:
MRUV(distanc = 100,acelera = 4,vel_ini = 3)
