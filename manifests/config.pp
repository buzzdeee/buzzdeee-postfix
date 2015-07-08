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

  ini_setting { 'relayhost_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'relayhost',
    value             => $relayhost,
  }
  ini_setting { 'myhostname_main_cf':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'myhostname',
    value             => $myhostname,
  }
  ini_setting { 'myhostname_alias_maps':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'alias_maps',
    value             => "hash:${alias_map}",
  }
  ini_setting { 'myhostname_newaliases_path':
    ensure            => present,
    path              => $main_cf,
    section           => '',
    key_val_separator => ' = ',
    setting           => 'newaliases_path',
    value             => $newaliases,
  }
}
