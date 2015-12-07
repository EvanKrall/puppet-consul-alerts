# == Class consul_alerts::service
#
# This class is meant to be called from consul_alerts
# It ensures the service is running
#
class consul_alerts::service {
  initscript { 'consul-alerts':
    launchd_name => 'ph.acele.consul-alerts.daemon',
    command      => ["${consul_alerts::bin_dir}/consul-alerts", 'start', '--watch-events', '--watch-checks'],
  }
}
