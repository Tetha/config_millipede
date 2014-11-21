# config_millipede

## Design Goals and Use Cases

The configuration millipede project tries to solve a number of issues I'm experiencing at work at the moment:

I need to deal with a **very, very large number of hosts**. The current system contains a
little less than 1e3 hosts (yes, I'm using scientific notation for number of hosts), and it is expected to scale
a lot more. This means, configuration pulls must be used *very carefully*, since otherwise the origin node might end
up in trouble.

Even worse, the hosts are **globally distributed**. This makes a configuration pull from a centralized server even harder,
since latencies between australia or japan and germany tend to be atrocious both in latency and stability. This makes a
configuration pulls even less desireable.

Furthermore, we also have a **high number of heterogenous services**. This means, we have many, many different services
running. Configuration syntaxes, configuration reload, alive checks, rollbacks, configuration sources and so on and so on
all differ from services to service. A strong, enterprise ready configuration push *must be able to handle this complexity*.
Even more, a future oriented configuration push must *embrace and support the idea of interdisciplinary configuration*.

Finally, we also have a lot of **different subsystems**. These need to be handled specifically. For example, in our global
queue, safe updates require us to (i) remove a node from the load balancer, (ii) update the configuration, 
(iii) restart the node, (iv) check the node itself for function, (v) re-add the node to the load balancer, and
(vi) do an integration test of the load balancer with the node. Once all of these are done, and all tests are good, we 
can go to the next node. If tests go back, it might be possible and useful to roll the config back on the problematic node and 
cancel this configuration push so a human can look at the mess. 

Esepecially the latter parts consume an atrocious amount of time when done manually. And even if done right, it still remains
a error-prone process. This process should not be necessary automatically, since the steps are fixed and structured. It should
be possible to automate and implement these change situations in a system designed to handle them, so we can have 
strong, consistent configuration rollouts, even with clusters and complex in-house software. 
