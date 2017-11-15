# RealignerTargetCreator  --> The local realignment process is designed to consume one or more BAM files and to locally realign reads such that the number of mismatching bases is minimized across all the reads. Local realignment serves to transform regions with misalignments due to indels into clean reads containing a consensus indel suitable for standard variant discovery approaches. 

# Inputs --> One or more aligned BAM files and optionally, one or more lists of known indels.
# Output  --> A list of target intervals to pass to the IndelRealigner.

* Usage example

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

# Usage Example
```
java -jar GenomeAnalysisTK.jar \
-T IndelRealigner \
-R reference.fasta \
-I input.bam \
-known indels.vcf \
-targetIntervals intervalListFromRTC.intervals \
-o realignedBam.bam
```


# -targetIntervals --> (Required Input) Intervals file output from RealignerTargetCreator
# -known --> (Optional Input) Input VCF file(s) with known indels
# -o --> (Optional Output) Output Bam
