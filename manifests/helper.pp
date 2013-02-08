# class gluster::helper
# Installs the helper script
#
class gluster::helper {

  file { '/opt/local/bin':
    ensure      => directory,
    owner       => 'root',
    group       => 'root',
    mode        => '0744';
    '/opt/local/bin/puppet-gluster.sh':
    ensure      => present,
    source      => 'puppet:///modules/gluster/puppet-gluster.sh',
    owner       => 'root',
    group       => 'root',
    mode        => '0544',
  }

  File['/opt/local/bin']                   ->
  File['/opt/local/bin/puppet-gluster.sh']
}
