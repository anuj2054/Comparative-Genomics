################preparing the individual gene and protein files #################33

#awk '/^>/{s="muscle"++d".fasta"} {print > "/mnt/dnarules/Anuj/queryDNA/"s}' /mnt/dnarules/Anuj/queryDNA/muscleDNA.fasta
#awk '/^>/{s="nerve"++d".fasta"} {print > "/mnt/dnarules/Anuj/queryDNA/"s}' /mnt/dnarules/Anuj/queryDNA/nerveDNA.fasta

##################createing the databases####################################

# echo " creating databases"
#for transcriptomePath in /mnt/dnarules/Anuj/CnidarianTranscriptome/*.fasta
#do
#transcriptome=`basename $transcriptomePath`
#makeblastdb -in /mnt/dnarules/Anuj/CnidarianTranscriptome/$transcriptome -dbtype 'nucl' -out /mnt/dnarules/Anuj/CnidarianTranscriptome/databases/$transcriptome -parse_seqids
#echo "database created"
#echo "moving onto next transcriptome"
#done
#################blasting the databases##################################################

#for proteinPath in /mnt/dnarules/Anuj/queryProtein/*.fasta
#do
#protein=`basename $proteinPath`
#for transcriptomePath in /mnt/dnarules/Anuj/CnidarianTranscriptome/*.fasta
#do
#transcriptome=`basename $transcriptomePath`
#echo "blasting" $transcriptome " with " $protein
##tblastn -db /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome -query /mnt/dnarules/Anuj/CnidarianGene/$gene -out /mnt/dnarules/Anuj/results/BlastResults$gene$genome -outfmt 6 -max_target_seqs 10 -num_threads 20 -evalue 0.0001
#tblastn -db /mnt/dnarules/Anuj/CnidarianTranscriptome/databases/$transcriptome -query /mnt/dnarules/Anuj/QueryProtein/$protein -out /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome -outfmt "6 qseqid sseqid evalue qseq sseq sstart send" -max_target_seqs 10 -num_threads 20 -evalue 0.0001
#echo "extracting only the best hit portion and keeping it in a seperate file"

#if [[ -s /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome ]]
#then
#echo " /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome  has data."

##Rscript /mnt/dnarules/Anuj/getBestHit.R /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome $transcriptome > /mnt/dnarules/Anuj/Blasted/BestHitOf$protein$transcriptome
###echo "extracting whole contig sequence and keeping it in a file"
##SSeqID=`Rscript /mnt/dnarules/Anuj/getBestHit.R `
#SSeqID=$(Rscript -e 'arg=commandArgs(TRUE); BlastResults <- read.table(arg[1], header=FALSE,stringsAsFactors=FALSE);SubjectSeqID=BlastResults[1,2];cat(SubjectSeqID);' /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome)
#SStart=$(Rscript -e 'arg=commandArgs(TRUE); BlastResults <- read.table(arg[1], header=FALSE,stringsAsFactors=FALSE);SubjectSeqID=BlastResults[1,6];cat(SubjectSeqID);' /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome)
#SEnd=$(Rscript -e 'arg=commandArgs(TRUE); BlastResults <- read.table(arg[1], header=FALSE,stringsAsFactors=FALSE);SubjectSeqID=BlastResults[1,7];cat(SubjectSeqID);' /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome)

#if [ $SStart -gt $SEnd ]
#then 
#temp=$SStart
#SStart=$SEnd
#SEnd=$temp
#blastdbcmd -db /mnt/dnarules/Anuj/CnidarianTranscriptome/databases/$transcriptome -dbtype nucl -entry $SSeqID -range $SStart-$SEnd -outfmt %f -out /mnt/dnarules/Anuj/Blasted/unreversedDNABestHitOf$protein$transcriptome
#/home/dnarules/seqtk-master/seqtk seq -r /mnt/dnarules/Anuj/Blasted/unreversedDNABestHitOf$protein$transcriptome > /mnt/dnarules/Anuj/Blasted/DNABestHitOf$protein$transcriptome
#else
#blastdbcmd -db /mnt/dnarules/Anuj/CnidarianTranscriptome/databases/$transcriptome -dbtype nucl -entry $SSeqID -range $SStart-$SEnd -outfmt %f -out /mnt/dnarules/Anuj/Blasted/DNABestHitOf$protein$transcriptome
#fi

#Rscript -e 'library(seqinr);arg=commandArgs(TRUE);sequence=read.fasta(arg[1],seqonly=TRUE); write.fasta(sequence,c(arg[2],arg[3]),file.out=arg[1])' /mnt/dnarules/Anuj/Blasted/DNABestHitOf$protein$transcriptome $transcriptome $protein
#else
#echo " /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome  is empty."
#rm /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome
#fi
#echo "moving onto next transcriptome"
#done
#done


#find . -name "*" -size 0k |xargs rm
#import into geneious and have a look

###############aligning the blast results#############################################

#for queryProteinPath in /mnt/dnarules/Anuj/QueryProtein/*.fasta
#do
#protein=`basename $queryProteinPath`
#for transcriptomePath in /mnt/dnarules/Anuj/CnidarianTranscriptome/*.fasta
#do
#transcriptome=`basename $transcriptomePath`
#echo " concantenating"
#cat /mnt/dnarules/Anuj/Blasted/DNABestHitOf$protein$transcriptome >>  /mnt/dnarules/Anuj/Aligned/unaligned$protein

#done
#echo " aligning"
#clustalo -i /mnt/dnarules/Anuj/Aligned/unaligned$protein -o /mnt/dnarules/Anuj/Aligned/Aligned$protein --force

#done


###################trimming the alignment#######################################################

for queryproteinPath in /mnt/dnarules/Anuj/QueryProtein/*.fasta
do
protein=`basename $queryproteinPath`
for transcriptomePath in /mnt/dnarules/Anuj/CnidarianTranscriptome/*.fasta
do
transcriptome=`basename $transcriptomePath`
echo "trimming the alignments"

##/home/dnarules/Gblocks_0.91b/Gblocks  /mnt/dnarules/Anuj/Aligned/Aligned$gene
##/home/dnarules/trimAl/source/trimal -in /mnt/dnarules/Anuj/Aligned/Aligned$gene -out /mnt/dnarules/Anuj/Aligned/Trimmed$gene -automated1 -fasta -gt 0.8 -st 0.001
/home/dnarules/trimAl/source/trimal -in /mnt/dnarules/Anuj/Aligned/Aligned$protein -out /mnt/dnarules/Anuj/Trimmed/Trimmed$protein -fasta -gt 0.8 -st 0.001

done
done

##### testing out git ######


########################## making the tree ################################3333

##### converting to the phylip format
#for files in /mnt/dnarules/Anuj/Trimmed/*.fasta
#do
#name=`basename $files`
#perl fasta2phylip.pl /mnt/dnarules/Anuj/Trimmed/$name > /mnt/dnarules/Anuj/Trimmed/$name.phy
#done 


#echo " making the tree"

#for proteinPath in /mnt/dnarules/Anuj/Trimmed/*.fasta
#do
#protein=`basename $proteinPath`
#for transcriptomePath in /mnt/dnarules/Anuj/CnidarianTranscriptome/*.fasta
#do
#transcriptome=`basename $transcriptomePath`

#./raxmlHPC-PTHREADS -T 20 -f a -x 339 -m PROTGAMMADAYHOFF -p 932 -N autoMRE -s /mnt/dnarules/Anuj/Trimmed/$protein -n $protein -O -w /mnt/dnarules/Anuj/Trees/

#echo " moving onto next query"
#done
#done
#########################do the correlation mirror tree study ########################################

#Rscript getDistanceMatrix.R

#for treePath in /mnt/dnarules/Anuj/Trees/RAxML_bestTree*
#do
#tree=`basename $treePath`
#echo "this is the"  $treePath
#Rscript /mnt/dnarules/Anuj/getDistanceMatrix.R $treePath > /mnt/dnarules/Anuj/Distances/distanceOf$tree.tsv
##Rscript mt_pvals.R  alltaxids.txt  ./distances/  40  0.05  1000 ./RESULTS.csv
#done 

#######################selection study using codeml ########################3




#################### compare the topology of the trees #######################33

# find the tol-mirror tree too and execute that
# distory kdetrees or dendextend or ape
# SH test
# also make gene trees or species tree find what these are in R CRAN
# ancestral state reconstruction
# diversification time

