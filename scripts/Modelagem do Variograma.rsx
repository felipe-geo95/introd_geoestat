##[Geoestatistica]=group
##showplots
##Pasta=folder
##Nome_do_Variograma_Experimental=string
##Pares=boolean FALSE
##Modelo=selection Exp;Sph;Gau
##Variancia_Espacial=number 0.1
##Alcance=number 0.1
##Efeito_Pepita=number 0.1
##Tipo_Variograma=selection omidirecional;anisotropia
##Angulo_Direcao_Principal=number 0
##Razao_da_Anisotropia=number 0.0
##Variancia_Espacial_Dois=number 0.1
##Modelo_de_Variograma=string

library(gstat)
setwd(Pasta)
s = Nome_do_Variograma_Experimental
x = c(s,"RData")
s = paste(x,collapse=".")
load(s)

pontos = Pares

m = Modelo_de_Variograma

type=Tipo_Variograma
angle=Angulo_Direcao_Principal
ration=Razao_da_Anisotropia

psill = Variancia_Espacial
models = c("Exp","Sph","Gau","Mat")
model = models[Modelo+1]
range = Alcance
nugget = Efeito_Pepita
#plot(vgm1,plot.numbers=pontos)

#Ajuste de parametros de la segunda estructura
psill1 = Variancia_Espacial_Dois

if(type==0){
vgm1.fit = fit.variogram(vgm1, model = vgm(psill,model,range,nugget), fit.sills=FALSE, fit.ranges=FALSE)
plot(vgm1, vgm1.fit,plot.numbers=pontos,main="Modelo de Variograma Ajustado",xlab="Distancia",ylab="Variancia Espacial")
}

if(type==1){
zonal = vgm(psill,model,range,nugget,anis=c(angle,ration))
vgm1.fit = vgm(psill1,model,1e13,add.to=zonal,anis=c(angle,1/1e10))
plot(vgm1, vgm1.fit,xlab="Distancia",ylab="Variancia Espacial")
}

x = c(m,"RData")
s = paste(x,collapse=".")
save(vgm1.fit,file=s)
