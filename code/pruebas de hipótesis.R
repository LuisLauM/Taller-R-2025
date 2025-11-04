# Pruebas de normalidad
x <- rnorm(n = 500, mean = 15, sd = 5)
y <- runif(n = 500, min = 10, max = 70)
z <- rnorm(n = 500, mean = 15, sd = 4.5)

hist(x = x, breaks = 30)
hist(x = y, breaks = 30)
hist(x = z, breaks = 30)

ks.test(
  x = x,
  y = y
)

ks.test(
  x = x,
  y = z
)

# Pruebas de homocedasticidad

require(car)

iris

leveneTest(
  Sepal.Length ~ Species, 
  data = iris
)

tapply(
  X = iris$Sepal.Length,
  INDEX = iris$Species,
  FUN = var
)

# Pruebas de Correlación

cor.test(
  x = iris$Sepal.Length[iris$Species == "virginica"],
  y = iris$Sepal.Length[iris$Species == "versicolor"],
  method = "pearson"
)

plot(
  x = iris$Sepal.Length[iris$Species == "virginica"],
  y = iris$Sepal.Length[iris$Species == "versicolor"]
)




cor.test(
  x = iris$Sepal.Length[iris$Species == "virginica"],
  y = iris$Sepal.Length[iris$Species == "versicolor"],
  method = "spearman"
)

plot(
  x = iris$Sepal.Length[iris$Species == "virginica"],
  y = iris$Sepal.Length[iris$Species == "versicolor"]
)


# Pruebas de Comparación de dos grupos

# Paramétricas
t.test(
  x = iris$Sepal.Length[iris$Species == "virginica"],
  y = iris$Sepal.Length[iris$Species == "versicolor"],
  paired = FALSE
)

boxplot(
  Sepal.Length ~ Species,
  data = iris
)


# No paramétricas
wilcox.test(
  x = iris$Sepal.Length[iris$Species == "virginica"],
  y = iris$Sepal.Length[iris$Species == "versicolor"],
  paired = FALSE
)



# Pruebas de Comparación de más de dos grupos

# Paramétrico
prueba_anova <- aov(
  Sepal.Length ~ Species,
  data = iris
)

summary(prueba_anova)



# No paramétrica: Kruskall-Wallis
kruskal.test(
  Sepal.Length ~ Species, 
  data = iris
)

# Pruebas post-hoc

# Tukey
TukeyHSD(x = prueba_anova)

# Dunn
dunnTest(
  Sepal.Length ~ Species, 
  data = iris
)


# Pruebas de Independencia y Homogeneidad

tabla_mtcars <- table(am = mtcars$am, cyl = mtcars$cyl)

chisq.test(x = tabla_mtcars)
fisher.test(x = tabla_mtcars)
