#
#
# prude:  Don't do crazy things like drop peers
class gluster(
  $peers,
  $volumes,
  $prude        = true,
) {
  include gluster::install
  include gluster::service
  include gluster::helper
  create_resources('gluster::peer', $peers)
  create_resources('gluster::volume', $volumes)

  Class['gluster::peer'] -> Class['gluster::volume'] -> Class['gluster::client']
}
