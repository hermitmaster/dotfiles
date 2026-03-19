# Open WebUI on k3s (Rancher Desktop)

Deploys [Open WebUI](https://github.com/open-webui/open-webui) into k3s (Rancher Desktop) via the official Helm chart, using a locally running Ollama instance for inference, served over HTTPS with a locally-trusted cert-manager CA.

## Prerequisites

- [Rancher Desktop](https://rancherdesktop.io/) running with k3s enabled
- [Ollama](https://ollama.com/) running locally on port `11434`
- `kubectl` configured to target the Rancher Desktop context
- `helm` installed (`brew install helm`)

## Usage

```bash
# First-time install (cert-manager + CA trust + Open WebUI)
make install

# Upgrade to latest chart + image
make upgrade
```

`make install` runs these steps in order:
1. **`cert-manager`** — installs cert-manager, waits for readiness, applies a self-signed `ClusterIssuer` and local CA `Certificate`
2. **`trust-ca`** — exports the CA cert from the cluster and trusts it in the macOS System Keychain (`sudo` required once)
3. **`_deploy`** — adds the Helm repo and installs/upgrades Open WebUI with the hostname injected dynamically

Individual targets can also be run standalone:

```bash
make cert-manager   # install/update cert-manager only
make trust-ca       # re-trust CA cert (e.g. after cluster reset)
```

## Post-Install

Add your machine hostname to `/etc/hosts` (one-time):

```bash
echo "127.0.0.1  $(scutil --get LocalHostName).local" | sudo tee -a /etc/hosts
```

Then open: **https://hermitbook.local** (or whatever `scutil --get LocalHostName` returns)

## How It Works

- **Hostname**: resolved dynamically at deploy time via `scutil --get LocalHostName` — no hardcoded values.
- **Ollama**: reached at `http://host.rancher-desktop.internal:11434` — Rancher Desktop maps this to the Mac host from inside pods.
- **Ingress**: Traefik (k3s default) routes the hostname → Open WebUI service on port 8080.
- **TLS**: cert-manager issues a leaf cert signed by the local CA; the CA is trusted in the macOS System Keychain so browsers accept it without warnings.
- **Storage**: 2Gi `PersistentVolumeClaim` (`local-path` StorageClass) persists chat history and settings.
- **Chart**: [`open-webui/open-webui`](https://helm.openwebui.com/) — bundled Ollama disabled, external URL via `ollamaUrls`.

## Layout

```
open-webui/
├── Makefile                        # install, upgrade, cert-manager, trust-ca targets
├── README.md
├── values.yaml                     # Helm chart overrides
└── cert-manager/
    └── cluster-issuer.yaml         # selfSigned ClusterIssuer + CA Certificate + CA ClusterIssuer
```
