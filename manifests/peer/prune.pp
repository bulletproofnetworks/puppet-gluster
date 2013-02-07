# class gluster::peer::prune
# Prunes all not-peers in the cluster
#
class gluster::peer::prune {
  $peers        = $::gluster::peers
  $peergrep     = regsubst(join($peers, "|"), '(\.)', '\\.', 'G')

  # egrep -v '(peer-1\.example\.com|peer-2\.example\.com)'
  exec { "gluster peer status | egrep -v '($peergrep)' | awk '/^Hostname:/{print $2}' | xargs -n 1 gluster peer detach":
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    provider    => shell,
  }
}
