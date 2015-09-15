#wget -r --no-parent ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP060/SRP060291

fastq-dump --split-files SRR1952742

#concantenate them before or after the fastqc process ???? 

fastqc SRR1952742_1.fastq --outdir=/mnt/dnarules/Anuj/
fastqc SRR1952742_2.fastq --outdir=/mnt/dnarules/Anuj/

java -jar /home/dnarules/Trimmomatic-0.33/trimmomatic-0.33.jar PE SRR1952742_1.fastq SRR1952742_2.fastq SRR1952742_1_paired_trimmed.fastq SRR1952742_1_unpaired_trimmed.fastq SRR1952742_2_paired_trimmed.fastq SRR1952742_2_unpaired_trimmed.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15

fastqc SRR1952742_1_paired_trimmed.fastq --outdir=/mnt/dnarules/Anuj/
fastqc SRR1952742_2_paired_trimmed.fastq --outdir=/mnt/dnarules/Anuj/

/home/dnarules/trinityrnaseq_r20140717/Trinity --seqType fq --left /mnt/dnarules/Anuj/SRR1952742_1_paired_trimmed.fastq --right /mnt/dnarules/Anuj/SRR1952742_2_paired_trimmed.fastq --CPU 18 --JM 50G


