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
