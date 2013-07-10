# class gluster::install::ubuntu
#
class gluster::install::ubuntu {
  include gluster::apt
  package { [ 'glusterfs-client', 'glusterfs-server' ]:
    ensure      => installed,
    tag         => 'gluster',
  }
}
