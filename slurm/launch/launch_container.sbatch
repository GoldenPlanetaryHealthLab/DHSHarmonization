#!/bin/sh

#SBATCH --cpus-per-task       6
#SBATCH --error               /n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar/slurm/launch/logs/launch-%j.err
#SBATCH --job-name            prospectorDHSMadagascar-vscode
#SBATCH --mail-user           aaaapr3lk7gfdswioulcmvi3te@harvard.org.slack.com
#SBATCH --mem                 32G
#SBATCH --output              /n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar/slurm/launch/logs/launch-%j.out
#SBATCH --partition           hsph
#SBATCH --time                04:00:00

set -o errexit -o nounset -o pipefail
PROJECT_DIR="/n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar"
SIF="${PROJECT_DIR}/.devcontainer/Singularity.sif"
CONTAINER_HOME="${PROJECT_DIR}/.container-home"
CONTAINER_TMP="${PROJECT_DIR}/.container-tmp"
mkdir -p "${PROJECT_DIR}/slurm/launch/logs"
mkdir -p "${CONTAINER_HOME}" "${CONTAINER_TMP}"
cd "${PROJECT_DIR}"
echo "=================== Slurm sitrep =================="
echo "Date:         $(date)"
echo "Host:         $(hostname)"
echo "User:         $(whoami)"
echo "Job ID:       ${SLURM_JOB_ID}"
echo "Project:      ${PROJECT_DIR}"
echo "SIF:          ${SIF}"
echo "Home:         ${CONTAINER_HOME}"
echo "Tmp:          ${CONTAINER_TMP}"
echo "==================================================="

module purge
singularity exec \
  --bind "${PROJECT_DIR}:/work" \
  --home "${CONTAINER_HOME}:/home/rse" \
  --bind "${CONTAINER_TMP}:/tmp" \
  "${SIF}" \
  bash --noprofile --norc -lc 'set -euo pipefail && source /work/env/activate.sh && cd /work && which code && code tunnel user login --provider github && rm -rf /home/rse/.vscode-server && code tunnel --accept-server-license-terms --name prospectorDHSMadagascar'
