FROM rocker/r-ver:4.5.1

# setup args
ARG DEBIAN_FRONTEND=noninteractive
ARG ARF_VERSION=0.3.0
ARG TARGETARCH

RUN echo " ============= Starting Container Setup ============= "
RUN echo " ===== Installing System Libraries and Tooling ====== "
RUN apt-get update && apt-get install -y --no-install-recommends \
  bash \
  zsh \
  curl \
  wget \
  ca-certificates \
  git \
  build-essential \
  pkg-config \
  cmake \
  ninja-build \
  cargo \
  tmux \
  ripgrep \
  fd-find \
  fzf \
  tree-sitter-cli \
  unzip \
  xz-utils \
  less \
  locales \
  libssl-dev \
  libcurl4-openssl-dev \
  libxml2-dev \
  libgit2-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libpng-dev \
  libtiff5-dev \
  libjpeg-dev \
  libcairo2-dev \
  libxt-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  libglpk-dev \
  gdebi \
  && rm -rf /var/lib/apt/lists/*

# Debian names fd as fdfind; expose fd
RUN ln -sf "$(command -v fdfind)" /usr/local/bin/fd || true

RUN echo " ================= Installing arf =================== "
RUN set -eux; \
  case "${TARGETARCH:-amd64}" in \
  amd64) ARF_ARCH="x86_64-unknown-linux-gnu" ;; \
  arm64) ARF_ARCH="aarch64-unknown-linux-gnu" ;; \
  *) echo "Unsupported TARGETARCH: ${TARGETARCH}" >&2; exit 1 ;; \
  esac; \
  curl -fsSL \
  "https://github.com/eitsupi/arf/releases/download/v${ARF_VERSION}/arf-console-${ARF_ARCH}.tar.xz" \
  -o /tmp/arf.tar.xz; \
  mkdir -p /tmp/arf; \
  tar -xJf /tmp/arf.tar.xz -C /tmp/arf; \
  find /tmp/arf -type f -name 'arf' -exec install -m 0755 {} /usr/local/bin/arf \;; \
  rm -rf /tmp/arf /tmp/arf.tar.xz
RUN arf --version

RUN echo " ================ Installing Quarto ================= "
#RUN curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
#RUN gdebi --non-interactive quarto-linux-amd64.deb

RUN echo " ============= Installing VS Code CLI =============== "

RUN set -eux; \
  case "${TARGETARCH:-amd64}" in \
  amd64) VSCODE_OS="cli-alpine-x64" ;; \
  arm64) VSCODE_OS="cli-alpine-arm64" ;; \
  *) echo "Unsupported TARGETARCH: ${TARGETARCH}" >&2; exit 1 ;; \
  esac; \
  curl -fsSL "https://code.visualstudio.com/sha/download?build=stable&os=${VSCODE_OS}" \
  -o /tmp/vscode-cli.tar.gz; \
  mkdir -p /opt/vscode-cli; \
  tar -xzf /tmp/vscode-cli.tar.gz -C /opt/vscode-cli; \
  ln -sf /opt/vscode-cli/code /usr/local/bin/code; \
  rm /tmp/vscode-cli.tar.gz; \
  /usr/local/bin/code --version
RUN echo " ======= Installing VS Code R extension runtime packages ========= "
RUN R -q -e "install.packages(c( \
  'websocket', \
  'later', \
  'jsonlite', \
  'rstudioapi', \
  'svglite', \
  'languageserver', \
  'httpgd' \
  ), repos = 'https://cloud.r-project.org')"
RUN echo " ============ Project Package Managers ============== "
RUN set -eux; \
  curl -sSL https://raw.githubusercontent.com/A2-ai/rv/refs/heads/main/scripts/install.sh | bash; \
  RV_BIN="$(command -v rv || true)"; \
  if [ -z "$RV_BIN" ]; then \
  RV_BIN="$(find /root /usr/local /opt -type f -name rv 2>/dev/null | head -n 1)"; \
  fi; \
  test -n "$RV_BIN"; \
  install -m 0755 "$RV_BIN" /usr/local/bin/rv; \
  /usr/local/bin/rv --version


# setup the vscode user and workspace
RUN id -u vscode >/dev/null 2>&1 || useradd -m -s /bin/bash vscode
USER vscode
WORKDIR /home/vscode
ENV PATH="/home/vscode/.local/bin:/home/vscode/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
RUN mkdir -p ~/.local/bin ~/.cargo

# Neovim stable-ish binary
# RUN wget -q https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz \
#     && tar xzf nvim-linux-x86_64.tar.gz -C /opt \
#     && ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim \
#     && rm nvim-linux-x86_64.tar.gz

# health check
RUN echo " ============ Running Tool Health Check ============= "
RUN echo "Checking Quarto installation..."
#RUN quarto check
RUN echo "Checking ARF installation..."
RUN arf --version
RUN echo "Checking R installation..."
RUN which R
RUN echo "Checking VS Code CLI installation..."
RUN command -v code && code --version

RUN echo " ================ Setting Up Project ================ "
RUN echo "Installing project dependencies with rv..."
RUN rv --version
RUN echo "Setting up spack..."
RUN git clone --depth=2 https://github.com/spack/spack.git
RUN . spack/share/spack/setup-env.sh
#RUN spack env activate --create -pd .
#RUN spack concretize -f
#RUN spack install
RUN echo " ============= Container Setup Complete ============= "
