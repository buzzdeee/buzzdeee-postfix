# private class, do not use directly
# This class takes care about managing
# the postfix service
class postfix::service (
  $service_name,
  $service_ensure,
  $service_enable,
  $service_flags,
) {
  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
    flags  => $service_flags,
  }

}
