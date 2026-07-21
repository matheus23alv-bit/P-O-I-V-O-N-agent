#!/data/data/com.termux/files/usr/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║                                                                  ║
# ║   POIVON - Gerenciador de Versões                               ║
# ║   PVN S¥STEM | AGENTE POIVON | skill yb                        ║
# ║   Termux Edition                                                 ║
# ║                                                                  ║
# ║   Uso: bash version.sh <patch|minor|major> [mensagem]           ║
# ║                                                                  ║
# ║   Exemplos:                                                     ║
# ║     bash version.sh patch "corrigir bug no login"              ║
# ║     bash version.sh minor "adicionar novo agente"              ║
# ║     bash version.sh major "reescrita completa"                 ║
# ║                                                                  ║
# ╚══════════════════════════════════════════════════════════════════╝

set -euo pipefail

# ─────────────────────────────────────────────────────────────────────
# CORES
# ─────────────────────────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

# ─────────────────────────────────────────────────────────────────────
# VALIDAR ARGUMENTOS
# ─────────────────────────────────────────────────────────────────────

BUMP="${1:-}"
MESSAGE="${2:-}"

if [[ -z "$BUMP" ]] || [[ "$BUMP" != "patch" && "$BUMP" != "minor" && "$BUMP" != "major" ]]; then
    echo -e "${RED}[ERRO] Uso: bash version.sh <patch|minor|major> [mensagem]${RESET}"
    echo -e "${YELLOW}  patch  → correção de bug (1.0.0 → 1.0.1)${RESET}"
    echo -e "${YELLOW}  minor  → nova funcionalidade (1.0.0 → 1.1.0)${RESET}"
    echo -e "${YELLOW}  major  → mudança quebrando compatibilidade (1.0.0 → 2.0.0)${RESET}"
    exit 1
fi

# ─────────────────────────────────────────────────────────────────────
# LER VERSÃO ATUAL
# ─────────────────────────────────────────────────────────────────────

CONTROL_FILE="DEBIAN/control"
if [[ ! -f "$CONTROL_FILE" ]]; then
    echo -e "${RED}[ERRO] Arquivo DEBIAN/control não encontrado.${RESET}"
    exit 1
fi

CURRENT_VERSION=$(grep "^Version:" "$CONTROL_FILE" | awk '{print $2}')
if [[ -z "$CURRENT_VERSION" ]]; then
    echo -e "${RED}[ERRO] Versão não encontrada em DEBIAN/control.${RESET}"
    exit 1
fi

# Separar partes
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# ─────────────────────────────────────────────────────────────────────
# CALCULAR NOVA VERSÃO
# ─────────────────────────────────────────────────────────────────────

case "$BUMP" in
    patch)
        PATCH=$((PATCH + 1))
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
esac

NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"
DATE=$(date +%Y-%m-%d)

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}${WHITE}  PVN S¥STEM | version.sh POIVON${RESET}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  Versão atual:  ${YELLOW}${CURRENT_VERSION}${RESET}"
echo -e "  Tipo:          ${BLUE}${BUMP}${RESET}"
echo -e "  Nova versão:   ${GREEN}${NEW_VERSION}${RESET}"
echo -e "  Data:          ${WHITE}${DATE}${RESET}"
echo ""

# ─────────────────────────────────────────────────────────────────────
# ATUALIZAR DEBIAN/control
# ─────────────────────────────────────────────────────────────────────

sed -i "s/^Version: ${CURRENT_VERSION}/Version: ${NEW_VERSION}/" "$CONTROL_FILE"
echo -e "${GREEN}[OK] DEBIAN/control atualizado → ${NEW_VERSION}${RESET}"

# ─────────────────────────────────────────────────────────────────────
# ATUALIZAR CHANGELOG.md
# ─────────────────────────────────────────────────────────────────────

CHANGELOG_FILE="CHANGELOG.md"

if [[ -f "$CHANGELOG_FILE" ]]; then
    # Determinar tipo de mudança para o changelog
    CHANGE_TYPE="### Added"
    case "$BUMP" in
        patch) CHANGE_TYPE="### Fixed" ;;
        minor) CHANGE_TYPE="### Added" ;;
        major) CHANGE_TYPE="### Changed" ;;
    esac

    MSG_DISPLAY="${MESSAGE:-$BUMP update}"

    # Criar nova seção
    NEW_SECTION="## [${NEW_VERSION}] - ${DATE}

${CHANGE_TYPE}
- ${MSG_DISPLAY}

---

"

    # Inserir após a linha "---" que vem depois do header
    # Encontrar a posição da primeira versão existente e inserir antes
    TEMP_FILE=$(mktemp)
    awk -v new_section="$NEW_SECTION" -v search="## \[" '
        NR == 1 { print; next }
        /^## \[/ && found == 0 {
            print new_section
            found = 1
        }
        { print }
    ' "$CHANGELOG_FILE" > "$TEMP_FILE"
    mv "$TEMP_FILE" "$CHANGELOG_FILE"

    echo -e "${GREEN}[OK] CHANGELOG.md atualizado${RESET}"
else
    echo -e "${YELLOW}[WARN] CHANGELOG.md não encontrado — criando${RESET}"
    echo "# CHANGELOG

## [${NEW_VERSION}] - ${DATE}

### Added
- ${MESSAGE:-Initial version bump}

---
" > "$CHANGELOG_FILE"
    echo -e "${GREEN}[OK] CHANGELOG.md criado${RESET}"
fi

# ─────────────────────────────────────────────────────────────────────
# RESUMO
# ─────────────────────────────────────────────────────────────────────

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}${GREEN}  ✓ Versão atualizada: ${CURRENT_VERSION} → ${NEW_VERSION}${RESET}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "${WHITE}  Próximos passos:${RESET}"
echo -e "  ${YELLOW}1.${RESET} git add -A"
echo -e "  ${YELLOW}2.${RESET} git commit -m \"release: v${NEW_VERSION}\""
echo -e "  ${YELLOW}3.${RESET} git tag -a v${NEW_VERSION} -m \"POIVON v${NEW_VERSION}\""
echo -e "  ${YELLOW}4.${RESET} git push origin main --tags"
echo ""
echo -e "  PVN S¥STEM | AGENTE POIVON | version.sh POIVON${RESET}"
echo ""
