#
define thanos::daemon(
  String $options,
  String $daemon_user,
  String $daemon_name,
  String $thanos_component,
  String $init_style = $facts['service_provider'],
  String $bin_dir = $thanos::bin_dir,
  String $bin_name = $thanos::bin_name,
  Boolean $restart_on_change = false,
) {

  if ! defined(Package[$thanos::package_name]) {
    package { $thanos::package_name :
      ensure => $thanos::package_ensure,
      notify => $thanos::notify_service,
    }
  }

  $notify_service = $restart_on_change ? {
    true    => Service[$daemon_name],
    default => undef,
  }


  case $init_style { # lint:ignore:case_without_default
    'systemd': {
      include 'systemd'
      systemd::unit_file {"${daemon_name}.service":
        content => template('thanos/thanos.systemd.erb'),
        notify  => $notify_service,
      }
    }
    'debian': {
      file { "/etc/init.d/${daemon_name}":
        mode    => '0555',
        owner   => 'root',
        group   => 'root',
        content => template('thanos/thanos.debian.erb'),
        notify  => $notify_service,
      }
    }
    'none': {}
  }

  service { $daemon_name :
    ensure => 'running',
    enable => true,
  }

}
