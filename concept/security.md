# Security and Authentication

The millipede needs to deal with authentication in multiple situations and scenarios. 

## Communication CLI & Millipede Master

## CLI Triggers

It is necessary to figure out if a certain user is allowed to trigger a certain push. For example, I
need to be able to give developers full configuration pushing rights on test-systems, but I need to
restrict pushing configurations to certain services on productive systems. In the millipede, 
access is granted by whitelisting push coordinates for certain users. 

## Communication between Millipede Segments
Communication between segments is secured through SSL with certificates. The extend of security for a
specific deployment is left to the end user. It is possible to use different certificates for every single
relay node as one extreme case, or a global certificate as another extreme case.

## Authentication between Millipede Segments
We use RSA Signatures to authenticate push commands from a segment. To do so, every relay millipede has a
private and public *push key pair*. Assume we have 2 millipede segments, master and us-gateway. The master
segment needs to push to the us-gateway segment. To do so, it is necessary to deploy the public push
key of the master segment on the us-gateway segment. This allows *everyone with the private push key* of 
the master server to trigger pushes on the us-gateway. In other words, keep those keys secret. 
