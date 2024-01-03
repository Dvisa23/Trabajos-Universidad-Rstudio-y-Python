#Preambulo
install.packages("tidyverse")
library(readxl)
library(tidyverse)

# Funciones ---------------------------------------------------------------

# Flip --------------------------------------------------------------------

flip <- function(z){
  
  N <- length(z)
  z <- z[N:1]
  
  return(z)
}




# Media movil -------------------------------------------------------------
mum <- function(z,k){
  N <- length(z)
  
  MUM <- matrix(data = NA,ncol = 1,nrow=N)
  
  for (i in 1:(N-k)) {
    
    MUM[k+i] <- sum(z[i:(i+k-1)])/k
    
    
  }
  return(MUM)
}


#Importar Datos ---------------------------------------------------------


desempleo <- read_xlsx(file.choose())
desempleo <- as.matrix(desempleo)

u <- flip(as.numeric(desempleo[,2])*100)


fecha <- flip(desempleo[,1])


Base.ts=ts(u,start=2001,frequency = 12)
Base.ts
plot(Base.ts,ylab="%Desempleo Mensual",xlab="Anual")


plot(decompose(Base.ts)$random)

#Parametros
K <- 12
N <- length(u)



# Media Movil -------------------------------------------------------------


mumu <- as.matrix(mum(Base.ts,12))


plot(mumu,
     type = "l",
    xlab = "Periodicidad",
    ylab="Mumu",
    main="Ciclo + Tendencia")

# Estacionalidad -----------------------------------------------------------



ditrend <- u-mumu

N <- length(ditrend)

muest <- function(z,K){

  N <- length(z)
  
  estacionalidad <- matrix(data = NA,nrow =K)
 
  for (i in 1:(K)) {
  
  estacionalidad[i] <- sum(na.omit(z[seq(from=i,to=N,by=K)]))/length(na.omit(ditrend[seq(from=1,to=N,by=12)]))
  
  }
  return(estacionalidad)
}

muestu <- muest(ditrend,12) 

muestus <- as.matrix(rep(muestu,N/K))

plot(muestus,
     type = "l",
     xlab = "Periodicidad",
     ylab="Estacionalidad",
     main="Estacionalidad")


# Componente Aleatorio ----------------------------------------------------

ca <- (u-mumu)- muestus

par(las=2,cex.lab=0.8,cex.axis=0.7,font.main=15,font.axis=14,font.lab=14,font.sub=14,cex.sub=0.7,bty="l",col="grey40",mfrow=c(1,2))
plot(ca,
     type = "l",
     xlab = "Periodicidad",
     ylab="ca",
     main="Componente Aletatorio")
plot(decompose(Base.ts)$random)
