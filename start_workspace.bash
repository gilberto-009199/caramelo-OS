#!/bin/bash

set -e

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

[ -z "${WOKSPACE_VOLUME}" ] && WOKSPACE_VOLUME="$DIR";

IMAGE_NAME="workspace-build"
CONTAINER_NAME="workspace-build-container"


mkdir -p "$WOKSPACE_VOLUME"

echo "=== Workpace Environment ==="
echo "Diretório de volume: $WOKSPACE_VOLUME"
echo ""


echo "Construindo imagem Docker..."
docker build -t "$IMAGE_NAME" - <<EOF
FROM debian:bookworm

RUN apt update && \
    apt install -y \
    live-build \
    sudo \
    curl \
    wget \
    vim \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN cat > /root/.profile << 'PROFILE'
echo "=== Wokspace Build Environment ==="
echo "Comandos disponíveis:"
echo "  lb clean    - Limpar build anterior"
echo "  lb config   - Configurar live build"
echo "  lb build    - Construir ISO"
echo "  lb bootstrap - Inicializar chroot"
echo "  lb chroot_install-packages install <package> - instala pacote"
echo ""
echo "Exemplo de uso:"
echo "  # lb config --arch amd64 --distribution bookworm"
echo "  # lb build"
echo ""
PROFILE

VOLUME ["/root/wokspace"]
WORKDIR /root/wokspace/debian-version

ENTRYPOINT ["/bin/bash", "--login"]
EOF

if [ $? -eq 0 ]; then
    echo "✅ Imagem construída com sucesso: $IMAGE_NAME"
else
    echo "❌ Falha ao construir imagem"
    exit 1
fi


echo "Executando container..."
docker run -it --rm \
    --name "$CONTAINER_NAME" \
    --hostname "wokspace-build" \
    -v "$WOKSPACE_VOLUME:/root/wokspace" \
    -v /tmp:/tmp \
    --privileged \
    "$IMAGE_NAME"
