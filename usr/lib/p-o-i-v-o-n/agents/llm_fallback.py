# Version: v2.0.0
# ─────────────────────────────────────────────────────
# POIVON — Fallback LLM (API Anthropic) — biblioteca PYTHON
# O CLI (pvn) usa scripts/llm_client.sh; este módulo serve
# server.py e futuros agentes Python.
# PVN S¥STEM | AGENTE POIVON | skill yb POIVON
#
# Placeholder de integração. NENHUMA chave real neste
# arquivo. A credencial vem SOMENTE de variável de
# ambiente (ex.: ~/.config/poivon/.env, chmod 600):
#
#   source ~/.config/poivon/.env
#   export ANTHROPIC_API_KEY
# ─────────────────────────────────────────────────────

import os

API_URL = "https://api.anthropic.com/v1/messages"
MODEL = "claude-sonnet-4-6"
ANTHROPIC_VERSION = "2023-06-01"
MAX_TOKENS = 1024
TIMEOUT = 30


def call_claude(prompt: str) -> str:
    """Chama a API Anthropic como fallback. Retorna texto ou erro claro (sem crash)."""
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        return "ERRO: ANTHROPIC_API_KEY não definida no ambiente."

    # Import tardio: o módulo deve importar mesmo sem 'requests'
    # instalado (Termux mínimo). Sem a dependência, erro claro.
    try:
        import requests
    except ImportError:
        return "ERRO: pacote 'requests' ausente. Instale com: pip install requests"

    try:
        resp = requests.post(
            API_URL,
            headers={
                "x-api-key": api_key,
                "anthropic-version": ANTHROPIC_VERSION,
                "content-type": "application/json",
            },
            json={
                "model": MODEL,
                "max_tokens": MAX_TOKENS,
                "messages": [{"role": "user", "content": prompt}],
            },
            timeout=TIMEOUT,
        )
    except requests.exceptions.RequestException as exc:
        return f"ERRO: falha de rede/timeout ao chamar a API ({exc.__class__.__name__})."

    if resp.status_code == 429:
        return "ERRO: limite de taxa atingido, tente novamente."

    try:
        resp.raise_for_status()
        return resp.json()["content"][0]["text"]
    except Exception as exc:
        return f"ERRO: resposta inesperada da API ({exc.__class__.__name__}: {exc})."
