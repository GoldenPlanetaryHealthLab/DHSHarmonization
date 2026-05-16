#!/usr/bin/env bash
#SBATCH --job-name=spack-r-gcc13
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --output=logs/spack-r-gcc13-%j.out
#SBATCH --error=logs/spack-r-gcc13-%j.err

set -euo pipefail
PROJECT_DIR="/n/holylabs/cgolden_lab/Lab/projects/DHSHarmonization"
cd "$PROJECT_DIR"

mkdir -p logs
# Clean shell environment
module purge

# Load FASRC compiler stack
module load gcc/13.2.0-fasrc01
module load mpfr/4.2.1-fasrc01
module load gmp/6.3.0-fasrc01

# Remove Homebrew pollution
export PATH="$(echo "$PATH" | tr ':' '\n' | grep -v "$HOME/.local/opt/brew" | paste -sd: -)"

# Make Spack available
export PATH="$HOME/software/spack/bin:$PATH"

# Activate project Spack environment
spack env activate -d .

# Fully reset environment specs + lock + view
spack remove --all --force || true
rm -f spack.lock
rm -rf .spack-env/view

# Remove failed install/build metadata
spack uninstall -y --dependents gmake || true
spack clean --all

# Remove bad compilers
spack compiler remove gcc@15.2.0 || true
spack compiler remove gcc@13.2.0 || true

# Register clean FASRC GCC
spack compiler find

# Add explicit specs
spack add "r@4.5.1 %gcc@13.2.0"
spack add "cmake %gcc@13.2.0"
spack add "gmake %gcc@13.2.0"
spack add "pkgconf %gcc@13.2.0"

# Force fresh solve
spack concretize --force --fresh

echo "==== spack.lock gcc refs ===="

grep -n "gcc@15.2.0\|lx4q7zu\|cascadelake" spack.lock || true
grep -n "gcc@13.2.0" spack.lock | head || true

# Inspect before install
spack find -c
spack compiler list
spack compiler info gcc@13.2.0

# Install only the environment root specs
spack install --fresh -j "$SLURM_CPUS_PER_TASK"
