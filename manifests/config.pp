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

  file_line { 'relayhost_main_cf':
    path  => $main_cf,
    line  => "relayhost = $relayhost",
    match => '^relayhost =\s',
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
