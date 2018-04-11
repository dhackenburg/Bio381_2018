# ggplot graphics
#5 April 2018
#DMH

# preliminaries
library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("10th Avenue Freeze-Out")
d <- mpg
str(d)

#qplots for use while coding

#basic histogram
qplot(x=d$hwy)
qplot(x=d$hwy,fill=I("khaki"),color=I("black"))
#I means leaves as is; fill refers to inside, color refers to line

#density plot
qplot(x=d$hwy,geom="density")
qplot(x=d$displ,y=d$hwy,geom=c("smooth","point"))

#linear regression
qplot(x=d$displ,y=d$hwy,geom=c("smooth","point"),method="lm")

#basic boxplot
qplot(x=d$fl,y=d$cty,geom="boxplot",fill=I("green"))

# basic barplot - a character string variable indicating different types/groups - pulling out counts of those groups
qplot(x=d$fl,geom="bar",fill=I("green"))

#common mistake:
qplot(x=d$fl,geom="bar",fill="green")
#illustrates distinction between setting and mapping a variable - this maps a variable, qplot misinterprets this, what comes after fill needs to be mapped on bars

# plotting curves and functions

myVec <- seq(1,100,by=0.1)
myFunc <- function(x) sin(x) + 0.1*x

# plot built in functions
qplot(x=myVec,y=sin(myVec),geom="line")
# line geom draws a straight line but this looks curved because it is so many points

#plot density distributions for probability functions
qplot(x=myVec,y=dgamma(myVec,shape=5,scale=3),geom="line")

# plot user-defined functions
qplot(x=myVec,y=myFunc(myVec),geom="line")

#-----------------------------
p1 <- ggplot(data=d,mapping=aes(x=displ,y=cty)) + geom_point()
print(p1)

p1 + theme_classic() #gets rid of background

p1 + theme_linedraw() #black frame around the plot with gridlines

p1 + theme_dark() #good with bright points

p1 + theme_base() # looks like base Rx

p1 + theme_par() # uses current par setting

p1 + theme_economist()

p1 + theme_void() # shows only data

p1 + theme_solarized()

p1 + theme_fivethirtyeight()

p1 + theme_pander()

p1 + theme_tufte()
p1
p1 + theme_few()

# major theme modifications - use theme parameters to modify font and font size
p1 + theme_classic(base_size=30,base_family="sans serif")

p2 <- ggplot(data=d,mapping=aes(x=fl,fill=fl)) + geom_bar()
p2

#flip the two coordinate axes
p2 + coord_flip() + theme_grey(base_size=20,base_family="Courier")

# minor theme modifications
p1 <- ggplot(data=d,mapping=aes(x=displ,y=cty)) + geom_point(size=5,shape=21,color="black",fill="coral")
p1
p1 <- ggplot(data=d,mapping=aes(x=displ,y=cty)) + geom_point(size=5,shape=21,color="black",fill="coral") + ggtitle("My Graph Title is Awesome")+ xlab("My x axis label") + ylab("My y axis label") + xlim(0,4) + ylim(0,20)
p1

#graph 1
g1 <- ggplot(data=d, mapping=aes(x=displ,y=cty)) + 
  geom_point() +
  geom_smooth()
print(g1)

#graph 2
g2 <- ggplot(data=d,mapping=aes(x=fl,fill=I("tomato"),color=I("black"))) + geom_bar(stat="count") + theme(legend.position="none")
print(g2)             
