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

* Introduce filters in the VCF file

Once we have called the variants, we might be interested in filtering out some according to the confidence associated to them. Some of the most basic filters consist of identifying variants with low calling quality or a low number of reads supporting the variant. There are many programs that can be used to filter VCFs like: bcftools from Samtools to preform a basic filtering.

* bcftools is a set of utilities for variant calling and manipulating VCFs and BCFs (or the binary variant call format, is the binary version of VCF).
More information about bcftools and the different possible commands: https://samtools.github.io/bcftools/bcftools.html

```
bcftools filter -s LowQual -e 'QUAL<20 | DP<3' yoursample.vcf > yoursample_filtered.vcf
```

To check how many variants fail to pass these filters:

```
grep LowQual yoursample_filtered.vcf | wc -l
``` 

To check how many  passed these filters:

```
grep PASS yoursample_filtered.vcf | wc -l
```

