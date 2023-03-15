library(lmerTest)
df <- read.table("./traits_input.txt",header = T,sep = "\t")
df$Group <- factor(df$Group)
for (i in 2:(ncol(df)-4)) {
  exp_i <- df[,i]
  exp_i <- as.data.frame(exp_i)
  colnames(exp_i)[1] <- "Trait"
  fit <- lmer(exp_i$Trait ~  Type + PC1 + PC2 + PC3 + (1|Group),data=df)
  block_pvalue <- paste(colnames(df)[i],anova(fit)[1,6],sep = "&")
  print(block_pvalue)
}
