
#' Construct a Householder matrix
#'
#' This function constructs a reflection matrix
#' from a numeric vector.
#'
#' @param x A non-zero numeric vector.
#' @return A Householder matrix H.
#'
#' @examples
#' householder_matrix(c(4, 3))
#' @export
householder_matrix <- function(x) {
  # Compute the Householder vector
  v <- householder_vector(x)
  
  # Compute the outer product v %*% t(v)
  produit <- v %*% t(v)
  
  # Compute the dot product v^T v
  denominateur <- sum(v^2)
  
  # Construct the identity matrix
  I <- diag(length(v))
  
  # Construct the Householder matrix
  H <- I - (2 * produit / denominateur)
  
  return(H)
}
