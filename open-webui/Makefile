SHELL := /bin/zsh
.DEFAULT_GOAL := help

DIR       := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
NAMESPACE := open-webui
RELEASE   := open-webui
REPO_NAME := open-webui
REPO_URL  := https://helm.openwebui.com/
CHART     := open-webui/open-webui
HOSTNAME  := $(shell scutil --get LocalHostName).local

.PHONY: help install upgrade

help: ## Show this help
	@echo "Open WebUI on k3s\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Add Helm repo, install chart, and wait for rollout
	@helm repo add $(REPO_NAME) $(REPO_URL) 2>/dev/null || true
	@helm repo update $(REPO_NAME)
	@kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	@helm upgrade --install $(RELEASE) $(CHART) \
		--namespace $(NAMESPACE) \
		--values $(DIR)values.yaml \
		--set ingress.host=$(HOSTNAME) \
		--set ingress.hosts[0].host=$(HOSTNAME) \
		--wait \
		--timeout 120s
	@echo "✅ Open WebUI is running at http://$(HOSTNAME)"

upgrade: ## Pull latest chart + image and upgrade release
	@helm repo update $(REPO_NAME)
	@helm upgrade $(RELEASE) $(CHART) \
		--namespace $(NAMESPACE) \
		--values $(DIR)values.yaml \
		--set ingress.host=$(HOSTNAME) \
		--set ingress.hosts[0].host=$(HOSTNAME) \
		--wait \
		--timeout 120s
	@echo "✅ Upgrade complete"
