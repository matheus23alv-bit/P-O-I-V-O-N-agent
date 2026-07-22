<!-- Version: v1.3.0 -->
# BACKLOG OFICIAL — POIVON AGENT
## PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Beta Edition

**Base:** branch1 — release 1.3.0-beta (22/07/2026)
**Prioridade:** P0 crítico · P1 alto · P2 médio · P3 desejável
**Status:** TODO · DOING · REVIEW · DONE

━━━━━━━━━━━━━━━━━━

## MILESTONE v1.3.0-beta — Governança e Housekeeping

| ID | P | Item | Status |
|----|---|------|--------|
| BL-001 | P0 | Adicionar seção de governança (fonte GitHub / branch1 / marcadores) ao README.md + marcador v1.3.0 | DONE |
| BL-002 | P0 | Reformular Regra 11 do system_prompt.md: auditoria permitida quando solicitada explicitamente | DONE |
| BL-003 | P0 | Adicionar regras rígidas de Git (main protegida, branch1 exclusiva) ao system_prompt.md | DONE |
| BL-004 | P0 | Criar entrada 1.3.0 no CHANGELOG.md e rodar `version.sh minor` | DONE |
| BL-005 | P1 | Adicionar marcadores de versão a todos os arquivos tocados na fase | DONE |
| BL-006 | P1 | Commitar docs de governança (registro oficial, padrão visual, checklist de promoção) em `docs/` na branch1 | DONE |
| BL-007 | P1 | Adicionar pacotes Python faltantes (beautifulsoup4, pillow, requests, flask) ao setup.sh/install_termux.sh | DONE (já resolvido em 22f483a) |
| BL-008 | P1 | Adicionar npm globais (nodemon, typescript) ao setup | DONE (já resolvido em 22f483a) |
| BL-009 | P2 | Criar checklist de promoção workspace → branch1 como arquivo versionado | DONE (docs/GOVERNANCA_v1.3.0.md §4) |

## MILESTONE v1.4.0-beta — Qualidade e Confiabilidade

| ID | P | Item | Status |
|----|---|------|--------|
| BL-010 | P1 | Executar test_all.sh em Termux REAL (Android) e gerar RELATORIO_TESTES_v2.md | PARCIAL — sandbox 100%; Termux real pendente (Issue #4) |
| BL-011 | P1 | CI: rodar test_all.sh (modo sandbox) no workflow em cada push na branch1 | DONE (job test-suite no CI) |
| BL-012 | P2 | Teste automatizado que valida branch ativa + marcador de versão antes de release | TODO |
| BL-013 | P2 | Tratar WARN de clang: documentar como opcional ou incluir no setup | DONE (clang no CI e ambiente) |
| BL-014 | P3 | Badge de versão/CI no README | TODO |

## MILESTONE v2.0.0-beta — Inteligência Real

| ID | P | Item | Status |
|----|---|------|--------|
| BL-015 | P0 | Arquitetura da integração LLM: definir provedor/API, armazenamento seguro de chave, camada `llm_client` | TODO |
| BL-016 | P0 | Implementar `pvn criar <ideia>` com LLM real (primeiro comando de referência) | TODO |
| BL-017 | P1 | Implementar `pvn editar / corrigir / revisar / refatorar` reutilizando llm_client | TODO |
| BL-018 | P1 | Implementar `pvn guias` / `pvn guia <nome>` com base em system_prompt + dicionario_termux | TODO |
| BL-019 | P1 | Firebase real: SDK, autenticação, `setDoc(..., {merge:true})`, estrutura admin/config.gnu, proteção gravame()/carta() | TODO |
| BL-020 | P2 | Testes de segurança do Firebase (regras de acesso) | TODO |
| BL-021 | P2 | Testes de performance do servidor local | TODO |
| BL-022 | P3 | PR branch1 → main + tag de release Stable | TODO |

━━━━━━━━━━━━━━━━━━

## REGRA DE USO DO BACKLOG

→ Todo novo pedido em qualquer chat de IA deve ser mapeado a um BL-ID existente ou gerar um novo (BL-023+).
→ Ao concluir: marcar DONE aqui + entrada no CHANGELOG + issue fechada.
→ Este arquivo deve viver na branch1 (`docs/BACKLOG.md`) após aprovação — item BL-006.

━━━━━━━━━━━━━━━━━━

PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Beta | branch1
