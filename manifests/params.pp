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
  $senders_map_hash = {}
  $main_cf = '/etc/postfix/main.cf'
  $master_cf = '/etc/postfix/master.cf'
  $package_ensure = 'installed'
  $package_name = 'postfix'
  $package_flavor = undef
  $service_ensure = 'running'
  $service_enable = true
  $service_flags = undef
  $service_name = 'postfix'
  $smtpd_sasl_auth_enable = 'no'
  $smtpd_sasl_path = 'smtpd'
  $smtpd_sasl_local_domain = '$mydomain'
  $smtpd_sasl_security_options = 'noanonymous'
  $smtp_sasl_auth_enable = 'no'
  $smtp_sasl_password_maps = '/etc/postfix/sasl_passwd'
  $smtp_sasl_security_options = 'noplaintext noanonymous'
  $smtp_sasl_tls_security_options = 'noanonymous'
  $sender_dependent_relayhost_maps = '/etc/postfix/sender_relay'
  $relay_to_amavis = false
  $amavis_dst_host = 'localhost'
  $amavis_dst_port = '10024'
  $amavis_listen_port = '10025'
  $amavis_listen_host = 'localhost'
  $enable_submission = false
  $submission_flags = 'smtpd_recipient_restrictions=permit_sasl_authenticated,reject_unauth_destination'
  $smtpd_tls_auth_only = 'no'
  $smtpd_tls_capath = '/etc/postfix/ssl/CA'
  $smtpd_tls_cert_file = "/etc/postfix/ssl/${::fqdn}.pem"
  $smtpd_tls_key_file = "/etc/postfix/ssl/${::fqdn}.key"
  $smtpd_use_tls = 'no'
  $smtp_use_tls = 'no'
  $smtpd_tls_received_header = 'no'
  $smtp_tls_note_starttls_offer = 'no'
  $inet_protocols = 'ipv4'
  $mailbox_transport = undef

  $chroot_lmtp = true
}
