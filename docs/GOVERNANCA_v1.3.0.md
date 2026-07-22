<!-- Version: v1.3.0 -->
# GOVERNANÇA OFICIAL — POIVON v1.3.0
## PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Beta Edition

**Autoridade final:** usuário-chefe (owner @matheus23alv-bit)
**Vigência:** até substituição por revisão versionada posterior

---

## 1. Modelo de autoridade

| Camada | Função | Autoridade |
|--------|--------|-----------|
| Usuário-chefe | Aprovar, rejeitar, versionar, publicar | **FINAL** |
| GitHub / main | Fonte estável, releases, distribuição | Oficial protegida |
| GitHub / branch1 | Canal Beta — trabalho e sincronização | Operacional |
| GitHub / branch2 | Canal Next — linha v2.x (LLM + Firebase) | Operacional |
| GitHub / dev | Experimentos | Livre |
| Workspaces de IA | Engenharia, testes, documentação | Pré-oficial |

**Regra absoluta:** nenhuma IA, modelo, ferramenta ou colaborador altera a `main` diretamente. Toda entrada na `main` passa por Pull Request revisado e aprovado explicitamente pelo usuário-chefe, passo a passo. Enforcement técnico: CODEOWNERS + Ruleset do GitHub + CI.

---

## 2. Estratégia de branches

```
main    ── Stable ── só recebe PR aprovado; tags de release
branch1 ── Beta ──── estabilização da linha 1.x (governança, qualidade)
branch2 ── Next ──── desenvolvimento da linha 2.x (LLM real, Firebase real)
dev     ── Dev ───── rascunhos e experimentos descartáveis
```

→ branch2 nasce de branch1 e recebe os itens do milestone v2.0.0-beta.
→ Correções feitas na branch1 devem ser mergeadas na branch2 periodicamente (`git merge branch1` estando na branch2) para evitar divergência.
→ Quando a linha 2.x estabilizar: PR branch2 → branch1 (consolidação) e depois branch1 → main.

---

## 3. GATE DE PROMOÇÃO branch1 → main

A promoção **nunca é automática**. O fluxo é: critérios fecham → sinalização "PRONTO PARA MAIN" → usuário-chefe abre/aprova o PR.

Critérios (todos obrigatórios):

- [ ] `test_all.sh` ≥ 95% de aprovação em sandbox
- [ ] `test_all.sh` executado em **Termux real** com relatório commitado (RELATORIO_TESTES_v2)
- [ ] CI verde no último commit da branch1
- [ ] CHANGELOG completo da versão candidata
- [ ] Nenhum FAIL aberto no backlog do milestone corrente
- [ ] Marcadores de versão presentes em todos os arquivos tocados
- [ ] Sem segredos/chaves no repositório (`git grep -iE "api_key|token|secret"` limpo)
- [ ] Aprovação explícita do usuário-chefe no PR

Qualquer sessão de trabalho pode avaliar este gate sob demanda ("avaliar gate main") e responder: **PRONTO** ou **PENDENTE (itens X, Y)**.

---

## 4. Checklist de sincronização workspace → branch

- [ ] `git branch --show-current` = branch alvo (branch1 ou branch2)
- [ ] Escopo mínimo mantido (Regra 10)
- [ ] Marcador de versão em cada arquivo tocado
- [ ] Teste relevante executado e evidência guardada
- [ ] Diff apresentado e aprovado pelo usuário-chefe
- [ ] Commit com prefixo `feat:` `fix:` `docs:` `chore:`
- [ ] Push somente para a branch de trabalho

Sem evidência → **NÃO VERIFICADO** (nunca "aprovado").

---

## 5. Marcadores de versão

```
md/html ......... <!-- Version: vX.Y.Z -->
sh/py/yaml ...... # Version: vX.Y.Z
js/ts/c/java .... // Version: vX.Y.Z
```

Release automatizada: `bash version.sh <patch|minor|major> "mensagem"` (atualiza DEBIAN/control, pvn.conf e CHANGELOG; sufixo `-beta` mantido fora da main).

---

PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Beta | branch1
