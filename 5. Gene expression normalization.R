# qqnorm
gene <- read.table("TPM.txt",header=T,row.names = 1,sep="\t")
mydata<-list()
for (i in seq_along(gene)){
  mydata[[i]] <- (qqnorm(gene[[i]]))$x
}
write.table(mydata,file="TPM_qqnorm.txt",quote=F,row.names=T,col.names=T,sep="\t")
# peer
library(peer)
## The data matrix is assumed to have N rows and G columns, where N is the number of samples, and G is the number of genes.
expr = read.table("TPM_qqnorm.txt", header=F, sep="\t")
model = PEER()
## set data and parameters
PEER_setNk(model,10)
PEER_setPhenoMean(model,as.matrix(expr))
## set priors
PEER_setPriorAlpha(model,0.001,0.1)
PEER_setPriorEps(model,0.1,10.)
PEER_setNmax_iterations(model,1000)
## perform inference
PEER_update(model)
#factors
factors = PEER_getX(model)
write.table(factors,"exp.peer.txt",quote=F,row.names=F,col.names=F,sep="\t")
pdf("all.pdf")
PEER_plotModel(model)
dev.off()
