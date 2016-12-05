# == Class consul_alerts::service
#
# This class is meant to be called from consul_alerts
# It ensures the service is running
#
class consul_alerts::service(
  $service_enable,
  $service_ensure,
  $consul_datacenter,
  $consul_acl_token,
) {
  initscript { 'consul-alerts':
    launchd_name   => 'ph.acele.consul-alerts.daemon',
    command        => [
      "${consul_alerts::bin_dir}/consul-alerts",
      'start',
      '--watch-events',
      '--watch-checks',
      "--consul-dc=${consul_datacenter}",
      "--consul-acl-token=${consul_acl_token}",
    ],
    service_ensure => $service_ensure,
    service_enable => $service_enable,
  }
}
