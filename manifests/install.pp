# == Class consul_alerts::install
#
# Installs consul_alerts based in the parameters from init
#
class consul_alerts::install {

  if $consul_alerts::install_method == 'url' {

    staging::file { 'consul_alerts.tar':
      source => $consul_alerts::download_url
    } ->
    staging::extract { 'consul_alerts.tar':
      target  => $consul_alerts::bin_dir,
      creates => "${consul_alerts::bin_dir}/consul_alerts",
    } ->
    file { "${consul_alerts::bin_dir}/consul_alerts":
      owner => 'root',
      group => 0, # 0 instead of root because OS X uses "wheel".
      mode  => '0555',
    }

  } elsif $consul_alerts::install_method == 'package' {

    package { $consul_alerts::package_name:
      ensure => $consul_alerts::package_ensure,
    }

  } else {
    fail("The provided install method ${consul_alerts::install_method} is invalid")
  }

  if $consul_alerts::manage_user {
    user { $consul_alerts::user:
      ensure => 'present',
    }
  }
  if $consul_alerts::manage_group {
    group { $consul_alerts::group:
      ensure => 'present',
    }
  }
}
