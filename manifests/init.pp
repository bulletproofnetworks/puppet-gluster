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
notify {"Running with \$peers ${peers} defined": withpath => true}
notify {"Running with \$volumes ${volumes} defined": withpath => true}
  create_resources('gluster::peer', $peers)
  create_resources('gluster::volume', $volumes)
}
