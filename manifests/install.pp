# class gluster::install
#
class gluster::install {
  case $osfamily {
    'redhat': {
      gluster::install::redhat
    }
    default:  { fail("$osfamily not supported") }
  }
}
