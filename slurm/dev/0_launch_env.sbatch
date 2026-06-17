#!/bin/bash
#SBATCH -p hsph
#SBATCH --mem=24g
#SBATCH --time=04:00:00
#SBATCH -c 4

# Logging
#SBATCH --output=/n/holylabs/LABS/cgolden_lab/Lab/projects/DHSHarmonization/slurm/dev/logs/build_%j.out
#SBATCH --error=/n/holylabs/LABS/cgolden_lab/Lab/projects/DHSHarmonization/slurm/dev/logs/build_%j.err

set -o errexit -o nounset -o pipefail

PROJECT_DIR="${PROJECT_DIR:-$SLURM_SUBMIT_DIR}"
TUNNEL_NAME="${TUNNEL_NAME:-$(basename "$PROJECT_DIR")-tunnel}"

cd "$PROJECT_DIR"

MY_SCRATCH=$(TMPDIR=/scratch mktemp -d)
echo "Scratch: $MY_SCRATCH"
echo "Project: $PROJECT_DIR"
echo "Tunnel: $TUNNEL_NAME"
echo "Host: $(hostname)"

module purge

source /n/home03/ttapera/software/spack/share/spack/setup-env.sh
spack env activate -d "$PROJECT_DIR"

which R
which Rscript
which gcc
which g++
R CMD config CC
R CMD config CXX17

curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-linux-x64' \
  | tar -C "$MY_SCRATCH" -xzf -

export VSCODE_CLI_DISABLE_KEYCHAIN_ENCRYPT=1

"$MY_SCRATCH/code" tunnel user login --provider github

"$MY_SCRATCH/code" tunnel \
  --accept-server-license-terms \
  --name "$TUNNEL_NAME"
