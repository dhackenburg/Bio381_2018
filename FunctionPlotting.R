# Plotting functions, sweeping parameters
# 29 March 2017
# DMH

#matrix in r is a vector under its shell but with two dimensions: rows and columns
#use differeing numbers of matrix rows and columns

z <- matrix(runif(9),nrow=3)
z[3,3]
z <- matrix(runif(20),nrow=5)
z
z[5,4]
z[4,5]

# using double for loops
m <- matrix(round(runif(20),digits=2),nrow=5)
m
for (i in 1:nrow(m)){
  m[i,] <- m[i,] + i
  }
print(m)

for (j in 1:ncol(m)){
  m[,j] <- m[,j] + j
}
print(m)

# loop over rows and columns
for (i in 1:nrow(m)){
  for(j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
  } # end of j column loop
} # end of i row loop
m

# Sweeping over parameters in an equation 

# Species area relationship
# S = cA^z

######################################
# FUNCTION: SpeciesAreaCurve
# creates power function for relationship of S and A
# input: A = vector of island areas
#      : c = intercept constant
#      : z = slope constant 
# output: S = vector of species richness values
#-------------------------------------
SpeciesAreaCurve <-function(A=1:5000,c=0.5,z=0.26){
  S <- c*(A^z)
  return(S)
}
# head(SpeciesAreaCurve())

######################################
# FUNCTION: SpeciesAreaPlot
# plot curve in base graphics
# input: A=vector of areas
#      : c = intercept parameter
#      : z = slope
# output: base graph with parameter values
#-------------------------------------
SpeciesAreaPlot <-function(A=1:5000,c=0.5,z=0.26){
  plot(x=A,y=SpeciesAreaCurve(A,c,z),
       type="l",
       xlab="Island Area",
       ylab="S",
       ylim=c(0,2500))
  mtext(paste("c =",c,"z =",z),cex=0.7)
  return()
}
SpeciesAreaPlot()

# now build a grid of plots
# each with different parameter values
# global variables
cPars <- c(100,150,175)
zPars <- c(0.10,0.16,0.26,0.30)
par(mfrow=c(3,4))

# enter into double loop for plotting
for (i in 1:length(cPars)) {
  for (j in 1:length(zPars)){
    SpeciesAreaPlot(c=cPars[i],z=zPars[j])
  }
}

par(mfrow=c(1,1))
# plotting redux with ggplot
library(ggplot2)
cPars <- c(100,150,175)
zPars <- c(0.10,0.16,0.26,0.30)
Area <- 1:5

#set up model frame
modelFrame <- expand.grid(c=cPars,
                          z=zPars,
                          A=Area)
head(modelFrame)
modelFrame
modelFrame$S <- NA
modelFrame

# tricky double for loop for filling new data frame
for (i in 1:length(cPars)){
  for (j in 1:length(zPars)){
    modelFrame[modelFrame$c==cPars[i] & modelFrame$z==zPars[j],"S"] <- SpeciesAreaCurve(A=Area,c=cPars[i],z=zPars[j])
  } # closes the zPars loop
} #close the cPars loop
modelFrame

p1 <- ggplot(data=modelFrame)
p1 + geom_line(mapping=aes(x=A,y=S)) + facet_grid(c~z)
p2 <- p1
p2 + geom_line(mapping=aes(x=A,y=S,group=c)) + facet_grid(.~z)
