#!/data/data/com.termux/files/usr/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║                                                                  ║
# ║   POIVON - Verificador de Dependências lxml                     ║
# ║   PVN S¥STEM | AGENTE POIVON | skill yb                         ║
# ║   Verifica se lxml pode ser compilado no Termux                  ║
# ║                                                                  ║
# ║   Uso: bash check_deps.sh                                        ║
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
RESET='\033[0m'

echo ""
echo -e "${CYAN}  ┌──────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}  │  POIVON - Verificador de Dependências lxml       │${RESET}"
echo -e "${CYAN}  │  PVN S¥STEM | AGENTE POIVON | skill yb          │${RESET}"
echo -e "${CYAN}  └──────────────────────────────────────────────────┘${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# RESULTADOS
# ─────────────────────────────────────────────────────────────────────

PASS=0
FAIL=0
WARN=0

check() {
    local name="$1"
    local check_cmd="$2"
    local install_cmd="$3"

    if eval "$check_cmd" &>/dev/null; then
        echo -e "  ${GREEN}[OK]${RESET}   $name"
        ((PASS++))
    else
        echo -e "  ${RED}[ERRO]${RESET} $name"
        if [ -n "$install_cmd" ]; then
            echo -e "         ${YELLOW}Instalar: $install_cmd${RESET}"
        fi
        ((FAIL++))
    fi
}

# ─────────────────────────────────────────────────────────────────────
# VERIFICAR DEPENDÊNCIAS lxml
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${WHITE}━━━ Dependências para lxml ━━━${RESET}"
echo ""

# 1. Verificar se está no Termux
check "Ambiente Termux" \
    "[ -d \"\$PREFIX\" ]" \
    "https://f-droid.org/packages/com.termux/"

# 2. clang (compilador C necessário)
check "clang (compilador C)" \
    "command -v clang" \
    "pkg install clang"

# 3. pkg-config
check "pkg-config" \
    "command -v pkg-config" \
    "pkg install pkg-config"

# 4. libxml2 (biblioteca principal)
check "libxml2-dev" \
    "dpkg -l libxml2-dev 2>/dev/null | grep -q ii || [ -f \"\$PREFIX/include/libxml2/libxml/xmlversion.h\" ]" \
    "pkg install libxml2"

# 5. libxslt (transformações XSL)
check "libxslt-dev" \
    "dpkg -l libxslt-dev 2>/dev/null | grep -q ii || [ -f \"\$PREFIX/include/libxslt/xslt.h\" ]" \
    "pkg install libxslt"

# 6. Python headers
check "Python dev (headers)" \
    "python -c 'import sysconfig; print(sysconfig.get_path(\"include\"))' 2>/dev/null" \
    "pkg install python"

# 7. pip (gerenciador de pacotes)
check "pip" \
    "command -v pip" \
    "python -m pip install --upgrade pip"

echo ""

# ─────────────────────────────────────────────────────────────────────
# TENTAR COMPILAR lxml
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${WHITE}━━━ Teste de compilação lxml ━━━${RESET}"
echo ""

if python -c "import lxml" 2>/dev/null; then
    LXML_VER=$(python -c "import lxml; print(lxml.__version__)" 2>/dev/null)
    echo -e "  ${GREEN}[OK]${RESET}   lxml já instalado (v$LXML_VER)"
    ((PASS++))
else
    echo -e "  ${YELLOW}[TESTE]${RESET} Tentando compilar lxml via pip..."
    echo ""
    echo -e "  ${CYAN}  ┌──────────────────────────────────────────┐${RESET}"
    echo -e "  ${CYAN}  │ pip install lxml --no-binary :all:       │${RESET}"
    echo -e "  ${CYAN}  └──────────────────────────────────────────┘${RESET}"
    echo ""

    # Tentar instalar lxml com flags do Termux
    export CFLAGS="-I$PREFIX/include/libxml2 -I$PREFIX/include/libxslt"
    export LDFLAGS="-L$PREFIX/lib -lxml2 -lxslt -lz -lm"

    if pip install lxml --no-binary lxml 2>&1 | tail -5; then
        echo ""
        echo -e "  ${GREEN}[OK]${RESET}   lxml compilado com sucesso!"
        ((PASS++))
    else
        echo ""
        echo -e "  ${RED}[ERRO]${RESET} lxml NÃO pôde ser compilado."
        ((FAIL++))
    fi
fi

echo ""

# ─────────────────────────────────────────────────────────────────────
# VERIFICAR ALTERNATIVAS
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${WHITE}━━━ Alternativas compatíveis ━━━${RESET}"
echo ""

for pkg in html5lib beautifulsoup4; do
    if python -c "import $pkg" 2>/dev/null; then
        echo -e "  ${GREEN}[OK]${RESET}   $pkg (instalado)"
    else
        echo -e "  ${YELLOW}[MISSING]${RESET} $pkg"
        echo -e "         ${CYAN}Instalar: pip install $pkg${RESET}"
    fi
done

echo ""

# ─────────────────────────────────────────────────────────────────────
# RESUMO
# ─────────────────────────────────────────────────────────────────────

echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  ${GREEN}OK:${RESET} $PASS  │  ${RED}ERRO:${RESET} $FAIL  │  ${YELLOW}AVISO:${RESET} $WARN"
echo ""

if [ "$FAIL" -gt 0 ]; then
    echo -e "  ${RED}╔══════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${RED}║  Dependências faltando! Execute:                ║${RESET}"
    echo -e "  ${RED}║                                                  ║${RESET}"
    echo -e "  ${RED}║  pkg install clang pkg-config libxml2 libxslt    ║${RESET}"
    echo -e "  ${RED}║                                                  ║${RESET}"
    echo -e "  ${RED}║  pip install lxml                                ║${RESET}"
    echo -e "  ${RED}║                                                  ║${RESET}"
    echo -e "  ${RED}║  Ou use html5lib como alternativa:              ║${RESET}"
    echo -e "  ${RED}║  pip install html5lib beautifulsoup4             ║${RESET}"
    echo -e "  ${RED}╚══════════════════════════════════════════════════╝${RESET}"
else
    echo -e "  ${GREEN}╔══════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${GREEN}║  Todas as dependências estão OK!                ║${RESET}"
    echo -e "  ${GREEN}╚══════════════════════════════════════════════════╝${RESET}"
fi

echo ""
echo -e "  PVN S¥STEM | AGENTE POIVON | skill yb"
echo ""
