#!/data/data/com.termux/files/usr/bin/bash
# Version: v2.0.0
# ─────────────────────────────────────────────────────
# POIVON — SETUP CANAL ESTÁVEL (main)
# PVN S¥STEM | AGENTE POIVON | skill yb POIVON
# Uso: bash setup_main.sh
# ─────────────────────────────────────────────────────
set -e
REPO="https://github.com/matheus23alv-bit/P-O-I-V-O-N-agent.git"
DIR="$HOME/poivon-stable"

command -v git >/dev/null || pkg install -y git
echo "[SETUP:main] Canal ESTÁVEL — clonando main em $DIR"
if [ -d "$DIR/.git" ]; then
    cd "$DIR" && git fetch origin && git checkout main && git pull origin main
else
    git clone --branch main "$REPO" "$DIR" && cd "$DIR"
fi
[ "$(git branch --show-current)" = "main" ] || { echo "[ERRO] branch ativa não é main"; exit 1; }
bash install_termux.sh

# ── Chave de API (OPCIONAL) ─────────────────────────
# O POIVON é autossuficiente e roda sem chave. A chave
# só amplia os comandos que consultam o LLM. Opt-in.
echo ""
echo "[SETUP] O POIVON funciona SEM chave de API."
echo "[SETUP] Uma chave própria (opcional) ativa: pvn ai, criar, corrigir, etc."
printf "[SETUP] Deseja adicionar uma chave agora? [s/N] "
read -r RESP
case "$RESP" in
    [sS]|[sS][iI][mM])
        pvn chave || echo "[SETUP] Chave não configurada — você pode rodar 'pvn chave' depois."
        ;;
    *)
        echo "[SETUP] Seguindo sem chave. Configure quando quiser com: pvn chave"
        ;;
esac

echo "[SETUP:main] Concluído. Canal: stable | $(grep AGENT_VERSION usr/etc/p-o-i-v-o-n/pvn.conf | head -1)"
