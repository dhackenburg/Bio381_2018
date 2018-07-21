Frameworks <- c(rep("Well-being",8),rep("CES",7),rep("Overlapping",3))
Frameworks
Categories <- c("mental health","autonomy","physical health","certainty","overall","inspiration","belonging","capability","culturalheritage","recreation","aesthetic","perspective","culturaldiversity","education","social capital","identity","sense of place", "spirituality")
Mentions <- c(77,46,46,31,31,23,77,31,62,38,31,15,8,38,77,54,38,15)

df <- data.frame(Frameworks,Categories,Mentions)
df

mdf <- melt(df)
mdf
library(reshape2)
mdf <- arrange(mdf,Frameworks,desc(value))
str(mdf)
library(ggplot2)
library(ggthemes)
ggplot(data=mdf,mapping=aes(x=reorder(Categories,-value),y=value,fill=Frameworks))+geom_col(position="dodge")+ facet_wrap(~Frameworks,scales="free_x")+
  scale_x_discrete(name="Categories") +
  scale_y_continuous(name="Mentions (% ofTotal)") +
  theme(axis.text.x=element_text(angle=90, hjust=.95,vjust=0, size=10,face="bold"))+theme(legend.position="none")

