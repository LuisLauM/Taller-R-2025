Linf <- 12.78
K <- 1.46
t0 <- -0.22
t <- 3
Lt <- Linf*(1 - exp(-K*(t - t0)))

print(Lt)
