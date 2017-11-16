http://varscan.sourceforge.net/using-varscan.html


. Call SNPs from an mpileup file based on user-defined parameters: use the mpileup2snp function

```
VarScan mpileup2snp Yoursample.pileup   --min-coverage 10 --min-base-qual 30 --output-vcf   1 > Yoursample.vcf
```
If the option --output-vcf	If set to 1, outputs in VCF format

Other possible OPTIONS:
	--min-coverage	Minimum read depth at a position to make a call [8]
	--min-reads2	Minimum supporting reads at a position to call variants [2]
	--min-avg-qual	Minimum base quality at a position to count a read [15]
	--min-var-freq	Minimum variant allele frequency threshold [0.01]
	--min-freq-for-hom	Minimum frequency to call homozygote [0.75]
	--p-value	Default p-value threshold for calling variants [99e-02]
	--strand-filter	Ignore variants with >90% support on one strand [1]
	--output-vcf	If set to 1, outputs in VCF format
	--variants	Report only variant (SNP/indel) positions (mpileup2cns only) [0]
