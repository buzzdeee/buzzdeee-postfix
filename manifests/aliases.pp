# private class, do not use directly
# takes care to setup the aliases file
class postfix::aliases (
  $aliases,
  $newaliases,
) {

  create_resources(mailalias, $aliases, {notify => Exec['update mail aliases']})

  Class['postfix::install'] ->
  Mailalias <| target == $alias_map |>

  exec { 'update mail aliases':
    command     => $newaliases,
    refreshonly => true,
  }

}
