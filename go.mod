module github.com/hashicorp/nomad-driver-ecs

go 1.16

require (
	github.com/Microsoft/go-winio v0.4.16 // indirect
	github.com/armon/go-metrics v0.3.5 // indirect
	github.com/aws/aws-sdk-go-v2 v0.19.0
	github.com/docker/docker v20.10.1+incompatible // indirect
	github.com/fatih/color v1.10.0 // indirect
	github.com/golang/snappy v0.0.2 // indirect
	github.com/hashicorp/errwrap v1.1.0 // indirect
	github.com/hashicorp/go-hclog v0.15.0
	github.com/hashicorp/go-retryablehttp v0.6.8 // indirect
	github.com/hashicorp/go-version v1.2.1 // indirect
	github.com/hashicorp/nomad v1.1.0-beta1
	github.com/hashicorp/raft v1.2.0 // indirect
	github.com/hashicorp/vault/api v1.0.5-0.20200717191844-f687267c8086 // indirect
	github.com/hashicorp/yamux v0.0.0-20200609203250-aecfd211c9ce // indirect
	github.com/kr/pretty v0.2.1 // indirect
	github.com/miekg/dns v1.1.35 // indirect
	github.com/mitchellh/go-testing-interface v1.14.1 // indirect
	github.com/mitchellh/hashstructure v1.1.0 // indirect
	github.com/mitchellh/mapstructure v1.4.0 // indirect
	github.com/moby/sys/mount v0.2.0 // indirect
	github.com/oklog/run v1.1.0 // indirect
	github.com/pierrec/lz4 v2.6.0+incompatible // indirect
	github.com/stretchr/testify v1.6.1
	github.com/vmihailenco/tagparser v0.1.2 // indirect
	golang.org/x/crypto v0.0.0-20201217014255-9d1352758620 // indirect
	golang.org/x/time v0.0.0-20201208040808-7e3f01d25324 // indirect
	golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	google.golang.org/genproto v0.0.0-20201214200347-8c77b98c765d // indirect
	google.golang.org/protobuf v1.25.0 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	gopkg.in/yaml.v3 v3.0.0-20200615113413-eeeca48fe776 // indirect
)

// use lower-case sirupsen
replace github.com/Sirupsen/logrus v1.0.6 => github.com/sirupsen/logrus v1.0.6

replace github.com/Sirupsen/logrus v1.2.0 => github.com/sirupsen/logrus v1.2.0

replace github.com/Sirupsen/logrus v1.4.1 => github.com/sirupsen/logrus v1.4.1

replace github.com/Sirupsen/logrus v1.4.2 => github.com/sirupsen/logrus v1.4.2

// don't use shirou/gopsutil, use the hashicorp fork
replace github.com/shirou/gopsutil => github.com/hashicorp/gopsutil v2.17.13-0.20190117153606-62d5761ddb7d+incompatible

// don't use ugorji/go, use the hashicorp fork
replace github.com/ugorji/go => github.com/hashicorp/go-msgpack v0.0.0-20190927123313-23165f7bc3c2

// fix the version of hashicorp/go-msgpack to 96ddbed8d05b
replace github.com/hashicorp/go-msgpack => github.com/hashicorp/go-msgpack v0.0.0-20191101193846-96ddbed8d05b

replace github.com/NVIDIA/gpu-monitoring-tools => github.com/notnoop/gpu-monitoring-tools v0.0.0-20200628182817-dfd5677e7d74

replace github.com/Microsoft/go-winio => github.com/endocrimes/go-winio v0.4.13-0.20190628114223-fb47a8b41948
