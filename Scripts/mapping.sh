#!/bin/bash
#PBS -l nodes=1:ppn=4 #you may use up to 40 CPU cores (depending on your job)
#PBS -l mem=20gb

# Creating the Bowtie index for our reference genome
#bowtie2-build -f genome.fa genomename #if you are using Bowtie as mapper
#generate the bwa index if you are using bwa as mapper
#The command below creates files for alignment. 
bwa index reference.fasta
bwa index -a bwtsw reference.fa 
# -a bwtsw specifies that we want to use the indexing algorithm that is capable of handling the whole human genome
