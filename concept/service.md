# Concept: Service

Pushing a configuration correctly requires a level of
intimacy with the configured service. How do we get the
service to reload the config? Is the service able to verify
the configuration beforehand? Can we check for correct
function later on? Can we safely roll back the configuration
change if things go bad? These questions are answered by the
service configuration. 

## Aspects
Unless we are dealing with a very simple service, the
configuration for this service can be split into a number
of independent parts. Consider for example a server such as
the Apache Web Server. The Apache Web Server has multiple 
largely independent virtual hosts, some central httpd config
and finally potentially some central logging configuration. 

Or, on the other hand most java applications offer several 
independent configurations. Bifroest services usually offer
three major configuration components: Logging, static
configuration and dynamic configuration. Static configuration
usually allocates configuration during service startup.
Dynamic configuration handles config which can easily change
at runtime.
 
The config millipede models this fundamental principle: A
*service definition* consists of a set of *configuration aspects*.
An aspect is the smallest possible push target in the configuration
millipede. For example, for a bifroest service, we end up
with aspects logging, static and dynamic configuration. These
might split up more dependening on the service. 

Each aspect consists of fragments. Fragments are difficult
to define, because fragments can take many, many shapes. To
me, the easiest fragment to reason about is a file. However,
a fragment could be just about anything we need to transmit
and apply to the service somehow. This could range from
plaintext files to encrypted binary blobs to json files we
send to a rest interface.

## Status Command The status command has the job of checking
if the service is working correctly

## Reload Command The reload command has the job of forcing
a service to reload the configuration right now. 

## Configuration Aspects The configuration aspect array is
necessary to define the configuration contents we are
interested in moving around with the configuration
millipede. Note that an *aspect* is not a *single
configuration file*. For example, an httpd with a
debian-style configuration might need to deploy an available
site and a symlink in order to push out a new page. 
