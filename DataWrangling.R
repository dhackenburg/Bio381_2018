# preliminaries
# https://github.com/daattali/timevis/tree/master/R
# http://visjs.org/docs/timeline/
# https://github.com/daattali/timevis

library(reshape2)
library(tidyr)
library(dplyr)
library(ggplot2)
library(TeachingDemos)
char2seed("Sharpei")

species <- 5
sites <- 8
abundanceRange <- 1:10
mFill <- 0.40
vec <- rep(0,species*sites) # set up empty vector for lengh of species x sites
abun <- sample(x=abundanceRange,size=round(mFill*length(vec)),replace=TRUE) #40 observations x .4 
vec[seq_along(abun)] <- abun
vec
vec <-sample(vec)
vec
aMat <- matrix(vec,nrow=species)
aMat
rownames(aMat) <- rownames(aMat,do.NULL=FALSE,prefix="Species")
colnames(aMat) <- colnames(aMat,do.NULL=FALSE,prefix="Sites")
aMat #this is wide format

# use melt from reshape2 package to get this into long form
. <- melt(aMat)
.
. <- melt(aMat,varnames=c("Species","Site"),value.name="Abundance")
head(.)
aFrame <- data.frame(cbind(Species=rownames(aMat),aMat))
aFrame

.<- gather(aFrame,Sites1:Sites8,key="Sites",value="Abundance")
.
str(.)
.$Abundance <- as.numeric(.$Abundance)
aFrameL <- .

# now able to do a bar plot with this
ggplot(aFrameL,aes(x=Sites,y=Abundance,fill=Species)) + geom_bar(position="dodge",stat="identity",color="black")

# build a subject x time experimental matrix
Treatment <- rep(c("Control","Treatment"),each=5)
Treatment
Subject <- 1:10
T1 <- rnorm(10)
T2 <- rnorm(10)
T3 <- rnorm(10)
eFrame <- data.frame(Treatment=Treatment,Subject=Subject,T1=T1,T2=T2,T3=T3)
str(eFrame)
. <- gather(eFrame, T1:T3,key="Time",value="Response")
str(.)
.$Time <- as.factor(.$Time)
eFrameL <- .
#ready for box plot
ggplot(eFrameL,aes(x=Treatment,y=Response,fill=Time)) + geom_boxplot()

# now change them back to wide format
. <- dcast(aFrameL,Species~Sites,value="Abundance")
str(.)
.

. <- spread(aFrameL,key=Sites,value=Abundance)
. <- spread(eFrameL,key=Time,value=Response)
.

# summarize and by_group

summarize(mpg,ctyM=mean(cty),ctySD=sd(cty))
. <-group_by(mpg,fl) #subset by category
head(.)
summarize(.,ctyM=mean(cty),ctySD=sd(cty),n=length(cty))

. <-group_by(mpg,fl,class) #subset by category
head(.)
summarize(.,ctyM=mean(cty),ctySD=sd(cty),n=length(cty))

.<-filter(mpg,class!="suv")
. <-group_by(.,fl,class) #subset by category
summarize(.,ctyM=mean(cty),ctySD=sd(cty),n=length(cty))

# replicate (n,expression,simplify)
# n= number of replication
#expression is any r expression or function call
# simplify defaul will kick out "array" with 1 more dimension than original output, simplify=TRUE gives vector or matrix, simplify=FALSE gives a list

#first set up matrix
myOut <- matrix(data=0,nrow=3,ncol=5)
myOut

# fill with for loop
for(i in 1:nrow(myOut)) {
  for(j in 1:ncol(myOut)) {
    myOut[i,j] <- runif(1)
  }
}
myOut
myOut <- matrix(data=runif(15),nrow=3)
myOut
mO <- replicate(n=5,100 +runif(3),simplify=TRUE)
mO

mO <- replicate(n=5,matrix(runif(6),3,2),simplify="array")
mO
print(mO[,,3])
      
      