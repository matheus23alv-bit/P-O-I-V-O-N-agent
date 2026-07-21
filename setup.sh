#!/data/data/com.termux/files/usr/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║                                                                  ║
# ║   POIVON - Setup Completo para Termux                            ║
# ║   PVN S¥STEM | AGENTE POIVON | skill yb                         ║
# ║   Termux Edition                                                 ║
# ║                                                                  ║
# ║   Uso: bash setup.sh                                             ║
# ║   Instala via pkg install e pip install com verificação lxml    ║
# ║                                                                  ║
# ╚══════════════════════════════════════════════════════════════════╝

set -euo pipefail

# ─────────────────────────────────────────────────────────────────────
# CORES
# ─────────────────────────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

# ─────────────────────────────────────────────────────────────────────
# SPLASH SCREEN
# ─────────────────────────────────────────────────────────────────────

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
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}║     ▄▀▄  P-O-I-V-O-N  ▄▀▄                                ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}║     iniciando PVN S¥STEM - °°°°°° starting....            ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}║     POIVON AGENTE MASTER CODE - TERMUX EDITION              ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [1/8] VERIFICAR AMBIENTE
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[1/8] Verificando ambiente Termux...${RESET}"

if [ ! -d "$PREFIX" ]; then
    echo -e "${RED}[ERRO] Este script deve ser executado no Termux.${RESET}"
    echo -e "${RED}[ERRO] Instale: https://f-droid.org/packages/com.termux/${RESET}"
    exit 1
fi

echo -e "${GREEN}[OK] Termux detectado → $PREFIX${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [2/8] pkg update && pkg upgrade
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[2/8] pkg update && pkg upgrade...${RESET}"
pkg update -y 2>/dev/null | tail -2
pkg upgrade -y 2>/dev/null | tail -2
echo -e "${GREEN}[OK] Repositórios atualizados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [3/8] pkg install - dependências essenciais + lxml dev
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[3/8] pkg install - dependências essenciais...${RESET}"
echo -e "${CYAN}  pkg install python python-pip nodejs git curl wget nano \\"
echo -e "    clang pkg-config libxml2 libxslt openssl jq tree termux-api${RESET}"
echo ""

pkg install -y \
    python python-pip \
    nodejs git \
    curl wget nano \
    clang pkg-config \
    libxml2 libxslt \
    openssl jq tree \
    termux-api openssh 2>&1 | tail -3

echo -e "${GREEN}[OK] pkg install concluído.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [4/8] VERIFICAR DEPENDÊNCIAS lxml
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[4/8] Verificando dependências para lxml...${RESET}"
echo ""

LXML_OK=false

# libxml2
if [ -f "$PREFIX/include/libxml2/libxml/xmlversion.h" ]; then
    echo -e "  ${GREEN}[OK]${RESET}   libxml2-dev → encontrado"
else
    echo -e "  ${RED}[ERRO]${RESET}   libxml2-dev → faltando"
    echo -e "  ${YELLOW}[FIX]${RESET}   Executando: pkg install libxml2${RESET}"
    pkg install -y libxml2 2>&1 | tail -2
fi

# libxslt
if [ -f "$PREFIX/include/libxslt/xslt.h" ]; then
    echo -e "  ${GREEN}[OK]${RESET}   libxslt-dev → encontrado"
else
    echo -e "  ${RED}[ERRO]${RESET}   libxslt-dev → faltando"
    echo -e "  ${YELLOW}[FIX]${RESET}   Executando: pkg install libxslt${RESET}"
    pkg install -y libxslt 2>&1 | tail -2
fi

# clang
if command -v clang &>/dev/null; then
    echo -e "  ${GREEN}[OK]${RESET}   clang → $(clang --version 2>&1 | head -1)"
else
    echo -e "  ${RED}[ERRO]${RESET}   clang → faltando"
    pkg install -y clang 2>&1 | tail -2
fi

# pkg-config
if command -v pkg-config &>/dev/null; then
    echo -e "  ${GREEN}[OK]${RESET}   pkg-config → encontrado"
else
    echo -e "  ${RED}[ERRO]${RESET}   pkg-config → faltando"
    pkg install -y pkg-config 2>&1 | tail -2
fi

echo ""

# ─────────────────────────────────────────────────────────────────────
# [5/8] pip install lxml (ou fallback para html5lib)
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[5/8] pip install - lxml e pacotes Python...${RESET}"
echo ""

python -m pip install --upgrade pip 2>&1 | tail -1

echo -e "  ${CYAN}┌──────────────────────────────────────────────────────┐${RESET}"
echo -e "  ${CYAN}│ Tentando instalar lxml...                            │${RESET}"
echo -e "  ${CYAN}└──────────────────────────────────────────────────────┘${RESET}"
echo ""

export CFLAGS="-I$PREFIX/include/libxml2 -I$PREFIX/include/libxslt"
export LDFLAGS="-L$PREFIX/lib -lxml2 -lxslt -lz -lm"

if pip install lxml --no-binary lxml 2>/dev/null; then
    echo ""
    echo -e "  ${GREEN}[OK]${RESET}   lxml instalado com sucesso!"
    LXML_OK=true
else
    echo ""
    echo -e "  ${YELLOW}[FALLBACK]${RESET} lxml falhou. Instalando html5lib..."
    pip install html5lib 2>&1 | tail -1
    echo -e "  ${GREEN}[OK]${RESET}   html5lib instalado (substituto de lxml)"
    LXML_OK=false
fi

echo ""

# Pacotes complementares
echo -e "  ${CYAN}┌──────────────────────────────────────────────────────┐${RESET}"
echo -e "  ${CYAN}│ pip install - pacotes complementares                 │${RESET}"
echo -e "  ${CYAN}└──────────────────────────────────────────────────────┘${RESET}"
echo ""

PIP_PKGS="flask requests beautifulsoup4 pillow pygments colorama watchdog"

if [ "$LXML_OK" = false ]; then
    PIP_PKGS="$PIP_PKGS html5lib"
    echo -e "  ${CYAN}  Usando: html5lib (lxml indisponível)${RESET}"
else
    echo -e "  ${CYAN}  Usando: lxml${RESET}"
fi

echo ""
pip install --quiet $PIP_PKGS 2>&1 | tail -3
echo -e "${GREEN}[OK] Pacotes Python instalados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [6/8] npm install -g
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[6/8] npm install -g - pacotes Node.js...${RESET}"
echo -e "${CYAN}  npm install -g nodemon http-server typescript ts-node${RESET}"
echo ""

npm install -g --silent nodemon http-server typescript ts-node 2>&1 | tail -1
echo -e "${GREEN}[OK] Pacotes Node.js instalados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [7/8] PERMISSÕES E ESTRUTURA
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[7/8] Configurando permissões e estrutura...${RESET}"

termux-setup-storage 2>/dev/null
sleep 1

mkdir -p "$HOME/storage/shared/POIVON/projects"
mkdir -p "$HOME/storage/shared/POIVON/scripts"
mkdir -p "$HOME/storage/shared/POIVON/data"
mkdir -p "$HOME/storage/shared/POIVON/backups"
mkdir -p "$HOME/storage/shared/POIVON/guides"
mkdir -p "$HOME/storage/shared/POIVON/logs"

echo -e "${GREEN}[OK] Estrutura: ~/storage/shared/POIVON/${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [8/8] INSTALAR BINÁRIO POIVON
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[8/8] Instalando binário POIVON...${RESET}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Binário
mkdir -p "$PREFIX/bin"
[ -f "$SCRIPT_DIR/usr/bin/pvn" ] && cp "$SCRIPT_DIR/usr/bin/pvn" "$PREFIX/bin/pvn" && chmod +x "$PREFIX/bin/pvn"

# Config
mkdir -p "$PREFIX/etc/p-o-i-v-o-n"
[ -f "$SCRIPT_DIR/usr/etc/p-o-i-v-o-n/pvn.conf" ] && cp "$SCRIPT_DIR/usr/etc/p-o-i-v-o-n/pvn.conf" "$PREFIX/etc/p-o-i-v-o-n/pvn.conf"

# Agentes
mkdir -p "$PREFIX/lib/p-o-i-v-o-n/agents"
[ -d "$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/agents" ] && cp "$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/agents/"* "$PREFIX/lib/p-o-i-v-o-n/agents/" 2>/dev/null

# Scripts
mkdir -p "$PREFIX/lib/p-o-i-v-o-n/scripts"
[ -d "$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/scripts" ] && cp "$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/scripts/"* "$PREFIX/lib/p-o-i-v-o-n/scripts/" 2>/dev/null

# Data
mkdir -p "$PREFIX/lib/p-o-i-v-o-n/data"
[ -d "$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/data" ] && cp "$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/data/"* "$PREFIX/lib/p-o-i-v-o-n/data/" 2>/dev/null

# Permissões
chmod +x "$PREFIX/bin/pvn" 2>/dev/null
chmod +x "$PREFIX/lib/p-o-i-v-o-n/agents/"* 2>/dev/null
chmod +x "$PREFIX/lib/p-o-i-v-o-n/scripts/"* 2>/dev/null

echo -e "${GREEN}[OK] POIVON instalado.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# VERIFICAÇÃO FINAL
# ─────────────────────────────────────────────────────────────────────

echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "${BOLD}${WHITE}  Ferramenta       │ Versão               │ Status${RESET}"
echo -e "${WHITE}  ──────────────────┼──────────────────────┼────────${RESET}"

for tool in python node git npm; do
    ver=""
    if command -v "$tool" &>/dev/null; then
        case "$tool" in
            python) ver=$(python --version 2>&1) ;;
            node)   ver=$(node --version 2>&1) ;;
            git)    ver=$(git --version 2>&1) ;;
            npm)    ver="v$(npm --version 2>&1)" ;;
        esac
        echo -e "  %-18s│ %-22s│ ${GREEN}OK${RESET}" "$tool" "$ver"
    else
        echo -e "  %-18s│ %-22s│ ${RED}ERRO${RESET}" "$tool" "N/A"
    fi
done

if [ "$LXML_OK" = true ]; then
    echo -e "  %-18s│ %-22s│ ${GREEN}OK${RESET}" "lxml" "$(python -c 'import lxml; print(lxml.__version__)' 2>/dev/null)"
else
    echo -e "  %-18s│ %-22s│ ${YELLOW}html5lib${RESET}" "lxml" "substituto"
fi

echo ""

# ─────────────────────────────────────────────────────────────────────
# CONCLUSÃO
# ─────────────────────────────────────────────────────────────────────

echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}║   ✓✓✓  POIVON instalado com sucesso!  ✓✓✓                   ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}║   PVN S¥STEM - AGENTE - POIVON                               ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
echo -e "${GREEN}║  Comandos:                                                   ║${RESET}"
echo -e "${GREEN}║    pvn              Iniciar o agente                         ║${RESET}"
echo -e "${GREEN}║    pvn help         Ajuda                                    ║${RESET}"
echo -e "${GREEN}║    pvn status       Verificar ambiente                       ║${RESET}"
echo -e "${GREEN}║    pvn setup        Reconfigurar                             ║${RESET}"
echo -e "${GREEN}║    pvn server       Servidor local (porta 8080)              ║${RESET}"
echo -e "${GREEN}║    pvn firebase     Firebase                                 ║${RESET}"
echo -e "${GREEN}║    pvn criar <nome> Criar projeto                            ║${RESET}"
echo -e "${GREEN}║    pvn guia <nome>  Executar guia                            ║${RESET}"
echo -e "${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
echo -e "${GREEN}║  Diretórios:                                                 ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/projects/  Projetos                ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/scripts/   Scripts                 ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/data/      Dados                  ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/logs/      Logs                   ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "${CYAN}──────────────────────────────────────────────────────────${RESET}"
echo -e "${CYAN}  PVN S¥STEM | AGENTE POIVON | skill yb | Termux Edition${RESET}"
echo -e "${CYAN}──────────────────────────────────────────────────────────${RESET}"
echo ""
echo -e "${BOLD}${WHITE}  Pronto! Digite:${RESET}"
echo -e "${GREEN}    pvn${RESET}"
echo ""
