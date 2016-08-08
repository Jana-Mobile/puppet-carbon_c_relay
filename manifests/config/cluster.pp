#
define carbon_c_relay::config::cluster (
  $cluster_name       = $title,
  $comments           = [],
  $destinations       = undef,
  $replication_factor = 1,
  $channel            = 'carbon_ch',
  $useall             = false,
){

  validate_string($cluster_name)
  validate_array($comments)
  validate_array($destinations)
  validate_integer($replication_factor)

  if ! ($channel in ['forward', 'any_of', 'failover', 'carbon_ch', 'fnv1a_ch', 'file']) {
    fail("channel '${channel}' is not in ['forward', 'any_of', 'failover', 'carbon_ch', 'fnv1a_ch', 'file']")
  }

  validate_bool($useall)

  concat::fragment { "cluster-${title}":
    target  => $carbon_c_relay::config_file,
    content => template('carbon_c_relay/config/cluster.erb'),
    order   => '02',
  }
}
