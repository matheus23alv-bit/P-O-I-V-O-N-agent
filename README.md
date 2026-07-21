# POIVON — Agente Determinístico de Engenharia para Termux

## PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Termux Edition

**POIVON** é um executor determinístico de engenharia estruturado exclusivamente para o ambiente **Termux** (Android). Gerencia tarefas gerais, executa guias passo a passo, gera CVs profissionais e entrega alterações diretas em código.

| Campo | Valor |
|-------|-------|
| **Versão** | `1.2.0` |
| **Plataforma** | Termux (Android) |
| **Skill vinculada** | yb POIVON |
| **Formato de entrega** | `PVN S¥STEM - AGENTE - POIVON` |
| **Pacote** | `.deb` (dpkg-deb) |
| **Repositório** | [matheus23alv-bit/P-O-I-V-O-N-agent](https://github.com/matheus23alv-bit/P-O-I-V-O-N-agent) |

---

## Sumário

1. [Instalação Rápida](#instalação-rápida)
2. [Instalação via Pacote .deb](#instalação-via-pacote-deb)
3. [Instalação Standalone](#instalação-standalone)
4. [Comandos Disponíveis](#comandos-disponíveis)
5. [Estrutura do Projeto](#estrutura-do-projeto)
6. [Splash Screen](#splash-screen-de-boot)
7. [Indicador de Estado](#indicador-de-estado)
8. [Configuração](#configuração)
9. [Base de Conhecimento do LLM](#base-de-conhecimento-do-llm)
10. [Gerador de CV](#gerador-de-cv-básico)
11. [Versionamento](#versionamento)
12. [Changelog](#changelog)
13. [Licença](#licença)

---

## Instalação Rápida

```bash
# 1. Clonar o repositório
git clone https://github.com/matheus23alv-bit/P-O-I-V-O-N-agent.git
cd P-O-I-V-O-N-agent

# 2. Executar o setup completo
chmod +x setup.sh build.sh
bash setup.sh

# 3. Usar o agente
pvn
pvn help
```

---

## Instalação via Pacote .deb

```bash
# 1. Compilar o .deb
chmod +x build.sh
./build.sh

# 2. Instalar no Termux
pkg install ./p-o-i-v-o-n_1.2.0_all.deb
```

---

## Instalação Standalone

```bash
# Script de instalação completa (10 fases)
chmod +x install_termux.sh
bash install_termux.sh
```

---

## Comandos Disponíveis

| Comando | Descrição |
|---------|-----------|
| `pvn` | Iniciar o agente (com Splash Screen) |
| `pvn help` | Mostrar ajuda geral |
| `pvn status` | Verificar ambiente Termux |
| `pvn setup` | Configurar ambiente completo (5 fases) |
| `pvn server [porta]` | Iniciar servidor local HTTP (porta > 1024) |
| `pvn install <pacote>` | Instalar dependência (pkg / pip / npm) |
| `pvn backup [projeto]` | Criar backup do projeto |
| `pvn criar <nome>` | Criar projeto web do zero |
| `pvn editar <arquivo>` | Editar arquivo existente |
| `pvn corrigir <bug>` | Corrigir bug reportado |
| `pvn revisar <escopo>` | Revisar sem modificar |
| `pvn refatorar <escopo>` | Refatorar escopo indicado |
| `pvn firebase <ação>` | Operar no Firebase |
| `pvn guias` | Listar guias disponíveis |
| `pvn guia <nome>` | Executar guia passo a passo |
| `pvn version` | Exibir versão do agente |
| `pvn -v` | Versão (atalho) |

---

## Estrutura do Projeto

```
P-O-I-V-O-N-agent/
├── setup.sh                              ← Instalação completa (5 fases)
├── build.sh                              ← Build do pacote .deb
├── install_termux.sh                     ← Instalação standalone (10 fases)
├── check_deps.sh                         ← Verificação de dependências
├── test_all.sh                           ← Suite de testes completa
├── version.sh                            ← Script de versionamento (patch/minor/major)
├── CHANGELOG.md                          ← Histórico de versões
├── README.md                             ← Documentação
├── LICENSE                               ← Licença
│
├── DEBIAN/                               ← Metadados do pacote .deb
│   ├── control                           ← Metadados (nome, versão, dependências)
│   ├── preinst                           ← Pré-instalação
│   ├── postinst                          ← Pós-instalação
│   ├── prerm                             ← Pré-remoção
│   ├── postrm                            ← Pós-remoção
│   └── conffiles                         ← Arquivos de configuração
│
├── usr/
│   ├── bin/
│   │   └── pvn                           ← Binário principal do agente
│   │
│   ├── etc/
│   │   └── p-o-i-v-o-n/
│   │       └── pvn.conf                  ← Configuração principal
│   │
│   ├── lib/
│   │   └── p-o-i-v-o-n/
│   │       ├── agents/
│   │       │   ├── firebase_agent.sh     ← Agente Firebase
│   │       │   └── termux_env.sh         ← Agente de Ambiente
│   │       ├── scripts/
│   │       │   ├── build_project.sh      ← Gerador de projetos web
│   │       │   ├── build_cv.sh           ← Gerador de CV básico
│   │       │   └── server.py             ← Servidor HTTP local
│   │       └── data/
│   │           ├── dicionario_termux.md  ← Base de conhecimento Termux
│   │           └── system_prompt.md      ← System Prompt do LLM (21 regras)
│   │
│   └── share/
│       └── p-o-i-v-o-n/
│           ├── templates/
│           ├── assets/
│           └── docs/
```

---

## Splash Screen de Boot

Ao executar `pvn`, a Splash Screen é exibida com o efeito de caracteres caindo e se organizando:

```
  ╭┬╮╭┬╮  ¥¥¥  █▓░  //\\  @#$%  °°°
    ╰╯╰╯  ░▓█  ¥¥¥  %$#@  ┬┬┬  °°°
  ▲▼▲▼  ╭┬╮  ▓░█  //\\  °°°  ╰╯╰╯
  ░▓█░  ▼▲▼  ┬┬┬  ¥¥¥  //\\  ▓░█░

  P-O-I-V-O-N  //\\  °°°°°°
  P-O-I-V-O-N  //\\  █████
  P-O-I-V-O-N  //\\  ▓▓▓▓▓

╔══════════════════════════════════════════════════╗
║                                                  ║
║     ▄▀▄  P-O-I-V-O-N  ▄▀▄                      ║
║                                                  ║
║     iniciando PVN S¥STEM - °°°°°° starting....  ║
║                                                  ║
║     POIVON AGENTE MASTER CODE - TERMUX EDITION   ║
║                                                  ║
╚══════════════════════════════════════════════════╝
```

---

## Indicador de Estado

Sempre visível no topo durante processamento:

```
┌──────────────────────────────────────────────────┐
│   •[ P-O-I-V-O-N ]  //\\  pensando.....•       │
│   PVN S¥STEM | AGENTE POIVON | skill yb POIVON  │
└──────────────────────────────────────────────────┘
```

Estados disponíveis:

| Estado | Quando |
|--------|--------|
| `pensando.....` | Analisando o pedido |
| `codificando.....` | Escrevendo código |
| `digitando.....` | Escrevendo texto |
| `criando.....` | Criando projeto/arquivo |
| `programando.....` | Desenvolvendo aplicação |
| `instalando.....` | Instalando dependências |
| `compilando.....` | Compilando código |
| `concluído.....` | Entrega finalizada |

---

## Configuração

Arquivo: `$PREFIX/etc/p-o-i-v-o-n/pvn.conf`

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `AGENT_VERSION` | `1.2.0` | Versão do agente |
| `SPLASH_SCREEN` | `true` | Ativar Splash Screen |
| `STATE_INDICATOR` | `true` | Ativar indicador de estado |
| `FIREBASE_ACTIVE` | `false` | Firebase (ativo por demanda) |
| `FIREBASE_PROJECT` | `agente-poivon` | Projeto Firebase |
| `WORK_DIR` | `~/storage/shared/POIVON` | Diretório de trabalho |
| `EDITOR` | `nano` | Editor padrão |
| `SERVER_PORT` | `8080` | Porta do servidor |
| `LANGUAGE` | `pt-BR` | Idioma |
| `LOG_ACTIONS` | `true` | Log de ações |

---

## Base de Conhecimento do LLM

O LLM que opera o POIVON é configurado com **21 regras estritas** e um **dicionário Termux** completo:

- **`system_prompt.md`** — 21 regras de comportamento do LLM (ambiente Termux, pacotes, caminhos, portas, permissões, Termux-API, Firebase, validação de comandos, geração de CV)
- **`dicionario_termux.md`** — 16 seções mapeando diferenças Termux vs Linux genérico

---

## Gerador de CV Básico

O POIVON inclui um gerador de CV profissional em HTML/CSS puro, sem dependências externas:

```bash
# Gerar CV com nome e profissão padrão
bash $PREFIX/lib/p-o-i-v-o-n/scripts/build_cv.sh

# Gerar CV personalizado
bash $PREFIX/lib/p-o-i-v-o-n/scripts/build_cv.sh "Seu Nome" "Desenvolvedor Full Stack"

# Visualizar no navegador
pvn server 8080
# Abrir: http://localhost:8080/cv/
```

O CV gerado inclui: cabeçalho com contato, perfil profissional, experiência, formação, competências (tags), projetos, idiomas e footer. Design dark mode responsivo.

---

## Versionamento

O projeto usa [Semantic Versioning](https://semver.org) + [Keep a Changelog](https://keepachangelog.com).

Script de versionamento automático:

```bash
# Bump patch (bug fix)
bash version.sh patch "corrigir bug no login"

# Bump minor (nova feature)
bash version.sh minor "adicionar novo agente"

# Bump major (quebra compatibilidade)
bash version.sh major "reescrita completa"
```

---

## Changelog

Veja o [CHANGELOG.md](./CHANGELOG.md) para o histórico completo de versões.

Resumo:

| Versão | Data | Resumo |
|--------|------|--------|
| `v1.0.0` | 2026-07-21 | Lançamento inicial — agente base, setup, splash screen |
| `v1.1.0` | 2026-07-21 | CHANGELOG + version.sh + fix tabela verificação |
| `v1.2.0` | 2026-07-21 | LLM atualizado (21 regras) + CV básico + 7 bugs corrigidos |

---

## Licença

Licenciado sob a licença incluída no arquivo [LICENSE](./LICENSE).

---

## Identidade

- **Nome:** POIVON
- **Skill:** yb POIVON
- **Formato de Entrega:** `PVN S¥STEM - AGENTE - POIVON`
- **Ambiente:** Termux (Android)
- **Editor Padrão:** nano
- **Firebase:** Desativado por padrão (ativar com `@pvn firebase`)

---

## PVN S¥STEM | AGENTE POIVON | skill yb POIVON | Termux Edition
