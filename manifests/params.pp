# private class, do not use directly.
# the parameters, that steer this module
class postfix::params {
  case $::osfamily {
    'OpenBSD': {
      $alias_map = '/etc/mail/aliases'
      $activate_postfix = true
      $postmap = '/usr/local/sbin/postmap'
      $newaliases = '/usr/local/sbin/newaliases'
      $sysconfig_mail = undef
      $sysconfig_postfix = undef
      $mail_config_type = undef
    }
    'Suse': {
      case $::operatingsystem {
        'SLES': {
          $sysconfig_mail = undef
        }
        'OpenSuSE': {
          $sysconfig_mail = '/etc/sysconfig/mail'
        }
        default: {
          fail("Unsupported platform: buzzdeee-${module_name} currently doesn't support ${::osfamily}/${::operatingsystem}")
        }
      }
      $alias_map = '/etc/aliases'
      $activate_postfix = false
      $postmap = '/usr/sbin/postmap'
      $newaliases = '/usr/bin/newaliases'
      $sysconfig_postfix = '/etc/sysconfig/postfix'
      $mail_config_type = 'standard'
    }
    default: {
      fail("Unsupported platform: buzzdeee-${module_name} currently doesn't support ${::osfamily}")
    }
  }

  # $aliases is a hash {target => "recipients"}
  $aliases = undef
  $myhostname = $::fqdn
  $relayhost = undef
  $mydomain = undef
  $mydestination = undef
  $myorigin = $::fqdn
  $maps = []
  $main_cf = '/etc/postfix/main.cf'
  $package_ensure = 'installed'
  $package_name = 'postfix'
  $package_flavor = undef
  $service_ensure = 'running'
  $service_enable = true
  $service_flags = undef
  $service_name = 'postfix'
}
