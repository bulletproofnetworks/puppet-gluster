# class gluster::mount
# sets up the mounts on the client
# and ensures the package
class gluster::client(
  $device,
  $mountpoint=$name,
  $mountoptions='fuse-opt=allow_other',
) {
  include gluster::install

  file { $mountpoint:
    ensure => directory,
  }

  mount { $mountpoint:
    ensure  => mounted,
    device  => $device,
    fstype  => 'glusterfs',
    options => $mountoptions,
    require => [
      File[$mountpoint],
      Package['glusterfs-client'],
    ],
  }
}
