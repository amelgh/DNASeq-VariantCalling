With good quality (trimmed, filtered if necessary) data in hands, you've aligned your samples to your reference genome and obtained a BAM file. 
Before performing the variant calling, you might need to perform local re-alignments around indels, mark duplicates, etc.  

Some of the more popular tools for calling variants include SAMtools mpileup, the GATK suite and FreeBayes.

We recommend using GATK during this Course. For more information, check the GATK suite website (https://software.broadinstitute.org/gatk/)

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

* RealignerTargetCreator

The local realignment process is designed to consume one or more BAM files and to locally realign reads such that the number of mismatching bases is minimized across all the reads. Local realignment serves to transform regions with misalignments due to indels into clean reads containing a consensus indel suitable for standard variant discovery approaches. 

Inputs --> One or more aligned BAM files and optionally, one or more lists of known indels.
Outputs  --> A list of target intervals to pass to the IndelRealigner.

Usage example

```
java -jar GenomeAnalysisTK.jar \
-T RealignerTargetCreator \
-R reference.fasta \
-I input.bam \
--known indels.vcf \
-o forIndelRealigner.intervals
```

* Usage Example for additional option "UnmappedReadFilter" = Filter out unmapped reads
```
java -jar GenomeAnalysisTk.jar \
-T ToolName \
-R reference.fasta \
-I input.bam \
-o output.file \
-rf UnmappedRead
```



* IndelRealigner

Usage Example
```
java -jar GenomeAnalysisTK.jar \
-T IndelRealigner \
-R reference.fasta \
-I input.bam \
-known indels.vcf \
-targetIntervals intervalListFromRTC.intervals \
-o realignedBam.bam
```


-targetIntervals --> (Required Input) Intervals file output from RealignerTargetCreator
-known --> (Optional Input) Input VCF file(s) with known indels
-o --> (Optional Output) Output Bam
