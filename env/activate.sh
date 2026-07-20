#!/usr/bin/env bash

# 0. Clear inherited developer convenience envs
if command -v deactivate >/dev/null 2>&1; then
  deactivate || true
fi
unset VIRTUAL_ENV
unset PYTHONHOME
unset R_HOME

# 1. Reset base executable search path
export PATH="/usr/local/bin:/opt/spack/bin:/usr/bin:/usr/sbin:/sbin:/bin"

# 2. Configure Spack state/cache
export SPACK_DISABLE_LOCAL_CONFIG=true
export SPACK_USER_CONFIG_PATH=/tmp/spack-user-config
export SPACK_USER_CACHE_PATH=/tmp/spack-user-cache
export SPACK_MISC_CACHE_PATH=/tmp/spack-misc-cache

# 3. Load Spack shell functions
. /opt/spack/share/spack/setup-env.sh

# 4. Activate project Spack environment
cd /work
spack env activate -pd .

# 5. Make the Spack view authoritative for compiled/system dependencies
export SPACK_VIEW=/work/.spack-env/view
export PATH="/work/env/bin:${SPACK_VIEW}/bin:${PATH}"
export PKG_CONFIG_PATH="${SPACK_VIEW}/lib/pkgconfig:${SPACK_VIEW}/lib64/pkgconfig:${SPACK_VIEW}/share/pkgconfig:${PKG_CONFIG_PATH:-}"
export CPATH="${SPACK_VIEW}/include:${CPATH:-}"
export LIBRARY_PATH="${SPACK_VIEW}/lib:${SPACK_VIEW}/lib64:${LIBRARY_PATH:-}"
export LD_LIBRARY_PATH="${SPACK_VIEW}/lib:${SPACK_VIEW}/lib64:${LD_LIBRARY_PATH:-}"

# 6. Configure rv/R project libraries
#
# Contract:
# - Spack provides R and compiled/system libraries.
# - rv provides the project R package library and package cache.
# - Do not also use /work/.rv unless intentionally migrating old state.
export RV_HOME=/work/rv
export RV_LIBRARY_DIR="${RV_HOME}/library"
export RV_CACHE_DIR="${RV_HOME}/cache"
export R_LIBS_USER="${RV_LIBRARY_DIR}"
export R_LIBS="${RV_LIBRARY_DIR}"

# 7. Prefer source installs when binary packages bind to unavailable system libs
#
# Keep this conservative. rv/PPM binaries are fine for simple pure-R packages,
# but source builds are safer for packages with native code that must link
# against the active Spack view.
#export R_MAKEVARS_USER=/work/env/Makevars

# 8. Configure Quarto to use project R and writable project cache
export QUARTO_R="${SPACK_VIEW}/bin/Rscript"
export QUARTO_CACHE_DIR=/work/.quarto/cache
export QUARTO_DATA_DIR=/work/.quarto/data

mkdir -p \
  "$RV_LIBRARY_DIR" \
  "$RV_CACHE_DIR" \
  "$QUARTO_CACHE_DIR" \
  "$QUARTO_DATA_DIR" \
  /work/env

# cat > "$R_MAKEVARS_USER" <<'EOF'
# PKG_CPPFLAGS += -I/work/.spack-env/view/include
# PKG_LIBS += -L/work/.spack-env/view/lib -L/work/.spack-env/view/lib64
# EOF

# 9. Add Home user to path for convenience, but do not use it for R or Python package installs
export PATH="/home/rse/bin:/home/rse/.cargo/bin:/home/rse/.local/bin:${PATH}"
