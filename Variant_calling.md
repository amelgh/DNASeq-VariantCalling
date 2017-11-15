With good quality (trimmed, filtered if necessary) data in hands, you've aligned your samples to your reference genome and obtained a BAM file. 
You might now perform variant calling 

Some of the more popular tools for calling variants include SAMtools mpileup, the GATK suite and FreeBayes.

We recommend using GATK during this Course. For more information, check the GATK suite website (https://software.broadinstitute.org/gatk/)

Add read group information, preprocess to make a clean BAM and call variants


You can start by specifying creating 2 variables $GATK and $PICARD that will contain the respective paths to the different JAR files contained in the GATK and PICARD suites.

```
export PICARD='/hpc/opt/conda/envs/picard@2.10.6/share/picard-2.10.6-0/picard.jar'
export GATK='/hpc/opt/conda/envs/gatk@3.8/opt/gatk-3.8/GenomeAnalysisTK.jar'
```


* Index your BAM file if you did not do it yet

```
samtools sort yoursample.bam > yoursample.srt.bam
samtools index yoursample.srt.bam # yoursample.srt.bam.bai will be created in the same directory 
```

* Mark Duplicated: duplicated reads flaged

```
java -jar $PICARD MarkDuplicates 
INPUT=yoursample.srt.bam 
OUTPUT=yoursample.rmdup.bam 
METRICS_FILE=yoursample.srt.bam.metrics  #File to write duplication metrics to Required
REMOVE_DUPLICATES=TRUE
```
More information about MarkDuplicates and the different picard command lines different options: http://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates

* Index the marked file
```
samtools index yoursample.rmdup.bam #a yoursample.rmdup.bam.bai will be created
```

* Add or replace groups

Replace read groups in a BAM file.This tool enables the user to replace all read groups in the INPUT file with a single new read group and assign all reads to this read group in the OUTPUT BAM file.

```
java -jar $PICARD AddOrReplaceReadGroups 
INPUT=yoursample.rmdup.bam
LB=1 PL=Illumina PU=x SM="$runName"
OUTPUT=yoursample.valid.bam
```
* Index the resulting file
```
samtools index yoursample.valid.bam #a yoursample.valid.bam.bai will be created
```

* Indexing the reference file

```
samtools faidx Path to your fasta file
```


* RealignerTargetCreator

```
java -jar $GATK -T RealignerTargetCreator 
-nt 8 -rf ReassignMappingQuality -DMQ 60 -R Path-to_your_Referencefasta_file
-I  yoursample.valid.bam 
-o yoursample.valid.bam.intervals;
```

* IndelRealigner

```
java -jar $GATK 
-T IndelRealigner -R Path-to_your_Referencefasta_file
-I yoursample.valid.bam
-targetIntervals yoursample.valid.bam.intervals
-o yoursample.valid.realigned.bam
```

