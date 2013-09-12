# type gluster::peer
# Verifies a peer in the Gluster cluster
#
define gluster::peer(
  $hostname,
) {
  # be relaxed, only grep for the hostname (not fqdn)
  $peergrep     = regsubst($hostname, '\..*$', '')
  $fqdngrep     = regsubst($::fqdn, '\..*$', '')

  # Do unless current system is peer
  if ( $peergrep != $fqdngrep ) {
    exec { "gluster peer probe $hostname":
      path        => '/bin:/sbin:/usr/bin:/usr/sbin',
      onlyif      => "! (gluster peer status | egrep -q '$peergrep')",
      provider    => shell,
    }
    Service <| tag == 'gluster' |>   ->
    Exec ["gluster peer probe $hostname"]
  }
}
