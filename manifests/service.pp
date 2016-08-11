# == Class carbon_c_relay::service
#
class carbon_c_relay::service (
  $config_file      = $carbon_c_relay::config_file,
  $group            = $carbon_c_relay::group,
  $limit_as         = $carbon_c_relay::limit_as,
  $limit_cpu        = $carbon_c_relay::limit_cpu,
  $limit_fsize      = $carbon_c_relay::limit_fsize,
  $limit_nofile     = $carbon_c_relay::limit_nofile,
  $limit_nproc      = $carbon_c_relay::limit_nproc,
  $limits_file      = $carbon_c_relay::limits_file,
  $limits_template  = $carbon_c_relay::limits_template,
  $log_dir          = $carbon_c_relay::log_dir,
  $pid_dir          = $carbon_c_relay::pid_dir,
  $pid_file         = $carbon_c_relay::pid_file,
  $service_enable   = $carbon_c_relay::service_enable,
  $service_ensure   = $carbon_c_relay::service_ensure,
  $service_file     = $carbon_c_relay::service_file,
  $service_manage   = $carbon_c_relay::service_manage,
  $service_name     = $carbon_c_relay::service_name,
  $service_template = $carbon_c_relay::service_template,
  $user             = $carbon_c_relay::user,
) {

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    file { $pid_dir:
      ensure => directory,
      group  => $group,
      mode   => '0644',
      owner  => $user,
    }

    file { $log_dir:
      ensure => directory,
      group  => $group,
      mode   => '0644',
      owner  => $user,
    }

    File[$log_dir] ~> Service[$service_name]

    case $::operatingsystemmajrelease {
      '6': {
        file { $limits_file:
          ensure  => file,
          group   => 'root',
          mode    => '0644',
          owner   => 'root',
          content => template($limits_template),
        }

        file { $service_file:
          ensure  => file,
          group   => 'root',
          mode    => '0755',
          owner   => 'root',
          content => template($service_template),
        }
        service { $service_name:
          ensure   => $service_ensure,
          enable   => $service_enable,
        }
      }

      '7': {
        file { $service_file:
          ensure  => file,
          group   => 'root',
          mode    => '0644',
          owner   => 'root',
          content => template($service_template),
        }
        exec { 'daemon-reload':
          command     => '/bin/systemctl daemon-reload',
          subscribe   => File[$carbon_c_relay::service_file],
          refreshonly => true,
          user        => 'root'
        } ~>

        service { $service_name:
          ensure   => $service_ensure,
          enable   => $service_enable,
        }
      }
    }
  }
}
