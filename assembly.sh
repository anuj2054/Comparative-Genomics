#wget -r --no-parent ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP060/SRP060291
# the wget is not needed since all files can be downloaded directly from the fastq-dump command, and no FTP is encouraged by NCBI anymore. 

fastq-dump --split-files SRR1952742

# concantenate them before or after the fastqc process ???? 

fastqc SRR1952742_1.fastq --outdir=/mnt/dnarules/Anuj/
fastqc SRR1952742_2.fastq --outdir=/mnt/dnarules/Anuj/

java -jar /home/dnarules/Downloads/Trimmomatic-0.33/trimmomatic-0.33.jar PE SRR1819888_1.fastq SRR1819888_2.fastq SRR1819888_1_paired_trimmed.fastq SRR1819888_1_unpaired_trimmed.fastq SRR1819888_2_paired_trimmed.fastq SRR1819888_2_unpaired_trimmed.fastq ILLUMINACLIP:/home/dnarules/Downloads/Trimmomatic-0.33/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15

fastqc SRR1952742_1_paired_trimmed.fastq --outdir=/mnt/dnarules/Anuj/
fastqc SRR1952742_2_paired_trimmed.fastq --outdir=/mnt/dnarules/Anuj/

sed '1~4 s/$/ \/2/g' SRR1819888_2_paired_trimmed.fastq > SRR1819888_2_paired_trimmed_mod.fastq

/home/dnarules/trinityrnaseq_r20140717/Trinity --seqType fq --left /mnt/dnarules/Anuj/SRR1952742_1_paired_trimmed.fastq --right /mnt/dnarules/Anuj/SRR1952742_2_paired_trimmed.fastq --CPU 18 --JM 50G

#### need to do some ORF or CDS prediction here ... we do not need to do annotation. 


