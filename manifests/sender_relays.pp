# private class, do not use directly
# takes care to setup the sender_relays file
class postfix::sender_relays (
  $senders_map_hash,
  $postmap,
  $smtp_sasl_password_maps,
  $sender_dependent_relayhost_maps,
) {

  file { $smtp_sasl_password_maps:
    owner   => 'root',
    group   => $postfix_group,
    mode    => '0640',
    content => template('postfix/passwd_map.erb'),
    notify  => Exec["postmap ${smtp_sasl_password_maps}"],
  }
  file { $sender_dependent_relayhost_maps:
    owner   => 'root',
    group   => $postfix_group,
    mode    => '0640',
    content => template('postfix/sender_relay_map.erb'),
    notify  => Exec["postmap ${sender_dependent_relayhost_maps}"],
  }

  exec { "postmap ${smtp_sasl_password_maps}":
    command     => "${postmap} ${smtp_sasl_password_maps}",
    refreshonly => true,
  }

  exec { "postmap ${sender_dependent_relayhost_maps}":
    command     => "${postmap} ${sender_dependent_relayhost_maps}",
    refreshonly => true,
  }

  Class['postfix::install'] ->
  File[$smtp_sasl_password_maps] ->
  File[$sender_dependent_relayhost_maps]
}
