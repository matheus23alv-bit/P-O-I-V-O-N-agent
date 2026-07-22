#!/data/data/com.termux/files/usr/bin/bash
# Version: v2.0.0
# ─────────────────────────────────────────────────────
# POIVON - Agente Firebase v2 (REAL: Identity Toolkit + Firestore REST)
# PVN S¥STEM | AGENTE POIVON | skill yb POIVON
# [BETA] branch2 | linha v2.x
#
# Regra 12: INATIVO por padrão. Só age quando chamado explicitamente.
#   - Escrita SEMPRE com semântica merge (updateMask) — nunca sobrescreve o doc
#   - Estrutura fixa: admin/config (doc) | campo-mapa "gnu" (dados)
#   - PROIBIDO escrever fora de gnu.* (hardcoded neste script)
#   - Funções web protegidas gravame()/carta(): este agente NÃO toca código,
#     apenas dados sob gnu.* — proteção garantida por construção.
#
# Credenciais (pvn.conf — NUNCA commitadas):
#   FIREBASE_WEB_API_KEY, FIREBASE_EMAIL, FIREBASE_SENHA
# ─────────────────────────────────────────────────────

set -u
PVN_CONFIG="${PVN_CONFIG:-$PREFIX/etc/p-o-i-v-o-n/pvn.conf}"
[ -f "$PVN_CONFIG" ] && source "$PVN_CONFIG" 2>/dev/null

PROJ="${FIREBASE_PROJECT:-agente-poivon}"
KEY="${FIREBASE_WEB_API_KEY:-}"
FB_EMAIL="${FIREBASE_EMAIL:-}"
FB_SENHA="${FIREBASE_SENHA:-}"
DOC_URL="https://firestore.googleapis.com/v1/projects/${PROJ}/databases/(default)/documents/admin/config"
AUTH_URL="https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword"
TOKEN_CACHE="${TMPDIR:-/tmp}/.pvn_fb_token"

erro(){ echo "[FIREBASE][ERRO] $*" >&2; }
info(){ echo "[FIREBASE] $*"; }

exigir_deps(){
    command -v curl >/dev/null || { erro "curl ausente (pkg install curl)"; exit 3; }
    command -v jq   >/dev/null || { erro "jq ausente (pkg install jq)"; exit 3; }
}

configurado(){ [ -n "$KEY" ] && [ -n "$FB_EMAIL" ] && [ -n "$FB_SENHA" ]; }

guia_config(){
    info "Credenciais ausentes — modo guia (Regra 12: opcional)."
    echo ""
    echo "  Para ativar operações reais, edite \$PREFIX/etc/p-o-i-v-o-n/pvn.conf:"
    echo "    FIREBASE_WEB_API_KEY=\"...\"   (Console → Config do app web)"
    echo "    FIREBASE_EMAIL=\"...\"          (usuário do Authentication)"
    echo "    FIREBASE_SENHA=\"...\""
    echo ""
    echo "  Estrutura: admin/config (doc) | gnu (mapa de dados)"
    echo "  Escrita: sempre merge (updateMask) — este agente nunca sobrescreve o doc"
    echo "  Protegidos: gravame(), carta() — fora do alcance (agente só toca gnu.*)"
}

signin(){
    if [ -f "$TOKEN_CACHE" ]; then
        local age=$(( $(date +%s) - $(stat -c %Y "$TOKEN_CACHE" 2>/dev/null || echo 0) ))
        [ "$age" -lt 2700 ] && { cat "$TOKEN_CACHE"; return 0; }
    fi
    local resp; resp=$(curl -sS --max-time 20 "${AUTH_URL}?key=${KEY}" \
        -H 'Content-Type: application/json' \
        -d "$(jq -n --arg e "$FB_EMAIL" --arg p "$FB_SENHA" '{email:$e,password:$p,returnSecureToken:true}')") || { erro "rede (auth)"; return 4; }
    local tok; tok=$(echo "$resp" | jq -r '.idToken // empty')
    if [ -z "$tok" ]; then
        erro "auth falhou: $(echo "$resp" | jq -r '.error.message // "desconhecido"')"
        return 5
    fi
    umask 077; printf '%s' "$tok" > "$TOKEN_CACHE"
    printf '%s' "$tok"
}

fb_status(){
    exigir_deps
    info "Projeto: $PROJ"
    local code; code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$DOC_URL")
    info "Firestore alcançável: HTTP $code"
    if configurado; then
        local tok; tok=$(signin) || { info "Autenticação: FALHOU"; return 1; }
        info "Autenticação: OK (idToken obtido, cache 45min)"
    else
        info "Credenciais: NÃO CONFIGURADAS (modo guia)"
    fi
}

fb_get(){
    exigir_deps
    configurado || { guia_config; return 0; }
    local campo="${1:-}"
    local tok; tok=$(signin) || return $?
    local resp; resp=$(curl -sS --max-time 20 -H "Authorization: Bearer $tok" "$DOC_URL") || { erro "rede (get)"; return 4; }
    if echo "$resp" | jq -e '.error' >/dev/null 2>&1; then
        erro "get: $(echo "$resp" | jq -r '.error.message')"; return 5
    fi
    if [ -n "$campo" ]; then
        echo "$resp" | jq -r --arg c "$campo" '.fields.gnu.mapValue.fields[$c] // "(campo ausente em gnu)"'
    else
        echo "$resp" | jq '.fields.gnu.mapValue.fields // {}'
    fi
}

fb_set(){
    exigir_deps
    configurado || { guia_config; return 0; }
    local chave="${1:?uso: firebase set <chave> <valor>}"
    local valor="${2:?uso: firebase set <chave> <valor>}"
    case "$chave" in
        *[!A-Za-z0-9_]*) erro "chave inválida (use A-Za-z0-9_): $chave"; return 2;;
    esac
    local tok; tok=$(signin) || return $?
    # merge REAL: updateMask restringe a escrita a gnu.<chave> — nada mais é tocado
    local body; body=$(jq -n --arg k "$chave" --arg v "$valor" \
        '{fields:{gnu:{mapValue:{fields:{($k):{stringValue:$v}}}}}}')
    local resp; resp=$(curl -sS --max-time 20 -X PATCH \
        -H "Authorization: Bearer $tok" -H 'Content-Type: application/json' \
        "${DOC_URL}?updateMask.fieldPaths=gnu.${chave}" -d "$body") || { erro "rede (set)"; return 4; }
    if echo "$resp" | jq -e '.error' >/dev/null 2>&1; then
        erro "set: $(echo "$resp" | jq -r '.error.message')"; return 5
    fi
    info "gravado (merge): gnu.${chave} = ${valor}"
}

firebase_agent(){
    local action="${1:-help}"; shift 2>/dev/null || true
    case "$action" in
        status)             fb_status;;
        get|ler|read)       fb_get "${1:-}";;
        set|escrever|write) fb_set "${1:-}" "${2:-}";;
        setup|init|guia)    guia_config;;
        logout)             rm -f "$TOKEN_CACHE"; info "cache de token limpo";;
        help|*)
            echo "Uso: pvn firebase {status | get [campo] | set <chave> <valor> | logout | guia}"
            ;;
    esac
}

if [ "${BASH_SOURCE[0]:-$0}" = "$0" ]; then
    firebase_agent "$@"
fi
