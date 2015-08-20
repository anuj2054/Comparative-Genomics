for transcriptomePath in /mnt/dnarules/Anuj/CnidarianTranscriptome/*.fasta
do
transcriptome=`basename $transcriptomePath`
makeblastdb -in /mnt/dnarules/Anuj/CnidarianTranscriptome/$transcriptome -dbtype 'nucl' -out /mnt/dnarules/Anuj/CnidarianTranscriptome/databases/$transcriptome -parse_seqids
echo "database created"
echo "moving onto next transcriptome"
done
