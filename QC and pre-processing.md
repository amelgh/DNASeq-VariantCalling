Keep in mind that you will be generating a lot of files in each step, organizing your data is crucial.

Create a directory Rawdata in which store your fastqfiles.
Create a directory scripts in which you have the different scripts you will be writing for the different analysis steps.
Create a directory Results in which you will be storing your resulting and intermediate files.


The first thing to do when you receive your raw data is to check the quality of your reads. This could be done using the FastQC tool: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/

You might need to trim your data, there are many trimming tools that will allow to do so. Trimmomatic is one of them.

More information about Trimmomatic: http://www.usadellab.org/cms/?page=trimmomatic

You can also use cutadapt that searches for the adapter in all reads and removes it when it finds it.
All reads that were present in the input file will also be present in the output file, some of them trimmed, some of them not.

Many different options are available with cutadapt, you can find more information here: https://cutadapt.readthedocs.io/en/stable/



