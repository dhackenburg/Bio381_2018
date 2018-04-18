# Using color in R raphics
# April 17 2018
# DMH

#preliminaries
library(ggplot2)
library(ggthemes)
library(wesanderson)

char2seed("short capo")

d <- mpg # mpg data frame
p1 <- ggplot(data=d,mapping=aes(x=fl,y=hwy,group=fl))
p1 + geom_boxplot()

p1 + geom_boxplot(fill="red")

myColor <- c("red","green","pink","blue","orange")
p1+geom_boxplot(fill=myColor)
myGray <- gray(0.7)
p1 + geom_boxplot(fill=myGray)
print(myGray)
. <- col2rgb("red")
. <- ./255
.
. <- rgb(t(.))
.
p1 + geom_boxplot(fill=.)
.<-col2rgb("red")
.<-./255
.<-rgb(t(.),alpha=0.5) #alpha is 4th element - transparency!
.
myPaleRed <- .
p1 + geom_boxplot(fill=myPaleRed)
p1 + geom_boxplot(fill=gray(seq(from=0.1,to=0.9,length=5)))

# Using alpha transparency in histograms
x1 <- rnorm(n=100,mean=0)
x2 <- rnorm(n=100,mean=3)
dFrame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control","Treatment"),each=100)
dFrame <- cbind(dFrame,lab)
h1 <- ggplot(data=dFrame,mapping=aes(x=v1,fill=lab))
h1 + geom_histogram(position="identity",color="black",alpha=0.5)

p1 + geom_boxplot(fill=wes_palettes[["Royal2"]])                                       
p1 + geom_boxplot(fill=c(gray(0.5),canva_palettes[[1]]))
p2 <- ggplot(data=d,mapping=aes(x=fl,y=hwy,fill=fl)) + geom_boxplot() + scale_fill_manual(values=wes_palettes[["Darjeeling"]])
p2

p2 + geom_boxplot() + scale_fill_brewer(palette="Blues")

p3 <- ggplot(data=d,mapping=aes(x=displ,y=hwy,color=fl)) + geom_point() + scale_color_brewer(palette="Spectral")
p3

p4 <- ggplot(data=d,mapping=aes(x=displ,y=hwy,color=cty)) + geom_point()
p4

p4 + scale_color_gradient(low="red",high="blue")
z <- mean(d$cty)
p4 + scale_color_gradient2(midpoint=z,low="red",mid="seagreen",high="cyan",space="Lab")
p4 + scale_color_gradientn(colors=rainbow(5))

# heatmap 
xVar <- 1:30
yVar <- 1:5
myData <- expand.grid(xVar=xVar,yVar=yVar)
myData
zVar <- myData$xVar + myData$yVar + 2*rnorm(n=150)
zVar
myData <- cbind(myData,zVar)
head(myData)
p4 <- ggplot(data=myData,mapping=aes(x=xVar,y=yVar,fill=zVar))
p4 + geom_tile()
p4 + geom_tile() + scale_fill_gradient2(midpoint=19,low="brown",mid=gray(0.8),high="darkblue")
