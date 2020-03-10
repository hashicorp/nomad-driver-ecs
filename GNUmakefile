PLUGIN_BINARY=nomad-driver-ecs
export GO111MODULE=on

default: test build

.PHONY: clean
clean: ## Remove build artifacts
	rm -rf ${PLUGIN_BINARY}

build:
	go build -o ${PLUGIN_BINARY} .

test:
	go test -v -race ./...
