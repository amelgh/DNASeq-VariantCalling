#!/bin/bash
#PBS -l nodes=1:ppn=4 #you may use up to 40 CPU cores (depending on your job)
#PBS -l mem=20gb
module load cutadapt
#many possible options to run cutadapt
cutadapt -a AACCGGTT -o output.fastq input.fastq #the adapter sequence given with the -a option could be find in your sequencing report
cutadapt -q 20 -m 20 -o out.1.fastq -p out.2.fastq reads.1.fastq reads.2.fastq #-q is the quality threshold indicator, -m is the minimum lenght of sequence


