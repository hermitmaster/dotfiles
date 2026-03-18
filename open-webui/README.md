# Open WebUI on k3s (Rancher Desktop)

Deploys [Open WebUI](https://github.com/open-webui/open-webui) into k3s (Rancher Desktop) via the official Helm chart, using a locally running Ollama instance for inference.

## Prerequisites

- [Rancher Desktop](https://rancherdesktop.io/) running with k3s enabled
- [Ollama](https://ollama.com/) running locally on port `11434`
- `kubectl` configured to target the Rancher Desktop context
- `helm` installed (`brew install helm`)

## Usage

```bash
# First-time install
make install

# Upgrade to latest chart + image
make upgrade
```

## Post-Install

Add `open-webui.local` to your `/etc/hosts` (one-time):

```bash
echo "127.0.0.1  open-webui.local" | sudo tee -a /etc/hosts
```

Then open: **http://open-webui.local**

## How It Works

- **Ollama**: reached at `http://host.rancher-desktop.internal:11434` — Rancher Desktop maps this hostname to the Mac host from inside pods.
- **Ingress**: Traefik (k3s default) routes `open-webui.local` → the Open WebUI service on port 8080.
- **Storage**: 1Gi `PersistentVolumeClaim` (k3s `local-path` StorageClass) persists chat history and settings.
- **Chart**: [`open-webui/open-webui`](https://helm.openwebui.com/) — bundled Ollama is disabled; external Ollama URL is passed via `ollamaUrls`.

## Layout

```
open-webui/
├── Makefile      # install + upgrade targets
├── README.md
└── values.yaml   # Helm chart overrides
```
