# ggplot graphics 3
#12 April 2018
#DMH

# preliminaries
library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("Sienna")
d <- mpg
#standard plot with all of the data
p1 <- ggplot(data=d,mapping=aes(x=displ,y=hwy)) + geom_point() + geom_smooth()
p1

# break out drive types
p2 <- ggplot(data=d,mapping=aes(x=displ,y=hwy,group=drv)) + geom_point() + geom_smooth() #repeat grouping for each variable
p2

#grouping based on color
p3 <- ggplot(data=d,mapping=aes(x=displ,y=hwy,color=drv)) + geom_point() + geom_smooth() 
p3

#map to fill for confidence interval
p4 <- ggplot(data=d,mapping=aes(x=displ,y=hwy,fill=drv)) + geom_point() + geom_smooth() 
p4

#use both fill and color for both effects as aesthetics
p5 <- ggplot(data=d,mapping=aes(x=displ,y=hwy,fill=drv,color=drv)) + geom_point() + geom_smooth() 
p5

# use aesthetic mappings within each group to override defauls
p6 <- ggplot(data=d,mapping=aes(x=displ,y=hwy,color=drv)) + geom_point(data=d[d$drv=="4",]) + geom_smooth() 
p6

# instead of subsetting, just map an aesthetic
p7 <- ggplot(data=d,mapping=aes(x=displ,y=hwy)) + geom_point(mapping=aes(color=drv)) + geom_smooth() 
p7

p8 <- ggplot(data=d,mapping=aes(x=displ,y=hwy)) + geom_point() + geom_smooth(mapping=aes(color=drv))
p8

#subset in first layer to eliminate some data entirely
p8 <- ggplot(data=d[d$drv!="4",],mapping=aes(x=displ,y=hwy)) + geom_point(mappin=aes(color=drv)) + geom_smooth()
p8

#geoms have additional attributes that can be set, in addition to any aesthetics that are mapped                                                         
p9 <- ggplot(data=d[d$drv!="4",],mapping=aes(x=displ,y=hwy)) + geom_point(mappin=aes(color=drv)) + geom_smooth(color="black",size=2,fill="steelblue",method="lm")
p9

# use bar plots for categorical variables
table(d$drv)
p10 <- ggplot(data=d,mapping=aes(x=drv)) + geom_bar(color="black",fill="goldenrod")
p10      

p11 <- ggplot(data=d,mapping=aes(x=drv)) + stat_count(color="black",fill="goldenrod")
p11

# can also get out proportions
p12 <- ggplot(data=d,mapping=aes(x=drv,y=..prop..,group=1)) + geom_bar(color="black",fill="goldenrod")
p12

#aesthetic mapping for multiple groups of bars
p13 <- ggplot(data=d,mapping=aes(x=drv,fill=fl)) + geom_bar()
p13

#unstack bars
p1 <- ggplot(data=d,mapping=aes(x=drv,fill=fl)) + geom_bar(position="identity")
p1

# make them transparent with alpha attribute
p1 <- ggplot(data=d,mapping=aes(x=drv,fill=fl)) + geom_bar(alpha=1/2,position="identity")
p1

p1 <- ggplot(data=d,mapping=aes(x=drv,color=fl)) + geom_bar(fill=NA,position="identity")
p1

p1 <- ggplot(data=d,mapping=aes(x=drv,fill=fl)) + geom_bar(position="fill")
p1

p1 <- ggplot(data=d,mapping=aes(x=drv,fill=fl)) + geom_bar(position="dodge",color="black")
p1

dTiny <- tapply(X=d$hwy,INDEX=as.factor(d$fl),FUN=mean) #calculates group means
dTiny <-data.frame(hwy=dTiny)
dTiny <- cbind(fl=row.names(dTiny),dTiny) # set up the data frame
dTiny

p2 <- ggplot(data=dTiny,mapping=aes(x=fl,y=hwy,fill=fl)) + geom_bar(stat="identity")
p2

d <- hwy
# use the stats geom to create the classic bar plot
p1 <- ggplot(data=d,mapping=aes(x=fl,y=hwy)) + stat_summary(fun.y=mean,fun.ymin=function(x) mean(x) - sd(x),fun.ymax=function(x) mean(x) + sd(x))
p1

# now put them together for the bar plot with error bars

p1 <- ggplot(data=d,mapping=aes(x=fl,y=hwy)) + stat_summary(fun.y=mean,fun.ymin=function(x) mean(x) - sd(x),fun.ymax=function(x) mean(x) + sd(x)) + geom_bar(data=dTiny,mapping=aes(x=fl,fill=fl)),stat="identity"
p1                                          

# use a boxplot instead!
p1 <- ggplot(data=d,mapping=aes(x=fl,y=hwy,fill=fl)) + geom_boxplot()
p1 + theme_classic()

# now add the data
p1 <- ggplot(data=d,mapping=aes(x=fl,y=hwy)) + geom_boxplot(fill="thistle",outlier.shape=22) + geom_point(position=position_jitter(width=0.2,height=0.7),color="grey60") # position "jitter" to spread
p1
