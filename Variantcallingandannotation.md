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

There any many other different options that can be used such as to add filtering layers such as:

Include/exclude specific chromosomes

```
--chr 1 #include chr1
--not-chr 1 #exclude chr1
```

Filter by variant types:

```
--keep-only-indels 
--remove-indels 
```

More information about vcftools and the different possible options can be found in the vcftools manual: https://vcftools.github.io/man_latest.html

* Annotating variants

Variant annotations is the process of predict the effect or function of SNP using SNP annotational tools. Read more about the different possible ways and tools for annotating variants https://en.wikipedia.org/wiki/SNP_annotation

An example of a guided SNP annotation analysis based on the use of SnpEff: https://github.com/hbctraining/In-depth-NGS-Data-Analysis-Course/blob/master/sessionVI/lessons/03_annotation-snpeff.md


