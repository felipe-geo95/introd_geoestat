##[Geoestatistica]=group
##showplots
##Camada=vector
##Variavel=Field Camada

name = c("Histograma da Variavel")
x = c(name,Variavel)
s = paste(x,collapse=" ")

hist(Camada[[Variavel]],freq=TRUE,col="gray",main=s,xlab=Variavel,ylab="Frequencia")
