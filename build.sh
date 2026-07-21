#!/bin/bash
# ─────────────────────────────────────────────────────
# POIVON - Script de Build (.deb para Termux)
# PVN S¥STEM | AGENTE POIVON | skill yb
# ─────────────────────────────────────────────────────

set -e

BUILD_DIR="$(pwd)"
DEB_VERSION=$(grep "^Version:" DEBIAN/control | awk '{print $2}')
DEB_NAME="p-o-i-v-o-n_${DEB_VERSION}_all.deb"
OUTPUT_DIR="$HOME"

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║                                                  ║"
echo "║   ▄▀▄  P-O-I-V-O-N  ▄▀▄                        ║"
echo "║                                                  ║"
echo "║   Build .deb para Termux                         ║"
echo "║                                                  ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo ""

# Verificar dependências de build
echo "[1/4] Verificando dependências de build..."
if ! command -v dpkg-deb &>/dev/null; then
    echo "[ERRO] dpkg-deb não encontrado."
    echo "[INFO] Instale: pkg install dpkg (ou use um ambiente Debian/Ubuntu)"
    exit 1
fi

# Garantir permissões dos scripts
echo "[2/4] Configurando permissões..."
chmod 755 "$BUILD_DIR/DEBIAN/"*
chmod 755 "$BUILD_DIR/usr/bin/pvn"
chmod 755 "$BUILD_DIR/usr/lib/p-o-i-v-o-n/agents/"*
chmod 755 "$BUILD_DIR/usr/lib/p-o-i-v-o-n/scripts/"*

# Verificar DEBIAN/control
echo "[3/4] Verificando DEBIAN/control..."
if [ ! -f "$BUILD_DIR/DEBIAN/control" ]; then
    echo "[ERRO] DEBIAN/control não encontrado!"
    exit 1
fi

# Criar o .deb
echo "[4/4] Empacotando .deb..."
dpkg-deb --build "$BUILD_DIR" "$OUTPUT_DIR/$DEB_NAME"

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║                                                  ║"
echo "║   ✓✓✓  .deb gerado com sucesso!  ✓✓✓            ║"
echo "║                                                  ║"
echo "║   Arquivo: $OUTPUT_DIR/$DEB_NAME                 ║"
echo "║   Tamanho: $(du -h "$OUTPUT_DIR/$DEB_NAME" | cut -f1)        ║"
echo "║                                                  ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

echo ""
echo "┌──────────────────────────────────────────────────┐"
echo "│   Instalação no Termux:                           │"
echo "│                                                   │"
echo "│   cp p-o-i-v-o-n_${DEB_VERSION}_all.deb $PREFIX/tmp/    │"
echo "│   pkg install ./p-o-i-v-o-n_${DEB_VERSION}_all.deb  │"
echo "│                                                   │"
echo "│   Ou instalar direto:                             │"
echo "│   pkg install p-o-i-v-o-n                         │"
echo "│                                                   │"
echo "│   Verificar: pvn version                          │"
echo "└──────────────────────────────────────────────────┘"

echo ""
echo "─────────────────────────────────────────"
echo "  PVN S¥STEM | AGENTE POIVON | skill yb"
echo "─────────────────────────────────────────"
echo ""
