#!/data/data/com.termux/files/usr/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║                                                                  ║
# ║   POIVON - Instalação Completa para Termux                       ║
# ║   PVN S¥STEM | AGENTE POIVON | skill yb                         ║
# ║   Termux Edition                                                 ║
# ║                                                                  ║
# ║   Uso: bash install_termux.sh                                    ║
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

clear
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
# VERIFICAÇÃO DO AMBIENTE
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[1/10] Verificando ambiente Termux...${RESET}"

if [ ! -d "$PREFIX" ]; then
    echo -e "${RED}[ERRO] Este script deve ser executado no Termux.${RESET}"
    echo -e "${RED}[ERRO] Instale: https://f-droid.org/packages/com.termux/${RESET}"
    exit 1
fi

echo -e "${GREEN}[OK] Termux detectado → $PREFIX${RESET}"
echo -e "${GREEN}[OK] Versão Termux → $(cat $PREFIX/../../../version-name 2>/dev/null || echo 'N/A')${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# ATUALIZAR REPOSITÓRIOS (pkg)
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[2/10] Atualizando repositórios com pkg...${RESET}"
echo -e "${CYAN}  ┌──────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │ pkg update && pkg upgrade -y             │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────┘${RESET}"

pkg update -y 2>&1 | tail -3
pkg upgrade -y 2>&1 | tail -3

echo -e "${GREEN}[OK] Repositórios atualizados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# INSTALAR DEPENDÊNCIAS ESSENCIAIS (pkg install)
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[3/10] Instalando dependências essenciais com pkg install...${RESET}"
echo -e "${CYAN}  ┌──────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │ pkg install python nodejs git nano wget curl jq tree     │${RESET}"
echo -e "${CYAN}  │ pkg install clang openssl make cmake openssh termux-api  │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────────────────────┘${RESET}"

pkg install -y python python-pip nodejs git nano wget curl jq tree \
    clang openssl make cmake openssh termux-api jq 2>&1 | tail -3

echo -e "${GREEN}[OK] Dependências essenciais instaladas.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# INSTALAR FERRAMENTAS ADICIONAIS (pkg install)
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[4/10] Instalando ferramentas adicionais com pkg install...${RESET}"
echo -e "${CYAN}  ┌──────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │ pkg install ruby perl php go proot proot-distro          │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────────────────────┘${RESET}"

pkg install -y ruby perl proot proot-distro 2>&1 | tail -3

echo -e "${GREEN}[OK] Ferramentas adicionais instaladas.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# PACOTES PYTHON (pip install)
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[5/10] Instalando pacotes Python com pip install...${RESET}"
echo -e "${CYAN}  ┌──────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │ pip install flask requests beautifulsoup4 html5lib       │${RESET}"
echo -e "${CYAN}  │ pip install pillow pygments colorama watchdog            │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────────────────────┘${RESET}"

python -m pip install --upgrade pip 2>&1 | tail -1

pip install --quiet \
    flask requests beautifulsoup4 html5lib pillow pygments \
    colorama watchdog 2>&1 | tail -3

echo -e "${GREEN}[OK] Pacotes Python instalados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# PACOTES NODE (npm install global)
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[6/10] Instalando pacotes Node.js com npm...${RESET}"
echo -e "${CYAN}  ┌──────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │ npm install -g nodemon http-server typescript ts-node    │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────────────────────┘${RESET}"

npm install -g --silent nodemon http-server typescript ts-node 2>&1 | tail -1

echo -e "${GREEN}[OK] Pacotes Node.js instalados.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# PERMISSÕES E ARMAZENAMENTO
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[7/10] Configurando permissões e armazenamento...${RESET}"
echo -e "${CYAN}  ┌──────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │ termux-setup-storage                                     │${RESET}"
echo -e "${CYAN}  │ mkdir -p ~/storage/shared/POIVON/{projects,scripts,...}  │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────────────────────┘${RESET}"

termux-setup-storage 2>/dev/null
sleep 1

# Estrutura de diretórios POIVON
mkdir -p "$HOME/storage/shared/POIVON/projects"
mkdir -p "$HOME/storage/shared/POIVON/scripts"
mkdir -p "$HOME/storage/shared/POIVON/data"
mkdir -p "$HOME/storage/shared/POIVON/backups"
mkdir -p "$HOME/storage/shared/POIVON/guides"
mkdir -p "$HOME/storage/shared/POIVON/logs"

echo -e "${GREEN}[OK] Estrutura criada: ~/storage/shared/POIVON/${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# INSTALAR AGENTE POIVON (git clone + setup)
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[8/10] Clonando e instalando Agente POIVON...${RESET}"
echo -e "${CYAN}  ┌──────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │ git clone https://github.com/matheus23alv-bit/           │${RESET}"
echo -e "${CYAN}  │   P-O-I-V-O-N-agent.git                                  │${RESET}"
echo -e "${CYAN}  │ cd P-O-I-V-O-N-agent && bash setup.sh                    │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────────────────────┘${RESET}"

POIVON_DIR="$HOME/storage/shared/POIVON/agent"

if [ -d "$POIVON_DIR/.git" ]; then
    echo -e "${YELLOW}[INFO] Agente já clonado. Atualizando...${RESET}"
    cd "$POIVON_DIR" && git pull origin main 2>&1 | tail -2
else
    git clone https://github.com/matheus23alv-bit/P-O-I-V-O-N-agent.git "$POIVON_DIR" 2>&1
    cd "$POIVON_DIR"
fi

# Executar setup interno
chmod +x setup.sh build.sh 2>/dev/null
bash setup.sh 2>&1 | tail -5

echo -e "${GREEN}[OK] Agente POIVON instalado.${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# CONFIGURAR ALIAS E PATH
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[9/10] Configurando alias e PATH...${RESET}"
echo -e "${CYAN}  ┌──────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │ Adicionando alias ao ~/.bashrc                          │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────────────────────┘${RESET}"

# Verificar se já existe configuração POIVON no bashrc
if ! grep -q "POIVON CONFIG" "$HOME/.bashrc" 2>/dev/null; then
    echo "" >> "$HOME/.bashrc"
    echo "# ═══ POIVON CONFIG - PVN S¥STEM ═══" >> "$HOME/.bashrc"
    echo "export POIVON_DIR=\"$HOME/storage/shared/POIVON\"" >> "$HOME/.bashrc"
    echo "export WORK_DIR=\"$HOME/storage/shared/POIVON/projects\"" >> "$HOME/.bashrc"
    echo "alias pvn='pvn'" >> "$HOME/.bashrc"
    echo "alias pvn-run='cd ~/storage/shared/POIVON/projects && python -m http.server 8080'" >> "$HOME/.bashrc"
    echo "alias pvn-status='pvn status'" >> "$HOME/.bashrc"
    echo "# ═══ FIM POIVON CONFIG ═══" >> "$HOME/.bashrc"
    echo -e "${GREEN}[OK] Alias adicionados ao ~/.bashrc${RESET}"
else
    echo -e "${YELLOW}[INFO] Alias POIVON já existem no ~/.bashrc${RESET}"
fi

echo ""

# ─────────────────────────────────────────────────────────────────────
# VERIFICAÇÃO FINAL
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${BLUE}[10/10] Verificação final do ambiente...${RESET}"
echo ""
echo -e "${WHITE}  Ferramenta          │ Versão           │ Status${RESET}"
echo -e "${WHITE}  ────────────────────┼──────────────────┼────────${RESET}"

for tool in python node git npm pkg; do
    ver=""
    status=""
    if command -v "$tool" &>/dev/null; then
        case "$tool" in
            python) ver=$(python --version 2>&1) ;;
            node)   ver=$(node --version 2>&1) ;;
            git)    ver=$(git --version 2>&1) ;;
            npm)    ver=$(npm --version 2>&1) ;;
            pkg)    ver="available" ;;
        esac
        status="${GREEN}OK${RESET}"
    else
        ver="N/A"
        status="${RED}ERRO${RESET}"
    fi
    printf "  %-20s│ %-18s│ %b\n" "$tool" "$ver" "$status"
done

echo ""

# Verificar POIVON
if command -v pvn &>/dev/null; then
    echo -e "${GREEN}[OK] pvn → instalado e disponível${RESET}"
else
    echo -e "${YELLOW}[AVISO] pvn → tente: pvn${RESET}"
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
echo -e "${GREEN}║   Termux Edition                                             ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
echo -e "${GREEN}║  Comandos rápidos:                                           ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}║    pvn              Iniciar o agente                         ║${RESET}"
echo -e "${GREEN}║    pvn help         Mostrar ajuda                            ║${RESET}"
echo -e "${GREEN}║    pvn status       Verificar ambiente                       ║${RESET}"
echo -e "${GREEN}║    pvn setup        Reconfigurar ambiente                    ║${RESET}"
echo -e "${GREEN}║    pvn server       Servidor local (porta 8080)              ║${RESET}"
echo -e "${GREEN}║    pvn firebase     Operar no Firebase                       ║${RESET}"
echo -e "${GREEN}║    pvn criar <nome> Criar novo projeto                       ║${RESET}"
echo -e "${GREEN}║    pvn guia <nome>  Executar guia passo a passo             ║${RESET}"
echo -e "${GREEN}║    pvn logs         Ver logs de ações                        ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}╠══════════════════════════════════════════════════════════════╣${RESET}"
echo -e "${GREEN}║  Diretórios:                                                 ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/          Base                     ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/projects/ Projetos                 ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/scripts/  Scripts personalizados   ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/data/     Dados                   ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/logs/     Logs                    ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/backups/  Backups                 ║${RESET}"
echo -e "${GREEN}║    ~/storage/shared/POIVON/guides/   Guias                   ║${RESET}"
echo -e "${GREEN}║                                                              ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "${CYAN}──────────────────────────────────────────────────────────${RESET}"
echo -e "${CYAN}  PVN S¥STEM | AGENTE POIVON | skill yb | Termux Edition${RESET}"
echo -e "${CYAN}──────────────────────────────────────────────────────────${RESET}"
echo ""
echo -e "${BOLD}${WHITE}  Pronto! Digite:${RESET}"
echo -e "${GREEN}    pvn${RESET}"
echo ""
