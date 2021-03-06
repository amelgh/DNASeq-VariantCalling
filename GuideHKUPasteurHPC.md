To connect to the server: ssh username@omics.cgs.hku.hk
Many strandards tools are already installed. 

```
module avail or module av: will list all the available tools
module load modulename+versionnumber: will load the tool so that you can run it
module list: will display all the currently loaded modules
```

To sumbit a job, we might run a simple command or run a bash script that will call your commands. We recommend that you create bash scripts for all your tasks

Use "qsub" to submit a job to the server: qsub <yourscript.sh>

Example of script.sh

```
#!/bin/bash
#PBS -l nodes=1:ppn=4 #you may use up to 40 CPU cores (depending on your job)
#PBS -l mem=20gb
cd $WORKDIR #command example that will allow you to change directory
command 
```

Upon successful submission of a job, the queuing system returns a job identifier of the form JobID.statgenpro where JobID is an integer number assigned by system to that job.
You will need the job identifier for any actions involving the job, such as checking the job status or deleting the job.
When the job aborted or finished, the file JobName.oxxxx and JobName.exxxx would be copied to the working directory to show standard outputand standard error that were not explicitly redirected in the job command file.

If you would like to delete a job use the command "qdel"
Command: qdel <jobID>


To check the jobs that are running on the HPC 

```
Use qstat -rn1: to list only running jobs
qstat -i: to list only queuing jobs
qstat -xan1: to list the completed jobs
``` 

Links to all the jar files that you might require to run some of the tools:

|trimmomatic |/hpc/opt/conda/envs/trimmomatic@0.36/share/trimmomatic-0.36-5/trimmomatic.jar|
|------------------------------------------------------------------------------------------|
|gatk        |/hpc/opt/conda/envs/gatk@3.8/opt/gatk-3.8/GenomeAnalysisTK.jar               |
|alientrimmer|/hpc/opt/alientrimmer/0.4.0/AlienTrimmer.jar                                 |
|picard      |/hpc/opt/conda/envs/picard@2.10.6/share/picard-2.10.6-0/picard.jar           |
|snpeff      |/hpc/opt/conda/envs/snpeff@4.3.1r/share/snpeff-4.3.1r-0/snpEff.jar           |



Let us know if you have any question, Julian will be happy to assist
