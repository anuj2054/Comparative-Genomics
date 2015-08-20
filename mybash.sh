i=0
for genome in /mnt/dnarules/Anuj/CnidarianGenome/*.fasta
do
((i++))
echo $genome
makeblastdb -in $genome -dbtype 'nucl' -out /mnt/dnarules/Anuj/CnidarianGenome/databases/$i
echo "database created"
for gene in /mnt/dnarules/Anuj/CnidarianGene/*.fasta
tblastx -db /mnt/dnarules/Anuj/CnidarianGenome/databases/$i -query $gene -out /mnt/dnarules/Anuj/results/BlastResults.txt -outfmt 6 -max_target_seqs 10 -num_threads 20 -evalue 0.0001
#echo "blasted with a gene"
#done
#SubjectSeqID=$(awk '{print $2}' /mnt/dnarules/Anuj/results/BlastResults.txt)
#awk 'BEGIN {RS=">";} /$SubjectSeqID/ { print ">" $0;}' $genome >  blastResult.fasta
#echo "blast output pasted onto a file"
done
done
