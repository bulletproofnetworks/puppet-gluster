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
#  $peergrep     = regsubst($hostname, '(\.)', '\\.', 'G')
  $brickvals       = join($bricks, " ")

  if ( $stripe > 0 )    { $stripecmd    = "stripe $stripe"        }
  if ( $replicate > 0 ) { $replicatecmd = "replicated $replicate" }
    

  exec { "gluster volume create $name transport $transport $stripecmd $replicatecmd $brickvals":
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    provider    => shell,
    onlyif      => "! (gluster volume info $name)",
  }

  Service <| tags == 'gluster' |>  ->
  Exec [ "gluster volume create $name transport $transport $stripecmd $replicatecmd $brickvals" ]
}
