
#' Check the properties of a Householder matrix
#'
#' This function checks whether a matrix is symmetric
#' and orthogonal.
#'
#' @param H A square numeric matrix.
#' @param tolerance Tolerance used for numerical comparisons.
#'
#' @return A list containing the results of the checks
#' and the corresponding numerical errors.
#'
#' @examples
#' H <- householder_matrix(c(4, 3))
#' householder_properties(H)
#'
#' @export

householder_properties <- function(H, tolerance = 1e-10) {
  # Check that H is a finite square numeric matrix
  if (!is.matrix(H) || !is.numeric(H) ||
      nrow(H) != ncol(H) || any(!is.finite(H))) {
    stop("H must be a finite square numeric matrix.")
  }
  
  # Compute the difference between H and its transpose
  erreur_symetrie <- max(abs(H - t(H)))
  
  # Compute the difference between H^T H and the identity matrix
  erreur_orthogonalite <- max(
    abs(t(H) %*% H - diag(nrow(H)))
  )
  
  # Check symmetry
  symetrique <- erreur_symetrie < tolerance
  
  # Check orthogonality
  orthogonale <- erreur_orthogonalite < tolerance
  
  # Return the results
  return(list(
    symetrique = symetrique,
    orthogonale = orthogonale,
    erreur_symetrie = erreur_symetrie,
    erreur_orthogonalite = erreur_orthogonalite
  ))
}
