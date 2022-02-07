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
      $mail_owner = '_postfix'
      $mail_group = '_postfix'
      $setgid_group = '_postdrop'
      $daemon_directory = '/usr/local/libexec/postfix'
      $command_directory = '/usr/local/sbin'
      $compatibility_level = '2'
      $run_chrooted = true
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
      $mail_owner = 'postfix'
      $mail_group = 'postfix'
      $setgid_group = 'maildrop'
      $daemon_directory = '/usr/lib/postfix'
      $command_directory = '/usr/sbin'
      $compatibility_level = undef
      $run_chrooted = false
    }
    'Debian': {
      case $::operatingsystem {
        'Ubuntu': {
          $sysconfig_mail = undef
          $alias_map = '/etc/aliases'
          $activate_postfix = false
          $postmap = '/usr/sbin/postmap'
          $newaliases = '/usr/bin/newaliases'
          $sysconfig_postfix = undef
          $mail_config_type = undef
          $mail_owner = 'postfix'
          $mail_group = 'postfix'
          $setgid_group = 'postdrop'
          case $::operatingsystemmajrelease {
            '14.04': {
              $daemon_directory = '/usr/lib/postfix'
            }
            default: {
              $daemon_directory = '/usr/lib/postfix/sbin'
            }
          }
          $command_directory = '/usr/sbin'
          $run_chrooted = true
        }
        default: {
          fail("Unsupported platform: buzzdeee-${module_name} currently doesn't support ${::osfamily}/${::operatingsystem}")
        }
      }
    }
    default: {
      fail("Unsupported platform: buzzdeee-${module_name} currently doesn't support ${::osfamily}")
    }
  }

  # $aliases is a hash {target => "recipients"}
  $aliases = undef
  $disable_vrfy_command = 'yes'
  $myhostname = $::fqdn
  $relayhost = undef
  $mydomain = undef
  $mydestination = undef
  $myorigin = $::fqdn
  $main_cf = '/etc/postfix/main.cf'
  $master_cf = '/etc/postfix/master.cf'
  $package_ensure = 'installed'
  $package_name = 'postfix'
  $package_flavor = undef
  $service_ensure = 'running'
  $service_enable = true
  $service_flags = undef
  $service_name = 'postfix'
  $smtpd_helo_required = 'yes'
  $smtpd_helo_restrictions = 'reject_unknown_helo_hostname'
  $smtpd_sender_restrictions = 'reject_unknown_sender_domain'
  $smtpd_sasl_auth_enable = 'no'
  $smtpd_sasl_path = 'smtpd'
  $smtpd_sasl_local_domain = '$mydomain'
  $smtpd_sasl_security_options = 'noanonymous'
  $smtp_sasl_auth_enable = 'no'
  $smtp_sasl_security_options = 'noplaintext noanonymous'
  $smtp_sasl_tls_security_options = 'noanonymous'
  $relay_to_amavis = false
  $amavis_dst_host = 'localhost'
  $amavis_dst_port = '10024'
  $amavis_listen_port = '10025'
  $amavis_listen_host = 'localhost'
  $enable_submission = false
  $submission_flags = 'smtpd_recipient_restrictions=permit_sasl_authenticated,reject_unauth_destination'
  $smtpd_data_restrictions = 'reject_unauth_pipelining, reject_multi_recipient_bounce, permit'
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
  $message_size_limit = '10240000'
  $mailbox_size_limit = '50240000'
}
