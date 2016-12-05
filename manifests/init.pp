# == Class: consul_alerts
#
# Installs, configures, and manages consul-alerts
#
# === Parameters
#
# [*version*]
#   Specify version of consul-alerts binary to download.
#
# [*install_method*]
#   Defaults to `url` but can be `package` if you want to install via a system
#   package.
#
# [*package_name*]
#   Only valid when the install_method == package. Defaults to `consul-alerts`.
#
# [*package_ensure*]
#   Only valid when the install_method == package. Defaults to `latest`.
#
# [*extra_options*]
#   Extra arguments to be passed to the consul-alerts agent, as an array of
#   strings. Will be shellquoted before being written to init scripts.
#
# [*consul_datacenter*]
#   The name of the datacenter to monitor
#
class consul_alerts (
  $manage_user       = false,
  $user              = 'root',
  $manage_group      = false,
  $group             = 'root',
  $bin_dir           = '/usr/local/bin',
  $extra_options     = [],
  $arch              = $consul_alerts::params::arch,
  $version           = $consul_alerts::params::version,
  $install_method    = $consul_alerts::params::install_method,
  $os                = $consul_alerts::params::os,
  $download_url      = "https://github.com/AcalephStorage/consul-alerts/releases/download/v${version}/consul-alerts-${version}-${os}-${arch}.tar",
  $package_name      = $consul_alerts::params::package_name,
  $package_ensure    = $consul_alerts::params::package_ensure,
  $service_enable    = true,
  $service_ensure    = 'running',
  $manage_service    = true,
  $consul_datacenter = 'dc1',
  $consul_acl_token  = '',
) inherits consul_alerts::params {

  # with no arguments, we simply install consul-alerts.
  anchor {'consul_alerts_first': } ->
  class { 'consul_alerts::install': } ->
  anchor {'consul_alerts_last': }

  validate_bool($manage_user)
  validate_bool($manage_service)

  if ($manage_service) {
    Class['consul_alerts::install'] ->
    class { 'consul_alerts::service':
      service_enable    => $service_enable,
      service_ensure    => $service_ensure,
      consul_datacenter => $consul_datacenter,
      consul_acl_token  => $consul_acl_token,
    } ->
    Anchor['consul_alerts_last']
  }
}
