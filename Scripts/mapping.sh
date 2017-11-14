#!/bin/bash
#PBS -l nodes=1:ppn=4 #you may use up to 40 CPU cores (depending on your job)
#PBS -l mem=20gb

#Using BWA mapper

#generate the bwa index if you are using bwa as mapper
#The command below creates files for alignment. 
```
bwa index -p genomename reference.fasta 
```

#bwa index  -p genomename -a bwtsw reference.fa
# you might use the option -a to specify the indexing algorithm. This option depends on the length of your genome
# -a bwtsw specifies that we want to use the indexing algorithm that is capable of handling the whole human genome and does not work for short genomes
# -a is does not work for long genomes

#once your index is ready, you can launch the mapping

```
bwa mem reference.fasta reads1.fastq reads2.fastq > alignedreads.sam # for PE sequencing 
```
#make sure you give a significative name to your resulting sam file

#Using bowtie2 mapper

# Creating the Bowtie index for our reference genome
bowtie2-build -f genome.fa genomename #the index will be created in the same directory as your reference genome file




