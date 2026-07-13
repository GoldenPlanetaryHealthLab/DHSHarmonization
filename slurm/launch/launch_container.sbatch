#!/bin/sh

#SBATCH --cpus-per-task       12
#SBATCH --error               /n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar/slurm/launch/logs/launch-%j.err
#SBATCH --job-name            launch-prospectorDHSMadagascar-container
#SBATCH --mail-user           aaaapr3lk7gfdswioulcmvi3te@harvard.org.slack.com
#SBATCH --mem                 32G
#SBATCH --output              /n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHSMadagascar/slurm/launch/logs/launch-%j.out
#SBATCH --partition           hsph
#SBATCH --time                04:00:00

set -o errexit -o nounset -o pipefail
PROJECT_DIR=${PROJECT_DIR}
SIF=${PROJECT_DIR}/.devcontainer/Singularity.sif
CONTAINER_HOME=${PROJECT_DIR}/.container-home
CONTAINER_TMP=${PROJECT_DIR}/.container-tmp
mkdir -p ${PROJECT_DIR}/slurm/launch/logs
mkdir -p ${CONTAINER_HOME}
mkdir -p ${CONTAINER_TMP}
cd ${PROJECT_DIR}
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
  --bind ${PROJECT_DIR}:/work \
  --home ${PROJECT_DIR}/.container-home:/home/rse \
  --bind ${PROJECT_DIR}/.container-tmp:/tmp \
  ${SIF} \
  bash --noprofile --norc -lc '
export SPACK_DISABLE_LOCAL_CONFIG=true && . /opt/spack/share/spack/setup-env.sh && cd /work && spack env activate -d . && spack concretize && spack install --deprecated --fail-fast -j12 --no-checksum && (rv sync || true) && (code tunnel unregister || true) && exec code tunnel --accept-server-license-terms --log trace --verbose --name vscode'
