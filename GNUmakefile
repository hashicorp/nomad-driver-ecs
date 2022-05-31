SHELL = bash
default: help

GIT_COMMIT := $(shell git rev-parse --short HEAD)
GIT_DIRTY := $(if $(shell git status --porcelain),+CHANGES)

GO_LDFLAGS := "-X github.com/hashicorp/nomad-driver-ecs/version.GitCommit=$(GIT_COMMIT)$(GIT_DIRTY)"

HELP_FORMAT="    \033[36m%-25s\033[0m %s\n"
.PHONY: help
help: ## Display this usage information
	@echo "Valid targets:"
	@grep -E '^[^ ]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ":.*?## "}; \
			{printf $(HELP_FORMAT), $$1, $$2}'
	@echo ""

pkg/%/nomad-driver-ecs: GO_OUT ?= $@
pkg/windows_%/nomad-driver-ecs: GO_OUT = $@.exe
pkg/%/nomad-driver-ecs: ## Build nomad-driver-ecs plugin for GOOS_GOARCH, e.g. pkg/linux_amd64/nomad
	@echo "==> Building $@ with tags $(GO_TAGS)..."
	@CGO_ENABLED=0 \
		GOOS=$(firstword $(subst _, ,$*)) \
		GOARCH=$(lastword $(subst _, ,$*)) \
		go build -trimpath -ldflags $(GO_LDFLAGS) -tags "$(GO_TAGS)" -o $(GO_OUT)

.PRECIOUS: pkg/%/nomad-driver-ecs
pkg/%.zip: pkg/%/nomad-driver-ecs ## Build and zip nomad-driver-ecs plugin for GOOS_GOARCH, e.g. pkg/linux_amd64.zip
	@echo "==> Packaging for $@..."
	zip -j $@ $(dir $<)*

.PHONY: dev
dev: ## Build for the current development version
	@echo "==> Building nomad-driver-ecs..."
	@CGO_ENABLED=0 \
		go build \
			-ldflags $(GO_LDFLAGS) \
			-o ./bin/nomad-driver-ecs
	@echo "==> Done"

.PHONY: test
test: ## Run tests
	go test -v -race ./...

.PHONY: version
version:
ifneq (,$(wildcard version/version_ent.go))
	@$(CURDIR)/scripts/version.sh version/version.go version/version_ent.go
else
	@$(CURDIR)/scripts/version.sh version/version.go version/version.go
endif
