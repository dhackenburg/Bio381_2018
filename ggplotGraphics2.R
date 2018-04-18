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
#create 4 individual graphs

#graph 1
g1 <- ggplot(data=d, mapping=aes(x=displ,y=cty)) + 
  geom_point() +
  geom_smooth()
print(g1)

#graph 2
g2 <- ggplot(data=d,mapping=aes(x=fl,fill=I("tomato"),color=I("black"))) + geom_bar(stat="count") + theme(legend.position="none")
print(g2)             

#graph 3
g3 <- ggplot(data=d, mapping=aes(x=displ,fill=I("royalblue"),color=I("black"))) + geom_histogram()
print(g3)

#graph 4
g4 <- ggplot(data=d,mapping=aes(x=fl,y=cty,fill=fl)) + geom_boxplot() + theme(legend.position="none")
print(g4)

# patchwork for awesome multipanel graphs

# place two plots hoirzontally

g1 + g2

# place 3 plots vertically
g1 + g2 + g3 + plot_layout(ncol=1)

# change relative area of each plot
g1 + g2 + plot_layout(ncol=1,heights=c(2,1))

g1 + g2 + plot_layout(ncol=2,widths=c(2,1))
                      
# add a spacer plot (under construction)
g1 + plot_spacer() + g2

# set up nested plots
g1 + {
  g2 + {
    g3 +
      g4 +
      plot_layout(ncol=1)
  }
} +
  plot_layout(ncol=1)

g1+g2 + g3 + plot_layout(ncol=1)

# / | for very intuitive layouts
(g1 | g2 | g3)/g4

(g1 | g2)/(g3 | g4)

# swapping axis orientiation within a plot

g3a <- g3 + scale_x_reverse() 
g3b <- g3 + scale_y_reverse()
g3c <- g3 + scale_x_reverse() + scale_y_reverse()

(g3 | g3a)/(g3b | g3c)

# switch orientation of coordinates

(g3 + coord_flip() | g3a + coord_flip())/(g3b + coord_flip() | g3c + coord_flip())

#ggsave for creating and saving plots
ggsave(filename="MyPlot.pdf",plot=g3,device="pdf",width=20,height=20,units="cm",dpi=300)

# mapping of variables to aesthetics

m1 <- ggplot(data=mpg, mapping=aes(x=displ,y=cty,color=class)) + geom_point()
print(m1)
m2 <- ggplot(data=mpg, mapping=aes(x=displ,y=cty,shape=class,color=class)) + geom_point()
m2

# mapping of a discrete variable to point size
m3 <- ggplot(data=mpg, mapping=aes(x=displ,y=cty,size=class,color=class)) + geom_point()
m3

# mapping a continuous variable to point size
m4 <- ggplot(data=mpg, mapping=aes(x=displ,y=cty,size=hwy,color=hwy)) + geom_point()
m4

# map a continous variable to color
m5 <- ggplot(data=mpg, mapping=aes(x=displ,y=cty,color=hwy)) + geom_point()
m5

# mapping two variables to two different aesthetics
m6 <- ggplot(data=mpg, mapping=aes(x=displ,y=cty,shape=class,color=hwy)) + geom_point()
m6

# mapping 3 variables onto shape, size and color
m7 <- ggplot(data=mpg, mapping=aes(x=displ,y=cty,shape=drv,color=fl,size=hwy)) + geom_point()
m7

# mapping a variable to the same aesthetic for two different geoms
m8 <- ggplot(data=mpg, mapping=aes(x=displ,y=cty,color=drv)) + geom_point() + geom_smooth(method="lm") #geom_smooth is regression line with confidence interval
m8

# faceting for excellent visualiztion in a set of related plots 

m9 <- ggplot(data=mpg, mapping=aes(x=displ,y=cty)) + geom_point()
m9 + facet_grid(class~fl)
m9 + facet_grid(class~fl,scales="free_y") #changes y axis for individual plots, look ease of comparing among rows
m9 + facet_grid(class~fl,scales="free")

# facet on only a single variable
m9 + facet_grid(.~class)
m9 + facet_grid(class~.)

# use facet wrap for unordered graphs
m9 + facet_wrap(~class)

m9 + facet_wrap(~class + fl)

m9 + facet_wrap(~class + fl,drop=FALSE)

# use facet in combination with aesthetics
m10 <- ggplot(data=mpg,mapping=aes(x=displ,y=cty,color=drv)) + geom_point()
m10 + facet_grid(.~class)

m11 <- ggplot(data=mpg,mapping=aes(x=displ,y=cty,color=drv)) + geom_smooth(method="lm",se=FALSE) #se says do not give me the standard error - confidence interval
m11 + facet_grid(.~class)

# fitting with boxplots over a continuous variable
m12 <- ggplot(data=mpg,mapping=aes(x=displ,y=cty)) + geom_boxplot()
m12 + facet_grid(.~class)
m13 <- ggplot(data=mpg,mapping=aes(x=displ,y=cty,group=drv,fill=drv)) + geom_boxplot()
m13
m13 + facet_grid(.~class)
