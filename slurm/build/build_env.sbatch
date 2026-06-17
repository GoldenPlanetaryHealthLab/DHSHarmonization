#!/bin/bash
#SBATCH --job-name=build-DHSHarmonization-%j

# Resources
#SBATCH --partition=hsph
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=04:00:00

# Logging
#SBATCH --output=/n/holylabs/LABS/cgolden_lab/Lab/projects/DHSHarmonization/slurm/build/logs/build_%j.out
#SBATCH --error=/n/holylabs/LABS/cgolden_lab/Lab/projects/DHSHarmonization/slurm/build/logs/build_%j.err

###############################################################################
# Strict shell behavior
###############################################################################

set -euo pipefail
module purge

###############################################################################
# Project paths
###############################################################################

PROJECT_DIR="${PROJECT_DIR:-${SLURM_SUBMIT_DIR:-/n/holylabs/LABS/cgolden_lab/Lab/projects/DHSHarmonization/}}"
if [[ ! -d "${PROJECT_DIR}" ]]; then
  echo "ERROR: PROJECT_DIR does not exist: ${PROJECT_DIR}" >&2
  exit 1
fi
cd "${PROJECT_DIR}"

###############################################################################
# Load Spack
###############################################################################

source /n/home03/ttapera/software/spack/share/spack/setup-env.sh

###############################################################################
# Diagnostics / provenance
###############################################################################

echo "=================================================="
echo "Build started"
echo "Date: $(date)"
echo "Host: $(hostname)"
echo "User: $(whoami)"
echo "SLURM_JOB_ID: ${SLURM_JOB_ID}"
echo "Working directory: $(pwd)"
echo "=================================================="

###############################################################################
# Architecture sanity check
###############################################################################

spack arch

###############################################################################
# Activate project environment

# Will need the following based on R {pak} of R 4.5.1:

# > pak::pkg_sysreqs(c("cli", "fs", "knitr", "rmarkdown", "testthat"))
# ✔ Updated metadata database: 3.25 MB in 2 files.
# ✔ Updating metadata database ... done
# ── Install scripts ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── Rockylinux 8 ──
# dnf install -y dnf-plugins-core
# dnf config-manager --set-enabled powertools
# dnf install -y cmake make libuv-devel

# ── Packages and their system dependencies ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# fs   – cmake, libuv-devel, make
# sass – make

# > pak::pkg_sysreqs(c("fledge", "fusen"))
# ── Install scripts ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── Rockylinux 8 ──
# dnf install -y dnf-plugins-core
# dnf config-manager --set-enabled powertools
# dnf install -y epel-release
# dnf install -y libX11-devel git libcurl-devel openssl-devel cmake make libuv-devel libgit2_1.7-devel freetype-devel libjpeg-turbo-devel libpng-devel \
#   libtiff-devel libwebp-devel libicu-devel fontconfig-devel fribidi-devel harfbuzz-devel libxml2-devel

# ── Packages and their system dependencies ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# clipr       – libX11-devel
# credentials – git
# curl        – libcurl-devel, openssl-devel
# fs          – cmake, libuv-devel, make
# gert        – libgit2_1.7-devel
# gitcreds    – git
# httpuv      – make
# openssl     – openssl-devel
# ragg        – freetype-devel, libjpeg-turbo-devel, libpng-devel, libtiff-devel, libwebp-devel
# sass        – make
# stringi     – libicu-devel
# systemfonts – fontconfig-devel, freetype-devel
# textshaping – freetype-devel, fribidi-devel, harfbuzz-devel
# xml2        – libxml2-devel
###############################################################################

spack env activate --create -p "$PROJECT_DIR"

###############################################################################
# Concretize environment
###############################################################################

# -f forces reconcretization only if desired
spack concretize -f

###############################################################################
# Install environment
###############################################################################

# --reuse is CRITICAL for fast layered workflows
spack install --reuse

###############################################################################
# Optional: refresh environment view
###############################################################################

spack env view regenerate

###############################################################################
# Optional: install project-level R packages
###############################################################################

# module load should generally happen AFTER Spack
# ONLY if you are sure that the spack env won't pollute
# module loads

# module load R/4.5.1
spack env deactivate
spack env activate --create -p "$PROJECT_DIR"
if command -v rv >/dev/null 2>&1; then
  rv sync
else
  echo "Error: 'rv' is not available in PATH after module purge and Spack activation." >&2
  echo "Install/provision 'rv' in this batch environment or invoke it via a known absolute path before running this job." >&2
  exit 1
fi

###############################################################################
# Completion diagnostics
###############################################################################

echo "=================================================="
echo "Build completed"
echo "Date: $(date)"
echo "Toolkit check: $(which R || echo "R not found")"
echo "Toolkit check: $(R --version 2>&1 | head -n 1 || echo "R not found")"
echo "=================================================="

