############An�lises Descritiva###################
library(pastecs)
library(corrplot)
library(xts)
library(forecast)

dados = read.csv2("C:/Users/COPEL3/Documents/Informa/Compessa/pressao_vazao_tratamento_rod.csv" , sep="," , dec=".")
attach(dados)

dim(dados)    # mostra a dimens�o dos dados
names(dados)  # mostra os nomes das vari�veis
str(dados)
summary(dados) # medidas de posi��o para vari�veis


#Vari�veis categ�ricas
dados <- within(dados, {
  Turno <- factor(Turno, labels=c('Manh�','Tarde', 'Noite', 'Madrugada'))
})

dados <- within(dados, {
  Estacao <- factor(Estacao, labels=c('Ver�o','Outono'))
})

par(bg="#fdf6e3") 
par(mfrow=c(1,2),bg="#fdf6e3") 

contagem = table(Turno)
nomes = c('Manh�','Tarde', 'Noite', 'Madrugada')
porcent = round(contagem/sum(contagem)*100,2)
rotulo=paste(nomes," (",porcent,"%",")",sep="")
pie(table(Turno),labels=rotulo, main="Turnos", col=c("#99CCFF","#99CCCC","#9999FF", "#99FFCC"))  

contagem2 = table(Estacao)
nomes2 = c('Ver�o','Outono')
porcent2 = round(contagem2/sum(contagem2)*100,2)
rotulo2=paste(nomes2," (",porcent2,"%",")",sep="")
pie(table(Estacao),labels=rotulo2, main="Esta��o", col=c("#99CCCC","#99CCFF"))  



#Vari�veis num�ricas
descr <- stat.desc(dados[2:4]) # Medidas descritivas
round(descr, 2)  #arredondar para 2 casas decimais

cat1 = replicate(3745, "PC")
cat2 = replicate(3745, "PM")
pressao = c(Press�.o...PC.52..mca., Pressao...PM.D52..mca.)
categoria = c(cat1, cat2)

boxplot(pressao~categoria, col = c("lightblue", "lightgreen"),
        boxwex=0.4, xlab="", ylab="Press�o", main = "Boxplots das Vari�veis Press�o")

boxplot(Vazao..L.s., col = "lightgreen",
        boxwex=0.4, xlab="", ylab="Vaz�o", main = "Boxplots da Vari�vel Vaz�o")

## Histogramas
hist(Press�.o...PC.52..mca.,prob=T,main='Histograma da press�o PC', xlab="Press�o PC", ylab="Densidade")
lines(density(Press�.o...PC.52..mca.),col='red')
rug(Press�.o...PC.52..mca.)

hist(Pressao...PM.D52..mca.,prob=T,main='Histograma da press�o PM', xlab="Press�o PM", ylab="Densidade")
lines(density(Pressao...PM.D52..mca.),col='red')
rug(Pressao...PM.D52..mca.)

hist(Vazao..L.s.,prob=T,main='Histograma da vaz�o', xlab="Vaz�o", ylab="Densidade")
lines(density(Vazao..L.s.),col='red')
rug(Vazao..L.s.)

plot(Vazao..L.s., Press�.o...PC.52..mca., main="Press�o Ponto Cr�tico x Vaz�o", 
     xlab="Press�o PC", ylab="Vaz�o", 
     col="darkgreen", pch=20)   #n�mero do pch altera o tipo de marcador

plot(Vazao..L.s., Pressao...PM.D52..mca., main="Press�o Ponto M�dio x Vaz�o", 
     xlab="Press�o PM", ylab="Vaz�o", 
     col="darkgreen", pch=20)   #n�mero do pch altera o tipo de marcador

#Correla��o
corrplot(cor(dados[2:4]), method = "number", type = "lower", diag = TRUE)
