setwd ("C:/Users/visitor/Sara/training/2014-oss/day-15")
install.packages ("lmPerm.tar.gz", repos=NULL, )
tdat <- read.csv("tundra.csv",na.strings="-")
## construct a *centered* version of the predictor
str (tdat)

tdat$Year
tdat <- transform(tdat,cYear=Year-min(Year))
## alternatively tdat$cYear <- tdat$Year-min
plot(GS.NEE~Year,data=tdat)
plot(GS.NEE~cYear,data=tdat)



ssqfun<- function (p){
  y.hat=p[1]+p[2]*tdat$cYear
  dif<- (y.hat - tdat$GS.NEE)^2
  res1<- sum (dif, na.rm=T)
  return (res1)
}

p<- c(400, -1)
ssqfun (p)

?optim
optim(c(400, -1), ssqfun)

fit1 <- optim(par=c(400,-10),fn=ssqfun)
plot(GS.NEE~cYear,data=tdat)
abline(coef=fit1$par,col=2)

install.packages ("bbmle")
library (bbmle)

tdat2 <- subset(tdat,!is.na(GS.NEE))
?mle2
fit2 <- mle2(GS.NEE~dnorm(mean=int+slope*cYear,sd=sd0),
             data=tdat2,
             start=list(int=400,slope=-10,sd0=5))
summary (fit2)
coef(fit2)
fit1


fit3<- optim(par=c(400,-10),fn=ssqfun, control=list(parscale=c(100,5)))
fit3
fit1


fit4<- optim(par=c(400,-10),fn=ssqfun, method="BFGS")
fit4

fit5<- mle2(GS.NEE~dnorm(mean=int+slope*cYear,sd=sd0),
            data=tdat2,
            start=list(int=400,slope=-10,sd0=5), method="Nelder-Mead")
fit6<- mle2(GS.NEE~dnorm(mean=int+slope*cYear,sd=sd0),
            data=tdat2,
            start=list(int=400,slope=-10,sd0=5), method="BFGS")
fit7<- mle2(GS.NEE~dnorm(mean=int+slope*cYear,sd=sd0),
            data=tdat2,
            start=list(int=400,slope=-10,sd0=5), method="SANN")

coef (fit5)


?optim
?lm
?mle2
vcov (fit5)
vcov (fit2)
plot (predict (fit6), predict (fit5))
plot (predict (fit6), predict (fit7))
coef (fit7)
coef (fit6)
coef (fit5)
coef (fit2)

dnorm2 <- function(x, mean,log=FALSE) {
  rss <- sum((x-mean)^2)
  n <- length(x)
  dnorm(x,mean=mean,sd=sqrt(rss/(n-1)),log=log)
}



