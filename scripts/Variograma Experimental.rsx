##[Geoestatistica]=group
##load_vector_using_rgdal
##showplots
##Camada=vector
##Variavel=Field Camada
##Passo=number 0.1
##Campo_Geometrico=number 0
##Tolerancia_Angular=number 0.1
##Tipo_Variograma=selection omnidireccional;analisis_exploratoria;anisotropia
##Angulo=number 0
##Pares=boolean FALSE
##Pasta=folder
##Nome_do_Variograma_Experimental=string
##VarExp= output table

library(sp)
library(gstat)

Layer = Camada
Field = Variavel

s = Nome_do_Variograma_Experimental

type = Tipo_Variograma
data = as.data.frame(Layer)
coordinates(data) = c("coords.x1","coords.x2")
vari = Layer[[Field]]
lag = Passo
lags = Campo_Geometrico
tol = Tolerancia_Angular

if(type==0){
alpha=0
vgm1 = variogram(vari~1,data,alpha=alpha,width=lag,cutoff=lags,tol.hor=tol)
plot(vgm1,type="p",plot.numbers=Pares,main="Variograma Experimental",xlab="Distancia",ylab="Variancia Espacial")
}

if(type==1){
vgm1 = variogram(vari~1,data,alpha=c(0:3)*45,width=lag,cutoff=lags,tol.hor=tol)
plot(vgm1,multipanel=FALSE,auto.key=TRUE,main="Analisis Exploratoria")
}

if(type==2){

if(Angulo<=90){
min_a=Angulo
max_a=180-min_a
}
if(Angulo>90){
min_a=180-Angulo
max_a=min_a+90
}

alpha = c(min_a,max_a)
vgm1 = variogram(vari~1,data,alpha=alpha,width=lag,cutoff=lags,tol.hor=tol)
plot(vgm1,multipanel=FALSE,auto.key=TRUE,main="Anisotropia")

}

setwd(Pasta)
x = c(s,"RData")
s = paste(x,collapse=".")
save(vgm1,file=s)

VarExp=vgm1
