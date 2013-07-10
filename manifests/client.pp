# class gluster::mount
# sets up the mounts on the client
# and ensures the package
class gluster::client(
  $device,
  $mountpoint=$name,
) {
  include gluster::install

  file { $mountpoint:
    ensure => directory,
  }

  mount { $mountpoint:
    device => "$device",
    fstype => "glusterfs",
    ensure => mounted,
    require => [
      File[$mountpoint],
      Package["glusterfs-client"],
    ],
  }
}
