#########################################################################################################
# Name             : Multiple Linear Regression
# Date             : 07-13-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Regression 
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150713              initial
#########################################################################################################

https://www.mathsisfun.com/algebra/matrix-inverse.html
http://www.statmethods.net/advstats/matrix.html
YouTube
Coursera
Kahn
https://www.coursera.org/learn/machine-learning/supplement/NMXXL/linear-algebra-review
https://class.coursera.org/statistics101-001
https://class.coursera.org/matrix-002/lecture
https://www.coursera.org/learn/machine-learning/lecture/FuSWY/inverse-and-transpose
https://www.coursera.org/learn/machine-learning/lecture/W1LNU/matrix-multiplication-properties
https://www.coursera.org/learn/machine-learning/lecture/dpF1j/matrix-matrix-multiplication
https://www.coursera.org/learn/machine-learning/lecture/aQDta/matrix-vector-multiplication
https://www.coursera.org/learn/machine-learning/lecture/38jIT/matrices-and-vectors

X <- with(mtcars, as.matrix(cbind(1,hp,disp,qsec)))
Y <- as.matrix(mtcars$mpg)

First = t(X)%*%X

#Solve:  Inverse of A where A is a square matrix.
# http://www.bluebit.gr/matrix-calculator/
Mm = solve(First)
Mx = t(X)%*%Y
bh= round(Mm %*% Mx, digits=5)

# bh <- round(solve(t(X)%*%X)%*%t(X)%*%Y, digits=5)

rownames(bh)[1] <- "Intercept"
bh
#               [,1]
# Intercept 38.62221
# hp        -0.03464
# disp      -0.02847
# qsec      -0.38556

lm(formula = mpg ~ hp + disp + qsec, data = mtcars)

