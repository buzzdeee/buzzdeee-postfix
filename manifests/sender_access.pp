# private class, do not use directly
# takes care to setup the sender_access regexp file
# sender_access_regex should look like the following in Hiera:
# postfix::sender_access_regex:
#   just_a_name:
#     regex_match: '/a regular expression/'
#     action: 'some action, i.e. REJECT'
class postfix::sender_access (
  $sender_access_regex,
  $sender_access_file,
  $mail_group,
) {

  file { $sender_access_file:
    owner   => 'root',
    group   => $mail_group,
    mode    => '0640',
    content => template('postfix/sender_access.erb'),
  }

  Class['postfix::install'] ->
  File[$sender_access_file]
}
