# private class, do not use directly
# takes care to setup the aliases file
class postfix::aliases (
  $aliases,
  $alias_map,
  $newaliases,
) {
  each ($aliases) |$origrecipient, $recipient| {
    mailalias { $origrecipient:
      recipient => $recipient,
      target    => $alias_map,
      notify    => Exec['update mail aliases'],
    }
  }
  Class['postfix::install'] ->
  Mailalias <| target == $alias_map |>

  exec { 'update mail aliases':
    command     => $newaliases,
    refreshonly => true,
  }

}
