
library(made4)
biocLite("made4")
biocLite("BiocUpgrade")

res_mat <- read.csv("res_mat_abun.csv.csv")
bac_mat <- read.csv("bac_mat_abun.csv.csv")
vf_mat <- read.csv("vf_mat_abun.csv.csv")

str(res_mat)
#so clean thus up by setting all values to numeric, except not the gene names
res_mat_all <- res_mat[,-c(1)]
res_mat_all[] <- lapply(res_mat_all[], as.numeric)
rownames(res_mat_all) <- res_mat$Name
head(res_mat_all)
str(res_mat_all)
none <- lapply(res_mat_all, function(x) all(x == 0))
which(none == "TRUE")
# remove those 6 columns
res_mat2 <- res_mat_all[,-c(4,10,11,15,21,24)]
head(res_mat_all)
str(res_mat_all)

bac_mat_all <- bac_mat[,-c(1)]
bac_mat_all[] <- lapply(bac_mat_all[], as.numeric)
rownames(bac_mat_all) <- bac_mat$Name
bac_mat2 <- bac_mat_all[,-c(4,10,11,15,21,24)]
head(bac_mat2)
str(bac_mat2)

vf_mat_all <- vf_mat[,-c(1)]
vf_mat_all[] <- lapply(vf_mat_all[], as.numeric)
rownames(vf_mat_all) <- vf_mat$Name
vf_mat2 <- vf_mat_all[,-c(4,10,11,15,21,24)]
head(vf_mat2)
str(vf_mat2)

source("https://bioconductor.org/biocLite.R")
install.packages("BiocInstaller",repos="http://bioconductor.org/packages/3.6/bioc")
biocLite("made4")
biocLite("BiocUpgrade")
browseVignettes("made4")

