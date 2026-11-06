#' Perform QR factorization using Householder reflections
#'
#' This function decomposes a matrix A into two matrices:
#' Q, an orthogonal matrix, and R, an upper triangular matrix.
#'
#' @param A A numeric matrix with at least as many rows as columns.
#' @param tolerance Threshold used to ignore numerically zero values.
#'
#' @return A list containing Q, R, Q_reduced and R_reduced.
#'
#' @examples
#' A <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3)
#' result <- householder_qr(A)
#' result$Q %*% result$R
#'
#' @export

householder_qr <- function(A, tolerance = 1e-10) {
  
  # Check that A is a finite numeric matrix
  if (!is.matrix(A) || !is.numeric(A) ||
      any(!is.finite(A))) {
    stop("A must be a numeric matrix containing finite values.")
  }
  
  # Get the number of rows and columns
  m <- nrow(A)
  n <- ncol(A)
  
  # Check that A has at least as many rows as columns
  if (m < n || m == 0 || n == 0) {
    stop("A must have at least as many rows as columns.")
  }
  
  # Copy A into R
  R <- A
  
  # Initialize Q with the identity matrix
  Q <- diag(m)
  
  # Apply Householder reflections successively
  for (k in 1:min(m, n)) {
    
    # Extract the part of the column to be transformed
    x <- R[k:m, k]
    
    # Compute its norm
    norm_x <- sqrt(sum(x^2))
    
    # Skip numerically zero values
    if (norm_x <= tolerance) {
      next
    }
    
    # Compute the Householder vector
    v <- householder_vector(x)
    
    # Construct the smaller reflection matrix
    H <- diag(length(v)) -
      2 * (v %*% t(v)) / sum(v^2)
    
    # Apply the reflection to R
    R[k:m, ] <- H %*% R[k:m, ]
    
    # Accumulate the reflections in Q
    Q[, k:m] <- Q[, k:m] %*% H
  }
  
  # Remove small numerical errors below the diagonal
  R[lower.tri(R)] <- 0
  
  # Extract the reduced factorization matrices
  Q_reduced <- Q[, 1:n, drop = FALSE]
  R_reduced <- R[1:n, , drop = FALSE]
  
  # Return the results
  return(list(
    Q = Q,
    R = R,
    Q_reduced = Q_reduced,
    R_reduced = R_reduced
  ))
}