You might alternatively use FreeBayes which also a sensitive and precise tool to call your variants. FreeBayes is a haplotype-based variant detector and is a great tool for calling variants from a population. 

More information about Freebayes: https://github.com/ekg/freebayes#freebayes-a-haplotype-based-variant-detector

* Running Freebayes

```
module load freebayes
freebayes -f pathttoyourReference.fa Yoursample.bam > Yoursample.vcf
```

The result will be a VCF file summarizing the different variants.
You can then perform the same steps to filter and annotate your variants.

