# private class, do not use directly
# takes care to setup the sender_canonical file
# senders_canonical_hash should look like the following in Hiera:
# postfix::senders_canonical_hash:
#   just_a_name:
#     regex_match: '/a regular expression/'
#     rewrite_to: 'some address to rewrite to'
class postfix::sender_canonicals (
  $senders_canonical_hash,
  $postmap,
  $sender_canonical_maps,
  $mail_group,
) {

  file { $sender_canonical_maps:
    owner   => 'root',
    group   => $mail_group,
    mode    => '0640',
    content => template('postfix/sender_canonical.erb'),
    notify  => Exec["postmap ${sender_canonical_maps}"],
  }

  exec { "postmap ${sender_canonical_maps}":
    command     => "${postmap} ${sender_canonical_maps}",
    refreshonly => true,
  }

  Class['postfix::install'] ->
  File[$sender_canonical_maps]
}
