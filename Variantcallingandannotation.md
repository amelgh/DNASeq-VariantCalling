export GATK='/hpc/opt/conda/envs/gatk@3.8/opt/gatk-3.8/GenomeAnalysisTK.jar'

* Variant calling (using GATK - HaplotypeCaller)

SNPs and INDELS are called using a single instruction.

```
java -jar $GATK\
    -T HaplotypeCaller \
    -R pathtoyourreferencegenome.fa \
    -I Yoursample_realigned_recalibrated.bam\
    -o yoursample.vcf
```
