# Randomization test for regression data
# 3 April 2018
# DMH

# Preliminaries
library(ggplot2)
library(TeachingDemos)
char2seed("Cruel April")


########################################################
# FUNCTION: readData
# read in or generate data frame 
# input: file name (or nothing for demo) 
# output: 3-column data frame of observed data (ID, x, y)
# will need to completely re-do this anyway because we'll actually be reading in data 
# tip for future teaching this course is give us fake data files before class so we can practice writing functions that will actually read in the data!
#------------------------------------------------------
readData <- function(z=NULL) {
  if(is.null(z)) {
    xVar <- 1:20 
    yVar <- xVar +10*rnorm(20)
    dF <- data.frame(ID=seq_along(xVar), xVar, yVar)
    
    return(dF)
    
  }
}
readData()

########################################################
# FUNCTION: getMetric
# calculate metric for randomization test
# input: 3- column data frame for regression
# output: regression slope (single number from randomization test notes)
#------------------------------------------------------
getMetric <- function(z=NULL) {
  if(is.null(z)){
    xVar <- 1:20 
    yVar <- xVar +10*rnorm(20)
    z <- data.frame(ID=seq_along(xVar), xVar, yVar)
  }
  . <- lm(z[,3]~z[,2]) 
  . <- summary(.)
  . <- .$coefficients[2,1]
  slope <- . 
  return(slope) 
}
getMetric()

########################################################
# FUNCTION: shuffleData
# randomization data for regression analysis
# input: 3-column data frame (ID, xVar, yVar)
# output: 3-column data frame (ID, xVar, yVar) (just shuffled up!)
#------------------------------------------------------
shuffleData <- function(z=NULL) {
  if(is.null(z)){
    xVar <- 1:20 
    yVar <- xVar +10*rnorm(20)
    z <- data.frame(ID=seq_along(xVar), xVar, yVar)
  }
  z[,3] <- sample(z[,3]) # reshuffling the y values 
  # de-coupling pattern between x and y 
  # default is replace = FALSE so in one swoop shuffles data randomly
  
  return(z)
}
shuffleData()

########################################################
# FUNCTION: getPVAL
# calculate p value for observed, simulated data
# input: list of observed metric and vector of simulated metric
# output: lower, upper tail probability vector 
#------------------------------------------------------
getPVAL <- function(z=NULL) {
  if(is.null(z)){
    z <- list(xObs=runif(1), xSim=runif(1000)) }
  pLower <- mean(z[[2]]<=z[[1]]) 
  pUpper <- mean(z[[2]]>=z[[1]])
  
  return(c(pL=pLower,pU=pUpper))
}
getPVAL()

######################################
# FUNCTION: plotRanTest
# ggplot graph
# input: list of observed metric and vector of simulated metric
# output: ggplot graph
#-------------------------------------
plotRanTest <-function(z=NULL){
  if(is.null(z)){
    z <- list(xObs=runif(1),xSim=runif(1000)) }
  dF <- data.frame(ID=seq_along(z[[2]]),simX=z[[2]])
  p1 <- ggplot(data=dF,mapping=aes(x=simX))
  p1 + geom_histogram(mapping=aes(fill=I("goldenrod"),color=I("black"))) + geom_vline(aes(xintercept=z[[1]],color="blue"))
}
plotRanTest()


#---------------------------------------------------
# main body of code 
nSim <- 1000 # number of simulations 
Xsim <- rep(NA, nSim) # will hold simulated slopes 

dF <- readData()
Xobs <- getMetric(dF)

# loop through to create 1000 simulated slopes for xSim vector
for (i in seq_len(nSim)){
  Xsim[i] <- getMetric(shuffleData(dF))
}

# creating the list structure that we need for final function
slopes <- list(Xobs, Xsim)
getPVAL(slopes)
# found that 98.7% of simulated slopes are to the left of the Xobs and only 1.3% are to the right


plotRanTest(slopes)
