
#' Compute the Householder vector
#'
#' This function computes the vector used to construct
#' a Householder reflection matrix.
#'
#' @param x A non-zero numeric vector.
#' @return The Householder vector v.
#' @examples
#' householder_vector(c(4, 3))
#' @export
householder_vector <- function(x) {
  # Check that x is a numeric vector
  if (!is.numeric(x) || !is.vector(x)) {
    stop("x must be a numeric vector.")
  }
  
  # Check that the vector is not empty and contains only finite values
  if (length(x) == 0 || any(!is.finite(x))) {
    stop("x must contain finite numeric values.")
  }
  
  if (all(x == 0)) {
    stop("x must not be the zero vector.")
  }
  
  # Compute the norm of vector x
  norme_x <- sqrt(sum(x^2))
  
  # Construct the Householder vector
  v <- x
  v[1] <- v[1] + ifelse(x[1] >= 0, 1, -1) * norme_x
  
  return(v)
}
