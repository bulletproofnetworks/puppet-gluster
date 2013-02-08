# class gluster::install
#
class gluster::install {
  case $osfamily {
    'redhat': {
      include gluster::install::redhat
    }
    default:  { fail("$osfamily not supported") }
  }
}
