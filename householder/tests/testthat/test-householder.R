library(testthat)
library(Householder)

# Test 1 : calcul du vecteur de Householder
test_that("Le vecteur de Householder est correctement calculé", {
  
  v <- householder_vector(c(4, 3))
  
  expect_equal(v, c(9, 3))
})


# Test 2 : construction de la matrice
test_that("La matrice de Householder est correctement construite", {
  
  H <- householder_matrix(c(4, 3))
  
  expect_equal(
    H,
    matrix(c(-0.8, -0.6, -0.6, 0.8), nrow = 2),
    tolerance = 1e-10
  )
})


# Test 3 : application de la réflexion
test_that("La réflexion transforme correctement le vecteur", {
  
  H <- householder_matrix(c(4, 3))
  
  resultat <- householder_reflect(c(4, 3), H)
  
  expect_equal(
    drop(resultat),
    c(-5, 0),
    tolerance = 1e-10
  )
})


# Test 4 : propriétés mathématiques
test_that("La matrice est symétrique et orthogonale", {
  
  H <- householder_matrix(c(4, 3))
  
  proprietes <- householder_properties(H)
  
  expect_true(proprietes$symetrique)
  expect_true(proprietes$orthogonale)
})


# Test 5 : factorisation QR
test_that("La factorisation QR reconstitue la matrice initiale", {
  
  A <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3)
  
  resultat <- householder_qr(A)
  
  expect_equal(
    resultat$Q %*% resultat$R,
    A,
    tolerance = 1e-10
  )
  
  expect_equal(
    t(resultat$Q) %*% resultat$Q,
    diag(3),
    tolerance = 1e-10
  )
})


# Test 6 : résolution des moindres carrés
test_that("Les coefficients des moindres carrés sont corrects", {
  
  A <- cbind(1:4, 1)
  b <- c(3, 5, 7, 9)
  
  resultat <- householder_least_squares(A, b)
  
  expect_equal(
    drop(resultat$coefficients),
    c(2, 1),
    tolerance = 1e-10
  )
})