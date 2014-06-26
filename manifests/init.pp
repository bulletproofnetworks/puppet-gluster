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
  # make sure the service is already running when
  # the peers are probed
  # before we create volumes and 
  # do the mount on the client last
  Service <| tag == 'gluster' |>
    -> Exec <| tag == 'peer_probe' |>
    -> Exec <| tag == 'gluster_volume' |>
    -> Mount <| tag == 'gluster_mount' |>
}
