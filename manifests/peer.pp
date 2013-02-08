# type gluster::peer
# Verifies a peer in the Gluster cluster
#
define gluster::peer(
  $hostname,
) {
  $peergrep     = regsubst($hostname, '(\.)', '\\.', 'G')

  # Do unless current system is peer
  if ( $hostname != $::fqdn ) {
    exec { "gluster peer probe $hostname":
      path        => '/bin:/sbin:/usr/bin:/usr/sbin',
      onlyif      => "! (gluster peer status | egrep -q '$peergrep')",
      provider    => shell,
    }
    Service <| tag == 'gluster' |>   ->
    Exec ["gluster peer probe $hostname"]
  }
}
