#!/data/data/com.termux/files/usr/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║                                                                  ║
# ║   POIVON - Instalação Completa para Termux                       ║
# ║   PVN S¥STEM | AGENTE POIVON | skill yb POIVON                  ║
# ║   Beta Edition — branch1                                         ║
# ║   Versão: 1.2.0-beta                                             ║
# ║                                                                  ║
# ║   Uso: bash install_termux.sh                                    ║
# ║   10 fases de instalação automática                             ║
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
echo -e "${GREEN}║     [BETA] branch1 | v1.2.0-beta                           ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [1/10] VERIFICAR TERMUX
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[1/10] Verificando ambiente Termux...${RESET}"

if [ ! -d "$PREFIX" ]; then
    echo -e "${RED}[ERRO] Este script deve ser executado no Termux.${RESET}"
    echo -e "${RED}[ERRO] Instale: https://f-droid.org/packages/com.termux/${RESET}"
    exit 1
fi

echo -e "${GREEN}[OK] Termux detectado → $PREFIX${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [2/10] pkg update && pkg upgrade
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[2/10] pkg update && pkg upgrade...${RESET}"
pkg update -y 2>/dev/null | tail -2
pkg upgrade -y 2>/dev/null | tail -2
echo -e "${GREEN}[OK] Repositórios atualizados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [3/10] INSTALAR DEPENDÊNCIAS DE SISTEMA
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[3/10] Instalando dependências de sistema...${RESET}"

pkg install -y \
    python python-pip \
    nodejs git \
    curl wget nano \
    clang pkg-config \
    libxml2 libxslt \
    openssl jq tree \
    termux-api openssh \
    proot proot-distro 2>&1 | tail -3

echo -e "${GREEN}[OK] Dependências de sistema instaladas.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [4/10] INSTALAR FERRAMENTAS EXTRAS
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[4/10] Instalando ferramentas extras...${RESET}"

pkg install -y \
    ruby perl \
    dpkg 2>&1 | tail -2

echo -e "${GREEN}[OK] Ferramentas extras instaladas.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [5/10] PACOTES PYTHON
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[5/10] Instalando pacotes Python...${RESET}"

pip install --quiet \
    flask requests beautifulsoup4 \
    pillow pygments colorama watchdog \
    html5lib 2>&1 | tail -3

echo -e "${GREEN}[OK] Pacotes Python instalados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [6/10] PACOTES NODE.JS GLOBAIS
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[6/10] Instalando pacotes Node.js globais...${RESET}"

npm install -g --silent nodemon http-server typescript ts-node 2>&1 | tail -1

echo -e "${GREEN}[OK] Pacotes Node.js instalados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [7/10] CONFIGURAR ARMAZENAMENTO
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[7/10] Configurando armazenamento...${RESET}"

if [ -d "$HOME/storage/shared" ]; then
    echo -e "  ${GREEN}[OK]${RESET}   Storage já configurado"
else
    termux-setup-storage <<< "y" 2>/dev/null || termux-setup-storage 2>/dev/null || true
    sleep 1
fi

# Estrutura POIVON
mkdir -p "$HOME/storage/shared/POIVON/projects"
mkdir -p "$HOME/storage/shared/POIVON/scripts"
mkdir -p "$HOME/storage/shared/POIVON/data"
mkdir -p "$HOME/storage/shared/POIVON/backups"
mkdir -p "$HOME/storage/shared/POIVON/guides"
mkdir -p "$HOME/storage/shared/POIVON/logs"

# Fallback
mkdir -p "$HOME/POIVON/projects"
mkdir -p "$HOME/POIVON/scripts"
mkdir -p "$HOME/POIVON/data"
mkdir -p "$HOME/POIVON/backups"
mkdir -p "$HOME/POIVON/guides"
mkdir -p "$HOME/POIVON/logs"

echo -e "${GREEN}[OK] Estrutura criada: ~/storage/shared/POIVON/${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [8/10] CLONAR E INSTALAR AGENTE POIVON (BETA - branch1)
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[8/10] Clonando e instalando Agente POIVON (Beta)...${RESET}"
echo -e "${CYAN}  ┌──────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │ git clone https://github.com/matheus23alv-bit/           │${RESET}"
echo -e "${CYAN}  │   P-O-I-V-O-N-agent.git -b branch1                      │${RESET}"
echo -e "${CYAN}  │ cd P-O-I-V-O-N-agent && bash setup.sh                    │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────────────────────┘${RESET}"

POIVON_DIR="$HOME/storage/shared/POIVON/agent"

if [ -d "$POIVON_DIR/.git" ]; then
    echo -e "${YELLOW}[INFO] Agente já clonado. Atualizando...${RESET}"
    cd "$POIVON_DIR" && git pull origin branch1 2>&1 | tail -2
else
    git clone -b branch1 https://github.com/matheus23alv-bit/P-O-I-V-O-N-agent.git "$POIVON_DIR" 2>&1
    cd "$POIVON_DIR"
fi

# Executar setup interno
chmod +x setup.sh build.sh 2>/dev/null
bash setup.sh 2>&1 | tail -5

echo -e "${GREEN}[OK] Agente POIVON instalado.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# [9/10] CONFIGURAR ALIASES
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[9/10] Configurando aliases...${RESET}"

if ! grep -q "pvn" "$HOME/.bashrc" 2>/dev/null; then
    cat >> "$HOME/.bashrc" << 'BASHRC'

# ─────────────────────────────────────────────────────────────────────
# POIVON - Aliases
# PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Beta
# ─────────────────────────────────────────────────────────────────────
alias pvn='bash $PREFIX/bin/pvn'
alias pvn-status='$PREFIX/bin/pvn status'
alias pvn-help='$PREFIX/bin/pvn help'
alias pvn-server='$PREFIX/bin/pvn server'
alias pvn-setup='$PREFIX/bin/pvn setup'
BASHRC
    echo -e "${GREEN}[OK] Aliases adicionados ao ~/.bashrc${RESET}"
else
    echo -e "${YELLOW}[INFO] Aliases já existem no ~/.bashrc${RESET}"
fi

echo ""

# ─────────────────────────────────────────────────────────────────────
# [10/10] VERIFICAÇÃO FINAL
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[10/10] Verificação final...${RESET}"
echo ""

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
        printf "  %-18s│ %-22s│ ${GREEN}OK${RESET}\n" "$tool" "$ver"
    else
        printf "  %-18s│ %-22s│ ${RED}ERRO${RESET}\n" "$tool" "N/A"
    fi
done

echo ""

# ─────────────────────────────────────────────────────────────────────
# CONCLUSÃO
# ─────────────────────────────────────────────────────────────────────

echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}║   ✓✓✓  POIVON instalado com sucesso!  ✓✓✓                   ║${RESET}"
echo -e "${GREEN}║   [BETA] v1.2.0-beta | branch1                              ║${RESET}"
echo -e "${GREEN}║   PVN S¥STEM - AGENTE - POIVON                               ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
echo -e "${GREEN}║  Comandos rápidos:                                           ║${RESET}"
echo -e "${GREEN}║    pvn              Iniciar o agente                         ║${RESET}"
echo -e "${GREEN}║    pvn status       Verificar ambiente                       ║${RESET}"
echo -e "${GREEN}║    pvn help         Ajuda                                    ║${RESET}"
echo -e "${GREEN}║    pvn server       Servidor local                           ║${RESET}"
echo -e "${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
echo -e "${GREEN}║  Diretórios:                                                 ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/                                   ║${RESET}"
echo -e "${GREEN}║    ├── projects/   ← Projetos web/app                        ║${RESET}"
echo -e "${GREEN}║    ├── scripts/    ← Scripts auxiliares                       ║${RESET}"
echo -e "${GREEN}║    ├── data/       ← Dados                                   ║${RESET}"
echo -e "${GREEN}║    ├── backups/    ← Backups                                 ║${RESET}"
echo -e "${GREEN}║    ├── guides/     ← Guias                                   ║${RESET}"
echo -e "${GREEN}║    └── logs/       ← Logs                                    ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "${CYAN}──────────────────────────────────────────────────────────${RESET}"
echo -e "${CYAN}  PVN S¥STEM | AGENTE POIVON | skill yb POIVON${RESET}"
echo -e "${CYAN}  Beta Edition | branch1 | v1.2.0-beta${RESET}"
echo -e "${CYAN}──────────────────────────────────────────────────────────${RESET}"
echo ""
echo -e "${BOLD}${WHITE}  Pronto! Digite:${RESET}"
echo -e "${GREEN}    pvn${RESET}"
echo ""
