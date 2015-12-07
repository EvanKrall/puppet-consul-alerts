# == Class consul_alerts::params
#
# This class is meant to be called from consul_alerts
# It sets variables according to platform
#
class consul_alerts::params {

  $install_method    = 'url'
  $package_name      = 'consul-alerts'
  $package_ensure    = 'latest'
  $version = '0.3.2'

  case $::architecture {
    'x86_64', 'amd64': { $arch = 'amd64' }
    'i386':            { $arch = '386'   }
    default:           {
      fail("Unsupported kernel architecture: ${::architecture}")
    }
  }
}
