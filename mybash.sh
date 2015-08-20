for genePath in /mnt/dnarules/Anuj/CnidarianGene/*.fasta
do
gene=`basename $genePath`
for genomePath in /mnt/dnarules/Anuj/CnidarianGenome/*.fasta
do
genome=`basename $genomePath`
echo "blasting" $genome " with " $gene
#tblastn -db /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome -query /mnt/dnarules/Anuj/CnidarianGene/$gene -out /mnt/dnarules/Anuj/results/BlastResults$gene$genome -outfmt 6 -max_target_seqs 10 -num_threads 20 -evalue 0.0001
tblastn -db /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome -query /mnt/dnarules/Anuj/CnidarianGene/$gene -out /mnt/dnarules/Anuj/results2/BlastResults$gene$genome -outfmt "6 qseqid sseqid evalue qseq sseq" -max_target_seqs 10 -num_threads 20 -evalue 0.0001
#Rscript /mnt/dnarules/Anuj/getBestHit.R > /mnt/dnarules/Anuj/results/BestHitOf$gene$genome
##echo "extracting sequence" $SSeqID  "and keeping it in a file"
##blastdbcmd -db /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome -dbtype nucl -entry $SSeqID -outfmt %f -out /mnt/dnarules/Anuj/results/$gene$genome
echo "moving onto next genome"
done
#echo "creating alignment"
#cat /mnt/dnarules/Anuj/results/BestHitOf$gene* >  /mnt/dnarules/Anuj/results/$gene
#clustalo -i /mnt/dnarules/Anuj/results/$gene -o /mnt/dnarules/Anuj/Aligned/Aligned$gene

#echo "trimming the alignments"

##/home/dnarules/Gblocks_0.91b/Gblocks  /mnt/dnarules/Anuj/Aligned/Aligned$gene
##/home/dnarules/trimAl/source/trimal -in /mnt/dnarules/Anuj/Aligned/Aligned$gene -out /mnt/dnarules/Anuj/Aligned/Trimmed$gene -automated1 -fasta -gt 0.8 -st 0.001
#/home/dnarules/trimAl/source/trimal -in /mnt/dnarules/Anuj/Aligned/Aligned$gene -out /mnt/dnarules/Anuj/Aligned/Trimmed$gene -fasta -gt 0.8 -st 0.001

#echo " making the tree"

echo " moving onto next gene"
done


