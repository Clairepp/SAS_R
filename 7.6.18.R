library(msos)
data("histamine")
y <- histamine[,2:4]
x <- cbind(1,c(-1,-1,1,1),c(-1,1,-1,1),c(1,-1,-1,1)) 
x <- kronecker(x,rep(1,4))
x <- cbind(histamine[,1],x)
z <- cbind(c(1,1,1),c(-1,0,1),c(1,-2,1))
yz <- y%*%solve(t(z))

cx <- solve(t(x)%*%x)
betahat <- cx%*%t(x)%*%yz
betahat
resid <- yz-x%*%betahat
sigmaz <- t(resid)%*%resid/(16-5) 
se <- sqrt(outer(diag(cx),diag(sigmaz),"*"))
se

cxstar <- cx[1:4,1:4]
sigmazstar <- sigmaz[3,3]
betastar <- betahat[1:4,3]
betastar <- matrix(betastar,ncol = 1)
b <- t(betastar) %*% solve(cxstar) %*% betastar
w <- (16-5)*sigmazstar
t2.trace <- sum(diag(b/w))
t2.trace
fstar <- b/w/4*(16-5)
fstar
1-pf(fstar,4,16)