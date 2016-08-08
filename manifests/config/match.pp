#
define carbon_c_relay::config::match (
  $clusters     = 'blackhole',
  $comments     = undef,
  $expressions  = $title,
  $order        = undef,
  $stop         = false
){

  concat::fragment { "match-${title}":
    target  => $carbon_c_relay::config_file,
    content => template('carbon_c_relay/config/match.erb'),
    order   => $order
  }
}
