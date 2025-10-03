Linf <- 12.78
K <- 1.46
t0 <- -0.22

Lt <- Linf*(1 + exp(-t/(K - t0)))

print(Lt)