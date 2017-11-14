#!/bin/bash

#BSUB -q priority # queue name
#BSUB -W 2:00 # hours:minutes runlimit after which job will be killed.
#BSUB -n 4 # number of cores requested
#BSUB -J rnaseq_mov10_trim         # Job name
#BSUB -o %J.out       # File to which standard out will be written
#BSUB -e %J.err       # File to which standard err will be written

cd ~/untrimmed_fastq #your path to the original fastq files (non trimmed) 

java -jar /hpc/opt/conda/envs/trimmomatic@0.36/share/trimmomatic-0.36-5/trimmomatic.jar PE \ #PE for Paired-end, if you have single End reads, use #SE
	# -threads 4 \ #optional
	-phred33 \ # TOPHRED33: Convert quality scores to Phred-33 It works with FASTQ (using phred + 33 or phred + 64 quality scores, depending on the Illumina pipeline used).
	<reads1.fastq>\ # you can use either uncompressed or gzipp'ed FASTQ
	<reads2.fastq>\
<paired output 1>  <paired output 2> \
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
<paired output 1>  <paired output 2> \
LEADING:3 TRAILING:3 MINLEN:50 

