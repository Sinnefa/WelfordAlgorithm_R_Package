#' Welford Algorithm for Incremental Mean, Variance and Standard Deviation
#'
#' @description The package is meant to handle a stream of numbers and compute descriptive values without a prior knowledge of how many values you have.
#' It basically computers numbers coming from a stream. 06 - January - 2020
#' @author Alberto Calderone <sinnefa@@gmail.com>
#' @docType class
#' @export
#' @format An \code{\link{R6Class}} object
#' @examples
#' x <- WelfordAlgorithm$new()
#' x$push(4)
#' x$pushList(c(3,6.5,4))
#' x
#' y <- x$getDataValues()
#' y
#' print(x$numDataValues())
#' print(x$mean())
#' print(x$standardDeviation())
#' print(x$variance())
#'
WelfordAlgorithm <- R6::R6Class(
  "WelfordAlgorithm",
  private = list(
    values = NULL,
    numberOfValues = NULL,
    oldMean = NULL,
    newMean = NULL,
    oldStandardDeviation = NULL,
    newStandardDeviation = NULL,
    keep = NULL),
  public = list(
    #' @description Object initialization
    #' @param keep Keeps all values in memory. Default is FALSE to save memory.
    initialize = function(keep = FALSE) {
      private$values <- c()
      private$numberOfValues <- 0
      private$oldMean <- 0
      private$newMean <- 0
      private$oldStandardDeviation <- 0
      private$newStandardDeviation <- 0
      private$keep <- keep
    },
    #' @description Empties out the list of values and resets all calculations
    clear = function() {
      private$numberOfValues <- 0
      private$values <- c()
      private$numberOfValues <- 0
      private$oldMean <- 0
      private$newMean <- 0
      private$oldStandardDeviation <- 0
      private$newStandardDeviation <- 0
    },
    #' @description Pushes one single element in the stream
    #' @param x The value to push in the stream
    push = function(x) {
      if (private$keep)
        private$values <- c(private$values,x)
      private$numberOfValues <- private$numberOfValues + 1
      if (private$numberOfValues == 1) {
        private$oldMean <- x
        private$newMean <- x
        private$oldStandardDeviation <- 0.0
      } else {
        private$newMean <- private$oldMean + (x - private$oldMean) / private$numberOfValues
        private$newStandardDeviation <- private$oldStandardDeviation + (x - private$oldMean) * (x - private$newMean)
        private$oldMean <- private$newMean
        private$oldStandardDeviation <- private$newStandardDeviation
      }
    },
    #' @description Pushes a list of values in the stream
    #' @param l The list to push in the stream
    pushList = function(l) {
      for (x in l)
        self$push(x)
    },
    #' @description Returns a vector of values
    getDataValues = function() {
      if (private$keep)
        return <- private$values
      else
        return <- NULL
    },
    #' @description Return the number of values processed so far
    numDataValues = function() {
      return <- private$numberOfValues
    },
    #' @description Returns the mean
    mean = function() {
      if (private$numberOfValues > 0)
        return <- private$newMean
      else
        return <- 0.0
    },
    #' @description Return the variance
    variance = function() {
      if (private$numberOfValues > 1)
        return <- private$newStandardDeviation / (private$numberOfValues - 1)
      else
        return <- 0.0
    },
    #' @description Returns the standard deviation
    standardDeviation = function() {
      return <- sqrt(self$variance())
    },
    #' @description Prints the current status of the stram
    print = function() {
      cat("Mean:\t\t\t", self$mean(), "\n", sep = "")
      cat("Variance:\t\t", self$variance(), "\n", sep = "")
      cat("Standard Deviation:\t", self$standardDeviation(), "\n", sep = "")
      cat("Values: [", paste(private$values,collapse=";"), "]\n", sep = "")
    }
  ),
  active = list()
)
