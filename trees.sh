################preparing the individual gene and protein files #################33

#awk '/^>/{s="muscle"++d".fasta"} {print > "/mnt/dnarules/Anuj/queryDNA/"s}' /mnt/dnarules/Anuj/queryDNA/muscleDNA.fasta
#awk '/^>/{s="nerve"++d".fasta"} {print > "/mnt/dnarules/Anuj/queryDNA/"s}' /mnt/dnarules/Anuj/queryDNA/nerveDNA.fasta

##################createing the databases####################################

#echo " creating databases"
#for transcriptomePath in /home/dnarules/Desktop/DATA2/*.fasta
#do
#transcriptome=`basename $transcriptomePath`
#makeblastdb -in /home/dnarules/Desktop/DATA2/$transcriptome -dbtype 'nucl' -out /home/dnarules/Desktop/CnidarianTranscriptome/databases/$transcriptome -parse_seqids
#echo "database created"
#echo "moving onto next transcriptome"
#done
#################blasting the databases##################################################

#mkdir Blasted
#for proteinPath in /home/dnarules/Desktop/QueryProtein/*.fasta
#do
#protein=`basename $proteinPath`
#for transcriptomePath in /home/dnarules/Desktop/CnidarianTranscriptome/*.fasta
#do
#transcriptome=`basename $transcriptomePath`
#echo "blasting" $transcriptome " with " $protein
##tblastn -db /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome -query /mnt/dnarules/Anuj/CnidarianGene/$gene -out /mnt/dnarules/Anuj/results/BlastResults$gene$genome -outfmt 6 -max_target_seqs 10 -num_threads 20 -evalue 0.0001
#tblastn -db /home/dnarules/Desktop/CnidarianTranscriptome/databases/$transcriptome -query /home/dnarules/Desktop/QueryProtein/$protein -out /home/dnarules/Desktop/Blasted/BlastResults$protein$transcriptome -outfmt "6 qseqid sseqid evalue qseq sseq sstart send" -max_target_seqs 10 -num_threads 20 -evalue 0.0001
#echo "extracting only the best hit portion and keeping it in a seperate file"

#if [[ -s /home/dnarules/Desktop/Blasted/BlastResults$protein$transcriptome ]]
#then
#echo " /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome  has data."

##Rscript /mnt/dnarules/Anuj/getBestHit.R /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome $transcriptome > /mnt/dnarules/Anuj/Blasted/BestHitOf$protein$transcriptome
###echo "extracting whole contig sequence and keeping it in a file"
##SSeqID=`Rscript /mnt/dnarules/Anuj/getBestHit.R `
#SSeqID=$(Rscript -e 'arg=commandArgs(TRUE); BlastResults <- read.table(arg[1], header=FALSE,stringsAsFactors=FALSE);SubjectSeqID=BlastResults[1,2];cat(SubjectSeqID);' /home/dnarules/Desktop/Blasted/BlastResults$protein$transcriptome)
#SStart=$(Rscript -e 'arg=commandArgs(TRUE); BlastResults <- read.table(arg[1], header=FALSE,stringsAsFactors=FALSE);SubjectSeqID=BlastResults[1,6];cat(SubjectSeqID);' /home/dnarules/Desktop/Blasted/BlastResults$protein$transcriptome)
#SEnd=$(Rscript -e 'arg=commandArgs(TRUE); BlastResults <- read.table(arg[1], header=FALSE,stringsAsFactors=FALSE);SubjectSeqID=BlastResults[1,7];cat(SubjectSeqID);' /home/dnarules/Desktop/Blasted/BlastResults$protein$transcriptome)

#if [ $SStart -gt $SEnd ]
#then 
#temp=$SStart
#SStart=$SEnd
#SEnd=$temp
#blastdbcmd -db /home/dnarules/Desktop/CnidarianTranscriptome/databases/$transcriptome -dbtype nucl -entry $SSeqID -range $SStart-$SEnd -outfmt %f -out /home/dnarules/Desktop/Blasted/unreversedDNABestHitOf$protein$transcriptome
#/home/dnarules/seqtk-master/seqtk seq -r /home/dnarules/Desktop/Blasted/unreversedDNABestHitOf$protein$transcriptome > /home/dnarules/Desktop/Blasted/DNABestHitOf$protein$transcriptome
#else
#blastdbcmd -db /home/dnarules/Desktop/CnidarianTranscriptome/databases/$transcriptome -dbtype nucl -entry $SSeqID -range $SStart-$SEnd -outfmt %f -out /home/dnarules/Desktop/Blasted/DNABestHitOf$protein$transcriptome
#fi

#Rscript -e 'library(seqinr);arg=commandArgs(TRUE);sequence=read.fasta(arg[1],seqonly=TRUE); write.fasta(sequence,c(arg[2],arg[3]),file.out=arg[1])' /home/dnarules/Desktop/Blasted/DNABestHitOf$protein$transcriptome $transcriptome $protein
#else
#echo " /mnt/dnarules/Anuj/Blasted/BlastResults$protein$transcriptome  is empty."
#rm /home/dnarules/Desktop/Blasted/BlastResults$protein$transcriptome
#fi
#echo "moving onto next transcriptome"
#done
#done


#find . -name "*" -size 0k |xargs rm
#import into geneious and have a look

###############aligning the blast results#############################################

#mkdir Aligned
#for queryProteinPath in /home/dnarules/Desktop/QueryProtein/*.fasta
#do
#protein=`basename $queryProteinPath`
#for transcriptomePath in /home/dnarules/Desktop/CnidarianTranscriptome/*.fasta
#do
#transcriptome=`basename $transcriptomePath`
#echo " concantenating"
#cat /home/dnarules/Desktop/Blasted/DNABestHitOf$protein$transcriptome >>  /home/dnarules/Desktop/Aligned/unaligned$protein

#done
#echo " aligning"
#clustalo -i /home/dnarules/Desktop/Aligned/unaligned$protein -o /home/dnarules/Desktop/Aligned/Aligned$protein --force

#done


###################trimming the alignment#######################################################

#mkdir Trimmed

#for queryproteinPath in /home/dnarules/Desktop/QueryProtein/*.fasta
#do
#protein=`basename $queryproteinPath`
#for transcriptomePath in /home/dnarules/Desktop/CnidarianTranscriptome/*.fasta
#do
#transcriptome=`basename $transcriptomePath`
#echo "trimming the alignments"

##/home/dnarules/Gblocks_0.91b/Gblocks  /mnt/dnarules/Anuj/Aligned/Aligned$gene
##/home/dnarules/trimAl/source/trimal -in /mnt/dnarules/Anuj/Aligned/Aligned$gene -out /mnt/dnarules/Anuj/Aligned/Trimmed$gene -automated1 -fasta -gt 0.8 -st 0.001
#/home/dnarules/trimAl/source/trimal -in /home/dnarules/Desktop/Aligned/Aligned$protein -out /home/dnarules/Desktop/Trimmed/Trimmed$protein -fasta -gt 0.8 -st 0.001

#done
#done

##### testing out git ######


########################## making the tree ################################3333


mkdir Trees

##### converting to the phylip format
for files in /home/dnarules/Desktop/Trimmed/*.fasta
do
name=`basename $files`
perl fasta2phylip.pl /home/dnarules/Desktop/Trimmed/$name > /home/dnarules/Desktop/Trimmed/$name.phy
done 


echo " making the tree"

for proteinPath in /home/dnarules/Desktop/Trimmed/*.fasta
do
protein=`basename $proteinPath`
for transcriptomePath in /home/dnarules/Desktop/CnidarianTranscriptome/*.fasta
do
transcriptome=`basename $transcriptomePath`

../raxmlHPC-PTHREADS-SSE3 -T 20 -f a -x 339 -m PROTGAMMADAYHOFF -p 932 -N autoMRE -s /home/dnarules/Desktop/Trimmed/$protein -n $protein -O -w /home/dnarules/Desktop/Trees/

echo " moving onto next query"
done
done
#########################do the correlation mirror tree study ########################################

#Rscript correlationAnalysis.R

##for treePath in /mnt/dnarules/Anuj/Trees/RAxML_bestTree*
##do
##tree=`basename $treePath`
##echo "this is the"  $treePath
##Rscript /mnt/dnarules/Anuj/getDistanceMatrix.R $treePath > /mnt/dnarules/Anuj/Distances/distanceOf$tree.tsv
##Rscript mt_pvals.R  alltaxids.txt  ./distances/  40  0.05  1000 ./RESULTS.csv
##done 

#######################selection study using codeml ########################3




#################### compare the topology of the trees #######################33

# find the tol-mirror tree too and execute that
# distory kdetrees or dendextend or ape
# SH test to compare the topologies of the different trees obtained.
# ancestral state reconstruction
# diversification time

