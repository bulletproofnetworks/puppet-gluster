# type gluster::peer
# Verifies a peer in the Gluster cluster
#

# FIXME:  Can't figure out how to make this react to an Exec[], particularly
# if your volume isn't the same as the one here.  Know how to detect it, but
# the Exec[] won't do anything useful.
#
define gluster::volume(
  $bricks,
  $vname        = $title,
  $stripe       = 0,
  $replicate    = 0,
  $transport    = tcp,
) {
  $brickvals       = join($bricks, ' ')

  $brickpath       = split("${bricks[0]}", ':')

  $brickpathdirs   = split("${brickpath[1]}", '[/]')

  file { "/${brickpathdirs[1]}":
    ensure => directory,
  }

# FIXME: give puppet's lack of "mkdir -p" or iteration, doing this up to 4 levles deep...
# /me sigh
#
  if ( "${brickpathdirs[2]}" ) {
    file { "/${brickpathdirs[1]}/${brickpathdirs[2]}":
      ensure => directory,
    }
  }
  if ( "${brickpathdirs[3]}" ) {
    file { "/${brickpathdirs[1]}/${brickpathdirs[2]}/${brickpathdirs[3]}":
      ensure => directory,
    }
  }
  if ( "${brickpathdirs[4]}" ) {
    file { "/${brickpathdirs[1]}/${brickpathdirs[2]}/${brickpathdirs[3]}/${brickpathdirs[4]}":
      ensure => directory,
    }
  }

  exec { "/opt/local/bin/puppet-gluster.sh ensure_volume $vname $transport $stripe $replicate $brickvals":
    tag         => 'gluster_volume',
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless      => "gluster volume info $vname",
    provider    => shell,
    tries       => 5,
    try_sleep   => 4,
  }

  Service <| tag == 'gluster' |>    ->
  Exec ["/opt/local/bin/puppet-gluster.sh ensure_volume $vname $transport $stripe $replicate $brickvals" ]

  File ['/opt/local/bin/puppet-gluster.sh'] ->
  Exec ["/opt/local/bin/puppet-gluster.sh ensure_volume $vname $transport $stripe $replicate $brickvals" ]
}
