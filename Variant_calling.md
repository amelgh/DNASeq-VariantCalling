With good quality (trimmed, filtered if necessary) data in hands, you've aligned your samples to your reference genome and obtained a BAM file. 
You might now perform variant calling 

Some of the more popular tools for calling variants include SAMtools mpileup, the GATK suite and FreeBayes.

We recommend using GATK during this Course. For more information, check the GATK suite website (https://software.broadinstitute.org/gatk/)

<Add read group information, preprocess to make a clean BAM and call variants>

The initial alignment file is missing read group information. You can 


Marking duplicates:

```
java -jar picard.jar MarkDuplicates \
      I=input.bam \
      O=marked_duplicates.bam \
      M=marked_dup_metrics.txt
 
 ```
