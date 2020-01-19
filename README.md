# Description
Welford Algorithm for Incremental Mean, Variance and Standard Deviation.

It handles a stream of numbers and computes descriptive values without a prior knowledge of how many values you have. It basically computers values coming from a stream of numbers.

# How to Install

The preferred way to install this package:
```
install.packages("devtools")
devtools::install_github("Sinnefa/WelfordAlgorithm_R_Package")
```
# Performance
This library has the followin advantages
1. Saves memeory
2. Saves time
3. Can be used wihtout known in advance the number of elements to process
## Welford approach performances
![Welford performances](/imgs/welford.png "Welford")

## Standard approach performances
![Standard performances](/imgs/standard.png "Standard")

# Example

```
library(WelfordAlgorithm)
x <- WelfordAlgorithm$new()
x$push(4)
x$pushList(c(3,6.5,4))
x
y <- x$getDataValues()
y
print(x$numDataValues())
print(x$mean())
print(x$standardDeviation())
print(x$variance())
```
