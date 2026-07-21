#!/data/data/com.termux/files/usr/bin/bash
# ─────────────────────────────────────────────────────────────────────
# POIVON - Gerador de CV Básico (HTML/CSS)
# PVN S¥STEM | AGENTE POIVON | skill yb POIVON
# Termux Edition
# ─────────────────────────────────────────────────────────────────────
#
# Uso: bash build_cv.sh
#
# Gera um CV/currículo básico em HTML puro (sem dependências externas)
# que funciona em qualquer navegador do celular.
#
# Arquivos gerados:
#   ~/storage/shared/POIVON/projects/cv/index.html
#   ~/storage/shared/POIVON/projects/cv/style.css
#
# ─────────────────────────────────────────────────────────────────────

set -euo pipefail

# ─────────────────────────────────────────────────────────────────────
# CORES
# ─────────────────────────────────────────────────────────────────────

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

# ─────────────────────────────────────────────────────────────────────
# CONFIG
# ─────────────────────────────────────────────────────────────────────

WORK_DIR="$HOME/storage/shared/POIVON/projects/cv"

# Dados do CV (edite conforme necessário)
NOME="${1:-SEU NOME COMPLETO}"
PROFISSAO="${2:-Desenvolvedor Full Stack}"

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}${WHITE}  PVN S¥STEM | build_cv.sh POIVON${RESET}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  ${YELLOW}Gerando CV básico em HTML/CSS...${RESET}"
echo -e "  Nome: ${WHITE}${NOME}${RESET}"
echo -e "  Profissão: ${WHITE}${PROFISSAO}${RESET}"
echo ""

# Criar diretório
mkdir -p "$WORK_DIR"

# ─────────────────────────────────────────────────────────────────────
# HTML - CV Completo
# ─────────────────────────────────────────────────────────────────────

cat > "$WORK_DIR/index.html" << HTML
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CV - ${NOME}</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="cv-container">

    <!-- HEADER -->
    <header class="cv-header">
        <h1 class="cv-nome">${NOME}</h1>
        <p class="cv-titulo">${PROFISSAO}</p>
        <div class="cv-contato">
            <span>📧 email@exemplo.com</span>
            <span>📱 (00) 00000-0000</span>
            <span>📍 Cidade - Estado</span>
            <span>🔗 github.com/seuusuario</span>
        </div>
    </header>

    <!-- PERFIL -->
    <section class="cv-section">
        <h2>Perfil</h2>
        <p>
            Profissional com experiência em desenvolvimento web, automação e engenharia de software.
            Capacidade de aprendizado rápido e resolução de problemas complexos.
            Foco em entrega de qualidade e resultados mensuráveis.
        </p>
    </section>

    <!-- EXPERIÊNCIA -->
    <section class="cv-section">
        <h2>Experiência Profissional</h2>

        <div class="cv-item">
            <h3>Desenvolvedor</h3>
            <span class="cv-periodo">2024 - Atual</span>
            <ul>
                <li>Desenvolvimento de aplicações web responsivas</li>
                <li>Integração de APIs e serviços externos</li>
                <li>Automação de processos e workflows</li>
            </ul>
        </div>

        <div class="cv-item">
            <h3>Freelancer</h3>
            <span class="cv-periodo">2023 - 2024</span>
            <ul>
                <li>Criação de sites e landing pages</li>
                <li>Manutenção e otimização de sistemas</li>
                <li>Consultoria técnica para pequenos negócios</li>
            </ul>
        </div>
    </section>

    <!-- FORMAÇÃO -->
    <section class="cv-section">
        <h2>Formação</h2>
        <div class="cv-item">
            <h3>Curso Superior / Técnico</h3>
            <span class="cv-periodo">2022 - 2025</span>
            <p>Instituição de Ensino - Cidade</p>
        </div>
    </section>

    <!-- COMPETÊNCIAS -->
    <section class="cv-section">
        <h2>Competências</h2>
        <div class="cv-skills">
            <span class="skill">HTML/CSS</span>
            <span class="skill">JavaScript</span>
            <span class="skill">Python</span>
            <span class="skill">Git/GitHub</span>
            <span class="skill">Node.js</span>
            <span class="skill">React</span>
            <span class="skill">SQL</span>
            <span class="skill">Linux/Termux</span>
            <span class="skill">APIs REST</span>
            <span class="skill">Firebase</span>
        </div>
    </section>

    <!-- PROJETOS -->
    <section class="cv-section">
        <h2>Projetos</h2>
        <div class="cv-item">
            <h3>Agente POIVON</h3>
            <p>Agente de engenharia determinístico para Termux. Automação de tarefas, geração de código e gerenciamento de projetos.</p>
        </div>
        <div class="cv-item">
            <h3>Portfolio Web</h3>
            <p>Site pessoal responsivo com animações e dark mode. Hospedado em GitHub Pages.</p>
        </div>
    </section>

    <!-- IDIOMAS -->
    <section class="cv-section">
        <h2>Idiomas</h2>
        <div class="cv-item">
            <p><strong>Português</strong> — Nativo</p>
            <p><strong>Inglês</strong> — Intermediário</p>
        </div>
    </section>

    <footer class="cv-footer">
        <p>Gerado por POIVON — PVN S¥STEM | AGENTE POIVON | skill yb POIVON</p>
    </footer>

</div>

</body>
</html>
HTML

# ─────────────────────────────────────────────────────────────────────
# CSS - Estilo Profissional Escuro
# ─────────────────────────────────────────────────────────────────────

cat > "$WORK_DIR/style.css" << 'CSS'
/* ═══════════════════════════════════════════════════════════════
   CV POIVON - Estilo Profissional
   PVN S¥STEM | AGENTE POIVON | skill yb POIVON
   ═══════════════════════════════════════════════════════════════ */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #0d1117;
    color: #c9d1d9;
    line-height: 1.6;
}

.cv-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
}

/* HEADER */
.cv-header {
    text-align: center;
    padding: 2rem 0;
    border-bottom: 2px solid #238636;
    margin-bottom: 2rem;
}

.cv-nome {
    font-size: 2.2rem;
    color: #58a6ff;
    font-weight: 700;
    letter-spacing: 1px;
}

.cv-titulo {
    font-size: 1.1rem;
    color: #8b949e;
    margin: 0.5rem 0 1rem;
}

.cv-contato {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 1rem;
    font-size: 0.9rem;
    color: #8b949e;
}

.cv-contato span {
    display: inline-flex;
    align-items: center;
    gap: 0.3rem;
}

/* SEÇÕES */
.cv-section {
    margin-bottom: 2rem;
}

.cv-section h2 {
    font-size: 1.4rem;
    color: #58a6ff;
    border-left: 3px solid #238636;
    padding-left: 0.8rem;
    margin-bottom: 1rem;
}

.cv-section p {
    color: #c9d1d9;
    margin-bottom: 0.5rem;
}

/* ITEMS */
.cv-item {
    margin-bottom: 1.2rem;
    padding-left: 1rem;
    border-left: 2px solid #30363d;
}

.cv-item h3 {
    color: #f0f6fc;
    font-size: 1.1rem;
    margin-bottom: 0.2rem;
}

.cv-periodo {
    font-size: 0.85rem;
    color: #8b949e;
    display: block;
    margin-bottom: 0.5rem;
}

.cv-item ul {
    list-style: none;
    padding-left: 0;
}

.cv-item ul li {
    position: relative;
    padding-left: 1rem;
    margin-bottom: 0.3rem;
    color: #c9d1d9;
}

.cv-item ul li::before {
    content: "▸";
    position: absolute;
    left: 0;
    color: #238636;
}

/* SKILLS */
.cv-skills {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.skill {
    background: #21262d;
    border: 1px solid #30363d;
    color: #58a6ff;
    padding: 0.3rem 0.8rem;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 500;
}

/* FOOTER */
.cv-footer {
    text-align: center;
    padding: 2rem 0;
    border-top: 1px solid #30363d;
    color: #484f58;
    font-size: 0.8rem;
}

/* RESPONSIVO */
@media (max-width: 600px) {
    .cv-nome {
        font-size: 1.6rem;
    }
    .cv-contato {
        flex-direction: column;
        align-items: center;
    }
    .cv-container {
        padding: 1rem;
    }
}
CSS

# ─────────────────────────────────────────────────────────────────────
# RESULTADO
# ─────────────────────────────────────────────────────────────────────

echo -e "${GREEN}[OK] CV gerado com sucesso!${RESET}"
echo -e "  Localização: ${WHITE}${WORK_DIR}/${RESET}"
echo -e "  Arquivos:    ${WHITE}index.html + style.css${RESET}"
echo ""
echo -e "${CYAN}  Para visualizar:${RESET}"
echo -e "  ${YELLOW}pvn server 8080${RESET}"
echo -e "  Abra: ${WHITE}http://localhost:8080/cv/${RESET}"
echo ""
echo -e "${WHITE}─────────────────────────────────────────${RESET}"
echo -e "${WHITE}  PVN S¥STEM | AGENTE POIVON | skill yb POIVON${RESET}"
echo -e "${WHITE}─────────────────────────────────────────${RESET}"
echo ""
