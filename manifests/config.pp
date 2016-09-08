# This class takes care to manage entries
# in the postfix configuration files, currently
# main.cf. On Suse, files in /etc/sysconfig
# are managed too
class postfix::config (
  $alias_map,
  $newaliases,
  $postmap,
  $maps,
  $main_cf,
  $master_cf,
  $sysconfig_mail,
  $sysconfig_postfix,
  $mail_config_type,
  $myhostname,
  $relayhost,
  $myorigin,
  $mydestination,
  $mydomain,
  $smtpd_sasl_auth_enable,
  $smtpd_sasl_path,
  $smtpd_sasl_local_domain,
  $smtpd_sasl_security_options,
  $smtp_sasl_auth_enable,
  $smtp_sasl_password_maps,
  $smtp_sasl_security_options,
  $smtp_sasl_tls_security_options,
  $sender_dependent_relayhost_maps,
  $relay_to_amavis,
  $amavis_dst_host,
  $amavis_dst_port,
  $amavis_listen_port,
  $amavis_listen_host,
  $enable_submission,
  $submission_flags,
  $smtpd_tls_auth_only,
  $smtpd_tls_capath,
  $smtpd_tls_cert_file,
  $smtpd_tls_key_file,
  $smtpd_use_tls,
  $smtp_use_tls,
  $smtpd_tls_received_header,
  $smtp_tls_note_starttls_offer,
  $inet_protocols,
  $mailbox_transport,
  $chroot_lmtp,
  $mail_owner,
  $setgid_group,
) {
  if $sysconfig_mail {
    ini_setting { 'configtype_sysconfig_mail':
      ensure            => present,
      path              => $sysconfig_mail,
      section           => '',
      key_val_separator => '=',
      setting           => 'CONFIG_TYPE',
      value             => "\"${mail_config_type}\"",
    }
  }

  if $sysconfig_postfix {
    ini_setting { 'relayhost_sysconfig_postfix':
      ensure            => present,
      path              => $sysconfig_postfix,
      section           => '',
      key_val_separator => '=',
      setting           => 'POSTFIX_RELAYHOST',
      value             => "\"${relayhost}\"",
    }
  }

  file { $master_cf:
    owner => 'root',
    group => '0',
    mode  => '0644',
    content => template('postfix/master.cf.erb')
  }

  file_line { 'relayhost_main_cf':
    path  => $main_cf,
    line  => "relayhost = $relayhost",
    match => '^relayhost =\s',
  }
  ini_setting { 'mailbox_transport_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'mailbox_transport',
    value             => $mailbox_transport,
  }
  ini_setting { 'inet_protocols_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'inet_protocols',
    value             => $inet_protocols,
  }
  ini_setting { 'mail_owner_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'mail_owner',
    value             => $mail_owner,
  }
  ini_setting { 'setgid_group_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'setgid_group',
    value             => $setgid_group,
  }
  ini_setting { 'smtp_tls_note_starttls_offer_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtp_tls_note_starttls_offer',
    value             => $smtp_tls_note_starttls_offer,
  }
  ini_setting { 'smtpd_tls_received_header_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_tls_received_header',
    value             => $smtpd_tls_received_header,
  }
  ini_setting { 'smtp_use_tls_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtp_use_tls',
    value             => $smtp_use_tls,
  }
  ini_setting { 'smtpd_use_tls_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_use_tls',
    value             => $smtpd_use_tls,
  }
  ini_setting { 'smtpd_tls_key_file_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_tls_key_file',
    value             => $smtpd_tls_key_file,
  }
  ini_setting { 'smtpd_tls_cert_file_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_tls_cert_file',
    value             => $smtpd_tls_cert_file,
  }
  ini_setting { 'smtpd_tls_capath_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_tls_CApath',
    value             => $smtpd_tls_capath,
  }
  ini_setting { 'smtpd_tls_auth_only_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_tls_auth_only',
    value             => $smtpd_tls_auth_only,
  }
  ini_setting { 'myorigin_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'myorigin',
    value             => $myorigin,
  }
  ini_setting { 'sender_dependent_relayhost_maps_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'sender_dependent_relayhost_maps',
    value             => "hash:${sender_dependent_relayhost_maps}",
  }
  ini_setting { 'smtp_sasl_tls_security_options_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtp_sasl_tls_security_options',
    value             => $smtp_sasl_tls_security_options,
  }
  ini_setting { 'smtp_sasl_security_options_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtp_sasl_security_options',
    value             => $smtp_sasl_security_options,
  }
  ini_setting { 'smtp_sasl_password_maps_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtp_sasl_password_maps',
    value             => "hash:${smtp_sasl_password_maps}",
  }
  ini_setting { 'smtp_sasl_auth_enable_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtp_sasl_auth_enable',
    value             => $smtp_sasl_auth_enable,
  }
  ini_setting { 'smtpd_sasl_security_options_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_sasl_security_options',
    value             => $smtpd_sasl_security_options,
  }
  ini_setting { 'smtpd_sasl_local_domain_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_sasl_local_domain',
    value             => $smtpd_sasl_local_domain,
  }
  ini_setting { 'smtpd_sasl_path_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_sasl_path',
    value             => $smtpd_sasl_path,
  }
  ini_setting { 'smtpd_sasl_auth_enable_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'smtpd_sasl_auth_enable',
    value             => $smtpd_sasl_auth_enable,
  }
  ini_setting { 'mydestination_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'mydestination',
    value             => $mydestination,
  }
  ini_setting { 'mydomain_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'mydomain',
    value             => $mydomain,
  }
  ini_setting { 'myhostname_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'myhostname',
    value             => $myhostname,
  }
  ini_setting { 'alias_maps_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'alias_maps',
    value             => "hash:${alias_map}",
  }
  ini_setting { 'newaliases_path_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'newaliases_path',
    value             => $newaliases,
  }
}
