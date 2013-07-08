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
  hiera_resources('gluster::peer', $peers)
  #create_resources('gluster::peer', {'modr-pmdh-static-01' => { hostname => 'modr-pmdh-static-01'} , 'modr-pmdh-static-02' => { hostname => 'modr-pmdh-static-02'} })
  create_resources('gluster::volume', $volumes)
}
