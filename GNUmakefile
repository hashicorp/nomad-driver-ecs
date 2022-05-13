SHELL = bash

GIT_COMMIT=$$(git rev-parse --short HEAD)
GIT_BRANCH = $$(git branch --show-current)
GIT_SHA    = $$(git rev-parse HEAD)
GIT_DIRTY=$$(test -n "`git status --porcelain`" && echo "+CHANGES" || true)
GIT_IMPORT="github.com/hashicorp/nomad-pack/internal/pkg/version"
GO_LDFLAGS="-s -w -X $(GIT_IMPORT).GitCommit=$(GIT_COMMIT)$(GIT_DIRTY)"
VERSION = $(shell ./scripts/version.sh version/version.go)

REPO_NAME    ?= $(shell basename "$(CURDIR)")
PRODUCT_NAME ?= $(REPO_NAME)
BIN_NAME     ?= $(PRODUCT_NAME)

# Get latest revision (no dirty check for now).
REVISION = $(shell git rev-parse HEAD)

# Get local ARCH; on Intel Mac, 'uname -m' returns x86_64 which we turn into amd64.
# Not using 'go env GOOS/GOARCH' here so 'make docker' will work without local Go install.
OS   = $(strip $(shell echo -n $${GOOS:-$$(uname | tr [[:upper:]] [[:lower:]])}))
ARCH = $(strip $(shell echo -n $${GOARCH:-$$(A=$$(uname -m); [ $$A = x86_64 ] && A=amd64 || [ $$A = aarch64 ] && A=arm64 ; echo $$A)}))
PLATFORM ?= $(OS)/$(ARCH)
DIST     = dist/$(PLATFORM)
BIN      = $(DIST)/$(BIN_NAME)

ifeq ($(firstword $(subst /, ,$(PLATFORM))), windows)
BIN = $(DIST)/$(BIN_NAME).exe
endif

PLUGIN_BINARY=nomad-driver-ecs
export GO111MODULE=on

pkg/%/nomad-driver-ecs: GO_OUT ?= $@
pkg/%/nomad-driver-ecs: ## Build Task Driver for GOOS_GOARCH, e.g. pkg/linux_amd64/nomad
	@echo "==> Building $@ with tags $(GO_TAGS)..."
	@CGO_ENABLED=0 \
		GOOS=$(firstword $(subst _, ,$*)) \
		GOARCH=$(lastword $(subst _, ,$*)) \
		go build -trimpath -ldflags $(GO_LDFLAGS) -tags "$(GO_TAGS)" -o $(GO_OUT)

pkg/windows_%/nomad-driver-ecs: GO_OUT = $@.exe

default: test build

.PHONY: clean
clean: ## Remove build artifacts
	rm -rf ${PLUGIN_BINARY}

build:
	go build -o bin/${PLUGIN_BINARY} .

test:
	go test -v -race ./...

.PHONY: version
version:
	@$(CURDIR)/scripts/version.sh version/version.go
