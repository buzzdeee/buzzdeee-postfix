# On OpenBSD, if using Postfix, it must be enabled
# or disabled. This is what this class takes care of
class postfix::enable (
  $service_enable,
) {
  if $service_enable {
    Exec { 'enable postfix':
      command => '/usr/local/sbin/postfix-enable',
      creates => '/etc/mailer.conf.pre-postfix',
    }
    service { 'smtpd':
      ensure => 'stopped',
      enable => false,
    }
  } else {
    Exec { 'disable postfix':
      command => '/usr/local/sbin/postfix-disable',
      creates => '/etc/mailer.conf.postfix',
    }
    service { 'smtpd':
      ensure => 'running',
      enable => true,
    }
  }
}
