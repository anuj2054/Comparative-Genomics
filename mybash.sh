
#for genomePath in /mnt/dnarules/Anuj/CnidarianGenome/*.fasta
#do
#genome=`basename $genomePath`
#echo "making database for" $genome
#makeblastdb -in /mnt/dnarules/Anuj/CnidarianGenome/$genome -dbtype 'nucl' -out /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome -parse_seqids
#echo "database created"
#done
### database has been created so no need to create it again
#  awk '/^>/{s=++d".fasta"} {print > s}' uniprot_cnidaria_muscle_pathway.fasta

for genePath in /mnt/dnarules/Anuj/CnidarianGene/*.fasta
do
gene=`basename $genePath`
for genomePath in /mnt/dnarules/Anuj/CnidarianGenome/*.fasta
do
genome=`basename $genomePath`
echo "blasting" $genome " with " $gene
tblastx -db /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome -query /mnt/dnarules/Anuj/CnidarianGene/$gene -out /mnt/dnarules/Anuj/results/BlastResults.txt -outfmt 6 -max_target_seqs 10 -num_threads 20 -evalue 0.0001
SSeqID=`Rscript /mnt/dnarules/Anuj/getBestHit.R`
echo "extracting sequence" $SSeqID  "and keeping it in a file"
blastdbcmd -db /mnt/dnarules/Anuj/CnidarianGenome/databases/$genome -dbtype nucl -entry $SSeqID -outfmt %f -out /mnt/dnarules/Anuj/results/$gene$genome
echo "moving onto next"

done
done
