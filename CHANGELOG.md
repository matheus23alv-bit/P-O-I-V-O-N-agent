# CHANGELOG

**Projeto:** POIVON — Agente Master Code  
**Formatação:** PVN S¥STEM - AGENTE - POIVON  
**Plataforma:** Termux (Android)  
**Convenção:** [Semantic Versioning](https://semver.org) + [Keep a Changelog](https://keepachangelog.com)

---

## [1.1.0] - 2026-07-21

### Added
- Script de instalação standalone `install_termux.sh` com 10 fases completas
- Script de verificação de dependências `check_deps.sh` (verifica lxml/libxml2)
- Script de testes automatizado `test_all.sh` (52 testes em 6 categorias)
- Relatório de análise crítica `RELATORIO_TESTES_v1.md` com plano de melhoria
- Verificação de lxml no setup com detecção de libxml2/libxslt/clang/pkg-config

### Changed
- Setup agora verifica lxml antes de instalar (8 fases em vez de 7)
- Tabela de verificação final usa `printf` para formatação correta
- Estrutura de diretórios: cria `~/POIVON/` como fallback além de `~/storage/shared/POIVON/`

### Fixed
- `termux-setup-storage` aborta quando storage já existe → agora detecta e pula
- `pip install --upgrade pip` removido (proibido no Termux, quebra python-pip)
- Tabela de versão imprimia `%s` como texto cru → corrigido com `printf`

---

## [1.0.1] - 2026-07-21

### Fixed
- Removido lxml como dependência obrigatória (não compila no Termux sem libxml2-dev)
- Substituído por html5lib como fallback (100% Python puro)
- Removidos numpy e pandas (pesados para Termux)

---

## [1.0.0] - 2026-07-21

### Added
- Estrutura completa do pacote Debian (.deb) para Termux
- Script de instalação `setup.sh` com 7 fases
- Script de build `build.sh` para gerar .deb
- Binário principal `usr/bin/pvn` com 15 comandos
- Configuração `pvn.conf` com 10 variáveis
- Agente Firebase (`firebase_agent.sh`) — inativo por padrão
- Agente Termux Environment (`termux_env.sh`)
- Script `build_project.sh` — criador de projetos
- Script `server.py` — servidor local HTTP (porta 8080)
- Dicionário Termux `dicionario_termux.md` (16 seções)
- System Prompt `system_prompt.md` (20 regras de execução)
- Splash Screen ASCII com efeito de queda de caracteres
- Indicador visual POIVON sempre no topo
- Script `postrm` com proteção contra remoção acidental
- Scripts DEBIAN: `preinst`, `postinst`, `prerm`, `postrm`, `conffiles`

---

## Formato

O CHANGELOG segue o formato [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).

Tipos de entrada:
- **Added** — Novas funcionalidades
- **Changed** — Alterações em funcionalidades existentes
- **Deprecated** — Funcionalidades que serão removidas
- **Removed** — Funcionalidades removidas
- **Fixed** — Correções de bugs
- **Security** — Correções de segurança

---

> **Agente POIVON** | PVN S¥STEM | skill yb POIVON  
> Manter este arquivo atualizado a cada release.
