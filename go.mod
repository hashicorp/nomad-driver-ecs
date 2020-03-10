module github.com/hashicorp/nomad-driver-ecs

go 1.14

require (
	github.com/LK4D4/joincontext v0.0.0-20171026170139-1724345da6d5 // indirect
	github.com/NVIDIA/gpu-monitoring-tools v0.0.0-20200116003318-021662a21098 // indirect
	github.com/NYTimes/gziphandler v1.1.1 // indirect
	github.com/Sirupsen/logrus v1.4.2 // indirect
	github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d // indirect
	github.com/appc/spec v0.8.11 // indirect
	github.com/aws/aws-sdk-go v1.29.19 // indirect
	github.com/aws/aws-sdk-go-v2 v0.19.0
	github.com/containerd/go-cni v0.0.0-20200107172653-c154a49e2c75 // indirect
	github.com/containernetworking/plugins v0.8.5 // indirect
	github.com/coreos/go-semver v0.3.0 // indirect
	github.com/coreos/pkg v0.0.0-20180928190104-399ea9e2e55f // indirect
	github.com/docker/cli v0.0.0-20200303162255-7d407207c304 // indirect
	github.com/docker/docker v1.13.1 // indirect
	github.com/docker/docker-credential-helpers v0.6.3 // indirect
	github.com/docker/go-metrics v0.0.1 // indirect
	github.com/dustin/go-humanize v1.0.0 // indirect
	github.com/elazarl/go-bindata-assetfs v1.0.0 // indirect
	github.com/fsouza/go-dockerclient v1.6.3 // indirect
	github.com/gorhill/cronexpr v0.0.0-20180427100037-88b0669f7d75 // indirect
	github.com/hashicorp/consul v1.7.1 // indirect
	github.com/hashicorp/consul-template v0.24.1 // indirect
	github.com/hashicorp/consul/api v1.4.0 // indirect
	github.com/hashicorp/go-checkpoint v0.5.0 // indirect
	github.com/hashicorp/go-discover v0.0.0-20200108194735-7698de1390a1 // indirect
	github.com/hashicorp/go-envparse v0.0.0-20190703193109-150b3a2a4611 // indirect
	github.com/hashicorp/go-getter v1.4.1 // indirect
	github.com/hashicorp/go-hclog v0.12.1
	github.com/hashicorp/go-immutable-radix v1.1.0 // indirect
	github.com/hashicorp/go-memdb v1.1.0 // indirect
	github.com/hashicorp/go-plugin v1.1.0 // indirect
	github.com/hashicorp/go-version v1.2.0 // indirect
	github.com/hashicorp/golang-lru v0.5.4 // indirect
	github.com/hashicorp/hcl v1.0.0 // indirect
	github.com/hashicorp/hcl2 v0.0.0-20191002203319-fb75b3253c80 // indirect
	github.com/hashicorp/nomad v0.10.3-0.20200309114918-e0fcd4da9d18
	github.com/hashicorp/nomad/api v0.0.0-20200309175143-994b58533f1f // indirect
	github.com/hashicorp/raft v1.1.2 // indirect
	github.com/hpcloud/tail v1.0.0 // indirect
	github.com/mitchellh/colorstring v0.0.0-20190213212951-d06e56a500db // indirect
	github.com/mitchellh/copystructure v1.0.0 // indirect
	github.com/mitchellh/go-ps v1.0.0 // indirect
	github.com/mitchellh/hashstructure v1.0.0 // indirect
	github.com/moby/moby v1.13.1 // indirect
	github.com/rs/cors v1.7.0 // indirect
	github.com/ryanuber/go-glob v1.0.0 // indirect
	github.com/seccomp/libseccomp-golang v0.9.1 // indirect
	github.com/skratchdot/open-golang v0.0.0-20200116055534-eef842397966 // indirect
	github.com/stretchr/testify v1.4.0
	github.com/syndtr/gocapability v0.0.0-20180916011248-d98352740cb2 // indirect
	github.com/ugorji/go v0.0.0-00010101000000-000000000000 // indirect
	github.com/vbatts/tar-split v0.11.1 // indirect
	github.com/zclconf/go-cty v1.3.1 // indirect
	go4.org v0.0.0-20200104003542-c7e774b10ea0 // indirect
	golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073 // indirect
	golang.org/x/time v0.0.0-20191024005414-555d28b269f0 // indirect
	gopkg.in/fsnotify.v1 v1.4.7 // indirect
	gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7 // indirect
	gopkg.in/tomb.v2 v2.0.0-20161208151619-d5d1b5820637 // indirect
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
