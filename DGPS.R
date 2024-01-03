#DGP 1

# Tamaño de la simulación
T <- 1000
p <- 2
# Valores iniciales
y1 <- 150

yt <- 150*(p:1)

#Beta
beta <- 32.54
# Parametros AR
phi1 <- 1
phi2 <- -0.018

set.seed(1155)
phis <- sort(runif(p,min =0 ,max=1),decreasing = TRUE)
# Ruido blanco
set.seed(10)
a <- rnorm(n=(T+1),mean=0,sd=58)
# El proceso
y <- c(yt)
ys <- c(yt)
for(t in (p+1):T){y[t]= beta+phi1*y[t-1]+phi2*y[t-2]+a[t]}

for(t in (p+1):T){ys[t]= beta+phis%*%y[(t-1):(t-p)]+a[t]}
#DGP2
#Tendencia 
tendencia <- seq(1:1000)
y2 <-c(y1)
for(t in 2:T){y2[t]= beta+tendencia[t]+phi1*y2[t-1]+a[t]}
#DGP3 caminata aleatoria
y3 <- c()
for(t in 1:T){y3[t]= a[t]}
#DGP4 caminata aleatoria con deriva
y4 <- c()
for(t in 1:T){y4[t]=beta + a[t]}

