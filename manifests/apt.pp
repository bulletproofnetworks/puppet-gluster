# == Class: gluster::apt
# you need the puppetlabs apt module in your path for this to work
# see https://forge.puppetlabs.com/puppetlabs/apt
#
class gluster::apt {
  apt::key { 'gluster':
    key        => '774BAC4D',
    key_server => 'pgp.mit.edu',
  }
  apt::source { 'launchpad_semiosis_glusterfs':
    location => 'http://ppa.launchpad.net/semiosis/ubuntu-glusterfs-3.3/ubuntu/',
    release  => $::lsbdistcodename,
    repos    => 'main',
    key      => '774BAC4D',
  }
}
