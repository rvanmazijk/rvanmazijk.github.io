# Load packages
library(tidyverse)
library(magrittr)  # ::divide_by()
library(circular)
library(astroFns)  # ::hms2rad()

month2rad <- function(month) {
  stopifnot(month %in% 1:12)
  hms2rad(2 * month)  # use 24hr time as astroFns:: does
}
rad2month <- function(radian) {
  radian %>%
    rad2hms() %>%
    substr(1, 2) %>%  # b/c astroFns:: returns an hms string
    as.numeric() %>%
    divide_by(2)
}
my_circular_mean <- function(x) {
  x %>%
    month2rad() %>%
    circular(rotation = "clock", template = "geographics") %>%
    mean() %>%
    rad2month()
}

# Test
my_circular_mean(1:10)
my_circular_mean(c(10:12, 1:6))

# Demonstrate that it works more explicitly
x <- month2rad(1:10)
x <- circular(x, rotation = "clock", template = "geographics")
plot(x)
points(mean(x), col = "red")
as.numeric(substr(rad2hms(mean(x)), 1, 2)) / 2
