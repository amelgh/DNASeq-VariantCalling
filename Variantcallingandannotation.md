
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

* To check how many variants fail to pass these filters:

```
grep LowQual yoursample_filtered.vcf | wc -l
``` 

* To check how many  passed these filters:

```
grep PASS yoursample_filtered.vcf | wc -l
```

There any many other different options that can be used such as to add filtering layers such as:

* Include/exclude specific chromosomes

```
--chr 1 #include chr1
--not-chr 1 #exclude chr1
```

* Filter by variant types:

```
--keep-only-indels 
--remove-indels 
```

More information about vcftools and the different possible options can be found in the vcftools manual: https://vcftools.github.io/man_latest.html

* Annotating variants

Variant annotations is the process of predict the effect or function of SNP using SNP annotational tools. The different types of functional annotations are summarized in this figure (source: https://en.wikipedia.org/wiki/SNP_annotation where you can read more about the different possible ways and tools for annotating variants). 


![Alt text](/Images/SNPannotation1.png "Different types of functional annotation")

You might perform annotation based known variants based on databases containing variants that have previously been described like dbSNP (https://www.ncbi.nlm.nih.gov/projects/SNP/) or categorize each variant based on the annotation of your genome to annotate and predict the impact of variants on genes functions: Are they in a gene? In an exon? Do they change protein coding? Do they cause premature stop codons? 

. SnpEff to annotate your variants

In order to produce the annotations, SnpEff requires a database. SnpEff has many pre-built databases for many reference genomes. If your organism is not supported,  you need to build a database.

To check which databases are supported, you can use this command:

```
snpEff databases | less
```
If you are looking for a specific database (hg38 for example), use this command
```
snpEff databases | grep -i hg38
```
Running SnpEff to annotate your VCF (a very simple example)
```
snpEff hg38 yoursample.vcf > yoursample.annotate.vcf
```
In your yoursample.annotate.vcf file, SnpEff added functional annotations in the ANN info field. More information about the ANN field: http://snpeff.sourceforge.net/VCFannotationformat_v1.0.pdf

If there is no available database for you genome of interest, you can build a database yourself. Here are the main steps you have to perform to do so:

1. Download yourreference.fasta, #you should create a folder named yourreferenceversion in which you store the fasta file

2. Add your genome to the SnpEff configuration file (to tell SnpEff there is a new genome available)

    1.If the genome uses a non-standard codon table. More information here:     http://snpeff.sourceforge.net/SnpEff_manual.html#buildAddConfigCodonTable
    2. You must add a new genome entry to snpEffect.config
    Here is an example adding the Influenze N1H1 genome
    ```
    open snpEffect.config 
    add line N1H1.genome : Influenza 
    ```
    
3. Download your reference genome annotation file (.GFF, .GTF, GenBank files, etc.) # add it to the same folder yourreferenceversion
4. Run a command to create the database

```
cd path_to_SnpEff directory
snpEff build -gff3 -v yourreferenceversion # -gff3 if you've gff3 annotation file
```
More information about building a new database to SnpEff: http://snpeff.sourceforge.net/SnpEff_manual.html#databases


An example of a guided SNP annotation analysis based on the use of SnpEff (a variant effect predictor): https://github.com/hbctraining/In-depth-NGS-Data-Analysis-Course/blob/master/sessionVI/lessons/03_annotation-snpeff.md

You can also perform the variants prioritarization step, for more information check this lesson: https://github.com/hbctraining/In-depth-NGS-Data-Analysis-Course/blob/master/sessionVI/lessons/04_prioritization-gemini.md

Here is a good practice guide to filtering and prioritizing genetic variants https://www.biotechniques.com/multimedia/archive/00253/BTN_A_000114492_O_253966a.pdf 


Check out this new proteo-genomics resource to visualize and explore mutations affecting post-translational modification (PTM) sites in human proteins/genes: active Drive DB https://www.activedriverdb.org. Here is the link to the publication: https://academic.oup.com/nar/article/doi/10.1093/nar/gkx973/4566599

 


