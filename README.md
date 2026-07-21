# POIVON - Agente para Termux

## PVN S¥STEM | AGENTE POIVON | skill yb

**POIVON** é um Executor Determinístico de Engenharia estruturado exclusivamente para o ambiente **Termux** (Android). Gerencia tarefas gerais, executa guias passo a passo e entrega alterações diretas em código.

---

## Instalação Rápida

```bash
# 1. Clonar o repositório
git clone https://github.com/seu-usuario/p-o-i-v-o-n.git
cd p-o-i-v-o-n

# 2. Executar o setup
chmod +x setup.sh build.sh
bash setup.sh
```

Após a instalação, o agente está disponível como `pvn`:

```bash
pvn           # Iniciar (com Splash Screen)
pvn help      # Ajuda
pvn status    # Verificar ambiente
pvn setup     # Configurar ambiente completo
```

---

## Instalação via Pacote .deb

```bash
# 1. Compilar o .deb
chmod +x build.sh
./build.sh

# 2. Instalar no Termux
pkg install ./p-o-i-v-o-n_1.0.0_all.deb
```

---

## Estrutura do Projeto

```
p-o-i-v-o-n/
├── setup.sh                          ← Script de instalação completo
├── build.sh                          ← Script de build do .deb
├── .gitignore
├── README.md
│
├── DEBIAN/                           ← Metadados do pacote .deb
│   ├── control                       ← Metadados do pacote
│   ├── preinst                       ← Pré-instalação
│   ├── postinst                      ← Pós-instalação
│   ├── prerm                         ← Pré-remoção
│   ├── postrm                        ← Pós-remoção
│   └── conffiles                     ← Arquivos de configuração
│
├── usr/
│   ├── bin/
│   │   └── pvn                       ← Binário principal
│   │
│   ├── etc/
│   │   └── p-o-i-v-o-n/
│   │       └── pvn.conf              ← Configuração principal
│   │
│   ├── lib/
│   │   └── p-o-i-v-o-n/
│   │       ├── agents/
│   │       │   ├── firebase_agent.sh ← Agente Firebase
│   │       │   └── termux_env.sh     ← Agente de Ambiente
│   │       ├── scripts/
│   │       │   ├── build_project.sh  ← Gerador de projetos
│   │       │   └── server.py         ← Servidor local Python
│   │       └── data/
│   │           ├── dicionario_termux.md ← Base de conhecimento
│   │           └── system_prompt.md     ← System Prompt do LLM
│   │
│   └── share/
│       └── p-o-i-v-o-n/
│           ├── templates/
│           ├── assets/
│           └── docs/
```

---

## Comandos Disponíveis

| Comando | Descrição |
|---------|-----------|
| `pvn` | Iniciar o agente (Splash Screen) |
| `pvn help` | Mostrar ajuda |
| `pvn status` | Verificar ambiente |
| `pvn setup` | Configurar ambiente completo |
| `pvn server [porta]` | Servidor local (porta > 1024) |
| `pvn install <pacote>` | Instalar dependência (pkg/pip/npm) |
| `pvn backup [projeto]` | Criar backup |
| `pvn criar <nome>` | Criar projeto |
| `pvn firebase <ação>` | Operar no Firebase |
| `pvn guias` | Listar guias |
| `pvn guia <nome>` | Executar guia passo a passo |
| `pvn version` | Versão do agente |

---

## Splash Screen de Boot

Ao executar `pvn`, a Splash Screen é exibida com o efeito de caracteres caindo e se organizando:

```
╔══════════════════════════════════════════════════╗
║                                                  ║
║     ▄▀▄  P-O-I-V-O-N  ▄▀▄                      ║
║                                                  ║
║     iniciando PVN S¥STEM - °°°°°° starting....  ║
║                                                  ║
║     POIVON AGENTE MASTER CODE - TERMUX EDITION   ║
║                                                  ║
╚══════════════════════════════════════════════════╝

┌──────────────────────────────────────────────────┐
│   •[ P-O-I-V-O-N ]  //\\\\  pensando.....•      │
│   PVN S¥STEM | AGENTE POIVON | skill yb         │
└──────────────────────────────────────────────────┘
```

---

## Configuração

Arquivo: `$PREFIX/etc/p-o-i-v-o-n/pvn.conf`

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `AGENT_VERSION` | `1.0.0` | Versão do agente |
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

Os arquivos `dicionario_termux.md` e `system_prompt.md` são usados para treinar/configurar o LLM que opera o POIVON:

- **`dicionario_termux.md`**: 16 seções mapeando diferenças Termux vs Linux.
- **`system_prompt.md`**: 20 regras estritas de comportamento do LLM.

---

## Identidade

- **Nome**: POIVON
- **Skill**: yb
- **Formato de Entrega**: `PVN S¥STEM - AGENTE - POIVON`
- **Ambiente**: Termux (Android)
- **Editor**: nano
- **Firebase**: Desativado por padrão (ativar com `@pvn firebase`)

---

## Skill Vinculada

POIVON é o agente vinculado à skill **yb** do sistema PVN S¥STEM.

---

## PVN S¥STEM | AGENTE POIVON | skill yb | Termux Edition
