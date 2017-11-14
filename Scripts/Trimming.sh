#!/bin/bash

#BSUB -q priority # queue name
#BSUB -W 2:00 # hours:minutes runlimit after which job will be killed.
#BSUB -n 4 # number of cores requested
#BSUB -J rnaseq_mov10_trim         # Job name
#BSUB -o %J.out       # File to which standard out will be written
#BSUB -e %J.err       # File to which standard err will be written

cd ~/untrimmed_fastq #your path to the original fastq files (non trimmed) 

java -jar /opt/Trimmomatic-0.33/trimmomatic-0.33.jar SE \
	-threads 4 \
	-phred33 \
	. \
