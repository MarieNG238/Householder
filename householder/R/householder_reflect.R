
#' Apply a Householder reflection
#'
#' This function applies a Householder reflection
#' to a vector or a matrix.
#'
#' @param x A numeric vector or matrix.
#' @param H A square Householder matrix.
#'
#' @return The result of the reflection H %*% x.
#'
#' @examples
#' H <- householder_matrix(c(4, 3))
#' householder_reflect(c(4, 3), H)
#'
#' @export

householder_reflect <- function(x, H) {
  # Check that H is a square matrix
  if (!is.matrix(H) || nrow(H) != ncol(H)) {
    stop("H must be a square matrix.")
  }
  
  # Check that x is numeric
  if (!is.numeric(x)) {
    stop("x must be numeric.")
  }
  
  # Convert the vector into a column matrix
  if (is.vector(x)) {
    x <- matrix(x, ncol = 1)
  }
  
  # Check dimension compatibility
  if (nrow(H) != nrow(x)) {
    stop("The dimensions of H and x are incompatible.")
  }
  
  # Apply the reflection
  resultat <- H %*% x
  
  return(resultat)
}
