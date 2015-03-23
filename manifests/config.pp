class postfix::config (
  $dmesgscript,
  $maps,
) {
  file { '/etc/postfix/main.cf':
    ensure  => 'present',
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => hiera('main.cf.erb')
  }
  file { '/etc/postfix/master.cf':
    ensure  => 'present',
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => hiera('master.cf.erb')
  }

  $aliases = hiera_hash('mailaliases')
  $aliasdefaults = hiera_hash('mailaliases::defaults')
  create_resources(mailalias, $aliases, $aliasdefaults)

  exec { "newaliases ${aliasdefaults['target']}":
    command     => "/usr/local/sbin/newaliases",
    refreshonly => true,
  }

  each ($maps) |$map| {
    file { "/etc/postfix/${map}":
      ensure  => 'present',
      owner   => 'root',
      group   => '0',
      mode    => '0644',
      content => hiera($map),
      notify  => Exec["postmap ${map}"],
    }
    exec { "postmap ${map}":
      command     => "/usr/local/sbin/postmap /etc/postfix/${map}",
      refreshonly => true,
    }
  }

}
