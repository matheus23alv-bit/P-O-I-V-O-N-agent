#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║                                                                  ║
# ║   POIVON - Teste Completo de Dependências e Funcionalidades     ║
# ║   PVN S¥STEM | AGENTE POIVON | skill yb                         ║
# ║                                                                  ║
# ║   Uso: bash test_all.sh [--log] [--install]                     ║
# ║   --log      Salva log em ~/storage/shared/POIVON/logs/         ║
# ║   --install  Instala dependências faltando automaticamente      ║
# ║                                                                  ║
# ╚══════════════════════════════════════════════════════════════════╝

set -e
# Don't use pipefail because test_cmd uses grep in conditionals
shopt -s expand_aliases 2>/dev/null || true

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
# CONFIGURAÇÃO
# ─────────────────────────────────────────────────────────────────────

LOG_ENABLED=false
AUTO_INSTALL=false
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE=""
PASS=0
FAIL=0
WARN=0
SKIP=0
LOGS=()

for arg in "$@"; do
    case "$arg" in
        --log) LOG_ENABLED=true ;;
        --install) AUTO_INSTALL=true ;;
        --help|-h)
            echo "Uso: bash test_all.sh [--log] [--install]"
            echo "  --log      Salva log"
            echo "  --install  Instala dependências faltando"
            exit 0 ;;
    esac
done

# Setup log
if [ "$LOG_ENABLED" = true ]; then
    LOG_DIR="$HOME/storage/shared/POIVON/logs"
    mkdir -p "$LOG_DIR" 2>/dev/null || LOG_DIR="/tmp/poivon_logs"
    mkdir -p "$LOG_DIR"
    LOG_FILE="$LOG_DIR/test_$(date +%Y%m%d_%H%M%S).log"
    echo "POIVON - Teste Completo - $(date)" > "$LOG_FILE"
    echo "═══════════════════════════════════════════" >> "$LOG_FILE"
fi

log() {
    if [ "${1:-}" = "-e" ]; then shift; fi
    local msg="${1:-}"
    echo -e "$msg" 2>/dev/null || true
    if [ -n "$LOG_FILE" ]; then
        echo "$msg" | sed 's/\x1b\[[0-9;]*m//g' >> "$LOG_FILE" 2>/dev/null || true
    fi
}

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
echo -e "${GREEN}║  ▄▀▄  P-O-I-V-O-N  ▄▀▄                                    ║${RESET}"
echo -e "${GREEN}║  iniciando PVN S¥STEM - °°°°°° starting....               ║${RESET}"
echo -e "${GREEN}║  POIVON AGENTE MASTER CODE - TESTES COMPLETOS              ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# HELPER: TESTAR DEPENDÊNCIA
# ─────────────────────────────────────────────────────────────────────

test_cmd() {
    local name="$1"
    local check="$2"
    local install_cmd="$3"
    local critical="${4:-false}"

    log -e "  ${CYAN}  Testando: ${WHITE}$name${RESET}"

    if eval "$check" &>/dev/null; then
        log -e "  ${GREEN}  [PASS]${RESET} $name"
        PASS=$((PASS + 1))
        LOGS+=("PASS:$name")
        return 0
    else
        if [ "$critical" = true ]; then
            log -e "  ${RED}  [FAIL]${RESET} $name (CRÍTICO)"
            FAIL=$((FAIL + 1))
            LOGS+=("FAIL:$name:CRÍTICO")
            if [ -n "$install_cmd" ] && [ "$AUTO_INSTALL" = true ]; then
                log -e "  ${YELLOW}         Auto-instalando: $install_cmd${RESET}"
                eval "$install_cmd" 2>/dev/null
                if eval "$check" &>/dev/null; then
                    log -e "  ${GREEN}  [FIXED]${RESET} $name instalado com sucesso"
                    FAIL=$((FAIL - 1))
                    PASS=$((PASS + 1))
                    LOGS+=("FIXED:$name")
                    return 0
                fi
            elif [ -n "$install_cmd" ]; then
                log -e "  ${YELLOW}         Instalar: $install_cmd${RESET}"
            fi
        else
            log -e "  ${YELLOW}  [WARN]${RESET} $name (não crítico)"
            WARN=$((WARN + 1))
            LOGS+=("WARN:$name")
            if [ -n "$install_cmd" ] && [ "$AUTO_INSTALL" = true ]; then
                log -e "  ${YELLOW}         Auto-instalando: $install_cmd${RESET}"
                eval "$install_cmd" 2>/dev/null
                if eval "$check" &>/dev/null; then
                    log -e "  ${GREEN}  [FIXED]${RESET} $name instalado com sucesso"
                    WARN=$((WARN - 1))
                    PASS=$((PASS + 1))
                    LOGS+=("FIXED:$name")
                    return 0
                fi
            elif [ -n "$install_cmd" ]; then
                log -e "  ${YELLOW}         Instalar: $install_cmd${RESET}"
            fi
        fi
        return 1
    fi
}

# ─────────────────────────────────────────────────────────────────────
# [1] SISTEMA
# ─────────────────────────────────────────────────────────────────────

echo ""
echo -e "${BOLD}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}${BLUE}  [1/6] DEPENDÊNCIAS DO SISTEMA${RESET}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

# Detectar ambiente
PREFIX="${PREFIX:-/usr}"
if [ -d "$PREFIX" ] && [ "$(uname -s)" = "Linux" ] && grep -q "Android" /proc/version 2>/dev/null; then
    ENV_TYPE="Termux"
else
    ENV_TYPE="Linux $(uname -s) (Sandbox)"
fi
log -e "  ${CYAN}  Ambiente: ${WHITE}$ENV_TYPE${RESET}"
log -e "  ${CYAN}  Shell: ${WHITE}$SHELL${RESET}"
log -e "  ${CYAN}  HOME: ${WHITE}$HOME${RESET}"
echo ""

# Dependências do sistema
test_cmd "bash" \
    "command -v bash" \
    "apt install bash" true || true

test_cmd "curl" \
    "command -v curl" \
    "pkg install curl" false || true

test_cmd "wget" \
    "command -v wget" \
    "pkg install wget" false || true

test_cmd "git" \
    "command -v git" \
    "pkg install git" false || true

test_cmd "jq" \
    "command -v jq" \
    "pkg install jq" false || true

test_cmd "nano" \
    "command -v nano" \
    "pkg install nano" false || true

test_cmd "tree" \
    "command -v tree" \
    "pkg install tree" false || true

test_cmd "openssl" \
    "command -v openssl" \
    "pkg install openssl" true || true

test_cmd "ssh (openssh)" \
    "command -v ssh" \
    "pkg install openssh" false || true

test_cmd "clang (compilador C)" \
    "command -v clang" \
    "pkg install clang" false || true

test_cmd "pkg-config" \
    "command -v pkg-config" \
    "pkg install pkg-config" false || true

echo ""

# ─────────────────────────────────────────────────────────────────────
# [2] PYTHON E PACOTES
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}${BLUE}  [2/6] PYTHON E PACOTES${RESET}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

test_cmd "python3" \
    "command -v python3" \
    "pkg install python" true || true

test_cmd "pip" \
    "command -v pip" \
    "pkg install python-pip" true || true

# Versão do Python
if command -v python3 &>/dev/null; then
    PY_VER=$(python3 --version 2>&1)
    log -e "  ${CYAN}  Python: ${WHITE}$PY_VER${RESET}"
fi

echo ""
log -e "  ${CYAN}  Testando pacotes Python...${RESET}"
echo ""

# pares "pacote-pip:módulo-import" (bs4 e PIL têm nomes de import diferentes)
for py_pair in flask:flask requests:requests beautifulsoup4:bs4 html5lib:html5lib pillow:PIL pygments:pygments colorama:colorama watchdog:watchdog; do
    py_pkg="${py_pair%%:*}"
    py_mod="${py_pair##*:}"
    test_cmd "Python: $py_pkg" \
        "python3 -c 'import ${py_mod}'" \
        "pip install $py_pkg" true || true
done

# lxml (opcional)
test_cmd "Python: lxml (opcional)" \
    "python3 -c 'import lxml'" \
    "pip install lxml" false || true

echo ""

# ─────────────────────────────────────────────────────────────────────
# [3] NODE.JS E PACOTES
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}${BLUE}  [3/6] NODE.JS E PACOTES${RESET}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

test_cmd "node" \
    "command -v node" \
    "pkg install nodejs" true || true

test_cmd "npm" \
    "command -v npm" \
    "pkg install nodejs" true || true

if command -v node &>/dev/null; then
    NODE_VER=$(node --version 2>&1)
    NPM_VER="v$(npm --version 2>&1)"
    log -e "  ${CYAN}  Node.js: ${WHITE}$NODE_VER${RESET}"
    log -e "  ${CYAN}  npm: ${WHITE}$NPM_VER${RESET}"
fi

echo ""
log -e "  ${CYAN}  Testando pacotes Node.js globais...${RESET}"
echo ""

for np in nodemon http-server typescript ts-node; do
    test_cmd "Node: $np" \
        "command -v $np || npm ls -g $np 2>/dev/null | grep -q $np" \
        "npm install -g $np" false || true
done

echo ""

# ─────────────────────────────────────────────────────────────────────
# [4] FERRAMENTAS DO PROJETO POIVON
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}${BLUE}  [4/6] FERRAMENTAS DO PROJETO POIVON${RESET}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

test_cmd "pvn (binário)" \
    "command -v pvn || [ -f '$PREFIX/bin/pvn' ] || [ -f '$SCRIPT_DIR/usr/bin/pvn' ]" \
    "bash $SCRIPT_DIR/setup.sh" true || true

test_cmd "pvn.conf (config)" \
    "[ -f '$PREFIX/etc/p-o-i-v-o-n/pvn.conf' ] || [ -f '$SCRIPT_DIR/usr/etc/p-o-i-v-o-n/pvn.conf' ]" \
    "" false || true

test_cmd "Agentes (firebase_agent.sh)" \
    "[ -f '$PREFIX/lib/p-o-i-v-o-n/agents/firebase_agent.sh' ] || [ -f '$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/agents/firebase_agent.sh' ]" \
    "" false || true

test_cmd "Agentes (termux_env.sh)" \
    "[ -f '$PREFIX/lib/p-o-i-v-o-n/agents/termux_env.sh' ] || [ -f '$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/agents/termux_env.sh' ]" \
    "" false || true

test_cmd "Server (server.py)" \
    "[ -f '$PREFIX/lib/p-o-i-v-o-n/scripts/server.py' ] || [ -f '$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/scripts/server.py' ]" \
    "" false || true

test_cmd "Build script (build_project.sh)" \
    "[ -f '$PREFIX/lib/p-o-i-v-o-n/scripts/build_project.sh' ] || [ -f '$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/scripts/build_project.sh' ]" \
    "" false || true

test_cmd "Dicionário Termux" \
    "[ -f '$PREFIX/lib/p-o-i-v-o-n/data/dicionario_termux.md' ] || [ -f '$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/data/dicionario_termux.md' ]" \
    "" false || true

test_cmd "System Prompt" \
    "[ -f '$PREFIX/lib/p-o-i-v-o-n/data/system_prompt.md' ] || [ -f '$SCRIPT_DIR/usr/lib/p-o-i-v-o-n/data/system_prompt.md' ]" \
    "" false || true

test_cmd "check_deps.sh" \
    "[ -f '$SCRIPT_DIR/check_deps.sh' ]" \
    "" false || true

test_cmd "install_termux.sh" \
    "[ -f '$SCRIPT_DIR/install_termux.sh' ]" \
    "" false || true

test_cmd "setup.sh" \
    "[ -f '$SCRIPT_DIR/setup.sh' ]" \
    "" false || true

echo ""

# ─────────────────────────────────────────────────────────────────────
# [5] TESTES DE COMUNICAÇÃO
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}${BLUE}  [5/6] TESTES DE COMUNICAÇÃO${RESET}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

# Teste 1: Python responde
log -e "  ${CYAN}  Teste 1: Python respondendo...${RESET}"
if python3 -c "print('POIVON OK')" 2>/dev/null; then
    log -e "  ${GREEN}  [PASS]${RESET} Python executou com sucesso"
    ((PASS++))
    LOGS+=("PASS:Teste1-Python")
else
    log -e "  ${RED}  [FAIL]${RESET} Python não respondeu"
    ((FAIL++))
    LOGS+=("FAIL:Teste1-Python")
fi

# Teste 2: Node responde
log -e "  ${CYAN}  Teste 2: Node.js respondendo...${RESET}"
if node -e "console.log('POIVON OK')" 2>/dev/null; then
    log -e "  ${GREEN}  [PASS]${RESET} Node.js executou com sucesso"
    ((PASS++))
    LOGS+=("PASS:Teste2-Node")
else
    log -e "  ${RED}  [FAIL]${RESET} Node.js não respondeu"
    ((FAIL++))
    LOGS+=("FAIL:Teste2-Node")
fi

# Teste 3: Flask server
log -e "  ${CYAN}  Teste 3: Servidor Flask (porta 8080)...${RESET}"
if command -v python3 &>/dev/null; then
    # Criar um servidor Flask mínimo para teste
    FLASK_TEST=$(mktemp /tmp/flask_test_XXXXXX.py)
    cat > "$FLASK_TEST" << 'PYEOF'
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return 'POIVON SERVER OK'

@app.route('/health')
def health():
    return '{"status":"ok","agent":"POIVON"}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
PYEOF

    # Iniciar servidor em background
    python3 "$FLASK_TEST" &>/dev/null &
    FLASK_PID=$!
    sleep 2

    if curl -s http://localhost:8080/ 2>/dev/null | grep -q "POIVON"; then
        log -e "  ${GREEN}  [PASS]${RESET} Servidor Flask respondendo em :8080"
        ((PASS++))
        LOGS+=("PASS:Teste3-Flask")

        # Teste health endpoint
        HEALTH=$(curl -s http://localhost:8080/health 2>/dev/null)
        if echo "$HEALTH" | grep -q '"status":"ok"'; then
            log -e "  ${GREEN}  [PASS]${RESET} Health endpoint respondendo"
            ((PASS++))
            LOGS+=("PASS:Teste3-Health")
        else
            log -e "  ${YELLOW}  [WARN]${RESET} Health endpoint não retornou JSON esperado"
            ((WARN++))
            LOGS+=("WARN:Teste3-Health")
        fi
    else
        log -e "  ${RED}  [FAIL]${RESET} Servidor Flask não respondeu em :8080"
        ((FAIL++))
        LOGS+=("FAIL:Teste3-Flask")
    fi

    kill $FLASK_PID 2>/dev/null
    rm -f "$FLASK_TEST"
else
    log -e "  ${YELLOW}  [SKIP]${RESET} Python não disponível, pulando teste Flask"
    SKIP=$((SKIP + 1))
    LOGS+=("SKIP:Teste3-Flask")
fi

# Teste 4: Node HTTP server
log -e "  ${CYAN}  Teste 4: Servidor Node.js (porta 9090)...${RESET}"
if command -v node &>/dev/null; then
    NODE_TEST=$(mktemp /tmp/node_test_XXXXXX.js)
    cat > "$NODE_TEST" << 'JSEOF'
const http = require('http');
const server = http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('POIVON NODE OK');
});
server.listen(9090, '0.0.0.0');
JSEOF

    node "$NODE_TEST" &>/dev/null &
    NODE_PID=$!
    sleep 2

    if curl -s http://localhost:9090/ 2>/dev/null | grep -q "POIVON"; then
        log -e "  ${GREEN}  [PASS]${RESET} Servidor Node.js respondendo em :9090"
        ((PASS++))
        LOGS+=("PASS:Teste4-NodeServer")
    else
        log -e "  ${RED}  [FAIL]${RESET} Servidor Node.js não respondeu em :9090"
        ((FAIL++))
        LOGS+=("FAIL:Teste4-NodeServer")
    fi

    kill $NODE_PID 2>/dev/null
    rm -f "$NODE_TEST"
else
    log -e "  ${YELLOW}  [SKIP]${RESET} Node.js não disponível, pulando teste"
    SKIP=$((SKIP + 1))
    LOGS+=("SKIP:Teste4-NodeServer")
fi

# Teste 5: Conexão Firebase
log -e "  ${CYAN}  Teste 5: Conexão Firebase (agente-poivon)...${RESET}"
# Firebase é OPCIONAL (Regra 12). O projeto usa Firestore, não Realtime DB.
# PASS = serviço alcançável (200/401/403/404 = rede ok, auth é escopo v2.0).
FB_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "https://firestore.googleapis.com/v1/projects/agente-poivon/databases/(default)/documents/admin/config" 2>/dev/null)
if echo "$FB_CODE" | grep -qE "^(200|401|403|404)$"; then
    log -e "  ${GREEN}  [PASS]${RESET} Firebase/Firestore alcançável (HTTP $FB_CODE — auth real: v2.0)"
    ((PASS++))
    LOGS+=("PASS:Teste5-Firebase")
else
    log -e "  ${RED}  [FAIL]${RESET} Firebase inacessível (agente-poivon)"
    ((FAIL++))
    LOGS+=("FAIL:Teste5-Firebase")
fi

# Teste 6: GitHub API
log -e "  ${CYAN}  Teste 6: GitHub API (repositório)...${RESET}"
GH_OK=false
for _try in 1 2 3; do
    if curl -s -o /dev/null -w "%{http_code}" --max-time 10 "https://api.github.com/repos/matheus23alv-bit/P-O-I-V-O-N-agent" 2>/dev/null | grep -q "200"; then
        GH_OK=true; break
    fi
    sleep 2
done
if [ "$GH_OK" = true ]; then
    log -e "  ${GREEN}  [PASS]${RESET} Repositório GitHub acessível"
    ((PASS++))
    LOGS+=("PASS:Teste6-GitHub")
else
    log -e "  ${RED}  [FAIL]${RESET} Repositório GitHub inacessível"
    ((FAIL++))
    LOGS+=("FAIL:Teste6-GitHub")
fi

echo ""

# ─────────────────────────────────────────────────────────────────────
# [6] TESTES DE TAREFA (Tarefa 2 de cada tipo)
# ─────────────────────────────────────────────────────────────────────

echo -e "${BOLD}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}${BLUE}  [6/6] TESTES DE TAREFA (Tarefa 2 de cada)${RESET}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

# Tarefa 2A: Criar arquivo com Python
log -e "  ${CYAN}  Tarefa 2A: Criar arquivo via Python...${RESET}"
TASK_FILE="/tmp/poivon_task_test.txt"
if python3 -c "
with open('$TASK_FILE', 'w') as f:
    f.write('POIVON TASK TEST OK\n')
    f.write('PVN S¥STEM - AGENTE - POIVON\n')
" 2>/dev/null && grep -q "POIVON" "$TASK_FILE" 2>/dev/null; then
    log -e "  ${GREEN}  [PASS]${RESET} Python criou e escreveu arquivo"
    ((PASS++))
    LOGS+=("PASS:Tarefa2A-PythonWrite")
else
    log -e "  ${RED}  [FAIL]${RESET} Python não conseguiu criar arquivo"
    ((FAIL++))
    LOGS+=("FAIL:Tarefa2A-PythonWrite")
fi
rm -f "$TASK_FILE"

# Tarefa 2B: Criar arquivo com Node.js
log -e "  ${CYAN}  Tarefa 2B: Criar arquivo via Node.js...${RESET}"
TASK_FILE2="/tmp/poivon_task_test.js"
if node -e "
const fs = require('fs');
fs.writeFileSync('/tmp/poivon_task_test_js.txt', 'POIVON NODE TASK OK\n');
" 2>/dev/null && grep -q "POIVON" "/tmp/poivon_task_test_js.txt" 2>/dev/null; then
    log -e "  ${GREEN}  [PASS]${RESET} Node.js criou e escreveu arquivo"
    ((PASS++))
    LOGS+=("PASS:Tarefa2B-NodeWrite")
else
    log -e "  ${RED}  [FAIL]${RESET} Node.js não conseguiu criar arquivo"
    ((FAIL++))
    LOGS+=("FAIL:Tarefa2B-NodeWrite")
fi
rm -f /tmp/poivon_task_test_js.txt

# Tarefa 2C: Testar BeautifulSoup
log -e "  ${CYAN}  Tarefa 2C: Parse HTML com BeautifulSoup...${RESET}"
if python3 -c "
from bs4 import BeautifulSoup
html = '<html><body><h1>POIVON</h1></body></html>'
soup = BeautifulSoup(html, 'html.parser')
assert soup.h1.text == 'POIVON'
print('OK')
" 2>/dev/null; then
    log -e "  ${GREEN}  [PASS]${RESET} BeautifulSoup parseou HTML corretamente"
    ((PASS++))
    LOGS+=("PASS:Tarefa2C-BS4")
else
    log -e "  ${RED}  [FAIL]${RESET} BeautifulSoup falhou"
    ((FAIL++))
    LOGS+=("FAIL:Tarefa2C-BS4")
fi

# Tarefa 2D: Testar Flask route
log -e "  ${CYAN}  Tarefa 2D: Flask route funcional...${RESET}"
if python3 -c "
from flask import Flask
app = Flask(__name__)

@app.route('/pvn')
def pvn():
    return 'PVN S¥STEM OK'

with app.test_client() as client:
    resp = client.get('/pvn')
    assert resp.status_code == 200
    assert 'PVN' in resp.data.decode()
    print('OK')
" 2>/dev/null; then
    log -e "  ${GREEN}  [PASS]${RESET} Flask route respondeu corretamente"
    ((PASS++))
    LOGS+=("PASS:Tarefa2D-FlaskRoute")
else
    log -e "  ${RED}  [FAIL]${RESET} Flask route não funcionou"
    ((FAIL++))
    LOGS+=("FAIL:Tarefa2D-FlaskRoute")
fi

# Tarefa 2E: Testar requests HTTP
log -e "  ${CYAN}  Tarefa 2E: Requisição HTTP com requests...${RESET}"
if python3 -c "
import requests
resp = requests.get('https://httpbin.org/get', timeout=10)
assert resp.status_code == 200
assert 'headers' in resp.json()
print('OK')
" 2>/dev/null; then
    log -e "  ${GREEN}  [PASS]${RESET} Requests fez HTTP GET com sucesso"
    ((PASS++))
    LOGS+=("PASS:Tarefa2E-Requests")
else
    log -e "  ${RED}  [FAIL]${RESET} Requests não conseguiu fazer HTTP"
    ((FAIL++))
    LOGS+=("FAIL:Tarefa2E-Requests")
fi

# Tarefa 2F: Git clone test
log -e "  ${CYAN}  Tarefa 2F: Git clone do repositório...${RESET}"
TASK_DIR="/tmp/poivon_git_test"
rm -rf "$TASK_DIR"
if git clone --depth 1 https://github.com/matheus23alv-bit/P-O-I-V-O-N-agent.git "$TASK_DIR" 2>/dev/null; then
    if [ -f "$TASK_DIR/setup.sh" ]; then
        log -e "  ${GREEN}  [PASS]${RESET} Git clone OK, setup.sh presente"
        ((PASS++))
        LOGS+=("PASS:Tarefa2F-GitClone")
    else
        log -e "  ${RED}  [FAIL]${RESET} Clone OK mas arquivos faltando"
        ((FAIL++))
        LOGS+=("FAIL:Tarefa2F-GitClone")
    fi
    rm -rf "$TASK_DIR"
else
    log -e "  ${RED}  [FAIL]${RESET} Git clone falhou"
    ((FAIL++))
    LOGS+=("FAIL:Tarefa2F-GitClone")
fi

echo ""

# ─────────────────────────────────────────────────────────────────────
# RESUMO FINAL
# ─────────────────────────────────────────────────────────────────────

echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "${BOLD}${WHITE}  ┌──────────────────────────────────────────┐${RESET}"
echo -e "${BOLD}${WHITE}  │  RESUMO DO TESTE                         │${RESET}"
echo -e "${BOLD}${WHITE}  └──────────────────────────────────────────┘${RESET}"
echo ""
echo -e "  ${GREEN}PASS: ${PASS}${RESET}  │  ${RED}FAIL: ${FAIL}${RESET}  │  ${YELLOW}WARN: ${WARN}${RESET}  │  ${CYAN}SKIP: ${SKIP}${RESET}"
echo ""

TOTAL=$((PASS + FAIL + WARN + SKIP))
if [ "$TOTAL" -gt 0 ]; then
    PCT=$((PASS * 100 / TOTAL))
    echo -e "  Taxa de sucesso: ${BOLD}${PCT}%${RESET} ($PASS/$TOTAL)"
fi
echo ""

# Classificação
if [ "$FAIL" -eq 0 ] && [ "$PCT" -ge 90 ]; then
    echo -e "  ${GREEN}╔══════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${GREEN}║  ✓✓✓  TODOS OS TESTES PASSARAM  ✓✓✓             ║${RESET}"
    echo -e "  ${GREEN}║  POIVON está pronto para operar!                 ║${RESET}"
    echo -e "  ${GREEN}╚══════════════════════════════════════════════════╝${RESET}"
elif [ "$FAIL" -gt 5 ]; then
    echo -e "  ${RED}╔══════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${RED}║  CRÍTICO: Muitas falhas! Execute:                ║${RESET}"
    echo -e "  ${RED}║    bash test_all.sh --install                     ║${RESET}"
    echo -e "  ${RED}║  Ou instale manualmente as dependências          ║${RESET}"
    echo -e "  ${RED}╚══════════════════════════════════════════════════╝${RESET}"
else
    echo -e "  ${YELLOW}╔══════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${YELLOW}║  PARCIAL: Alguns testes falharam                 ║${RESET}"
    echo -e "  ${YELLOW}║  Execute: bash test_all.sh --install             ║${RESET}"
    echo -e "  ${YELLOW}╚══════════════════════════════════════════════════╝${RESET}"
fi

echo ""

# Salvar log
if [ "$LOG_ENABLED" = true ] && [ -n "$LOG_FILE" ]; then
    echo "" >> "$LOG_FILE"
    echo "═══════════════════════════════════════════" >> "$LOG_FILE"
    echo "RESUMO: PASS=$PASS FAIL=$FAIL WARN=$WARN SKIP=$SKIP" >> "$LOG_FILE"
    echo "TAXA DE SUCESSO: $PCT%" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
    echo "LOG DETALHADO:" >> "$LOG_FILE"
    for entry in "${LOGS[@]}"; do
        echo "  $entry" >> "$LOG_FILE"
    done
    log -e "  ${CYAN}  Log salvo em: ${WHITE}$LOG_FILE${RESET}"
fi

echo -e "${CYAN}──────────────────────────────────────────────────────────${RESET}"
echo -e "${CYAN}  PVN S¥STEM | AGENTE POIVON | skill yb | TESTES${RESET}"
echo -e "${CYAN}  [BETA] branch1 | v${AGENT_VERSION:-1.3.1-beta}${RESET}"
echo -e "${CYAN}──────────────────────────────────────────────────────────${RESET}"
echo ""

exit $FAIL
