library(reshape2)
setwd("C:/Users/dnarules/Desktop/Anuj")
RESULTS2_onlyCorrelation<-read.table('RESULTS2_onlyCorrelation.tsv',header=TRUE,sep='\t')
RESULTS2_onlyCorrelationCast <- dcast(RESULTS2_onlyCorrelation,p1~p2)
rownames(RESULTS2_onlyCorrelationCast) <- RESULTS2_onlyCorrelationCast$p1
RESULTS2_onlyCorrelationCast$p1 <- NULL
RESULTS2_onlyCorrelationCastMatrix <- data.matrix(RESULTS2_onlyCorrelationCast)
pdf('nerve.pdf')
heatmap(RESULTS2_onlyCorrelationCastMatrix[,35:223],Rowv=NA,Colv=NA,col = cm.colors(256))
dev.off()
pdf('neurotoxin.pdf')
heatmap(RESULTS2_onlyCorrelationCastMatrix[,224:239],Rowv=NA,Colv=NA,col = cm.colors(256))
dev.off()
pdf('muscle.pdf')
heatmap(RESULTS2_onlyCorrelationCastMatrix[,1:34],Rowv=NA,Colv=NA,col = cm.colors(256))
dev.off()

