library(lmerTest)
df <- read.table("TWAS_input.txt",header = T,sep = "\t")
df$Group=factor(df$Group)
for (i in 2:(ncol(df)-8)) {
  exp_i <- df[,i]
  exp_i <- as.data.frame(exp_i)
  colnames(exp_i)[1] <- "Gene"
  fit <- lmer(RS ~  exp_i$Gene + PC1 + PC2 + PC3 + (1|Group),data=df)
  TWAS_pvalue <- paste(colnames(df)[i],anova(fit)[1,6],sep = "&")
  print(TWAS_pvalue)
}
