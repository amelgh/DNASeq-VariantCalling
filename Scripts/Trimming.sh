#!/bin/bash

#PBS -l nodes=1:ppn=4
#PBS -l mem=20gb
#PBS -l walltime=01:00:00
#PBS -m abe
#PBS -q default
#PBS -N testing

cd ~/untrimmed_fastq #your path to the original fastq files (non trimmed) 

java -jar /hpc/opt/conda/envs/trimmomatic@0.36/share/trimmomatic-0.36-5/trimmomatic.jar PE \ #PE for Paired-end, if you have single End reads, use #SE
	# -threads 4 \ #optional
	-phred33 \ # TOPHRED33: Convert quality scores to Phred-33 It works with FASTQ (using phred + 33 or phred + 64 quality scores, depending on the Illumina pipeline used).
	# If no quality encoding is specified, it will be determined automatically
	<reads1.fastq>\ # you can use either uncompressed or gzipp'ed FASTQ
	<reads2.fastq>\
<paired output 1> <unpaired output 1> <paired output 2> <unpaired output 2> \ #specify 4 different output files for PE sequencing to allow the storage of unpaired reads
LEADING:3 TRAILING:3 MINLEN:50
#LEADING: Cut bases off the start of a read, if below a threshold quality
#TRAILING: Cut bases off the end of a read, if below a threshold quality
#MINLEN: Drop the read if it is below a specified length

or

module load trimmomatic/0.36
trimmomatic PE \ #PE for Paired-end, if you have single End reads, use #SE
	# -threads 4 \ #optional
	-phred33 \ # TOPHRED33: Convert quality scores to Phred-33
	<reads1.fastq>\
	<reads2.fastq>\
<paired output 1> <unpaired output 1> <paired output 2> <unpaired output 2> \
LEADING:3 TRAILING:3 MINLEN:50 

