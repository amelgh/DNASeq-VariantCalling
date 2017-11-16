* Call SNPs from an mpileup file based on user-defined parameters: use the mpileup2snp function

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
	
* Additional example details to perform somatic mutation calling:

Run SAMtools mpileup on the BAM files for normal and tumor
```
samtools mpileup –B –q 1 –f reference.fasta normal.bam tumor.bam >normal-tumor.mpileup
```
Run VarScan in somatic mode, providing the mpileup file (normal-tumor.mpileup) and a basename for output files (output.basename):
```
java –jar VarScan.jar somatic normal-tumor.mpileup output.basename –min-coverage 10 –min-var-freq 0.08 –somatic-p-value 0.05
```

Many options available for somatic mutations, including mutation calling parameters (see table 3) or output field names (table 4) at:
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4278659/


Example of additional options for VCF output: 
--output-vcf	Generate VCF output	Set to 1 if VCF output is desired, or leave unset for VarScan's native output format, which is more human readable.

More information: http://varscan.sourceforge.net/using-varscan.html	
