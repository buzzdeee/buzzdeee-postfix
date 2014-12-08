class postfix::params {
  $package_name = 'postfix'
  $package_ensure = 'installed'
  $package_flavor = undef
  $service_ensure = 'running'
  $service_enable = true
  $service_flags = undef
  $service_name = 'postfix'
  $postmap = '/usr/local/sbin/postmap'
  $newaliases = '/usr/local/sbin/newaliases'
  $maps = []
}
