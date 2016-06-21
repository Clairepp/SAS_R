library(msos)
data(skulls)
y <- skulls[,1:4]
x <- cbind(1,c(-2,-1,0,1,2),c(2,-1,-2,-1,2),c(-1,2,0,-2,1),c(1,-4,6,-4,1)) # or x <- cbind(1,poly(1:5,4))
x <- kronecker(x,rep(1,30))
cx <- solve(t(x)%*%x)
betahat <- cx%*%t(x)%*%y
resid <- y-x%*%betahat
sigmaz <- t(resid)%*%resid/(150-5) 

cxstar <- cx[2:5,2:5]
t2 <- t(betahat[2:5,]) %*% solve(cxstar) %*% betahat[2:5,] %*% solve(sigmaz)
t2.trace <- sum(diag(t2))
t2.trace
fstar <- (145-4+1)/(145*4*4)*t2.trace
fstar
1 - pf(fstar,16,142)


cxstar <- cx[3:5,3:5]
t2 <- t(betahat[3:5,]) %*% solve(cxstar) %*% betahat[3:5,] %*% solve(sigmaz)
t2.trace <- sum(diag(t2))
t2.trace
fstar <- (145-4+1)/(145*3*4)*t2.trace
fstar
1 - pf(fstar,12,142)

cxstar <- cx[2,2]
t2 <- betahat[2,]%*%solve(sigmaz,betahat[2,])/cxstar
t2.trace <- sum(diag(t2))
t2.trace
fstar <- (145-4+1)/(145*1*4)*t2.trace
fstar
1 - pf(fstar,4,142)
