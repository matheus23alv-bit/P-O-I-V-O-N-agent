#!/data/data/com.termux/files/usr/bin/bash
# ╔══════════════════════════════════════════════════╗
# ║                                                  ║
# ║   POIVON - Setup Completo para Termux            ║
# ║   PVN S¥STEM | AGENTE POIVON | skill yb          ║
# ║   Termux Edition                                 ║
# ║                                                  ║
# ╚══════════════════════════════════════════════════╝
#
# Uso: bash setup.sh
# Este script configura todo o ambiente POIVON no Termux.
# Deve ser executado após o clone do repositório.
#

set -e

# ─────────────────────────────────────────────────────
# CORES E FORMATO
# ─────────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# ─────────────────────────────────────────────────────
# SPLASH SCREEN
# ─────────────────────────────────────────────────────

echo ""
echo -e "${CYAN}  ╭┬╮╭┬╮  ¥¥¥  █▓░  //\\  @#$%  °°°${RESET}"
echo -e "${CYAN}    ╰╯╰╯  ░▓█  ¥¥¥  %$#@  ┬┬┬  °°°${RESET}"
echo -e "${CYAN}  ▲▼▲▼  ╭┬╮  ▓░█  //\\\\  °°°  ╰╯╰╯${RESET}"
echo -e "${CYAN}  ░▓█░  ▼▲▼  ┬┬┬  ¥¥¥  //\\  ▓░█░${RESET}"
echo ""
sleep 0.3
echo -e "${YELLOW}  P-O-I-V-O-N  //\\\\  °°°°°°${RESET}"
echo -e "${YELLOW}  P-O-I-V-O-N  //\\\\  █████${RESET}"
echo -e "${YELLOW}  P-O-I-V-O-N  //\\\\  ▓▓▓▓▓${RESET}"
echo ""
sleep 0.3
echo -e "${GREEN}╔══════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║                                                  ║${RESET}"
echo -e "${GREEN}║     ▄▀▄  P-O-I-V-O-N  ▄▀▄                      ║${RESET}"
echo -e "${GREEN}║                                                  ║${RESET}"
echo -e "${GREEN}║     iniciando PVN S¥STEM - °°°°°° starting....  ║${RESET}"
echo -e "${GREEN}║                                                  ║${RESET}"
echo -e "${GREEN}║     POIVON AGENTE MASTER CODE - TERMUX EDITION   ║${RESET}"
echo -e "${GREEN}║                                                  ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════╝${RESET}"
echo ""

# ─────────────────────────────────────────────────────
# VERIFICAÇÕES INICIAIS
# ─────────────────────────────────────────────────────

echo -e "${BLUE}[1/7] Verificando ambiente Termux...${RESET}"

if [ ! -d "$PREFIX" ]; then
    echo -e "${RED}[ERRO] Este script deve ser executado no Termux (Android).${RESET}"
    echo -e "${RED}[ERRO] Instale o Termux em: https://f-droid.org/packages/com.termux/${RESET}"
    exit 1
fi

echo -e "${GREEN}[OK] Ambiente Termux detectado: $PREFIX${RESET}"
echo ""

# ─────────────────────────────────────────────────────
# ATUALIZAR REPOSITÓRIOS
# ─────────────────────────────────────────────────────

echo -e "${BLUE}[2/7] Atualizando repositórios...${RESET}"
pkg update -y 2>/dev/null
pkg upgrade -y 2>/dev/null
echo -e "${GREEN}[OK] Repositórios atualizados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────
# INSTALAR DEPENDÊNCIAS ESSENCIAIS
# ─────────────────────────────────────────────────────

echo -e "${BLUE}[3/7] Instalando dependências essenciais...${RESET}"
pkg install -y python nodejs git curl wget nano clang openssh termux-api jq tree openssl make cmake 2>/dev/null
echo -e "${GREEN}[OK] Dependências instaladas.${RESET}"
echo ""

# ─────────────────────────────────────────────────────
# PACOTES PYTHON
# ─────────────────────────────────────────────────────

echo -e "${BLUE}[4/7] Instalando pacotes Python...${RESET}"
python -m pip install --upgrade pip 2>/dev/null
pip install --quiet flask requests beautifulsoup4 lxml pillow pygments 2>/dev/null
echo -e "${GREEN}[OK] Pacotes Python instalados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────
# PERMISSÕES E ARMAZENAMENTO
# ─────────────────────────────────────────────────────

echo -e "${BLUE}[5/7] Configurando permissões e armazenamento...${RESET}"
termux-setup-storage 2>/dev/null
sleep 1

# Criar estrutura de diretórios
mkdir -p "$HOME/storage/shared/POIVON"
mkdir -p "$HOME/storage/shared/POIVON/projects"
mkdir -p "$HOME/storage/shared/POIVON/scripts"
mkdir -p "$HOME/storage/shared/POIVON/data"
mkdir -p "$HOME/storage/shared/POIVON/backups"
echo -e "${GREEN}[OK] Estrutura criada: ~/storage/shared/POIVON/${RESET}"
echo ""

# ─────────────────────────────────────────────────────
# INSTALAR AGENTE POIVON (via .deb ou copia direta)
# ─────────────────────────────────────────────────────

echo -e "${BLUE}[6/7] Instalando Agente POIVON...${RESET}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Opção 1: Instalar via .deb se existir
if [ -f "$SCRIPT_DIR/p-o-i-v-o-n_1.0.0_all.deb" ]; then
    echo -e "${YELLOW}[INFO] Instalando via .deb...${RESET}"
    cp "$SCRIPT_DIR/p-o-i-v-o-n_1.0.0_all.deb" "$PREFIX/tmp/"
    dpkg -i "$PREFIX/tmp/p-o-i-v-o-n_1.0.0_all.deb" 2>/dev/null || \
    pkg install -y "$PREFIX/tmp/p-o-i-v-o-n_1.0.0_all.deb" 2>/dev/null
    echo -e "${GREEN}[OK] POIVON instalado via .deb.${RESET}"
else
    echo -e "${YELLOW}[INFO] Instalando manualmente (sem .deb)...${RESET}"
    
    # Copiar binário
    mkdir -p "$PREFIX/bin"
    cp "$SCRIPT_DIR/usr/bin/pvn" "$PREFIX/bin/pvn"
    chmod +x "$PREFIX/bin/pvn"
    
    # Copiar configuração
    mkdir -p "$PREFIX/etc/p-o-i-v-o-n"
    cp "$SCRIPT_DIR/usr/etc/p-o-i-v-o-n/pvn.conf" "$PREFIX/etc/p-o-i-v-o-n/pvn.conf"
    
    # Copiar agentes
    mkdir -p "$PREFIX/lib/p-o-i-v-o-n/agents"
    cp "$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/agents/"* "$PREFIX/lib/p-o-i-v-o-n/agents/" 2>/dev/null
    chmod +x "$PREFIX/lib/p-o-i-v-o-n/agents/"* 2>/dev/null
    
    # Copiar scripts
    mkdir -p "$PREFIX/lib/p-o-i-v-o-n/scripts"
    cp "$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/scripts/"* "$PREFIX/lib/p-o-i-v-o-n/scripts/" 2>/dev/null
    chmod +x "$PREFIX/lib/p-o-i-v-o-n/scripts/"* 2>/dev/null
    
    # Copiar base de conhecimento
    mkdir -p "$PREFIX/lib/p-o-i-v-o-n/data"
    cp "$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/data/"* "$PREFIX/lib/p-o-i-v-o-n/data/" 2>/dev/null
    
    # Copiar docs
    mkdir -p "$PREFIX/share/p-o-i-v-o-n/docs"
    
    echo -e "${GREEN}[OK] POIVON instalado manualmente.${RESET}"
fi

# Garantir permissões
chmod +x "$PREFIX/bin/pvn" 2>/dev/null

echo ""

# ─────────────────────────────────────────────────────
# VERIFICAÇÃO FINAL
# ─────────────────────────────────────────────────────

echo -e "${BLUE}[7/7] Verificação final...${RESET}"
echo ""

if command -v pvn &>/dev/null; then
    echo -e "${GREEN}[OK] pvn → instalado em $PREFIX/bin/pvn${RESET}"
else
    echo -e "${YELLOW}[AVISO] pvn não encontrado no PATH. Tente: pvn ${RESET}"
fi

echo -e "${GREEN}[OK] python → $(python --version 2>&1)${RESET}"
echo -e "${GREEN}[OK] node → $(node --version 2>&1)${RESET}"
echo -e "${GREEN}[OK] git → $(git --version 2>&1)${RESET}"
echo -e "${GREEN}[OK] nano → disponível${RESET}"
echo ""

# ─────────────────────────────────────────────────────
# CONCLUSÃO
# ─────────────────────────────────────────────────────

echo -e "${GREEN}╔══════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║                                                  ║${RESET}"
echo -e "${GREEN}║   ✓✓✓  P-O-I-V-O-N instalado com sucesso!  ✓✓✓   ║${RESET}"
echo -e "${GREEN}║                                                  ║${RESET}"
echo -e "${GREEN}║   PVN S¥STEM - AGENTE - POIVON                    ║${RESET}"
echo -e "${GREEN}║                                                  ║${RESET}"
echo -e "${GREEN}║   Digite: pvn          para iniciar               ║${RESET}"
echo -e "${GREEN}║   Digite: pvn help     para ajuda                 ║${RESET}"
echo -e "${GREEN}║   Digite: pvn status   para verificar ambiente    ║${RESET}"
echo -e "${GREEN}║                                                  ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "${CYAN}─────────────────────────────────────────${RESET}"
echo -e "${CYAN}  PVN S¥STEM | AGENTE POIVON | skill yb | Termux Edition${RESET}"
echo -e "${CYAN}─────────────────────────────────────────${RESET}"
echo ""
