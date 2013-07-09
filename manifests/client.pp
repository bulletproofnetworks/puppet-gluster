# class gluster::mount
# sets up the mounts on the client
# and ensures the package
class gluster::client(
  $peers,
  $volumes,
  $mountpoint=$name,
) {
  include gluster::install

  file { $mountpoint:
    ensure => directory,
  }

#  mount { $mountpoint:
#    device => "$peers:$volumes",
#    fstype => "glusterfs",
#    ensure => mounted,
#    require => [
#      File[$mountpoint],
#      Package["glusterfs-client"],
#    ],
#  }
}
