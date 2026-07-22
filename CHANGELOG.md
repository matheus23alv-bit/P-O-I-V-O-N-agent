# Changelog — POIVON

**Projeto:** Agente POIVON — Executor Determinístico de Engenharia para Termux  
**Manutenção:** MATHEUS <mentalista-framework@pvn.system>  
**Formato:** PVN S¥STEM - AGENTE - POIVON  
**Plataforma:** Termux (Android)  
**Convenção:** [Semantic Versioning](https://semver.org) + [Keep a Changelog](https://keepachangelog.com)

---

## [2.0.0-beta] - 2026-07-22 — branch2 (linha Next)

### Added
- **`llm_client.sh`** — cliente da Anthropic Messages API: `ask` (pergunta direta) e `criar` (gera projeto via manifesto de arquivos `### FILE:`/`### END`); usa `system_prompt.md` como contexto; chave via pvn.conf/env, nunca hardcoded; `--selftest` offline do parser (Issue #15)
- **`pvn criar <ideia>`** — REAL: consulta o LLM e materializa o projeto em `~/storage/shared/POIVON/projects/<slug>/`
- **`pvn ai <pergunta>`** — passagem direta ao LLM operador
- **`pvn firebase {status|get|set|logout|guia}`** — agente v2 REAL: sign-in Identity Toolkit → Firestore REST; escrita restrita a `gnu.*` com merge via `updateMask` (Regra 12 por construção); cache de idToken 45min com umask 077 (Issue #16)
- Chaves de configuração em `pvn.conf`: `LLM_API_KEY`, `LLM_MODEL`, `FIREBASE_WEB_API_KEY`, `FIREBASE_EMAIL`, `FIREBASE_SENHA` (placeholders vazios — proibido commitar preenchidas)

### Security
- Parser de manifesto bloqueia caminhos absolutos e `..` (validado no selftest)
- Escrita Firestore impossibilitada fora de `admin/config → gnu.*` (caminho hardcoded)

### Changed
- Dispatcher do `pvn`: `criar`/`firebase` saem do stub; `editar/corrigir/revisar/refatorar/guias` permanecem na fila v2.x com aviso

---


## [1.3.1-beta] - 2026-07-22

### Added
- **Job `test-suite` no CI** — executa `test_all.sh` completo em cada push na branch1/branch2; CI falha se houver FAIL (Issue #5)
- **Retry 3x** no Teste 6 (GitHub API) — robustez contra rate-limit transitório
- **`RELATORIO_TESTES_v2_SANDBOX.md`** — evidência da suíte 100% (Issue #3)

### Fixed
- **`test_all.sh` — `log()`** engolia a mensagem quando chamada como `log -e "..."`; resultados individuais saíam em branco
- **`test_all.sh` — imports Python** — testava `import beautifulsoup4`/`import pillow`; corrigido para os módulos reais `bs4`/`PIL`
- **`test_all.sh` — Teste 5 Firebase** — apontava para Realtime DB inexistente (`firebaseio.com`); corrigido para o endpoint Firestore do projeto (auth real: escopo v2.0, Issue #7)
- **`test_all.sh` — rodapé** com versão hardcoded → dinâmica via `$AGENT_VERSION`

### Quality
- **Suíte em sandbox Ubuntu 24.04: 52/52 PASS (100%)** — Issues #3 e #5 fechadas

---


## [1.3.0-beta] - 2026-07-22

### Added
- **Regra 22 (Governança Git)** no `system_prompt.md` — main protegida, branch1 exclusiva, confirmação de branch ativa e marcador de versão obrigatório
- **`.github/CODEOWNERS`** — toda alteração via PR para `main` exige revisão do owner
- **`docs/GOVERNANCA_v1.3.0.md`** — modelo GitHub-fonte / workspaces-IA-isolados, estratégia de branches (main/branch1/branch2/dev), gate de promoção para main e checklist de sincronização
- **`docs/BACKLOG.md`** — backlog oficial versionado com milestones v1.3.0 / v1.4.0 / v2.0.0
- **Seção "Governança e Branches"** no README.md
- Marcadores `<!-- Version: v1.3.0 -->` nos arquivos alterados

### Changed
- **Regra 11** reformulada — auditoria/revisão/refatoração proibidas apenas quando implícitas; permitidas mediante solicitação explícita do usuário-chefe
- Versão global: `1.2.0-beta` → `1.3.0-beta` (control, pvn.conf, postinst)

---


## [1.2.0] - 2026-07-21

### Added
- **`build_cv.sh`** — Gerador de CV/currículo básico em HTML/CSS puro com design profissional dark mode, responsivo
- **Regra 21** no `system_prompt.md` — geração de CV via `pvn criar cv` ou script direto
- **Assinatura padronizada** — "skill yb POIVON" em todo o projeto (system_prompt, splash, footer, help)
- **README.md completo** — documentação profissional com sumário, tabelas, exemplos de uso e versionamento
- **CHANGELOG.md** — histórico completo de versões seguindo padrão Keep a Changelog

### Fixed
- **`build.sh` linha 57** — erro de sintaxe: `╚══════...╝"` sem `echo` (quebrava execução do shell)
- **`build.sh` linha 10** — versão hardcoded `1.0.0` → agora lê dinamicamente de `DEBIAN/control`
- **`postinst` linha 113** — erro de sintaxe: `╚══════...╝"` sem `echo` (quebrava pós-instalação)
- **`postinst` linha 21** — versão hardcoded `1.0.0` na config gerada → atualizado para `1.2.0`
- **`pvn` linha 165** — `pip install --upgrade pip` removido (proibido no Termux, quebra python-pip)
- **`pvn` linha 166** — `lxml` removido dos pacotes pip (não compila no Termux sem libxml2-dev)
- **`pvn.conf` linha 7** — versão hardcoded `1.0.0` → atualizado para `1.2.0`
- **`pvn` linha 288** — versão fallback `1.0.0` → atualizado para `1.2.0`

### Changed
- Versão global: `1.0.0` → `1.2.0` (control, pvn.conf, postinst, pvn binário)
- Assinatura: "skill yb" → "skill yb POIVON" (padrão global)

---

## [1.1.0] - 2026-07-21

### Added
- **CHANGELOG.md** — registro de versões seguindo padrão Keep a Changelog
- **`version.sh`** — script de versionamento automático (patch/minor/major)
- **`install_termux.sh`** — script de instalação standalone com 10 fases completas
- **`check_deps.sh`** — verificação de dependências do sistema
- **`test_all.sh`** — suite de testes completa (instalação, comunicação, tarefas)
- **`RELATORIO_TESTES_v1.md`** — relatório de análise crítica v1.0
- Script de setup com verificação de lxml/html5lib

### Fixed
- **`setup.sh` linhas 296, 298, 303, 305** — tabela de verificação de versões usando `echo -e` com formatadores `%s` (não interpretados por echo) → corrigido para `printf`
- **`setup.sh`** — verificação segura para versão do lxml (`${lxml_ver:-N/A}`)

---

## [1.0.0] - 2026-07-21

### Added
- **Lançamento inicial** do Agente POIVON para Termux
- **`pvn`** — binário principal com splash screen, indicador de estado, comandos
- **`pvn.conf`** — configuração principal (versão, splash, Firebase, editor, porta, idioma)
- **`system_prompt.md`** — 20 regras de comportamento do LLM (Termux-only)
- **`dicionario_termux.md`** — base de conhecimento Termux vs Linux
- **`build_project.sh`** — gerador de projetos web básicos
- **`server.py`** — servidor HTTP local
- **`termux_env.sh`** — agente de verificação de ambiente
- **`firebase_agent.sh`** — stub de integração Firebase
- **`setup.sh`** — script de instalação completo (5 fases)
- **`build.sh`** — script de build do pacote .deb
- **Pacote .deb** — empacotamento completo com `dpkg-deb`
- **`preinst` / `postinst` / `prerm` / `postrm`** — scripts de ciclo de vida do pacote
- **Splash Screen** — efeito ASCII de caracteres caindo e formando POIVON
- **Indicador de Estado** — 8 estados visuais (pensando, codificando, criando, etc.)
- **Firebase (opcional)** — ativável via `@pvn firebase` (merge:true, cpfAtual, estrutura admin/config)
- **Termux-API** — regras para câmera, localização, notificação, clipboard, SMS, bateria
- **Tradução Linux → Termux** — tabela completa de mapeamento de comandos
- **Verificação de comandos** — 6 critérios de validação antes de executar

---

## Referências

- [Semantic Versioning](https://semver.org)
- [Keep a Changelog](https://keepachangelog.com)
- [Repositório GitHub](https://github.com/matheus23alv-bit/P-O-I-V-O-N-agent)

---

## PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Termux Edition
