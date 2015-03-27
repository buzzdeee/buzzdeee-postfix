# == Class: postfix
#
# Full description of class postfix here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'postfix':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <sebastia@l00-bugdead-prods.de>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class postfix (
  $package_ensure    = $postfix::params::package_ensure,
  $package_name      = $postfix::params::package_name,
  $package_flavor    = $postfix::params::package_flavor,
  $activate_postfix  = $postfix::params::activate_postfix,
  $service_ensure    = $postfix::params::service_ensure,
  $service_enable    = $postfix::params::service_enable,
  $service_name      = $postfix::params::service_name,
  $service_flags     = $postfix::params::service_flags,
  $postmap           = $postfix::params::postmap,
  $aliases           = $postfix::params::aliases,
  $alias_map         = $postfix::params::alias_map,
  $newaliases        = $postfix::params::newaliases,
  $maps              = $postfix::params::maps,
  $main_cf           = $postfix::params::main_cf,
  $sysconfig_mail    = $postfix::params::sysconfig_mail,
  $sysconfig_postfix = $postfix::params::sysconfig_postfix,
  $mail_config_type  = $postfix::params::mail_config_type,
  $myhostname        = $postfix::params::myhostname,
  $relayhost         = $postfix::params::relayhost,
) inherits postfix::params {

  class { 'postfix::install':
    package_ensure => $package_ensure,
    package_name   => $package_name,
    package_flavor => $package_flavor,
  }

  class { 'postfix::config':
    alias_map         => $alias_map,
    newaliases        => $newaliases,
    postmap           => $postmap,
    maps              => $maps,
    main_cf           => $main_cf,
    sysconfig_mail    => $sysconfig_mail,
    sysconfig_postfix => $sysconfig_postfix,
    mail_config_type  => $mail_config_type,
    myhostname        => $myhostname,
    relayhost         => $relayhost,
  }

  if $activate_postfix {
    class { 'postfix::enable':
      service_enable => $service_enable,
      require        => Class['postfix::install'],
    }
  }

  class { 'postfix::aliases':
    aliases    => $aliases,
    newaliases => $newaliases,
    alias_map  => $alias_map,
  }

  class { 'postfix::service':
    service_name   => $service_name,
    service_ensure => $service_ensure,
    service_enable => $service_enable,
    service_flags  => $service_flags,
  }

  Class['postfix::install'] ->
  Class['postfix::config'] ~>
  Class['postfix::service']
}
