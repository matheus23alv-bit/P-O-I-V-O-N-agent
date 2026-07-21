#!/data/data/com.termux/files/usr/bin/bash
# ─────────────────────────────────────────────────────
# POIVON - Script de Build de Projeto
# PVN S¥STEM | AGENTE POIVON | skill yb
# [BETA] branch1 | v1.2.0-beta
# ─────────────────────────────────────────────────────

WORK_DIR="$HOME/storage/shared/POIVON/projects"

build_project() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "[ERRO] Especifique o nome do projeto: build_project <nome>"
        return 1
    fi
    
    echo ""
    echo "┌──────────────────────────────────────────────────┐"
    echo "│   •[ P-O-I-V-O-N ]  //\\\\  criando.....•       │"
    echo "└──────────────────────────────────────────────────┘"
    echo ""
    echo "[BUILD] Criando projeto: $name"
    
    # Criar diretório do projeto
    mkdir -p "$WORK_DIR/$name"
    
    # Gerar arquivo base
    cat > "$WORK_DIR/$name/index.html" << 'HTML'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>POIVON - Projeto</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Projeto criado por POIVON</h1>
    <p>POIVON AGENTE MASTER CODE - TERMUX EDITION</p>
    <script src="script.js"></script>
</body>
</html>
HTML
    
    cat > "$WORK_DIR/$name/style.css" << 'CSS'
/* PVN S¥STEM | AGENTE POIVON | skill yb */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
body {
    font-family: monospace;
    background: #0a0a0a;
    color: #00ff41;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}
h1 { font-size: 2rem; margin-bottom: 1rem; }
p { opacity: 0.7; }
CSS
    
    cat > "$WORK_DIR/$name/script.js" << 'JS'
// PVN S¥STEM | AGENTE POIVON | skill yb
document.addEventListener('DOMContentLoaded', function() {
    console.log('Projeto inicializado por POIVON');
});
JS
    
    echo "[OK] Projeto criado: $WORK_DIR/$name/"
    echo "  - index.html"
    echo "  - style.css"
    echo "  - script.js"
    echo ""
    echo "─────────────────────────────────────────"
    echo "  PVN S¥STEM | AGENTE POIVON | skill yb"
    echo "─────────────────────────────────────────"
    echo ""
}

build_project "$@"
