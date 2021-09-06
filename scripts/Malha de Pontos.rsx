##[Geoestatistica]=group
##Fronteira_Convexa=vector
##Abertura_em_X=number 0
##Abertura_em_Y=number 0
##Malha_de_Pontos=output vector
##load_vector_using_rgdal

library(sp)
library(rgdal)

Layer1 = Fronteira_Convexa
str(Layer1)

dx = Abertura_em_X
dy = Abertura_em_Y

set.seed(7458939);
grid = spsample(Layer1,n=1,cellsize=c(dx,dy),type="regular")
data = data.frame(grid,1:length(grid))
str(data)
coordinates(data) = ~x1+x2
proj4string(data) = proj4string(grid)
Malha_de_Pontos = data


