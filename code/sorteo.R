sorteo <- function(participantes, n = 10){
  
  for(i in seq(n)){
    
    if(i == n){
      cli::cli_alert_success(text = "Lista final")  
    }else{
      cli::cli_alert_warning(text = "Sorteando...")
    }
    
    data.frame(Nombre = sample(x = participantes)) |> print()  
    
    Sys.sleep(.5)
  }
}

sorteo(participantes = c("Jorge", "Eliana", "Analucia", "Sandra", 
                         "Wendy", "Jaime", "Yasmine", "Ruggeri"))
