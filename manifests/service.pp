# class gluster::service
# Starts the service
#
class gluster::service {
  service { 'glusterd':
    ensure      => running,
    enabled     => true,
    tag         => 'gluster',
  }

  service { 'glusterfsd-portmap':
    name        => 'portmap',
    ensure      => running,
    enabled     => true,
    tag         => 'glusterfsd-portmap'
  }

  service { 'glusterfsd-rpcbind':
    name        => 'rpcbind',
    ensure      => running,
    enabled     => true,
    tag         => 'glusterfsd-portmap'
  }

  service { 'glusterfsd':
    ensure      => running,
    enabled     => true,
    tag         => 'glusterfsd'
  }

  service { 'glusterfsd-nfs':
    name        => 'nfs',
    ensure      => stopped,
    enabled     => false,
    tag         => 'glusterfsd-nfs'
  }

  Service['glusterd']           ->
  Service['glusterfsd-portmap'] ->
  Service['glusterfsd-rpcbind'] ->
  Service['glusterfsd-nfs']     ->
  Service['glusterfsd']

  Service['glusterfsd-portmap'] ~>
  Service['glusterfsd']

  Service['glusterfsd-rpcbind'] ~>
  Service['glusterfsd']

  Service['glusterfsd-nfs']     ~>
  Service['glusterfsd']
}
