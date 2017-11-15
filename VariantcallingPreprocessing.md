With good quality (trimmed, filtered if necessary) data in hands, you've aligned your samples to your reference genome and obtained a BAM file. 

![Alt text](/Images/DNASeqGeneralPipeline.png "A reminder of DNASeq general analysis workflow leading to the Variant calling step")

Some of the more popular tools for calling variants include SAMtools mpileup, the GATK suite and FreeBayes.
We recommend using GATK during this Course. For more information, check the GATK suite website https://software.broadinstitute.org/gatk/ and a best practices guide with examples from different organisms: https://software.broadinstitute.org/gatk/best-practices/

Before performing the variant calling, you might need to perform some clean up operations on your data to correct for technical biases and make the data suitable for analysis like re-alignments around indels, mark duplicates, etc.  

![Alt text](/Images/VariantCallingStepsusingGATK.png "The general variant calling process")

You can start by specifying creating 2 variables $GATK and $PICARD that will contain the respective paths to the different JAR files of the GATK and PICARD suites.

```
export PICARD='/hpc/opt/conda/envs/picard@2.10.6/share/picard-2.10.6-0/picard.jar'
export GATK='/hpc/opt/conda/envs/gatk@3.8/opt/gatk-3.8/GenomeAnalysisTK.jar'
```

* Index your BAM file if you did not do it yet

```
samtools sort yoursample.bam > yoursample.srt.bam
samtools index yoursample.srt.bam # yoursample.srt.bam.bai will be created in the same directory 
```

* Indexing the reference file
```
samtools faidx Path to your fasta file
```

* Generate the sequence dictionary using Picard:

```
java -jar $PICARD CreateSequenceDictionary 
REFERENCE=yourreference.fa 
OUTPUT=yourreference.dict
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
samtools index yoursample.rmdup.bam # yoursample.rmdup.bam.bai will be created
```


* AddOrReplaceReadGroups 

Replace read groups in a BAM file. This tool enables the user to replace all read groups in the INPUT file with a single new read group and assign all reads to this read group in the OUTPUT BAM file.

https://software.broadinstitute.org/gatk/documentation/article.php?id=6472

Usage Example
```
java -jar picard.jar AddOrReplaceReadGroups \
I= yoursample.rmdup.bam \
O= yoursample.valid.bam \
RGID=4 \
RGLB=lib1 \
RGPL=illumina \
RGPU=unit1 \
RGSM=20
```
LB --> Read Group library
PL --> Read Group platform (e.g. illumina, solid)
PU --> Read Group platform unit (eg. run barcode)
SM --> Read Group sample name

Other example: 
```
java -jar $PICARD AddOrReplaceReadGroups
INPUT= yoursample.rmdup.bam
LB=1 PL=Illumina PU=x 
SM="$runName"
OUTPUT= yoursample.valid.bam
```

* Index the resulting file
```
samtools index yoursample.valid.bam #a yoursample.valid.bam.bai will be created
```
* Local realignment around INDELS

There are 2 steps to the realignment process:
1. Determining (small) suspicious intervals which are likely in need of realignment (RealignerTargetCreator)
2. Running the realigner over those intervals (see the IndelRealigner tool)

* First: create a target list of intervals which need to be realigned using #RealignerTargetCreator

The local realignment process is designed to consume one or more BAM files and to locally realign reads such that the number of mismatching bases is minimized across all the reads. Local realignment serves to transform regions with misalignments due to indels into clean reads containing a consensus indel suitable for standard variant discovery approaches.

Note that indel realignment is no longer necessary for variant discovery if you plan to use a variant caller that performs a haplotype assembly step, such as HaplotypeCaller or MuTect2. However it is still required when using legacy callers such as UnifiedGenotyper or the original MuTect.

Inputs --> One or more aligned BAM files and optionally, one or more lists of known indels.
Output  --> A list of target intervals to pass to the IndelRealigner.

Usage example

```
java -jar $GATK \
-T RealignerTargetCreator \
-R reference.fasta \
-I yoursample.valid.bam \
--known indels.vcf \
-o yoursample.valid.bam.intervals
```

Usage Example for additional option "UnmappedReadFilter" = Filter out unmapped reads
```
java -jar $GATK\
-T ToolName \
-R reference.fasta \
-I input.bam \
-o output.file \
-rf UnmappedRead
```



* Second: perform realignment of the target intervals using #IndelRealigner

Usage Example
```
java -jar $GATK \
-T IndelRealigner \
-R reference.fasta \
-I yoursample.valid.bam \
-known indels.vcf \
-targetIntervals yoursample.valid.bam.intervals \
-o realignedBam.bam
```


-targetIntervals --> (Required Input) Intervals file output from RealignerTargetCreator
-known --> (Optional Input) Input VCF file(s) with known indels
-o --> (Optional Output) Output Bam


* Base quality score recalibration

Two steps:
- Analyse patterns of covariation in the sequence dataset
- Apply the recalibration to your sequence data

Step1:

```
java -jar $GATK \
    -T BaseRecalibrator \
    -R pathtoyourreferencegenome.fa \
    -I realignedBam.bam\
    -knownSites dbSNP.vcf\
    -o Yoursample_recalibration_data.table
```  
This creates a GATKReport file called Yoursample_recalibration_data.table containing several tables. These tables contain the covariation data that will be used in a later step to recalibrate the base qualities of your sequence data.
It is important that you provide the program with a set of known sites, otherwise it will refuse to run. The known sites are used to build the covariation model and estimate empirical base qualities. For details on what to do if there are no known sites available for your organism of study, please see the online GATK documentation.

Step2:
```
java -jar $GATK \
    -T PrintReads \
    -R pathtoyourreferencegenome.fa\
    -I realignedBam.bam \
    -BQSR Yoursample_recalibration_data.table \
    -o Yoursample_realigned_recalibrated.bam
 ```   
This creates a file called Yoursample_realigned_recalibrated.bam containing all the original reads, but now with exquisitely accurate base substitution, insertion and deletion quality scores. By default, the original quality scores are discarded in order to keep the file size down.


