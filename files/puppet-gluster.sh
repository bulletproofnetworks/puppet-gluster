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
    | awk '/^Hostname:/{print $2}' \
    | xargs -n 1 gluster peer detach
}

validate_brick_peers() {
  e=0
  peers=$(echo $* | awk '
BEGIN{
  RS=" "
  FS=":"
}

! /^[a-zA-Z][^\.]*(\.[^\.]+)*[^:]:\/.*$/ {
  print "FAIL OF EPICNESS"
  exit 1;
}

{
  print $1
}
')
  if ( echo $peers | grep -q 'FAIL OF EPICNESS' ) ; then
    e=1
  fi

  if [ $e -eq 0 ]; then 
    for i in $peers; do
      if ! (gluster peer status | egrep -q "$peergrep"); then
        e=2
      fi
    done
  fi
  return $e
}

create_volume() {
  name=$1
  transport=$2
  stripe=$3
  replicate=$4
  shift 4
  [ "$stripe" -gt 0 ] &&    stripecmd="stripe $stripe"
  [ "$replicate" -gt 0 ] && replicatecmd="replica $replicate"
  brickvals="$*"

  validate_brick_peers $brickvals
  e=$?
  if [ $e -eq 0 ]; then
    gluster volume create $name $stripecmd $replicatecmd transport $transport $brickvals
    e=$?
  fi
  return $e
}

analyze_volume() {
  true
}

ensure_volume() {
  name=$1
  transport=$2
  stripe=$3
  replicate=$4
  shift 4
  if ! (gluster volume info $name); then
    create_volume $name $transport $stripe $replicate $*
    e=$?
  else
    analyze_volume $name $transport $stripe $replicate $*
  fi

  if [ "$e" -eq 0 ]; then
    gluster volume status $name \
      | grep -q 'not started' \
      && gluster volume start $name
  fi
  return $e
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
  ensure_volume)
    shift
    echo $* > /tmp/log.txt
    ensure_volume $*
    ;;
esac
