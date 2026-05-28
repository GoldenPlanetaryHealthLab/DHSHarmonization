echo "Starting container build..."
container build --arch amd64 --tag ghcr.io/tinashemtapera/prospector-mahery:amd64 --file .devcontainer/Dockerfile .

echo "Container build complete. Starting container push..."
container image push --scheme https --arch amd64 ghcr.io/tinashemtapera/prospector-mahery:amd64
