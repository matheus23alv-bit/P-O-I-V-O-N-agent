#!/data/data/com.termux/files/usr/bin/python3
"""
POIVON - Servidor Local Python
PVN S¥STEM | AGENTE POIVON | skill yb
Termux Edition
"""
import http.server
import socketserver
import sys
import os

WORK_DIR = os.path.expanduser("~/storage/shared/POIVON/projects")
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8080

os.chdir(WORK_DIR)

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("╔══════════════════════════════════════════════════╗")
    print("║                                                  ║")
    print("║  •[ P-O-I-V-O-N ]  //\\\\  programando.....•    ║")
    print("║                                                  ║")
    print(f"║  Servidor local: http://localhost:{PORT}        ║")
    print(f"║  Diretório: {WORK_DIR}              ║")
    print("║                                                  ║")
    print("║  PVN S¥STEM | AGENTE POIVON | skill yb           ║")
    print("╚══════════════════════════════════════════════════╝")
    print("")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n[POIVON] Servidor encerrado.")
