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
We support RSA signatures to create a chain of trust. The strength of this chain of trust depends on your
configuration. Every relaying millipede segment can add its own signature with its own private push key
to a push request. Given this, every triggered millipede segment can check as many of these signatures 
as it has public keys. 

If this is done consequently, security increases towards the end of the millipede, because it is necessary
to compromise more and more private push keys in order to get one of the segments running as root on a 
target system to do anything.

Note that this requires careful consideration if you want to manage the segments with the millipede itself.
You almost always want to route a push through at least the master node and one further relay node, so
an attacker has to compromise at least 2 systems to reconfigure nodes of the millipede. 
