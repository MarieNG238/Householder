# PROJET : PREVISION DES BESOINS EN MEDICAMENTS
# METHODE : FACTORISATION QR PAR HOUSEHOLDER
# 1.INITIALISATION DU PROJET
# Afficher le repertoire de travail
getwd()
# Afficher les informations sur R
version
#2. VERIFICATION DES FICHIERS DU PROJET
#Afficher les fichiers presents dans le dossier
list.files("data")
#Lecture du fichier CSV
list.files("data", pattern = "\\.csv$")
# 3. IMPORTATION DES DONNEES
consumption <- read.csv("~/Projet_HouseHolder/Projet_Householder/data/donnees_medicaments.csv",fileEncoding = "UTF-8-BOM")
consommation <- consumption
head(consumption)
dim(consumption)
names(consumption)
str(consumption)
summary(consumption)
stocks<- read.csv("~/Projet_HouseHolder/Projet_Householder/data/donnees_stocks.csv",fileEncoding = "UTF-8-BOM")
head(stocks)
dim(stocks)
names(stocks)
str(stocks)
summary(stocks)
# 4. IDENTIFICATION DES MEDICAMENTS
medicaments <- unique(consumption$Medicament)
table(consumption$Medicament)
#Extraction du paracétamol
paracetamol <- consumption[consumption$Medicament=="Paracétamol",]
mean(paracetamol$Consommation)
# Consommation minimale
min(paracetamol$Consommation)
# Consommation maximale
max(paracetamol$Consommation)
# Consommation totale
sum(paracetamol$Consommation)
# Médiane
median(paracetamol$Consommation)
# Ecart-type
sd(paracetamol$Consommation)
aggregate(
  Consommation ~ Medicament,
  data = consumption,
  FUN = mean
)
# Vérification de la cohérence des stocks
consumption$Stock_final ==
  consumption$Stock_initial +
  consumption$Approvisionnement -
  consumption$Consommation
#Construction des graphiques
#Consommation mensuelle du Paracétamol
plot(
  paracetamol$Consommation,
  type = "b",
  main = "Consommation mensuelle du Paracétamol",
  xlab = "Mois",
  ylab = "Quantité consommée",
  col = "red",
  pch = 19,
  lwd = 2
)
#Distribution des consommations de tous les medicaments
boxplot(
  Consommation ~ Medicament,
  data = consumption,
  main = "Distribution des consommations par médicament",
  xlab = "Médicaments",
  ylab = "Quantité consommée",
  col = "green",
  las = 2
)
# 6. REGRESSION LINEAIRE
# Selectionner les donnees du Paracetamol
paracetamol <- consumption[
  consumption$Medicament == "Paracétamol",]
# Creer un indice numerique pour les mois
x <- 1:24
# Recuperer les consommations
y <- paracetamol$Consommation
# Afficher les deux variables
x
y
length(x)
length(y)
#Evolution de la consommation du paracetamol
plot(
  x, y,
  main = "Evolution de la consommation du Paracetamol",
  xlab = "Mois",
  ylab = "Consommation",
  pch = 19,
  col = "blue")
# 7. CALCUL DES COEFFICIENTS
# Construire le modele de regression
modele_reference <- lm(y ~ x)
# Afficher les coefficients
coefficients(modele_reference)
# Tracer la droite de regression
abline(modele_reference,col = "red",lwd = 2)
# 9. CONSTRUCTION DU SYSTEME MATRICIEL
# Construire la matrice A
A <- cbind(x, 1)
# Transformer les consommations en vecteur colonne
Y <- matrix(y, ncol = 1)
Y# Afficher les matrices
A
Y
# Verifier les dimensions
dim(A)
dim(Y)
# Verifier les dimensions du systeme
dim(A)
dim(Y)
# Verifier la compatibilite des dimensions
nrow(A) == nrow(Y)
ncol(A)
# 10. PREMIERE REFLEXION DE HOUSEHOLDER
# Extraire la premiere colonne de A
x1 <- A[, 1]
# Afficher le vecteur
x1
# Calculer la norme du vecteur
norme_x1 <- sqrt(sum(x1^2))
# Afficher la norme
norme_x1
# Calculer alpha
alpha <- -sign(x1[1]) * norme_x1
# Afficher alpha
alpha
# Construire le vecteur e1
e1 <- c(1, rep(0, length(x1) - 1))
# Construire le vecteur v
v <- x1 - alpha * e1
# Afficher 
v
#11 CONSTRUCTION DE LA MATRICE H
#Construire la matrice identite
I <-  diag(length(v))
I
#Calculons le produit vv transposée
vvT <- v %*% t(v)
vvT
#Calculons le produit scalaire v transposée v
vTv <- t(v) %*% v
vTv
#Construire la matrice Householder
H <- I - 2 * vvT / as.numeric(vTv)
H
dim(H)
#Verifier la symétrie
all.equal(H, t(H))
#Verifier l'orthogonalité
all.equal(t(H) %*% H, I)
#Appliquer la reflexion de Householder
x1_transform <-  H %*% x1
x1_transform
# 12 APPLICATION DE LA PREMIERE REFLEXION A LA MATRICE A
A1 <- H %*% A
A1
dim(A1)
# 13 PREPARATION DE LA DEUXIEME REFLEXION
# extraire les elements de la deuxieme colonne à partir de la deuxieme ligne
x2 <-  A1[2:24, 2]
#calculer la norme
norme_x2 <-  sqrt(sum(x2^2))
#calculons alpha2
alpha2 <- -sign(x2[1]) * norme_x2
#Construire le vecteur e2
e2 <-  c(1, rep(0, length(x2)-1))
#Construire le vecteur V2
v2 <-  x2 - alpha2 * e2
# 14. CONSTRUCTION DE LA DEUXIEME MATRICE H2
# Construire la matrice identite
I2 <- diag(length(v2))
# Calculer v2 fois sa transposee
v2v2T <- v2 %*% t(v2)
# Calculer v2 transposee fois v2
v2Tv2 <- t(v2) %*% v2
# Construire la deuxieme matrice de Householder
H2_petite <-I2 - 2 * v2v2T / as.numeric(v2Tv2)
H2_petite
# Construire la matrice H2 de dimension 24 x 24
H2 <- diag(24)
# Remplacer le bloc correspondant aux lignes et colonnes 2 a 24
H2[2:24, 2:24] <- H2_petite
H2                  
# 15. APPLICATION DE LA DEUXIEME REFLEXION
A2 <- H2 %*% A1
A2
# 16. EXTRACTION DE LA MATRICE R
R <- A2[1:2, ]
R
dim(R)
# 17. CONSTRUCTION DE LA MATRICE Q
# Construire la matrice Q complete
Q_complete <- H %*% H2
# Extraire les deux premieres colonnes
Q <- Q_complete[, 1:2]
Q
dim(Q)
# 18. VERIFICATION DE LA FACTORISATION QR
# Reconstruire A
A_reconstruite <- Q %*% R
# Comparer A et A reconstruite
all.equal(A, A_reconstruite)
# 19. VERIFICATION DE L'ORTHOGONALITE DE Q
QtQ <- t(Q)%*%Q
QtQ
# Construire la matrice identite 2 x 2
identite <- diag(2)
# Verifier
all.equal(QtQ, identite)
# 20. CALCUL DE Q TRANSPOSEE FOIS Y
Y_transforme <- t(Q) %*% Y
Y_transforme
dim(Y_transforme)
# 21. RESOLUTION DU SYSTEME TRIANGULAIRE
beta_householder <- backsolve(R, Y_transforme)
beta_householder
# 22. COMPARAISON AVEC LE MODELE LM
coefficients_householder <- as.vector(beta_householder)
coefficients_lm <- c(
  coef(modele_reference)["x"],
  coef(modele_reference)["(Intercept)"]
)
comparaison <- data.frame(
  Methode = c("Householder", "lm"),
  Pente = c(coefficients_householder[1], coefficients_lm[1]),
  Intercept = c(coefficients_householder[2], coefficients_lm[2])
)
comparaison
# 23. CONSTRUCTION DU MODELE DE PREVISION
a <- beta_householder[1, 1]
b <- beta_householder[2, 1]
modele_householder <- function(x) {
  a * x + b}
v
# 24. PREVISION SUR SIX MOIS
mois_futurs <- 25:30
previsions <- modele_householder(mois_futurs)
resultats_previsions <- data.frame(
  Mois = mois_futurs,
  Consommation_prevue = round(previsions, 2)
)
resultats_previsions
# 25. FONCTION DE PREVISION HOUSEHOLDER
prevoir_householder <- function(y, nb_mois = 6) {
  # Nombre d'observations
  n <- length(y)
  # Construire les variables explicatives
  x <- 1:n
  A <- cbind(x, 1)
  Y <- matrix(y, ncol = 1)
  # PREMIERE REFLEXION
  x1 <- A[, 1]
  norme_x1 <- sqrt(sum(x1^2))
  alpha1 <- -sign(x1[1]) * norme_x1
  e1 <- c(1, rep(0, n - 1))
  v1 <- x1 - alpha1 * e1
  H1 <- diag(n) - 2 * (v1 %*% t(v1)) /
    as.numeric(t(v1) %*% v1)
  # Appliquer la premiere reflexion
  A1 <- H1 %*% A
  # DEUXIEME REFLEXION
  x2 <- A1[2:n, 2]
  norme_x2 <- sqrt(sum(x2^2))
  alpha2 <- -sign(x2[1]) * norme_x2
  e2 <- c(1, rep(0, n - 2))
  v2 <- x2 - alpha2 * e2
  H2_petite <- diag(n - 1) -
    2 * (v2 %*% t(v2)) /
    as.numeric(t(v2) %*% v2)
  H2 <- diag(n)
  H2[2:n, 2:n] <- H2_petite
  # MATRICES Q ET R
  A2 <- H2 %*% A1
  R <- A2[1:2, ]
  Q_complete <- H1 %*% H2
  Q <- Q_complete[, 1:2]
  # RESOLUTION DU SYSTEME
  Y_transforme <- t(Q) %*% Y
  beta <- backsolve(R, Y_transforme)
  # EXTRACTION DES COEFFICIENTS
  a <- beta[1, 1]
  b <- beta[2, 1]
  # PREVISIONS
  mois_futurs <- (n + 1):(n + nb_mois)
  previsions <- a * mois_futurs + b
  # Retourner les resultats
  return(list(
    pente = a,
    intercept = b,
    previsions = data.frame(
      Mois = mois_futurs,
      Consommation_prevue = round(previsions, 2)
    )
  ))
}
prevoir_householder(y)
test_paracetamol <- prevoir_householder(
  paracetamol$Consommation
)
test_paracetamol$pente
test_paracetamol$intercept
test_paracetamol$previsions
# 26. PREVISION POUR LES 8 MEDICAMENTS
# Recuperer la liste des medicaments
medicaments <- unique(consommation$Medicament)
# Creer un tableau vide
previsions_toutes <- data.frame()

# Parcourir les medicaments
for (med in medicaments) {
  # Extraire les donnees du medicament
  donnees_med <- consommation[
    consommation$Medicament == med,
  ]
  # Classer les observations par mois
  donnees_med <- donnees_med[
    order(donnees_med$Mois),
  ]
  # Calculer les previsions
  resultat <- prevoir_householder(
    donnees_med$Consommation
  )
  
  # Construire le tableau des previsions
  tableau_med <- data.frame(
    Medicament = med,
    Mois = resultat$previsions$Mois,
    Consommation_prevue =
      resultat$previsions$Consommation_prevue
  )
  # Ajouter les resultats au tableau general
  previsions_toutes <- rbind(
    previsions_toutes,
    tableau_med
  )
}
# Afficher toutes les previsions
previsions_toutes
head(previsions_toutes, 12)
# Sélectionner le Paracétamol
paracetamol <- subset(consumption, Medicament == "Paracétamol")
# Trier les données chronologiquement
paracetamol <- paracetamol[order(paracetamol$Mois), ]
# Créer la variable temporelle
temps <- 1:nrow(paracetamol)
# Extraire les consommations
y <- paracetamol$Consommation
# Construire la matrice de régression
A <- cbind(temps, 1)
# Vérifier les dimensions et les premières valeurs
dim(A)
head(A)
head(y)
library(Householder)
# Résoudre le problème des moindres carrés
resultat <- householder_least_squares(A, y)
# Afficher les coefficients
resultat$coefficients
