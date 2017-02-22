# == Class: carbon_c_relay
#
# Installs, configures and manages carbon-c-relay service.
# Carbon-c-relay is an enhanced C implementation of Carbon relay, aggregator
# and rewriter.
#
# === Parameters
#
# [*allowed_chars*]
#   Specifies the allowed chars next to [A-Za-z0-9]
#   Default: [-_:#]
#
# [*config_clusters*]
#   Specifies what clusters are added to the config file
#
# [*config_file*]
#   Specifies where carbon-c-relay reads it's config settings.
#
# [*config_matches*]
#   Specifies what match rules are added to the config file
#
# [*config_rewrites*]
#   Specifies what rewrite rules are added to the config file
#
# [*io_timeout*]
#   Specifies IO timeout in milliseconds for server connections
#   Default: 600
#
# [*interface*]
#   Specify on which interface carbon-c-relay should listen
#   Default: all

# [*limits_file*]
#   Specifies name of security limits file
#   Default: /etc/security/limits.d/carbon_c_relay.conf
#
# [*listen_backlog*]
#   Specify connection listen backlog
#   Default: 3 for < v2.2 and  32 for v2.2
#
# [*listen*]
#   Specify on which port carbon-c-relay should listen.
#   Default: 2003
#
# [*max_stalls*]
#   Specify server max stalls
#   Default: 4
#
# [*ouput_file*]
#   Specify to which file carbon-c-relay should redirect its output
#
# [*package_ensure*]
#   Specifies what state the package should be in.
#   Valid values: present, installed, absent, purged, held, latest.
#   Default: present
#
# [*package_manage*]
#   Specify if the package should be managed by this module.
#   Default: true
#
# [*package_name*]
#   Specify the name this package.
#   Default: carbon-c-relay
#
# [*pid_dir*]
#   Specifies directory where the pid file is written.
#   Default: /var/run/carbon-c-relay
#
# [*pid_file*]
#   Specifies name of pid file
#   Default: carbon-c-relay.
#
# [*server_batch_size*]
#   Specifies server send batch size
#   Default: 2500
#
# [*server_queue_size*]
#   Specifies server queue size
#   Default: 25000
#
# [*service_enable*]
#   Specify if the service should be enabled to start at boot.
#   Valid values: true, false, manual, mask.
#   Default: true
#
# [*service_ensure*]
#   Specify if the service should be running.
#   Valid values: stopped, running.
#   Default: running
#
# [*service_manage*]
#   Specify if the service should be managed by this module.
#   Default: true
#
# [*service_name*]
#   Specifies the name of the service to run
#   Default: carbon-c-relay
#
# [*sorted_matches*]
#   Indicates whether match rules in conf should be sorted
#   Default: true
#
# [*sorted_rewrites*]
#   Indicates whether rewrite rules in conf should be sorted
#   Default: false
#
# [*statistics_hostname*]
#   Specify to override hostname used in statistics
#
# [*statistics_non_cumulative*]
#   Specifies to send statistics like carbon-cache.py, e.g. not cumulative
#   Default: false
#
# [*statistics_sending_interval*]
#   Specify the number of seconds between sending data
#   Default: 60
#
# [*worker_threads*]
#   Specify to use <workers> worker threads
#   Default: # of cores
#
# === Examples
#
# * Installation, make sure service is running and will be started at boot time:
#  class { 'carbon_c_relay': }
#
# === Authors
#
# Marc Lambrichs <marc.lambrichs@gmail.com>
#
class carbon_c_relay (
  $allowed_chars               = $carbon_c_relay::params::allowed_chars,
  $config_clusters             = $carbon_c_relay::params::config_clusters,
  $config_file                 = $carbon_c_relay::params::config_file,
  $config_matches              = $carbon_c_relay::params::config_matches,
  $config_rewrites             = $carbon_c_relay::params::config_rewrites,
  $group                       = $carbon_c_relay::params::group,
  $io_timeout                  = $carbon_c_relay::params::io_timeout,
  $interface                   = $carbon_c_relay::params::interface,
  $limit_fsize                 = $carbon_c_relay::params::limit_fsize,
  $limit_cpu                   = $carbon_c_relay::params::limit_cpu,
  $limit_as                    = $carbon_c_relay::params::limit_as,
  $limit_nofile                = $carbon_c_relay::params::limit_nofile,
  $limit_nproc                 = $carbon_c_relay::params::limit_nproc,
  $limits_file                 = $carbon_c_relay::params::limits_file,
  $limits_template             = $carbon_c_relay::params::limits_template,
  $listen                      = $carbon_c_relay::params::listen,
  $listen_backlog              = $carbon_c_relay::params::listen_backlog,
  $log_dir                     = $carbon_c_relay::params::log_dir,
  $log_file                    = $carbon_c_relay::params::log_file,
  $max_stalls                  = $carbon_c_relay::params::max_stalls,
  $package_ensure              = $carbon_c_relay::params::package_ensure,
  $package_manage              = $carbon_c_relay::params::package_manage,
  $package_name                = $carbon_c_relay::params::package_name,
  $pid_dir                     = $carbon_c_relay::params::pid_dir,
  $pid_file                    = $carbon_c_relay::params::pid_file,
  $server_batch_size           = $carbon_c_relay::params::server_batch_size,
  $server_queue_size           = $carbon_c_relay::params::server_queue_size,
  $service_enable              = $carbon_c_relay::params::service_enable,
  $service_ensure              = $carbon_c_relay::params::service_ensure,
  $service_file                = $carbon_c_relay::params::service_file,
  $service_manage              = $carbon_c_relay::params::service_manage,
  $service_name                = $carbon_c_relay::params::service_name,
  $service_template            = $carbon_c_relay::params::service_template,
  $statistics_hostname         = $carbon_c_relay::params::statistics_hostname,
  $statistics_non_cumulative   = $carbon_c_relay::params::statistics_non_cumulative,
  $statistics_sending_interval = $carbon_c_relay::params::statistics_sending_interval,
  $sorted_matches              = $carbon_c_relay::params::sorted_matches,
  $sorted_rewrites             = $carbon_c_relay::params::sorted_rewrites,
  $sysconfig_file              = $carbon_c_relay::params::sysconfig_file,
  $sysconfig_template          = $carbon_c_relay::params::sysconfig_template,
  $user                        = $carbon_c_relay::params::user,
  $worker_threads              = $carbon_c_relay::params::worker_threads
) inherits carbon_c_relay::params {

  validate_bool(
    $package_manage,
    $service_enable,
    $service_manage,
    $sorted_matches,
    $sorted_rewrites,
    $statistics_non_cumulative,
  )

  validate_hash(
    $config_clusters,
    $config_rewrites,
  )

  validate_integer([
    $io_timeout,
    $limit_nofile,
    $limit_nproc,
    $listen,
    $listen_backlog,
    $max_stalls,
    $server_batch_size,
    $server_queue_size,
    $statistics_sending_interval,
  ])

  validate_string(
    $allowed_chars,
    $config_file,
    $group,
    $limits_file,
    $limits_template,
    $log_dir,
    $log_file,
    $package_ensure,
    $package_name,
    $pid_dir,
    $pid_file,
    $service_ensure,
    $service_name,
    $sysconfig_file,
    $sysconfig_template,
    $user,
  )

  anchor { 'carbon_c_relay::begin': } ->
  class { '::carbon_c_relay::install': } ->
  class { '::carbon_c_relay::config': } ~>
  class { '::carbon_c_relay::service': } ->
  anchor { 'carbon_c_relay::end': }
}
