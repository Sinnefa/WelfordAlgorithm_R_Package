# Description
Welford Algorithm for Incremental Mean, Variance e Standard Deviation.

It handles a stream of numbers and computes descriptive values without a prior knowledge of how many values you have. It basically computers values coming from a stream of numbers.

# How to Install

The preferred way to install this package is through conda:

```
install.packages("devtools")
devtools::install_github("Sinnefa/WelfordAlgorithm_R_Package")
```
# Example

```
library(WelfordAlgorithm)
x <- WelfordAlgorithm$new()
x$push(4)
x$pushList(c(3,6.5,4))
x
y <- x$getDataValues()
print(x$numDataValues())
```
