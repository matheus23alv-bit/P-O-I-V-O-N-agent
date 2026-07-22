# POIVON — Proteção de Branches

## PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Beta Edition

---

## Estrutura de Branches

| Branch | Canal | Descrição | Push Direto |
|--------|-------|-----------|-------------|
| `main` | Stable | Versão estável, produção | **BLOQUEADO** (só via PR aprovado) |
| `branch1` | **Beta** | Canal ativo de desenvolvimento | Permitido |
| `dev` | Dev | Experimentos e features em teste | Permitido |

---

## Regras da `main`

1. **Nenhum push direto** — A branch `main` aceita apenas merges via Pull Request.
2. **Aprovação obrigatória** — O maintainer (owner do repositório) deve aprovar antes do merge.
3. **CI obrigatório** — O workflow de validação deve passar antes do merge.
4. **Tags de release** — Apenas na `main`, após merge aprovado.

## Regras da `branch1` (Beta)

1. **Canal ativo** — Todo desenvolvimento acontece aqui.
2. **Versionamento `-beta`** — Toda versão deve ter sufixo `-beta` no DEBIAN/control.
3. **CI automático** — Validação de integridade rodando em cada push.
4. **Promoção para `main`** — Via PR quando estiver estável.

---

## Como Fazer Mudanças na `main`

```bash
# 1. Trabalhe sempre na branch1
git checkout branch1

# 2. Faça suas mudanças e commit
git add -A
git commit -m "feat: adicionar nova funcionalidade"

# 3. Push para branch1
git push origin branch1

# 4. Abra um Pull Request no GitHub
#    https://github.com/matheus23alv-bit/P-O-I-V-O-N-agent/compare/main...branch1

# 5. Aguarde aprovação do owner
# 6. Mergue via PR
```

---

## Proteção Adicional (GitHub Settings)

Para proteção máxima, configure em:
**GitHub → Settings → Branches → Add rule → `main`**

- [x] Require pull request reviews before merging
- [x] Require status checks to pass before merging
- [x] Include administrators
- [x] Require signed commits (opcional)
- [x] Restrict who can push to matching branches

---

## Versionamento

O script `version.sh` gerencia automaticamente:
- `DEBIAN/control` — Versão do pacote
- `pvn.conf` — Versão de runtime
- `CHANGELOG.md` — Histórico de mudanças

```bash
bash version.sh patch "corrigir bug"
bash version.sh minor "nova feature"
bash version.sh major "breaking change"
```

---

*PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Beta | branch1*
