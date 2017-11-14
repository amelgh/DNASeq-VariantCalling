#!/bin/bash
#PBS -l nodes=1:ppn=4 #you may use up to 40 CPU cores (depending on your job)
#PBS -l mem=20gb
```
module load fastqc
fastqc fastqfile  #only one sample

#you can fastqc many fastq files on the same time
#fastqc fastqfile1 fastqfile2 .... #You can specify as many files as you like

