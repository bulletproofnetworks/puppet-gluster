# class gluster::service
# Starts the service
#
class gluster::service {
  $osmajrelease = regsubst($operatingsystemrelease, '^(\d+)\..*', '\1')
  service { 'glusterd':
    ensure      => running,
    enable      => true,
    tag         => 'gluster',
  }

  if ( $operatingsystem == 'RedHat' and $osmajrelease > 5 ) {
    service { 'glusterfsd-portmap':
      name        => 'portmap',
      ensure      => running,
      enable      => true,
      tag         => 'glusterfsd-rpcbind'
    }
  }

  service { 'glusterfsd-rpcbind':
    name        => 'rpcbind',
    ensure      => running,
    enable      => true,
    tag         => 'glusterfsd-rpcbind'
  }

#  service { 'glusterfsd':
#    ensure      => running,
#    enable      => true,
#    tag         => 'glusterfsd'
#  }

  service { 'glusterfsd-nfs':
    name        => 'nfs',
    ensure      => stopped,
    enable      => false,
    tag         => 'glusterfsd-nfs'
  }

  Package <| tag == 'gluster' |>  ->
  Service['glusterd']             #->
#  Service['glusterfsd-rpcbind']   ->
#  Service['glusterfsd-nfs']       ->
#  Service['glusterfsd']

#  Service['glusterfsd-rpcbind']   ~>
#  Service['glusterfsd']

#  Service['glusterfsd-nfs']       ~>
#  Service['glusterfsd']
}
