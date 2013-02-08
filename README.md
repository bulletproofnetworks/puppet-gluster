Puppet GlusterFS Module
=======================

This module administrates GlusterFS.  It does so mainly by GlusterFS
commands.

This module banks heavily on Hiera.  If you don't have a hiera.yaml,
you definitely need to learn to use Hiera.

This module 

Example usage
-------------

```puppet
node /^gluster-\d+\.example\.com$/ {
  class { gluster:
    peers       => hiera("gluster::peers"),
    volumes     => hiera("gluster::volumes"),
  }
}

```

With this and the below in Hiera, you will get replication between
[peer-1, peer2] and [peer-3, peer-4], with distribution between these
two pairs.


```yaml
---
gluster::peers:
  - peer-1.example.com:
  - peer-2.example.com:
  - peer-3.example.com:
  - peer-4.example.com:
gluster::volumes:
  web:
    replicate: 2
    bricks:
      - peer-1.example.com:/mnt/silo0
      - peer-2.example.com:/mnt/silo0
      - peer-3.example.com:/mnt/silo0
      - peer-4.example.com:/mnt/silo0
```


