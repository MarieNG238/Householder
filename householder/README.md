# Householder

## Overview

**Householder** is an R package developed as part of the Introduction to R course in the third year of the Data Science and Artificial Intelligence (SDIA) program at the National Advanced School of Engineering of Douala (ENSPD).

Its purpose is to facilitate the construction and use of Householder matrices, as well as their application to QR factorization and the solution of least squares problems.

## Objectives

The package provides functions to:

- Compute the Householder vector.
- Construct a Householder matrix.
- Apply a reflection to a vector or matrix.
- Check symmetry and orthogonality properties.
- Perform QR factorization.
- Solve least squares problems.

## Mathematical Background

A Householder matrix is defined by:

\[
H=I-\frac{2vv^T}{v^Tv}
\]

where:

- \(I\) denotes the identity matrix;
- \(v\) represents the Householder vector;
- \(v^T\) denotes its transpose.

A Householder matrix is symmetric and orthogonal:

\[
H^T=H
\]

\[
H^TH=I
\]

Successive Householder reflections can be used to perform QR factorization:

\[
A=QR
\]

## Available Functions

| Function | Description |
|---|---|
| `householder_vector()` | Computes the Householder vector. |
| `householder_matrix()` | Constructs a Householder matrix. |
| `householder_reflect()` | Applies a Householder reflection. |
| `householder_properties()` | Checks the mathematical properties of a Householder matrix. |
| `householder_qr()` | Performs QR factorization. |
| `householder_least_squares()` | Solves a least squares problem. |

## Usage Examples

### Constructing a Householder Matrix

```r
library(Householder)

x <- c(4, 3)

H <- householder_matrix(x)

print(H)
```

### Checking Matrix Properties

```r
householder_properties(H)
```

### QR Factorization

```r
A <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3)

result <- householder_qr(A)

Q <- result$Q
R <- result$R

Q %*% R
```

### Solving a Least Squares Problem

```r
A <- cbind(1:4, 1)

b <- c(3, 5, 7, 9)

result <- householder_least_squares(A, b)

result$coefficients
```

## Engineering Application

Householder matrices are used in several areas of numerical engineering, including data processing, scientific computing, and the solution of overdetermined systems.

As part of this project, an illustrative application is considered in the healthcare field: analyzing monthly medicine consumption to estimate future needs.

QR factorization is used to solve the least squares problem required to fit a linear model.

The data used in this demonstration are simulated and do not represent real data from a healthcare facility.

## Technologies Used

- R
- RStudio
- usethis
- devtools
- roxygen2
- testthat

## Installation

The package can be installed locally from its development directory using:

```r
devtools::install()
```

Once published on GitHub, it will also be possible to install it directly from its repository.

## Author

Academic project developed as part of the Introduction to R course.

**Specialization:** Data Science and Artificial Intelligence (SDIA).

**Institution:** ENSPD.