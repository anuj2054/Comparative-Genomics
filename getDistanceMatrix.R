#setwd("/mnt/dnarules/Anuj/")
#library(seqinr)
#for(genome in basename(Sys.glob("./CnidarianGenome/*.fasta"))){
#  print(genome) 
#  system(paste("makeblastdb -in /mnt/dnarules/Anuj/CnidarianGenome/",genome," -dbtype 'nucl' -out /mnt/dnarules/Anuj/CnidarianGenome/databases/",genome," -parse_seqids",sep=""),wait=TRUE)
#}

#mydata <- list()
# mydata <- lapply(genome, read.fasta)
#for (genome in basename(Sys.glob("/mnt/dnarules/Anuj/CnidarianGenome/*.fasta"))) {
#  mydata[[genome]] <- read.fasta(paste("/mnt/dnarules/Anuj/CnidarianGenome/",genome,sep=""))
#}


#for(gene in basename(Sys.glob("/mnt/dnarules/Anuj/CnidarianGene/*.fasta"))){
#  print(gene)  
#  for(genome in basename(Sys.glob("/mnt/dnarules/Anuj/CnidarianGenome/*.fasta"))){
#    print(genome) 
#    system(paste("tblastx -db /mnt/dnarules/Anuj/CnidarianGenome/databases/",genome, " -query /mnt/dnarules/Anuj/CnidarianGene/",gene," -out /mnt/dnarules/Anuj/results/BlastResults.txt -outfmt 10 -max_target_seqs 10 -num_threads 20 -evalue 0.0001",sep=""),wait=TRUE)
#    BlastResults <- read.table("/mnt/dnarules/Anuj/results/BlastResults.txt", header=FALSE,stringsAsFactors=FALSE)
#    SubjectSeqID=BlastResults[1,2]
#    besthit=mydata[genome][c(which(names(mydata[genome]) %in% SubjectSeqID))]
#    write.fasta(sequences=besthit,names=SubjectSeqID,file.out=paste("/mnt/dnarules/Anuj/results/",gene,"AND",genome,sep=""))    
#  }
#}
#myfunction  <- function(){
#system("clustalw *.fasta")
#system("raxml alignment.fasta")

### statistics for correlation
#require(ape)
library(ape)
#library(gdata)
#arg=commandArgs(TRUE)


species= c(  "GBXJ01_", "GBYC01_", "Shys_tr", "GASU01.", "Mcav_tr", "Pdae_v1", "Fscu_tr", "Halophi", "Pstr_tr", "GBRG01_", "GBGH01_", "GAOL01_", "Maur_tr", "GBFD01_","GAWH01_", "GARY01.", "Aele_tr", "GBGP01_")
#myrownames=as.vector(t(outer(species,species, paste, sep="."))) 
#proteins=substr(basename(list.files("/mnt/dnarules/Anuj/QueryProtein")), 1, nchar(basename(list.files("/mnt/dnarules/Anuj/QueryProtein"))) - 6) 
files <- list.files(path="/mnt/dnarules/Anuj/Trees/", pattern="RAxML_bestTree.TrimmedAligned")
proteins=substr( files,1,nchar(files)-10) 
#mycolnames=proteins
mytable=data.frame(matrix(NA, nrow=(length(species)*(length(species)-1))/2, ncol=length(proteins)))
#rownames(mytable) <- myrownames
colnames(mytable) <- proteins


#tree1=read.tree("/mnt/dnarules/Anuj/Trees/RAxML_bestTree.TrimmedAlignedmuscle3.fasta.phy")
#tree2=read.tree("/mnt/dnarules/Anuj/Trees/RAxML_bestTree.TrimmedAlignedmuscle4.fasta.phy")

#files <- list.files(path="/mnt/dnarules/Anuj/Trees/", pattern="RAxML_bestTree.TrimmedAligned")
mytrees <- lapply(files, function(x) {
    read.tree(paste("/mnt/dnarules/Anuj/Trees/",x,sep="")) # load file
})


### two ways is to use cophenetic or to use edge.lenght
#mytable[1,1] <- cophenetic(mytrees[[1]])["Aele_tr","GBYC01_"]
#mytable[1,2] <- cophenetic(mytrees[[1]])["Aele_tr","GBYC01_"]

### two errors over here, the subscript out of bounds comes because not all trees have all the species, and the m and n loops put the different values in the same j loop

#for(i in 1:length(mycolnames)){
#m=1
#n=m+1
#for(j in 1:length(myrownames)){

i=1
j=1

while(i<length(proteins)){
#while(j<length(myrownames)){
for(m in 1:(length(species)-1)){
for(n in (m+1):length(species)){
rownames(mytable)[j] <- paste(species[m],".",species[n],sep="")
try(mytable[j,i] <- cophenetic(mytrees[[i]])[species[m],species[n]],silent=TRUE) 
#mytable[j,i] <- cophenetic(mytrees[[i]])[species[m],species[n]]
j=j+1
#print("hello")
}
}
#}
j=1
i=i+1
}

#mytable[j,i] <- cophenetic(mytrees[[i]])[species[18],species[2]]
#m=m++
#n=n++
#}}
#}}

#mytable[1,1] <- cophenetic(mytrees[[1]])[species[1],species[2]]
#mytable[2,1] <- cophenetic(mytrees[[1]])[species[1],species[3]]
#mytable[3,1] <- cophenetic(mytrees[[1]])[species[1],species[4]]
#mytable[4,1] <- cophenetic(mytrees[[1]])[species[1],species[5]]
#mytable[5,1] <- cophenetic(mytrees[[1]])[species[1],species[6]]
#mytable[1,2] <- cophenetic(mytrees[[2]])[species[2],species[3]]
#mytable[2,2] <- cophenetic(mytrees[[2]])[species[2],species[4]]

write.table(mytable,file="mytable")
library(corrgram)
corrgram(mytable,upper.panel=NULL,lower.panel=panel.shade,main="evolutionary correlation between nerve muscle and neurotoxin pathways in cnidaria")

#make plot
#dev.print(pdf, file="filename.pdf");
#or
#make plot
#dev.copy(device = png, filename = 'MyPlot.png', width = 1000, height = 500) 
#dev.off()
#or
#pdf('filename.pdf')
# make plot
#dev.off()




######################################################################################3
#matrix1<-cophenetic(tree1)
#matrix2<cophenetic(tree2)
#int(PatristicDistMatrix)
#PatristicDistMatrixMyosin1<-cophenetic(treemyosin1)
#PatristicDistMatrixSCN1A["GBFD","GBGH"]

#### two ways is to use unmatrix or to use upper.tri
#vector1=unmatrix(matrix1)
#vector2=unmatrix(matrix2)
#PatristicDistVector= PatristicDistMatrix[upper.tri(PatristicDistMatrix,diag=FALSE)]
#Rnew= R[upper.tri(R,diag=FALSE)]
#cor(as.vector(Snew),as.vector(Rnew))

## this is the second method after using the cophenetic but this is not proper because we dont know what the edge.lenghts represent. 
#S=treemyosin1$edge.length
#R=treeSCN1A$edge.length
#cor(S,R)
