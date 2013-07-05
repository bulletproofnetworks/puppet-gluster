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
notice("Running with \$peers ${peers} ID defined")
notice("Running with \$volumes ${volumes} ID defined")
  #create_resources('gluster::peer', $peers)
  #create_resources('gluster::volume', $volumes)
  create_resources('gluster::peer', {'modr-pmdh-static-01' => {} , 'modr-pmdh-static-02' => {} })
  create_resources('gluster::volume', $volumes)
}
