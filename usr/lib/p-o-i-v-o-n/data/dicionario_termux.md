# Dicionário Termux - Base de Conhecimento do Agente P-O-I-V-O-N

## PVN S¥STEM | AGENTE POIVON | skill yb | Termux Edition

---

## 1. Sistema de Pacotes

O Termux não usa `apt-get` diretamente. Ele usa o gerenciador `pkg`, que é um wrapper inteligente do `apt`.

```
Linux Ubuntu/Debian     →   Termux
─────────────────────────────────────────────────────────
apt-get install         →   pkg install
apt-get update          →   pkg update
apt-get upgrade         →   pkg upgrade
apt-get remove          →   pkg uninstall
apt-get autoremove      →   pkg clean
apt-get search          →   pkg search
apt-cache policy        →   pkg show
```

**Regra do LLM**: NUNCA gere comandos com `apt-get`, `apt`, `snap`, `brew` ou `pacman`. Sempre use `pkg`.

---

## 2. Variáveis de Ambiente Essenciais

O Termux define variáveis próprias que o LLM precisa conhecer:

| Variável | Valor | Descrição |
|----------|-------|-----------|
| `$PREFIX` | `/data/data/com.termux/files/usr` | Raiz do sistema Termux (equivalente a `/usr`) |
| `$HOME` | `/data/data/com.termux/files/home` | Diretório home do usuário |
| `$TMPDIR` | `/data/data/com.termux/files/usr/tmp` | Diretório temporário |
| `$ANDROID_DATA` | `/data` | Raiz do Android |
| `$ANDROID_ROOT` | `/system` | Sistema Android |

**Regra do LLM**: NUNCA use caminhos absolutos Linux como `/usr/bin`, `/etc`, `/var/log`. Sempre use `$PREFIX/bin`, `$PREFIX/etc`, `$PREFIX/var/log` ou suas variáveis equivalentes.

---

## 3. Estrutura de Diretórios

```
Linux tradicional           →   Termux
─────────────────────────────────────────────────────────────────────────
/usr/bin/                   →   $PREFIX/bin/
/usr/lib/                   →   $PREFIX/lib/
/usr/include/               →   $PREFIX/include/
/usr/share/                 →   $PREFIX/share/
/etc/                       →   $PREFIX/etc/
/var/log/                   →   $PREFIX/var/log/
/var/tmp/                   →   $TMPDIR/
/tmp/                       →   $TMPDIR/
/home/usuario/              →   $HOME/  (ou ~/)
/root/                      →   NÃO EXISTE (não há root por padrão)
/opt/                       →   $PREFIX/opt/
/dev/                       →   Acesso limitado (sem root)
/proc/                      →   Acesso limitado
/sys/                       →   Acesso limitado
```

**Regra do LLM**: NUNCA gere paths com `/usr/`, `/etc/`, `/var/`, `/home/` ou `/root/`. Sempre traduza para a estrutura Termux.

---

## 4. Gerenciador de Processos

O Termux NÃO possui `systemd`, `init`, `upstart` ou qualquer init system.

```
Linux tradicional           →   Termux
─────────────────────────────────────────────────────────
systemctl start <svc>       →   NÃO DISPONÍVEL
systemctl enable <svc>      →   NÃO DISPONÍVEL
systemctl status <svc>      →   NÃO DISPONÍVEL
service <svc> start         →   NÃO DISPONÍVEL
/etc/init.d/                →   NÃO EXISTE
crontab                     →   cronie (pkg install cronie)
```

**Como iniciar serviços no Termux:**
```bash
# Servidor web
python -m http.server 8080 &
# ou
node server.js &

# Background com nohup
nohup comando &>/dev/null &

# Gerenciar processos
jobs                  # Listar jobs
fg %1                 # Trazer job 1 para foreground
bg %1                 # Enviar job 1 para background
kill %1               # Matar job 1

# Usar termux-services para gerenciar serviços
pkg install termux-services
sv up <servico>       # Iniciar serviço
sv down <servico>     # Parar serviço
sv status <servico>   # Status
```

**Regra do LLM**: NUNCA gere comandos com `systemctl`, `service`, `systemd`, `init.d`. Use background processes (`&`), `nohup`, ou `termux-services`.

---

## 5. Permissões e Armazenamento

O Termux roda como usuário não-root por padrão. Acesso a `/sdcard/` requer `termux-setup-storage`.

```bash
# Conceder acesso ao armazenamento interno
termux-setup-storage

# Paths criados após termux-setup-storage:
~/storage/shared/          → /sdcard/ (armazenamento interno)
~/storage/downloads/       → /sdcard/Download/
~/storage/dcim/            → /sdcard/DCIM/
~/storage/movies/          → /sdcard/Movies/
~/storage/music/           → /sdcard/Music/
~/storage/pictures/        → /sdcard/Pictures/

# Acesso direto ao /sdcard (sem termux-setup-storage)
/storage/emulated/0/       → Armazenamento interno
/storage/emulated/0/Download/ → Downloads
```

**Regra do LLM**: NUNCA tente escrever em `/sdcard/` diretamente. Sempre usar `termux-setup-storage` primeiro, ou os paths `~/storage/`.

---

## 6. Termux-API (Integração com Android)

O pacote `termux-api` permite que o Termux interaja com recursos do Android:

```bash
pkg install termux-api

# Clipboard
termux-clipboard-set "texto"
termux-clipboard-get

# Notificações
termux-notification --title "POIVON" --content "Tarefa concluída"

# Vibração
termux-vibrate -d 1000

# Localização
termux-location

# Câmera
termux-camera-photo -c 0 ~/foto.jpg

# SMS
termux-sms-send -n 123456789 "mensagem"

# Toast
termux-toast "POIVON concluído"

# Bateria
termux-battery-status

# Sensores
termux-sensor -s "Accelerometer" -n 1

# Wi-Fi
termux-wifi-connectioninfo

# Volume
termux-volume music 50

# Brilho
termux-brightness 128

# Flash/Torch
termux-torch on
termux-torch off
```

**Regra do LLM**: Quando o usuário pedir interação com hardware do celular (câmera, GPS, notificações, clipboard), usar `termux-api` e os comandos `termux-*`.

---

## 7. Python no Termux

```bash
# Instalação
pkg install python

# Execução
python script.py              # Python 3 (padrão)
python3 script.py             # Alias para python
pip install pacote            # Pip do Python 3
pip3 install pacote           # Alias para pip

# Virtual environment
python -m venv venv
source venv/bin/activate

# Pacotes Python comuns (sempre usar pip)
pip install flask requests beautifulsoup4 lxml pillow pygments

# Compilação de código C
pkg install clang
clang arquivo.c -o arquivo
```

**Regra do LLM**: Python 3 é o padrão. Use `python` (não `python3` explicitamente). Pacotes via `pip install`, nunca `apt install python3-pip`.

---

## 8. Node.js no Termux

```bash
# Instalação
pkg install nodejs

# Execução
node script.js
node index.js

# npm (já vem com nodejs)
npm install pacote
npm install -g pacote        # Global

# Gerenciadores de pacotes
pkg install yarn             # Yarn
pkg install pnpm             # pnpm
```

**Regra do LLM**: Node.js é instalado via `pkg install nodejs`. NPM já está incluído. Pacotes globais com `npm install -g`.

---

## 9. Servidores e Redes

```bash
# Servidor web estático
python -m http.server 8080
# ou
serve ~/projetos -p 8080     # npm install -g serve

# SSH
pkg install openssh
sshd                          # Iniciar servidor SSH
whoami                        # Ver usuário
passwd                        # Definir senha
# Conectar via IP: ssh usuario@192.168.x.x -p 8022

# Curl e Wget
pkg install curl wget

# Proxy/reverse
pkg install ngrok            # Tunelamento
```

**Regra do LLM**: Portas comuns (80, 443) estão bloqueadas no Termux. Use portas altas (8080, 3000, 5000, etc.).

---

## 10. Git e Versionamento

```bash
# Instalação
pkg install git

# Uso padrão
git init
git clone url
git add .
git commit -m "msg"
git push origin main

# Credenciais
git config --global user.name "POIVON"
git config --global user.email "agente@pvn.system"

# SSH keys
ssh-keygen -t ed25519 -C "POIVON"
cat ~/.ssh/id_ed25519.pub
```

---

## 11. Compiladores e Build Tools

```bash
# C/C++
pkg install clang make cmake

# Build C
clang main.c -o main
clang++ main.cpp -o main

# Make
make
make install                 # Instalar em $PREFIX

# CMake
cmake . && make

# Rust (via rustup)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Go
pkg install golang
```

**Regra do LLM**: Use `clang` e `clang++` (NUNCA `gcc` ou `g++` direto, embora existam como aliases). Use `make install` para instalar em `$PREFIX`.

---

## 12. Diferenças Críticas (NÃO FAZER)

| NUNCA FAZER | POR QUE | ALTERNATIVA |
|-------------|---------|-------------|
| `sudo comando` | Não há sudo por padrão | Executar direto (Termux já é user) |
| `apt-get install` | Não existe | `pkg install` |
| `systemctl` | Sem systemd | `&`, `nohup`, `termux-services` |
| `/usr/bin/python` | Path não existe | `$PREFIX/bin/python` ou `python` |
| `/etc/apt/` | Não existe | `$PREFIX/etc/apt/` |
| `pip install --user` | Desnecessário | `pip install` (já é user) |
| `chmod 777 /` | Perigoso e desnecessário | `chmod` apenas nos arquivos do projeto |
| `/var/log/` | Não existe | `$PREFIX/var/log/` |
| `ufw`, `iptables` | Sem root | Não disponível |
| `docker`, `podman` | Sem root/kernel | Não disponível |
| `/dev/sda1` | Sem root | Não disponível |
| `crontab -e` | Funciona só com cronie | `pkg install cronie && crontab -e` |

---

## 13. Cron no Termux

```bash
# Instalar cron
pkg install cronie

# Habilitar e iniciar
crond

# Editar crontab
crontab -e

# Exemplo de cronjob
* * * * * python $HOME/script.py

# Cron jobs são salvos em:
$PREFIX/var/spool/cron/crontabs/
```

---

## 14. Limitações Físicas do Termux

| Limitação | Impacto | Solução |
|-----------|---------|---------|
| Sem root | Limitado a `$PREFIX` e `~/storage/` | Usar `termux-setup-storage` |
| Sem systemd | Sem serviços persistentes | Usar `termux-services` |
| Sem `/dev/` completo | Limitação em dispositivos hardware | Usar `termux-api` |
| Portas < 1024 bloqueadas | HTTP em 80/443 não funciona | Usar portas > 1024 |
| Sem GPU/CUDA | Sem aceleração GPU | Uso CPU |
| RAM limitada | Processos pesados podem falhar | Limitar escopo |
| Armazenamento | Depende do dispositivo | Gerenciar com cuidado |
| Conexão | Wi-Fi/dados variáveis | Usar offline quando possível |

---

## 15. Proot-distro (Linux completo dentro do Termux)

```bash
# Instalar proot-distro
pkg install proot-distro

# Ver distribuições disponíveis
proot-distro list

# Instalar Ubuntu
proot-distro install ubuntu

# Entrar no Ubuntu
proot-distro login ubuntu

# Dentro do proot: apt-get funciona normalmente!
# Mas NÃO é o Termux nativo - é um ambiente isolado
```

**Regra do LLM**: Distinguir entre Termux nativo e proot-distro. Se o usuário não pediu proot-distro, NUNCA sugira comandos Linux genéricos. Trabalhe sempre no Termux nativo.

---

## 16. Estrutura do Agente POIVON no Termux

```
$PREFIX/
├── bin/pvn                              ← Binário principal
├── etc/p-o-i-v-o-n/pvn.conf             ← Configuração
└── lib/p-o-i-v-o-n/
    ├── agents/
    │   ├── firebase_agent.sh            ← Agente Firebase
    │   └── termux_env.sh                ← Agente de Ambiente
    ├── scripts/
    │   ├── build_project.sh             ← Gerador de projetos
    │   └── server.py                    ← Servidor local
    └── data/
        └── dicionario_termux.md         ← Este arquivo

~/storage/shared/POIVON/
├── projects/                            ← Projetos do usuário
├── scripts/                             ← Scripts auxiliares
├── data/                                ← Dados
└── backups/                             ← Backups
```

---

## PVN S¥STEM | AGENTE POIVON | skill yb
