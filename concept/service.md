# Concept: Service

Pushing a configuration correctly requires a level of
intimacy with the configured service. How do we get the
service to reload the config? Is the service able to verify
the configuration beforehand? Can we check for correct
function later on? Can we safely roll back the configuration
change if things go bad? These questions are answered by the
service configuration. 

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
