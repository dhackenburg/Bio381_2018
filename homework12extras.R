#Homework 12 extras


table(MyData$MAILING.LIST)

p1 <- ggplot(data=MyData,mapping=aes(x=TREATMENT,fill=PE.RANK)) + geom_bar(position="dodge",color="black")
p1

p2 <-ggplot(data=MyData,mapping=aes(x=TREATMENT,fill=PK.Rank)) + geom_bar(position="dodge")
p2

p3 <- ggplot(data=MyData,mapping=aes(x=TREATMENT,color=factor(CONCERN))) + geom_bar
p3

d <- MyData
d
d$CONCERN[d$CONCERN==0] <- "No"
d$CONCERN[d$CONCERN==1] <- "Yes"
d$CONCERN.LEVEL[d$CONCERN.LEVEL==0] <- "Not Concerned"
d$CONCERN.LEVEL[d$CONCERN.LEVEL==1] <- "Only a Little Concerned"
d$CONCERN.LEVEL[d$CONCERN.LEVEL==3] <- "Somewhat Concerned"
d$CONCERN.LEVEL[d$CONCERN.LEVEL==5] <- "Extremely Concerned"

d
treatment_conc <- ggplot(data=MyData,mapping=aes(x=TREATMENT,fill=factor(CONCERN.LEVEL,levels = c("Not Concerned","Only a Little Concerned","Somewhat Concerned","Extremely Concerned")))) + geom_bar()
treatment_conc
levels(d$CONCERN.LEV