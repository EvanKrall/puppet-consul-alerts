# puppet-consul-alerts
Puppet module for managing [consul-alerts](https://github.com/AcalephStorage/consul-alerts)

##Installation

To simply install the consul-alerts binary:

```puppet
include consul_alerts
```

## What this module handles
This module handles installing the consul-alerts binary, and creating an init script (using [puppet-initscript](https://github.com/EvanKrall/puppet-initscript)).

It does not write keys into Consul to configure consul-alerts.

##Development
Open an [issue](https://github.com/EvanKrall/puppet-consul-alerts/issues) or
[fork](https://github.com/EvanKrall/puppet-consul-alerts/fork) and open a
[Pull Request](https://github.com/EvanKrall/puppet-consul-alerts/pulls)

##Acknowledgements

Much of the initial code was adapted from [solarkennedy/puppet-consul](https://github.com/solarkennedy/puppet-consul). Thank you to the contributors to that project.
