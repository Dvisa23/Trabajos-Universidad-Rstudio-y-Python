#Preambulo
library(readxl)



# Comandos ----------------------------------------------------------------


# Flip 

flip <- function(z){
 
  N <- length(z)
  z <- z[N:1]
  
  return(z)
}

# Rezago 

lag <- function(z,k){

  N <- length(z)
#Lista i+k

  z_ik <- z[(k+1):N]
  
  return(z_ik)
}

# Diff 

Diff <- function(z,k){
 
   N <- length(z)

#Lista i

  z_i <- z[1:(N-k)]

#Lista i+k

  z_ik <- z[(k+1):N]

#Diff
  
  diff <- z_ik-z_i
 return(diff) 
}

#Diff_INV
diff_inv <- function(dg){
  SUMAN <- c()
  for (i in 1:length(dg)) {
    SUMAN[i] <- sum(dg[1:i]) 
  }
  yr <- SUMAN[2:length(SUMAN)]+dg[1:(length(dg)-1)]
  
  return(yr)
}
# Estadistica Descriptiva -------------------------------------------------


# Media 
media <- function(zt){
  
  N <- length(zt)
  
  sum(zt)/N
}

#Varianza
varianza <- function(zt){
  
  N <- length(zt)
  
  sum(( zt-(sum(zt)/N) )^2 )/(N-1)
}

#Jarque-Bera
JB <- function(res){
  
  N <- length(res)
  mu <- media(res)
  var <- varianza(res)  
  sim <- ((sum((res-mu)^3))/(var^(3/2)))/N
  kurt <-((sum((res-mu)^4))/(var^(4/2)))/N   
  
  jarquebera <- (N/6)*((sim^2)+((1/4)*((kurt-3)^2)))
  pvalor <- 1-pchisq(jarquebera,2)
  vc <- (qchisq(1-0.05,2))
  pv <- t(rbind(pvalor,0.05))
  jb_vc <- t(rbind(jarquebera,vc))
  
  jb <- (rbind(jb_vc,pv))
  rownames(jb) <- c("Estadisticos","%")
  return(jb)
}




#Media movil
mum <- function(z,k){
  N <- length(z)
  
  MUM <- matrix(data = NA,ncol = 1,nrow=N)
  
  for (i in 1:(N-k)) {
    
    MUM[k+i] <- sum(z[i:(i+k-1)])/k
    
    
  }
  return(MUM)
}


# Autocorrelogramas -------------------------------------------------------


#ACF
RHOK <- function(z,K){
  RHO <- c()
  RHO[1] <-1 
  for (k in 1:K) {
    RHO[k+1] <- sum((z[1:(length(z)-k)]-media(z))*(lag(z,k)-media(z)))/sum((z-media(z))^2)
  }  
  print(RHO) 
}




Autocorrelograma_ACF <- function(rhok,DG_y,main){
  n <- length(DG_y)
  
  varrhok <- c()
  varrhok[1] <- abs(2*sqrt((1+2*sum(0^2))/n))
  i <- 1
  while (abs(2*sqrt((1+2*sum(rhok[2:(i+1)]^2))/n))<abs(rhok[2+i])) {
    i <- i+1
    varrhok[i+1] <- abs(2*sqrt((1+2*sum(rhok[2:(i+1)]^2))/n))
  }
  varrhok <- na.omit(varrhok)
  plot(rhok,type = "h",xlab = "Rho",main = main)
  abline(0,0)
  for (i in 1:length(varrhok)) {
    abline(a=(varrhok[i]),b = 0,col="blue",lty="dashed") 
    abline(a=(-varrhok[i]),b = 0,col="blue",lty="dashed") 
  }      
}     

#PACF
crammer.f <- function(GRHOS,kk){ 
  MAT <- matrix(data = NA,nrow = kk,ncol=kk)
  for (i in (1:kk)) {
    for (j in 1:kk) {
      MAT[i,j]<- as.numeric(GRHOS[abs(j-i)+1])
    }
  }
  
  MATNUM <- MAT 
  MATNUM[,kk] <- as.numeric(GRHOS [2:(kk+1)])
  crammer <- det(MATNUM)/det(MAT)
  
  return(crammer) 
}


PHIKK <- function(GRHOS,kk){
  
  FACP <- c()
  
  for (i in 1:kk) {
    
    FACP[i] <- crammer.f(GRHOS,i)
    
  }
  return(FACP)
}

Autocorrelograma_PACF <- function(PHIKK,DG_y){
  DESVPHIKK <- 2/sqrt(length(DG_y))
  
  plot(PHIKK,type = "h",xlab = "Rho",main = "PACF")
  abline(0,0)
  abline(DESVPHIKK,0,col="blue",lty="dashed")
  abline(-DESVPHIKK,0,col="blue",lty="dashed")
 
}


# Comportamiento de los residuales ----------------------------------------



independencia_individual <- function(modelo,d,p,k){
  res <- modelo1$residuals
  n <- length(res)
  n_ita <- d+p+1
  rhok_res <- c()
  test <- c() #Significancia individual
  for (i in 1:k) {
    rhok_res[i] <- sum(res[n_ita:(n-i)]*res[(n_ita+i):n])/sum(res[n_ita:n]^2)  
    if (abs(rhok_res[i])<(1/sqrt(n-n_ita))) {test[i] <-"H0"}else{test[i] <-"H1"}
  }
  return(rbind(rhok_res,test))
  
}


#Jarque -Bera
JB <- function(res){
  
  N <- length(res)
  mu <- media(res)
  var <- varianza(res)  
  sim <- ((sum((res-mu)^3))/(var^(3/2)))/N
  kurt <-((sum((res-mu)^4))/(var^(4/2)))/N   
  
  jarquebera <- (N/6)*((sim^2)+((1/4)*((kurt-3)^2)))
  pvalor <- 1-pchisq(jarquebera,2)
  vc <- (qchisq(1-0.05,2))
  pv <- t(rbind(pvalor,0.05))
  jb_vc <- t(rbind(jarquebera,vc))
  
  jb <- (rbind(jb_vc,pv))
  rownames(jb) <- c("Estadisticos","%")
  return(jb)
}

#Ljung-box
ljung_box <- function(modelo1,rhok_res,p,d,q) {
  
  res <- modelo1$residuals
  N <- length(res)
  mu_rhok <- c()
  for (i in 1:length(rhok_res)) { mu_rhok[i] <- (rhok_res[i]^2/(N-d-p-i))}
  Q <- (N-d-p)*(N-d-p+2)*sum(mu_rhok)
  pvalue <- (1-pchisq(Q,(length(rhok_res)-p-q)))
  ljb <- rbind(Q,pvalue)
  rownames (ljb)<- c("Chi-Cuadrado","P-value")
  colnames(ljb) <- c("Ljung-Box")
  return(ljb)
} 

#Box- Pierce
box_pierce <- function(modelo1,rhok_res,p,d,q) {
  
  res <- modelo1$residuals
  N <- length(res)
  mu_rhok <- c()
  for (i in 1:length(rhok_res)) { mu_rhok[i] <- (rhok_res[i]^2)}
  Q <- (N-d-p)*sum(mu_rhok)
  pvalue <- (1-pchisq(Q,(length(rhok_res)-p-q)))
  ljb <- rbind(Q,pvalue)
  rownames (ljb)<- c("Chi-Cuadrado","P-value")
  colnames(ljb) <- c("Box-Pierce")
  return(ljb)
} 

