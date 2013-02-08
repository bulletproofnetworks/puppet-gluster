# class gluster::install::redhat
#
class gluster::install::redhat {
  package { [ 'glusterfs', 'glusterfs-fuse', 'glusterfs-server' ]:
    ensure      => present,
    tag         => 'gluster',
  }
}
