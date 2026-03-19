SHELL := /bin/zsh
.DEFAULT_GOAL := help

DIR              := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
NAMESPACE        := open-webui
RELEASE          := open-webui
REPO_NAME        := open-webui
REPO_URL         := https://helm.openwebui.com/
CHART            := open-webui/open-webui
HOSTNAME         := $(shell scutil --get LocalHostName).local
CERT_MANAGER_VER := v1.17.1
CA_SECRET        := local-ca-secret
CA_TMP           := /tmp/open-webui-ca.crt

.PHONY: help install upgrade cert-manager trust-ca

help: ## Show this help
	@echo "Open WebUI on k3s\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: cert-manager trust-ca _deploy ## Full install: cert-manager, trust CA, deploy Open WebUI
	@echo "✅ Open WebUI is running at https://$(HOSTNAME)"

upgrade: ## Pull latest chart + image and upgrade release
	@helm repo update $(REPO_NAME)
	@helm upgrade $(RELEASE) $(CHART) \
		--namespace $(NAMESPACE) \
		--values $(DIR)values.yaml \
		--set ingress.host=$(HOSTNAME) \
		--set "ingress.hosts[0].host=$(HOSTNAME)" \
		--set "ingress.tls[0].hosts[0]=$(HOSTNAME)" \
		--wait \
		--timeout 120s
	@echo "✅ Upgrade complete"

cert-manager: ## Install cert-manager and apply ClusterIssuer/CA manifests
	@echo "⏳ Installing cert-manager $(CERT_MANAGER_VER)..."
	@kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/$(CERT_MANAGER_VER)/cert-manager.yaml
	@echo "⏳ Waiting for cert-manager to be ready..."
	@kubectl rollout status deployment/cert-manager -n cert-manager --timeout=120s
	@kubectl rollout status deployment/cert-manager-webhook -n cert-manager --timeout=120s
	@kubectl rollout status deployment/cert-manager-cainjector -n cert-manager --timeout=120s
	@echo "⏳ Applying ClusterIssuer and CA certificate..."
	@kubectl apply -f $(DIR)cert-manager/cluster-issuer.yaml
	@echo "⏳ Waiting for CA certificate to be issued..."
	@kubectl wait certificate/local-ca -n cert-manager --for=condition=Ready --timeout=60s

trust-ca: ## Export CA cert from cluster and trust it in macOS Keychain
	@echo "⏳ Exporting CA certificate..."
	@kubectl get secret $(CA_SECRET) -n cert-manager \
		-o jsonpath='{.data.tls\.crt}' | base64 -d > $(CA_TMP)
	@echo "🔐 Trusting CA in macOS System Keychain (sudo required)..."
	@sudo security add-trusted-cert -d -r trustRoot \
		-k /Library/Keychains/System.keychain $(CA_TMP)
	@rm -f $(CA_TMP)
	@echo "✅ CA trusted"

_deploy:
	@helm repo add $(REPO_NAME) $(REPO_URL) 2>/dev/null || true
	@helm repo update $(REPO_NAME)
	@kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	@helm upgrade --install $(RELEASE) $(CHART) \
		--namespace $(NAMESPACE) \
		--values $(DIR)values.yaml \
		--set ingress.host=$(HOSTNAME) \
		--set "ingress.hosts[0].host=$(HOSTNAME)" \
		--set "ingress.tls[0].hosts[0]=$(HOSTNAME)" \
		--wait \
		--timeout 120s
