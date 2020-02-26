# Thanos-puppet module
Small and simple module for deployment of Thanos

In current version thanos is installed using a .deb package, in the future it will have option of downloading straight from official Thanos git repo.

## Compatibility

|  Puppet version | Thanos Version|
|---|---|
| 5 + | any |

Architectures:
- x86_64/amd64

Operating Systems (init systems):
- Ubuntu (systemd)

## Deployment

The style the module is written is to minimise clutter in manifests by simply defining component by one line:

`  include thanos::$component `

Currently all components need these values defined:

`
  $s3bucket, $s3endpoint, $s3access_key, $s3secret_key 
`

For Query component you have to specify all store apis and prometheus replicas via:

`
    $query::store_apis , $query::prometheus_replicas
`

ToDo list:

- Installation straight from binary
- Support more OSes
- Ruler deployment
- Other storage backends