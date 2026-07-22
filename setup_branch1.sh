#!/data/data/com.termux/files/usr/bin/bash
# Version: v2.0.0
# ─────────────────────────────────────────────────────
# POIVON — SETUP CANAL DESENVOLVIMENTO (branch1)
# PVN S¥STEM | AGENTE POIVON | skill yb POIVON
# Uso: bash setup_branch1.sh
# ATENÇÃO: canal de trabalho; pode conter mudanças não promovidas.
# ─────────────────────────────────────────────────────
set -e
REPO="https://github.com/matheus23alv-bit/P-O-I-V-O-N-agent.git"
DIR="$HOME/poivon-dev"

command -v git >/dev/null || pkg install -y git
echo "[SETUP:branch1] Canal DEV — clonando branch1 em $DIR"
if [ -d "$DIR/.git" ]; then
    cd "$DIR" && git fetch origin && git checkout branch1 && git pull origin branch1
else
    git clone --branch branch1 "$REPO" "$DIR" && cd "$DIR"
fi
[ "$(git branch --show-current)" = "branch1" ] || { echo "[ERRO] branch ativa não é branch1"; exit 1; }
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

echo "[SETUP:branch1] Concluído. Canal: dev/branch1 — NUNCA aponte comandos para main daqui."
