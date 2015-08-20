#for genome in $(basename /mnt/dnarules/Anuj/CnidarianGenome/*.fasta)
#do
#echo $genome
#makeblastdb -in /mnt/dnarules/Anuj/CnidarianGenome/$genome -dbtype 'nucl' -out /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome
#echo "database created"
#done
### database has been created so no need to create it again

for genePath in /mnt/dnarules/Anuj/CnidarianGene/*.fasta
do
gene=`basename $genePath`
for genomePath in /mnt/dnarules/Anuj/CnidarianGenome/*.fasta
do
genome=`basename $genomePath`
echo "blasting" $genome " with " $gene
tblastx -db /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome -query /mnt/dnarules/Anuj/CnidarianGene/$gene -out /mnt/dnarules/Anuj/results/BlastResults.txt -outfmt 6 -max_target_seqs 10 -num_threads 20 -evalue 0.0001
SSeqID=`Rscript /mnt/dnarules/Anuj/getBestHit.R`
echo "extracting sequence and keeping it in a file"
perl /mnt/dnarules/Anuj/extractSequence.pl /mnt/dnarules/Anuj/CnidarianGenome/$genome $SSeqID > $gene$genome.txt
echo "moving onto next"

done
done
