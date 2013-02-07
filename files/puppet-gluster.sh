#!/bin/bash

ensure_peer() {
  peergrep=${1//./\\.}
  if ! (gluster peer status | egrep -q "$peergrep"); then
    gluster probe $1
  fi
}


prune_peers() {
  peergrep="$(echo $* | sed -e 's/ /|/g')"
  gluster peer status \
    | egrep -v "($peergrep)" \
    | awk '/^Hostname:/{print $2}'
    | xargs -n 1 gluster peer detach
}

case $1 in
  ensure_peer)
    shift
    ensure_peer $1
    ;;
  prune_peers)
    shift
    prune_peers $*
    ;;
esac
