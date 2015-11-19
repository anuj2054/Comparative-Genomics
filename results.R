library(reshape2)
setwd("/home/dnarules/Desktop/")
RESULTS<-read.table('results.tsv',header=TRUE,sep='\t')
RESULTS <- RESULTS[RESULTS$p.value<0.05,]
RESULTS_onlyCorrelation <- data.frame(RESULTS$p1,RESULTS$p2,RESULTS$r)
RESULTS_onlyCorrelationCast <- dcast(RESULTS_onlyCorrelation,RESULTS.p1~RESULTS.p2)
rownames(RESULTS_onlyCorrelationCast) <- RESULTS_onlyCorrelationCast$RESULTS.p1
RESULTS_onlyCorrelationCast$RESULTS.p1 <- NULL
RESULTS_onlyCorrelationCastMatrix <- data.matrix(RESULTS_onlyCorrelationCast)
pdf('all.pdf')
heatmap(RESULTS_onlyCorrelationCastMatrix,Rowv=NA,Colv=NA,col = cm.colors(256))
dev.off()
pdf('muscle.pdf')
heatmap(RESULTS_onlyCorrelationCastMatrix[,1:34],Rowv=NA,Colv=NA,col = cm.colors(256))
dev.off()
pdf('nerve.pdf')
heatmap(RESULTS_onlyCorrelationCastMatrix[,35:223],Rowv=NA,Colv=NA,col = cm.colors(256))
dev.off()
pdf('neurotoxin.pdf')
heatmap(RESULTS_onlyCorrelationCastMatrix[,224:239],Rowv=NA,Colv=NA,col = cm.colors(256))
dev.off()


