##[Geoestatistica]=group
##load_vector_using_rgdal
##showplots
##Camada=vector
##Variavel=Field Camada
##Centro_da_Celula=vector
##Pasta=folder
##Modelo_de_Variograma=string
##Metodo_de_Interpolacao=selection Krigagem_Ordinaria;Krigagem_Universal
##Tipo_de_Krigagem=selection Pontual;Bloco
##Maximo_Pontos=number 0
##Minimo_Pontos=number 0
##Distancia_Maxima=number 0.1
##Tamanho_do_Bloco= number 0
##kriging_prediction=output raster
##kriging_var=output raster

library(sp)
library(gstat)
library(raster)

set.seed(7458939);

setwd(Pasta)
s = Modelo_de_Variograma
x = c(s,"RData")
s = paste(x,collapse=".")
load(s)



#load("VarExpMeuse.RData")

#vm = vgm1
vm.fit = vgm1.fit
gridded(Centro_da_Celula) = TRUE
#str(Centro_da_Celula)


Dados = Camada
Field = Variavel
gridm = Centro_da_Celula

Layer2 = Dados

Field = make.names(Field)
names(Layer2)[names(Layer2)==Field]="Field"
Layer2$Field = as.numeric(as.character(Layer2$Field))
str(Layer2)
Layer2 = remove.duplicates(Layer2)
Layer2 = Layer2[!is.na(Layer2$Field),]

type = Tipo_de_Krigagem
typeK = Metodo_de_Interpolacao
nmax = Maximo_Pontos
nmin = Minimo_Pontos
maxdist = Distancia_Maxima
xSub = Tamanho_do_Bloco

if(typeK==0){

if(type==0){
vm.kriged1 = krige(Field~1, Layer2, gridm, model = vm.fit, nmax = nmax, nmin = nmin, maxdist = maxdist)
}

if(type==1){
vm.kriged1 = krige(Field~1, Layer2, gridm, model = vm.fit, nmax = nmax, nmin = nmin, maxdist = maxdist, block = c(xSub,xSub))
}

}

if(typeK==1){

f1 = formula(Field~coords.x1+coords.x2+(coords.x1)^2+coords.x1*coords.x2+(coords.x2)^2)

if(type==0){
vm.kriged1 = krige(f1, Layer2, gridm, model = vm.fit, nmax = nmax, nmin = nmin, maxdist = maxdist)
}

if(type==1){
vm.kriged1 = krige(f1, Layer2, gridm, model = vm.fit, nmax = nmax, nmin = nmin, maxdist = maxdist, block = c(xSub,xSub))
}

}


kriging_prediction = raster(vm.kriged1)
kriging_var = raster(vm.kriged1["var1.var"])
#plot(vm,vm.fit,plot.numbers=TRUE)


