# == Class carbon_c_relay::config
#
class carbon_c_relay::config (
  $allowed_chars               = $carbon_c_relay::allowed_chars,
  $config_file                 = $carbon_c_relay::config_file,
  $group                       = $carbon_c_relay::group,
  $interface                   = $carbon_c_relay::interface,
  $io_timeout                  = $carbon_c_relay::io_timeout,
  $limit_fsize                 = $carbon_c_relay::limit_fsize,
  $limit_cpu                   = $carbon_c_relay::limit_cpu,
  $limit_as                    = $carbon_c_relay::limit_as,
  $limit_nofile                = $carbon_c_relay::limit_nofile,
  $limit_nproc                 = $carbon_c_relay::limit_nproc,
  $listen                      = $carbon_c_relay::listen,
  $listen_backlog              = $carbon_c_relay::listen_backlog,
  $log_dir                     = $carbon_c_relay::log_dir,
  $log_file                    = $carbon_c_relay::log_file,
  $max_stalls                  = $carbon_c_relay::max_stalls,
  $package_name                = $carbon_c_relay::package_name,
  $server_batch_size           = $carbon_c_relay::server_batch_size,
  $server_queue_size           = $carbon_c_relay::server_queue_size,
  $service_name                = $carbon_c_relay::service_name,
  $sorted_matches              = $carbon_c_relay::sorted_matches,
  $sorted_rewrites             = $carbon_c_relay::sorted_rewrites,
  $statistics_hostname         = $carbon_c_relay::statistics_hostname,
  $statistics_non_cumulative   = $carbon_c_relay::statistics_non_cumulative,
  $statistics_sending_interval = $carbon_c_relay::statistics_sending_interval,
  $sysconfig_file              = $carbon_c_relay::sysconfig_file,
  $sysconfig_template          = $carbon_c_relay::sysconfig_template,
  $user                        = $carbon_c_relay::user,
  $worker_threads              = $carbon_c_relay::worker_threads,
) {

  file { $sysconfig_file:
    ensure  => file,
    content => template($sysconfig_template),
    notify  => Service[$service_name]
  }

  concat { $config_file:
    warn   => true,
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0644',
    notify => Service[$service_name]
  }

  ### Count the number of clusters and match rules for giving a proper order
  ### to matches and rewrites.
  $nr_of_clusters = count(keys($carbon_c_relay::config_clusters))
  $nr_of_matches  = count(keys($carbon_c_relay::config_matches))

  create_resources( 'carbon_c_relay::config::cluster', $carbon_c_relay::config_clusters )

  ### Sort match rules
  if $sorted_matches {
    $matches = carbon_c_relay_sorted( $carbon_c_relay::config_matches,
                  $nr_of_clusters + 1 )
  } else {
    $matches = $carbon_c_relay::config_matches
  }

  create_resources( 'carbon_c_relay::config::match', $matches )

  ### Sort rewrite rules
  if $sorted_rewrites {
    $rewrites = carbon_c_relay_sorted( $carbon_c_relay::config_rewrites,
                  $nr_of_clusters + $nr_of_matches + 1 )
  } else {
    $rewrites = $carbon_c_relay::config_rewrites
    $rewrite_defaults = { order => $nr_of_clusters + $nr_of_matches + 1 }
  }

  create_resources('carbon_c_relay::config::rewrite', $rewrites, $rewrite_defaults)

  Carbon_c_relay::Config::Cluster<| |> ->
  Carbon_c_relay::Config::Match<| |> ->
  Carbon_c_relay::Config::Rewrite<| |>

}
