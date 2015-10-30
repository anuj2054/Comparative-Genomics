 library(ape)
 library(reshape2)
i=1
for( eachtree in Sys.glob("/mnt/dnarules/Anuj/Trees/RAxML_bestTree.TrimmedAligned*")){
# read the tree
 mytree<-read.tree(eachtree)
# extract the distance matrix
 x<-cophenetic(mytree)
 # change to lower triangular
 x[lower.tri(x,diag=TRUE)] <- NA 
# change to coloumnar long format
x.m<-na.omit(melt(x))
# write the coloumn to a file
 write.table(x.m, file=paste(basename(eachtree),i,'.dist',sep=""),quote=FALSE, sep='\t',row.names=FALSE,col.names=FALSE)
 i=i+1
}
