# class gluster::install
#
class gluster::install {
  case $::osfamily {
    'redhat': {
      include gluster::install::redhat
    }
    'debian': {
      case $::operatingsystem {
        'Ubuntu': {
          include gluster::install::ubuntu
        }
        default: { fail("$::operatingsystem not supported") }
    }
    default: { fail("$::osfamily not supported") }
  }
}
