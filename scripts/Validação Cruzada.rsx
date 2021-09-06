##[Geoestatistica]=group
##load_vector_using_rgdal
##showplots
##Camada=vector
##Variavel=Field Camada
##Pasta=folder
##Modelo_de_Variograma=string
##Vizinhanca_max=number 0
##Vizinhanca_min=number 0
##Distancia_Maxima=number 0.1
##CrossValidation= output vector

library(sp)
library(gstat)
library(rgdal)

Layer = Camada
Field = Variavel

str(Layer)
setwd(Pasta)
s = Modelo_de_Variograma
x = c(s,"RData")
s = paste(x,collapse=".")
load(s)

nmax = Vizinhanca_max
nmin = Vizinhanca_min
maxdist = Distancia_Maxima

Field <- make.names(Field)
names(Layer)[names(Layer)==Field]="Field"
Layer$Field <- as.numeric(as.character(Layer$Field))
str(Layer)
Layer = remove.duplicates(Layer)
Layer = Layer[!is.na(Layer$Field),]


crossval = krige.cv(Field~1,Layer,vgm1.fit,nmax=nmax,nmin=nmin,maxdist=maxdist,verbose=FALSE)
proj4string(crossval) = proj4string(Layer)
CrossValidation = crossval
r = cor(crossval$var1.pred,crossval$observed)

plot(crossval$var1.pred,crossval$observed,xlab="Valor Estimado",ylab="Valor Real",main="Validacao Cruzada",sub=paste(" coef.corr = ",round(r, 3)))
abline(lm(crossval$observed~crossval$var1.pred),col="red")
abline(h = median(crossval$observed), v = median(crossval$var1.pred), col = "gray60")
