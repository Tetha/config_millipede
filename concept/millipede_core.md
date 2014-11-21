# The millipede core

The configuration millipede doesn't consider relaying and distributing pushes as complexity requiring abstraction.
The millipede rather considers relaying and distribution as points of abstraction and embraces them. On a high level, 
relaying is very simple. We passively receive configuration on a configuration source and push the
configuration to configuration targets, according to the push destination coordinates. 

The configuration sources mostly deal with control semantics. For example, a master node would have a file in
a github repository as a source, along with an external trigger. This allows the centipede-cli to trigger a configuration
push by telling the master node to pull the repository, grab the new configuration and shove it to the next nodes.  On the
other hand, the other nodes use a receiving source, which waits for a source to connect, authorize and push a new configuration.

On the other side, we have targets. The millipede pushes a received configuration into the targets it knows. Each target
reports the result of it's push, and the target handles the result. A result might abort the entire push, continue the entire
push or trigger other bookkeeping tasks. This very simple concept transfers a lot of power into the implementation of a target.
