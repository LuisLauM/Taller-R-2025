
# Leer valores ------------------------------------------------------------

# Leer hoja 1
readxl::read_excel(path = "data/datos_curso_Wendy.xlsx", sheet = 1, )

# Leer las tres hojas en un solo comando
nombres <- lapply(
  X = 1:3, 
  FUN = readxl::read_excel, 
  path = "data/datos_curso.xlsx"
) |> 
  
  lapply(FUN = unlist) |> 
  
  setNames(nm = c("emb_id", "destino", "armador"))


# Indexar -----------------------------------------------------------------

# Embarcaciones con la palabra 'virgen'
index <- grepl(
  x = nombres$emb_id, 
  pattern = "virgen", 
  ignore.case = TRUE
)
nombres$emb_id[index]



# Corporación Nacional Perú Exportaciones
index <- grepl(
  x = nombres$destino,
  pattern = "^corp.*nac.*per.*export.*",
  ignore.case = TRUE
)

nombres$destino[index]



# Consorcio Muza
index <- grepl(
  x = nombres$destino,
  pattern = "^cons.* muza.*",
  ignore.case = TRUE
)

nombres$destino[index]



# CONCOSMAR
index <- grepl(
  x = nombres$destino,
  pattern = "concosmar",
  ignore.case = TRUE,
  perl = TRUE
)

nombres$destino[index]


# CONCOSMAR, SIN incluir los que lleven la palabra Ecuador
# https://howtoregex.com/cheat-sheet/pcre
index <- grepl(
  x = nombres$destino,
  pattern = "^(?=concosmar.*)(?!.*ecuador)",
  ignore.case = TRUE,
  perl = TRUE
)

nombres$destino[index]
