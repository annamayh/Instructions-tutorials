#!/bin/bash

#$ -V
#$ -cwd
#$ -N Rum_neutral
#$ -o o_files/
#$ -e e_files/


#activate conda environment
source /ceph/software/conda/etc/profile.d/conda.sh &&
conda activate ahewett &&

# make directory in /scratch for this job
SCRATCH=/scratch/ahewett/ROH/Rum/neutral_$SGE_TASK_ID &&
mkdir -p $SCRATCH &&

Rscript R_scripts/pipe_Rum_neutral.R $SCRATCH $SGE_TASK_ID

rsync -av $SCRATCH /data/johnston/rumdeer/results/ah_ROH_output/New_ROH_out/Rum/Neutral/

# remove the directory ceated for this job to clear up any unwanted files
rm -rf $SCRATCH &&

#deactivate conda environment
conda deactivate

