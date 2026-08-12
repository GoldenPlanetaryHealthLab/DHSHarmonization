#!/bin/bash

# Parameters
#SBATCH --cpus-per-task=6
#SBATCH --error=/n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar/slurm/submitit/%j/%j_0_log.err
#SBATCH --job-name=build-prospectorDHSMadagascar-container
#SBATCH --mail-user=aaaapr3lk7gfdswioulcmvi3te@harvard.org.slack.com
#SBATCH --mem=32GB
#SBATCH --nodes=1
#SBATCH --open-mode=append
#SBATCH --output=/n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar/slurm/submitit/%j/%j_0_log.out
#SBATCH --partition=hsph
#SBATCH --signal=USR2@90
#SBATCH --time=120
#SBATCH --wckey=submitit

# command
export SUBMITIT_EXECUTOR=slurm
srun --unbuffered --output /n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar/slurm/submitit/%j/%j_%t_log.out --error /n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar/slurm/submitit/%j/%j_%t_log.err /n/holylabs/cgolden_lab/Lab/frontier/town/tinashe/rse-workbench/.venv/bin/python -u -m submitit.core._submit /n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar/slurm/submitit/%j
