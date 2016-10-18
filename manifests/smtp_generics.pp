# private class, do not use directly
# takes care to setup the generic_maps file
# smtp_generic_map_hash should look like the following in Hiera:
# postfix::smtp_generic_map_hash:
#   just_a_name:
#     regex_match: '/a regular expression/'
#     rewrite_to: 'some address to rewrite to'
class postfix::smtp_generics (
  $smtp_generic_map_hash,
  $postmap,
  $smtp_generic_maps,
  $mail_group,
) {

  file { $smtp_generic_maps:
    owner   => 'root',
    group   => $mail_group,
    mode    => '0640',
    content => template('postfix/generic_map.erb'),
    notify  => Exec["postmap ${smtp_generic_maps}"],
  }

  exec { "postmap ${smtp_generic_maps}":
    command     => "${postmap} ${smtp_generic_maps}",
    refreshonly => true,
  }

  Class['postfix::install'] ->
  File[$smtp_generic_maps]
}
