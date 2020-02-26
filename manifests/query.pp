#
class thanos::query(
  Array $store_apis ,
  Array $prometheus_replicas ,
  String $http_address = $thanos::http_address,
  String $grpc_address = $thanos::grpc_address,
  String $daemon_name = 'thanos-query',
) inherits thanos
{
  include stdlib

  $store_processed = $store_apis.map |$tempvar| { " --store=${tempvar}"}

  $replica_processed = $prometheus_replicas.map |$tempvar| { " --query.replica-label=${tempvar}" }

  $output = concat([" --http-address=${http_address} --grpc-address=${grpc_address}"] , $store_processed , $replica_processed)

  thanos::daemon{ $daemon_name :
    options          => join($output,''),
    daemon_user      => 'root',
    daemon_name      => $daemon_name,
    thanos_component => 'query',
  }
}
