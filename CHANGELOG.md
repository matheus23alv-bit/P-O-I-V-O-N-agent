# Changelog — POIVON

**Projeto:** Agente POIVON — Executor Determinístico de Engenharia para Termux  
**Manutenção:** MATHEUS <mentalista-framework@pvn.system>  
**Formato:** PVN S¥STEM - AGENTE - POIVON  
**Plataforma:** Termux (Android)  
**Convenção:** [Semantic Versioning](https://semver.org) + [Keep a Changelog](https://keepachangelog.com)

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
