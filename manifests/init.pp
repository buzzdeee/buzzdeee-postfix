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
  $senders_map_hash  = $postfix::params::senders_map_hash,
  $main_cf           = $postfix::params::main_cf,
  $master_cf         = $postfix::params::master_cf,
  $sysconfig_mail    = $postfix::params::sysconfig_mail,
  $sysconfig_postfix = $postfix::params::sysconfig_postfix,
  $mail_config_type  = $postfix::params::mail_config_type,
  $myhostname        = $postfix::params::myhostname,
  $relayhost         = $postfix::params::relayhost,
  $mydomain          = $postfix::params::mydomain,
  $myorigin          = $postfix::params::myorigin,
  $mydestination     = $postfix::params::mydestination,
  $smtpd_sasl_auth_enable = $postfix::params::smtpd_sasl_auth_enable,
  $smtpd_sasl_path = $postfix::params::smtpd_sasl_path,
  $smtpd_sasl_local_domain = $postfix::params::smtpd_sasl_local_domain,
  $smtpd_sasl_security_options = $postfix::params::smtpd_sasl_security_options,
  $smtp_sasl_auth_enable = $postfix::params::smtp_sasl_auth_enable,
  $smtp_sasl_password_maps = $postfix::params::smtp_sasl_password_maps,
  $smtp_sasl_security_options = $postfix::params::smtp_sasl_security_options,
  $smtp_sasl_tls_security_options = $postfix::params::smtp_sasl_tls_security_options,
  $sender_dependent_relayhost_maps = $postfix::params::sender_dependent_relayhost_maps,
  $relay_to_amavis = $postfix::params::relay_to_amavis,
  $amavis_dst_host = $postfix::params::amavis_dst_host,
  $amavis_dst_port = $postfix::params::amavis_dst_port,
  $amavis_listen_port = $postfix::params::amavis_listen_port,
  $amavis_listen_host = $postfix::params::amavis_listen_host,
  $enable_submission = $postfix::params::enable_submission,
  $submission_flags = $postfix::params::submission_flags,
  $smtpd_tls_auth_only = $postfix::params::smtpd_tls_auth_only,
  $smtpd_tls_capath = $postfix::params::smtpd_tls_capath,
  $smtpd_tls_cert_file = $postfix::params::smtpd_tls_cert_file,
  $smtpd_tls_key_file = $postfix::params::smtpd_tls_key_file,
  $smtpd_use_tls = $postfix::params::smtpd_use_tls,
  $smtp_use_tls = $postfix::params::smtp_use_tls,
  $smtpd_tls_received_header = $postfix::params::smtpd_tls_received_header,
  $smtp_tls_note_starttls_offer = $postfix::params::smtp_tls_note_starttls_offer,
  $inet_protocols = $postfix::params::inet_protocols,
  $mailbox_transport = $postfix::params::mailbox_transport,
  $chroot_lmtp = $postfix::params::chroot_lmtp,
  $mail_owner = $postfix::params::mail_owner,
  $mail_group = $postfix::params::mail_group,
  $setgid_group = $postfix::params::setgid_group,
  $daemon_directory = $postfix::params::daemon_directory,
  $compatibility_level = $postfix::params::compatibility_level,
  $command_directory = $postfix::params::command_directory,
) inherits postfix::params {

  class { 'postfix::install':
    package_ensure => $package_ensure,
    package_name   => $package_name,
    package_flavor => $package_flavor,
  }

  class { 'postfix::config':
    alias_map                       => $alias_map,
    newaliases                      => $newaliases,
    postmap                         => $postmap,
    main_cf                         => $main_cf,
    master_cf                       => $master_cf,
    sysconfig_mail                  => $sysconfig_mail,
    sysconfig_postfix               => $sysconfig_postfix,
    mail_config_type                => $mail_config_type,
    myhostname                      => $myhostname,
    relayhost                       => $relayhost,
    mydomain                        => $mydomain,
    myorigin                        => $myorigin,
    mydestination                   => $mydestination,
    smtpd_sasl_auth_enable          => $smtpd_sasl_auth_enable,
    smtpd_sasl_path                 => $smtpd_sasl_path,
    smtpd_sasl_local_domain         => $smtpd_sasl_local_domain,
    smtpd_sasl_security_options     => $smtpd_sasl_security_options,
    smtp_sasl_auth_enable           => $smtp_sasl_auth_enable,
    smtp_sasl_password_maps         => $smtp_sasl_password_maps,
    smtp_sasl_security_options      => $smtp_sasl_security_options,
    smtp_sasl_tls_security_options  => $smtp_sasl_tls_security_options,
    sender_dependent_relayhost_maps => $sender_dependent_relayhost_maps,
    relay_to_amavis                 => $relay_to_amavis,
    amavis_dst_host                 => $amavis_dst_host,
    amavis_dst_port                 => $amavis_dst_port,
    amavis_listen_port              => $amavis_listen_port,
    amavis_listen_host              => $amavis_listen_host,
    enable_submission               => $enable_submission,
    submission_flags                => $submission_flags,
    smtpd_tls_auth_only             => $smtpd_tls_auth_only,
    smtpd_tls_capath                => $smtpd_tls_capath,
    smtpd_tls_cert_file             => $smtpd_tls_cert_file,
    smtpd_tls_key_file              => $smtpd_tls_key_file,
    smtpd_use_tls                   => $smtpd_use_tls,
    smtp_use_tls                    => $smtp_use_tls,
    smtpd_tls_received_header       => $smtpd_tls_received_header,
    smtp_tls_note_starttls_offer    => $smtp_tls_note_starttls_offer,
    inet_protocols                  => $inet_protocols,
    mailbox_transport               => $mailbox_transport,
    chroot_lmtp                     => $chroot_lmtp,
    mail_owner                      => $mail_owner,
    setgid_group                    => $setgid_group,
    daemon_directory                => $daemon_directory,
    compatibility_level             => $compatibility_level,
    command_directory               => $command_directory,
  }

  if $activate_postfix {
    class { 'postfix::enable':
      service_enable => $service_enable,
      require        => Class['postfix::install'],
      before         => Class['postfix::aliases'],
    }
    Class['postfix::enable'] ->
    Mailalias <| target == $alias_map |>
  }

  class { 'postfix::aliases':
    aliases    => $aliases,
    newaliases => $newaliases,
  }

  class { 'postfix::sender_relays':
    senders_map_hash                => $senders_map_hash,
    postmap                         => $postmap,
    smtp_sasl_password_maps         => $smtp_sasl_password_maps,
    sender_dependent_relayhost_maps => $sender_dependent_relayhost_maps,
    mail_group                      => $mail_group,
  }

  class { 'postfix::service':
    service_name   => $service_name,
    service_ensure => $service_ensure,
    service_enable => $service_enable,
    service_flags  => $service_flags,
  }

  Class['postfix::install'] ->
  Class['postfix::config'] ~>
  Class['postfix::aliases'] ~>
  Class['postfix::sender_relays'] ~>
  Class['postfix::service']
}
