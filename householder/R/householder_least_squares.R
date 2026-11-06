#' Solve a least squares problem using Householder reflections
#'
#' This function uses Householder QR factorization
#' to estimate the coefficients of a linear model.
#'
#' @param A A numeric matrix of dimension m x n, with m >= n.
#' @param b A numeric vector of length m.
#'
#' @return A list containing the estimated coefficients,
#' fitted values and residuals.
#'
#' @examples
#' A <- cbind(1:4, 1)
#' b <- c(3, 5, 7, 9)
#' householder_least_squares(A, b)
#'
#' @export

householder_least_squares <- function(A, b) {
  
  # Check dimensions and input data
  if (!is.matrix(A) || !is.numeric(A) ||
      any(!is.finite(A))) {
    stop("A must be a finite numeric matrix.")
  }
  
  if (!is.numeric(b) || !is.vector(b) ||
      any(!is.finite(b))) {
    stop("b must be a finite numeric vector.")
  }
  
  if (nrow(A) < ncol(A) || nrow(A) != length(b)) {
    stop("The dimensions of A and b are incompatible.")
  }
  
  # Perform QR factorization
  qr_result <- householder_qr(A)
  
  Q <- qr_result$Q_reduced
  R <- qr_result$R_reduced
  
  # Check whether R is invertible
  if (any(abs(diag(R)) < 1e-10)) {
    stop("Matrix A does not have full column rank.")
  }
  
  # Compute the transpose of Q multiplied by b
  Qt_b <- crossprod(Q, b)
  
  # Solve the triangular system R beta = Q^T b
  beta <- backsolve(R, Qt_b)
  
  # Compute the fitted values
  fitted_values <- drop(A %*% beta)
  
  # Compute the residuals
  residuals <- b - fitted_values
  
  # Return the results
  return(list(
    coefficients = beta,
    fitted_values = fitted_values,
    residuals = residuals
  ))
}