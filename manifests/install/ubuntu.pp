# class gluster::install::ubuntu
#
class gluster::install::ubuntu {
  if $::lsbdistcodename == 'precise' {
    include gluster::apt
  }
  package { [ 'glusterfs-client', 'glusterfs-server' ]:
    ensure      => installed,
    tag         => 'gluster',
  }
}
