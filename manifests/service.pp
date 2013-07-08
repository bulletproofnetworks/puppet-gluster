# class gluster::service
# Starts the service
#
class gluster::service {
  service { 'glusterfs-server':
    ensure      => running,
    enable      => true,
    tag         => 'gluster',
  }
}
