uncumulate <- function(x) {
  w <- c(NA, x)
  z <- c(x, 0)
  out <- z - w
  out <- out[1:(length(out) - 1)]

  out
}