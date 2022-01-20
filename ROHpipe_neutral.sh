#!/bin/bash

#$ -V
#$ -cwd
#$ -N Rum_neutral
#$ -o o_files/
#$ -e e_files/

### nice example of shell script  ###

#activate conda environment
source /ceph/software/conda/etc/profile.d/conda.sh &&
conda activate ahewett &&

# make directory in /scratch for this job
SCRATCH=/scratch/ahewett/ROH/Rum/neutral_$SGE_TASK_ID && ##$SGE_TASK_ID is the task id for the job i.e. if you run an array number will change
mkdir -p $SCRATCH &&

Rscript R_scripts/pipe_Rum_neutral.R $SCRATCH $SGE_TASK_ID ##putting these after the Rscript creates a trailing argument in the R script 
#Then would put:
#args <- commandArgs(trailingOnly = TRUE)
#scratch<- as.character(args[1]) ... in the R script


rsync -av $SCRATCH /data/johnston/rumdeer/results/ah_ROH_output/New_ROH_out/Rum/Neutral/ #Moves files from scratch (where you write things to) to the specified directory

# remove the directory ceated for this job to clear up any unwanted files
rm -rf $SCRATCH &&

#deactivate conda environment
conda deactivate

