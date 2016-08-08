# == Class: carbon_c_relay::params
#
class carbon_c_relay::params {
  $allowed_chars               = undef
  $config_clusters             = {}
  $config_file                 = '/etc/carbon-c-relay.conf'
  $config_matches              = {}
  $config_rewrites             = {}
  $group                       = 'carbon-c-relay'
  $interface                   = undef
  $io_timeout                  = 600
  $limit_as                    = undef
  $limit_cpu                   = undef
  $limit_fsize                 = undef
  $limit_nofile                = 64000
  $limit_nproc                 = 64000
  $limits_file                 = '/etc/security/limits.d/carbon-c-relay.conf'
  $limits_template             = "carbon_c_relay${limits_file}.erb"
  $listen                      = 2003
  $listen_backlog              = 32
  $log_dir                     = '/var/log/carbon-c-relay'
  $log_file                    = 'carbon-c-relay.log'
  $max_stalls                  = 4
  $package_ensure              = latest
  $package_manage              = true
  $package_name                = 'carbon-c-relay'
  $pid_dir                     = '/var/run/carbon-c-relay'
  $pid_file                    = 'carbon-c-relay.pid'
  $server_batch_size           = 2500
  $server_queue_size           = 25000
  $service_enable              = true
  $service_ensure              = running
  $service_file                = $::operatingsystemmajrelease ? {
    '6' => '/etc/init.d/carbon-c-relay',
    '7' => '/usr/lib/systemd/system/carbon-c-relay.service',
  }
  $service_manage              = true
  $service_name                = $package_name
  $service_template            = "carbon_c_relay${service_file}.erb"
  $sorted_matches              = false
  $sorted_rewrites             = false
  $statistics_hostname         = undef
  $statistics_non_cumulative   = false
  $statistics_sending_interval = 60
  $sysconfig_file              = '/etc/sysconfig/carbon-c-relay'
  $sysconfig_template          = "carbon_c_relay${sysconfig_file}.erb"
  $user                        = 'carbon-c-relay'
  $worker_threads              = undef
}
