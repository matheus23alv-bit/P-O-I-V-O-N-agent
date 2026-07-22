#!/data/data/com.termux/files/usr/bin/bash
# Version: v2.0.0
# ─────────────────────────────────────────────────────
# POIVON - Cliente LLM (Anthropic Messages API)
# PVN S¥STEM | AGENTE POIVON | skill yb POIVON
# [BETA] branch2 | linha v2.x
#
# Uso:
#   llm_client.sh ask "<pergunta>"          → resposta em texto
#   llm_client.sh criar "<ideia>" [destino] → gera projeto (manifesto de arquivos)
#   llm_client.sh --selftest                → testa o parser de manifesto offline
#
# Chave: LLM_API_KEY em $PREFIX/etc/p-o-i-v-o-n/pvn.conf
#        ou variável de ambiente ANTHROPIC_API_KEY / LLM_API_KEY
#        NUNCA hardcoded. NUNCA commitada.
# ─────────────────────────────────────────────────────

set -u
PVN_CONFIG="${PVN_CONFIG:-$PREFIX/etc/p-o-i-v-o-n/pvn.conf}"
[ -f "$PVN_CONFIG" ] && source "$PVN_CONFIG" 2>/dev/null

LLM_API_KEY="${ANTHROPIC_API_KEY:-${LLM_API_KEY:-}}"
LLM_MODEL="${LLM_MODEL:-claude-sonnet-4-6}"
LLM_MAX_TOKENS="${LLM_MAX_TOKENS:-4096}"
LLM_TIMEOUT="${LLM_TIMEOUT:-90}"
SYSTEM_PROMPT_FILE="${SYSTEM_PROMPT_FILE:-$PREFIX/lib/p-o-i-v-o-n/data/system_prompt.md}"
WORK_DIR="${WORK_DIR:-$HOME/storage/shared/POIVON}"
API_URL="https://api.anthropic.com/v1/messages"

erro() { echo "[LLM][ERRO] $*" >&2; }

exigir_deps() {
    command -v curl >/dev/null || { erro "curl ausente. Rode: pkg install curl"; exit 3; }
    command -v jq   >/dev/null || { erro "jq ausente. Rode: pkg install jq"; exit 3; }
}

exigir_chave() {
    if [ -z "$LLM_API_KEY" ]; then
        erro "Nenhuma chave de API configurada."
        echo "" >&2
        echo "  Configure UMA das opções:" >&2
        echo "    1) nano \$PREFIX/etc/p-o-i-v-o-n/pvn.conf  → LLM_API_KEY=\"sua-chave\"" >&2
        echo "    2) export ANTHROPIC_API_KEY=\"sua-chave\"" >&2
        echo "" >&2
        echo "  A chave NUNCA deve ser commitada no repositório." >&2
        exit 2
    fi
}

# ── chamada bruta: recebe prompt no stdin, devolve texto no stdout ──
chamar_llm() {
    local sys=""
    [ -f "$SYSTEM_PROMPT_FILE" ] && sys=$(cat "$SYSTEM_PROMPT_FILE")
    local extra_sys="${1:-}"
    local prompt; prompt=$(cat)

    local payload; payload=$(jq -n \
        --arg model "$LLM_MODEL" \
        --argjson max "$LLM_MAX_TOKENS" \
        --arg sys "${sys}

${extra_sys}" \
        --arg p "$prompt" \
        '{model:$model, max_tokens:$max, system:$sys, messages:[{role:"user",content:$p}]}')

    local resp; resp=$(curl -sS --max-time "$LLM_TIMEOUT" "$API_URL" \
        -H "x-api-key: $LLM_API_KEY" \
        -H "anthropic-version: 2023-06-01" \
        -H "content-type: application/json" \
        -d "$payload") || { erro "Falha de rede na chamada da API."; exit 4; }

    local err_type; err_type=$(echo "$resp" | jq -r '.error.type // empty')
    if [ -n "$err_type" ]; then
        erro "API: $err_type — $(echo "$resp" | jq -r '.error.message')"
        exit 5
    fi
    echo "$resp" | jq -r '[.content[]? | select(.type=="text") | .text] | join("\n")'
}

# ── parser do manifesto de arquivos ─────────────────────────────────
# Formato exigido do LLM:
#   ### FILE: caminho/relativo.ext
#   <conteúdo integral>
#   ### END
# Grava cada arquivo sob $2 (diretório destino). Ignora caminhos com
# ".." ou absolutos (segurança). Retorna lista dos arquivos criados.
parse_manifesto() {
    local destino="$1"
    awk -v dest="$destino" '
        /^### FILE: /{
            if (f != "") close(dest "/" f)
            f=$0; sub(/^### FILE: */,"",f); gsub(/\r/,"",f)
            if (f ~ /\.\./ || f ~ /^\//) { print "[SKIP-inseguro] " f > "/dev/stderr"; f=""; next }
            cmd="mkdir -p \"" dest "/$(dirname \"" f "\")\""
            system("mkdir -p \"" dest "\"/\"$(dirname \"" f "\")\" 2>/dev/null")
            print "" > (dest "/" f)   # trunca
            criados = criados f "\n"
            primeiro=1; next
        }
        /^### END/{ if (f!="") close(dest "/" f); f=""; next }
        {
            if (f != "") {
                if (primeiro) { printf "%s", $0 >> (dest "/" f); primeiro=0 }
                else          { printf "\n%s", $0 >> (dest "/" f) }
            }
        }
        END { printf "%s", criados }
    '
}

# ── ações ───────────────────────────────────────────────────────────
acao_ask() {
    exigir_deps; exigir_chave
    printf '%s' "$1" | chamar_llm ""
}

acao_criar() {
    exigir_deps; exigir_chave
    local ideia="$1"
    local slug; slug=$(echo "$ideia" | tr 'A-Z' 'a-z' | tr -cs 'a-z0-9' '-' | sed 's/^-//;s/-$//' | cut -c1-40)
    [ -z "$slug" ] && slug="projeto-$(date +%s)"
    local destino="${2:-$WORK_DIR/projects/$slug}"
    mkdir -p "$destino"

    local instr='FORMATO OBRIGATÓRIO DA RESPOSTA — MANIFESTO DE ARQUIVOS:
Para CADA arquivo do projeto, emita exatamente:
### FILE: caminho/relativo.ext
<conteúdo integral do arquivo>
### END
Nada fora desses blocos (sem explicações, sem markdown de código).
Caminhos sempre relativos; projeto autocontido, funcional no Termux
(porta > 1024, sem sudo/systemd). Comece pelo arquivo principal.'

    echo "[POIVON] Consultando LLM ($LLM_MODEL)..." >&2
    local saida; saida=$(printf 'Crie um projeto para: %s' "$ideia" | chamar_llm "$instr") || exit $?

    local criados; criados=$(printf '%s\n' "$saida" | parse_manifesto "$destino")
    if [ -z "$criados" ]; then
        erro "O LLM não devolveu manifesto válido. Resposta bruta salva em $destino/_resposta_llm.txt"
        printf '%s\n' "$saida" > "$destino/_resposta_llm.txt"
        exit 6
    fi
    echo "$destino"
    printf '%s' "$criados" | sed 's/^/  + /'
}

selftest() {
    local tmp="${TMPDIR:-/tmp}/pvn_llm_selftest_$$"
    rm -rf "$tmp"
    local amostra='### FILE: index.html
<!doctype html>
<title>PVN OK</title>
### END
### FILE: css/app.css
body{margin:0}
### END
### FILE: ../fora.txt
hack
### END'
    local criados; criados=$(printf '%s\n' "$amostra" | parse_manifesto "$tmp")
    local n; n=$(printf '%s' "$criados" | grep -c .)
    if [ "$n" = "2" ] && grep -q "PVN OK" "$tmp/index.html" && grep -q "margin:0" "$tmp/css/app.css" && [ ! -e "$tmp/../fora.txt.pvn_selftest" ]; then
        echo "[SELFTEST][PASS] parser: 2 arquivos válidos gravados, caminho inseguro bloqueado"
        rm -rf "$tmp"; exit 0
    else
        echo "[SELFTEST][FAIL] esperado 2 arquivos; obtido: $n"; ls -R "$tmp" 2>/dev/null
        rm -rf "$tmp"; exit 1
    fi
}

case "${1:-}" in
    ask)        shift; acao_ask "${1:?uso: llm_client.sh ask \"pergunta\"}";;
    criar)      shift; acao_criar "${1:?uso: llm_client.sh criar \"ideia\" [destino]}" "${2:-}";;
    --selftest) selftest;;
    *) echo "Uso: llm_client.sh {ask \"pergunta\" | criar \"ideia\" [destino] | --selftest}"; exit 1;;
esac
