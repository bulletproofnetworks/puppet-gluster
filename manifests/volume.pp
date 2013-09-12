# type gluster::peer
# Verifies a peer in the Gluster cluster
#

# FIXME:  Can't figure out how to make this react to an Exec[], particularly
# if your volume isn't the same as the one here.  Know how to detect it, but
# the Exec[] won't do anything useful.
#
define gluster::volume(
  $bricks,
  $name         = $title,
  $stripe       = 0,
  $replicate    = 0,
  $transport    = tcp,
) {
  $brickvals       = join($bricks, ' ')

  exec { "/opt/local/bin/puppet-gluster.sh ensure_volume $name $transport $stripe $replicate $brickvals":
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless      => "gluster volume info $name",
    provider    => shell,
  }

  Service <| tag == 'gluster' |>    ->
  Exec ["/opt/local/bin/puppet-gluster.sh ensure_volume $name $transport $stripe $replicate $brickvals" ]

  File ['/opt/local/bin/puppet-gluster.sh'] ->
  Exec ["/opt/local/bin/puppet-gluster.sh ensure_volume $name $transport $stripe $replicate $brickvals" ]
}
