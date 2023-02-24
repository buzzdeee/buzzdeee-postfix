# private class, do not use directly
# This class takes care about
# package installation
class postfix::install (
  $package_name,
  $package_ensure,
  $package_flavor,
) {

  package { $package_name:
    ensure => $package_ensure,
    flavor => $package_flavor,
  }

  package { 'py3-policyd-spf':
    ensure => installed,
  }

}
