library("MatrixEQTL")
useModel <- modelLINEAR
base.dir <- "."
SNP_file_name <- paste(base.dir, "/eQTL.406.SNP.txt", sep="")
expression_file_name <- paste(base.dir, "/TPM_406_qqnorm.txt", sep="")
covariates_file_name <- paste(base.dir, "/cov.finish.txt", sep="")
output_file_name = tempfile()
pvOutputThreshold = 1e-6
errorCovariance = numeric()
snps = SlicedData$new()
snps$fileDelimiter = "\t"
snps$fileOmitCharacters = "NA"
snps$fileSkipRows = 1
snps$fileSkipColumns = 1
snps$fileSliceSize = 2000
snps$LoadFile(SNP_file_name)
gene = SlicedData$new()
gene$fileDelimiter = "\t"
gene$fileOmitCharacters = "NA"
gene$fileSkipRows = 1
gene$fileSkipColumns = 1
gene$fileSliceSize = 2000
gene$LoadFile(expression_file_name)
cvrt = SlicedData$new()
cvrt$fileDelimiter = "\t"
cvrt$fileOmitCharacters = "NA"
cvrt$fileSkipRows = 1
cvrt$fileSkipColumns = 1
if(length(covariates_file_name)>0) {
cvrt$LoadFile(covariates_file_name)
}
me = Matrix_eQTL_engine(
snps = snps,
gene = gene,
cvrt = cvrt,
output_file_name = output_file_name,
pvOutputThreshold = pvOutputThreshold,
useModel = useModel,
errorCovariance = errorCovariance,
verbose = TRUE,
pvalue.hist = TRUE,
min.pv.by.genesnp = FALSE,
noFDRsaveMemory = FALSE)
unlink(output_file_name)
all_results <- me$all$eqtls
write.table(all_results,"eQTL.cov.r2.txt",quote=F,row.names=T,col.names=T,sep="\t")
print("cov.finish")
dfFull = me$param$dfFull
tstat = me$all$eqtls$statistic
r = tstat / sqrt(dfFull + tstat^2)
R2 = r^2
write.table(R2,"eQTL.cov.r2.finish.txt",quote=F,row.names=T,col.names=T,sep="\t")
jpeg(file = "cov.jpg",width=600,height=600)
plot(me)
dev.off()
save(me,file="me.Rdata")
