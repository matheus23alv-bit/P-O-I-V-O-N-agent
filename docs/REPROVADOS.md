<!-- Version: v2.0.0 -->

# POIVON — REGISTRO DE REPROVADOS E ENCERRADOS

| Campo | Valor |
| --- | --- |
| **Projeto** | P-O-I-V-O-N Agent |
| **Data** | 21 de julho de 2026 |
| **Autoridade** | Usuário-chefe |
| **Função** | Cemitério oficial: o que foi reprovado, encerrado ou não deu certo |

**PVN S¥STEM | AGENTE POIVON | skill yb | Termux Edition**

---

## 1. Desvio de conduta — múltiplas branches (CORRIGIDO)

A governança v1.3.0 definia a **branch1 como única branch de trabalho**.
Na prática surgiram `branch2` e `branch3` fora dessa regra.

| Branch | Conteúdo | Destino |
| --- | --- | --- |
| branch2 | LLM real (`llm_client.sh`, `pvn criar/ai`) + Firebase real (Identity Toolkit → Firestore, escrita restrita a `gnu.*`) | ABSORVIDA na branch1 (merge auditado) e REMOVIDA como branch. Backup: tag `arquivo/branch2`. |
| branch3 | Pacote auditado: `+mm ¥00`, `llm_fallback.py`, Regra 23 | ABSORVIDA na branch1 (patch aplicado limpo, auditoria APROVADA COM RESSALVAS; ressalvas corrigidas). Nunca existiu no remoto. |

**Regra reafirmada:** trabalho SOMENTE na branch1; promoção para main
SOMENTE por decisão explícita do usuário-chefe; qualquer branch nova
exige registro prévio na governança.

## 2. Execução reprovada — 1º retorno do executor (branch3)

O primeiro retorno da tarefa branch3 veio sem NENHUM dos 8 itens
obrigatórios de evidência (sem diff, sem saída de testes, sem
confirmação de branch). Veredito: **REPROVADO — NÃO VERIFICADO**.

Lição consolidada: chat não executa git; descreve. Evidência é saída
crua de Termux/CI, ou não é evidência. O segundo retorno, com patch
aplicável e logs, foi reproduzido de forma independente e aprovado.

## 3. Incidente de credencial (ENCERRADO)

Uma chave de API da Anthropic foi colada em chat durante a sessão
v1.3.0. Tratada como comprometida por definição.

→ chave NUNCA incorporada a arquivo, artefato ou commit;
→ varredura `sk-ant` em todo o repositório e patches: **zero ocorrências**;
→ obrigação permanente: revogar chave exposta e gerar nova fora do chat;
→ credenciais só em `pvn.conf`/`.env` locais (permissão 600), jamais versionadas.

## 4. Decisões substituídas

| Reprovado / substituído | Vigente |
| --- | --- |
| `sed -i "s\|...\|"` na gravação da memória (quebrava com `\|` no caminho) | Reescrita via `grep -v` + append atômico |
| Validação de caminho sem guarda de `$PREFIX` vazio | Guarda explícita `[ -z "$PREFIX" ]` |
| Slot aceitando apenas `¥00` (U+00A5) | Aceita também `￥00` (U+FFE5, teclado Android) |
| CHANGELOG sem marcador de versão (GAP 1 da auditoria) | Marcador no topo do CHANGELOG |
| Stubs de `editar/corrigir/revisar/refatorar/guia` ("fila v2.x") | Ligados ao `llm_client.sh` — engenharia real |
| Pendência "chave de fallback: automática ou manual?" | AMBAS: manual (`pvn ai`) e embutida nos comandos de engenharia |
| Pedido de manter/commitar a chave exposta no chat ("tenho backup") | Reprovado: repo é PÚBLICO (clone anônimo verificado); backup não cobre cobrança indevida; secret scanning revogaria no push. Vigente: `pvn chave` grava credencial NOVA só no aparelho (600) |
| Banners fixando "branch1 / Beta" no binário | Canal parametrizado por `AGENT_CHANNEL` (pvn.conf) |
| Datas de changelog no futuro (2026-07-22) em entradas beta | Mantidas como histórico; novas entradas usam a data real |

## 5. Não sobreviveu como caminho

→ Tratar decisões de chat como oficiais sem teste/auditoria/sincronização.
→ Multiplicar branches sem governança.
→ Dois clientes LLM concorrentes sem papel definido — resolvido:
  `llm_client.sh` é o cliente do CLI; `llm_fallback.py` é biblioteca
  Python para `server.py`/agentes futuros.

---

**PVN S¥STEM | AGENTE POIVON | skill yb | Termux Edition**
Fonte geral: GitHub | Branch única: branch1 | Estável: main
