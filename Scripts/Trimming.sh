#!/bin/bash

#BSUB -q priority # queue name
#BSUB -W 2:00 # hours:minutes runlimit after which job will be killed.
#BSUB -n 4 # number of cores requested
#BSUB -J rnaseq_mov10_trim         # Job name
#BSUB -o %J.out       # File to which standard out will be written
#BSUB -e %J.err       # File to which standard err will be written

cd ~/untrimmed_fastq #your path to the original fastq files (non trimmed) 

java -jar /hpc/opt/conda/envs/trimmomatic@0.36/share/trimmomatic-0.36-5/trimmomatic.jar PE \ #PE for Paired-end, if you have single End reads, use #SE
	-threads 4 \
	-phred33 \ # TOPHRED33: Convert quality scores to Phred-33
	. <input1>\
	. <input2>\
<paired output 1> <unpaired output 1> <paired output 2> <unpaired output 2>
