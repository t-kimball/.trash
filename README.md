# .trash

Task 1: Scalable, secure AWS architecture

A combination of elastic load balancers (ELB) and security groups (SG) provide an effective, flexible route to building a more secure and resilient infrastructure. At a high level, having an ELB handling internet traffic reduces the threat surface considerably. As you move down the stack, using an ELB as the gateway to individual applications or services allows for horizontal scale. It also provides a route for removing single points of failure, or even changing architecture, without having to modify upstream sources.

It's relatively simple, and something I consider low hanging fruit, but it makes a huge impact.
