#!/bin/bash

#SBATCH -p hsph
#SBATCH --mem=24g
#SBATCH --time=04:00:00
#SBATCH -c 4

#SBATCH --output=/n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHS/slurm/launch/logs/launch_%j.out
#SBATCH --error=/n/holylabs/LABS/cgolden_lab/Lab/frontier/works/prospectors/prospectorDHS/slurm/launch/logs/launch_%j.err

set -o errexit -o nounset -o pipefail

PROJECT_DIR="${PROJECT_DIR:-$SLURM_SUBMIT_DIR}"
SIF="${SIF:-$PROJECT_DIR/.devcontainer/prospector-dhs_amd64.sif}"
TUNNEL_NAME="${TUNNEL_NAME:-launch-${SLURM_JOB_ID}}"
CONTAINER_HOME="${CONTAINER_HOME:-$PROJECT_DIR/.container-home}"

mkdir -p "$PROJECT_DIR/slurm/launch/logs"
mkdir -p "$CONTAINER_HOME"

cd "$PROJECT_DIR"

echo "================ Slurm tunnel test ================"
echo "Date:         $(date)"
echo "Host:         $(hostname)"
echo "User:         $(whoami)"
echo "Job ID:       ${SLURM_JOB_ID}"
echo "Project:      ${PROJECT_DIR}"
echo "SIF:          ${SIF}"
echo "Home:         ${CONTAINER_HOME}"
echo "Tunnel:       ${TUNNEL_NAME}"
echo "==================================================="

module purge

singularity exec \
  --cleanenv \
  --home "$CONTAINER_HOME:/home/vscode" \
  --bind "$PROJECT_DIR:/work" \
  --pwd /work \
  "$SIF" \
  env -i \
    HOME=/home/vscode \
    USER="$USER" \
    LOGNAME="$USER" \
    SHELL=/bin/bash \
    VSCODE_CLI_DISABLE_KEYCHAIN_ENCRYPT=1 \
    PATH=/home/vscode/.local/bin:/home/vscode/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    bash --noprofile --norc -c '
      set -o errexit -o nounset -o pipefail
      echo "================ Inside container ================"
      echo "Date:  $(date)"
      echo "Host:  $(hostname)"
      echo "User:  $(whoami)"
      echo "PWD:   $(pwd)"
      echo "HOME:  $HOME"
      echo "PATH:  $PATH"
      echo "=================================================="
      command -v code
      code --version
      echo "Starting tunnel..."
      exec code tunnel \
        --verbose \
        --accept-server-license-terms \
        --name "'"$TUNNEL_NAME"'"
      '
