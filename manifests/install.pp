# == Class: carbon_c_relay::install
#
class carbon_c_relay::install (
  $group          = $carbon_c_relay::group,
  $package_ensure = $carbon_c_relay::package_ensure,
  $package_manage = $carbon_c_relay::package_manage,
  $package_name   = $carbon_c_relay::package_name,
  $user           = $carbon_c_relay::user,
) {

  if $package_manage {

    group { $group:
      ensure => present
    } ->
    user { $user:
      ensure => present,
      groups => $group,
    }

    package { $package_name:
      ensure => $package_ensure
    }
  }
}
