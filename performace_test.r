library(profvis)
rm(list=ls())
size <- 100000
values_in <- runif(size)

## Compare performances between packages and standard approach

## Standard approach
profvis({
  diff <- function(x, mu){
    return <- (x-mu)^2
  }
  values <- c()
  total <- 0
  count <- 0 #assuming we don't know the stream length
  # simulation values coming in
  for (v in values_in) {
    total <- total + v
    values <- append(values,v)
    count <- count + 1
  }
  mu <- total/count
  sd <- sqrt(sum(sapply(values,diff,mu=mu))/(size-1))
})
print(paste(mu,sd))

#Welford
profvis({
  library(WelfordAlgorithm)
  x <- WelfordAlgorithm$new()
  # simulation values coming in
  for (v in values_in) { 
    x$push(v)
  }
})
print(x)
