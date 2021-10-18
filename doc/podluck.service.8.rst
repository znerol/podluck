podluck.service
===============

Synopsis
--------

**podluck.service**

Description
-----------

Systemd unit used to start and stop a podman pod managed by podluck.


Environment
-----------

.. envvar:: PODLUCK_POD_ARGS_DEFAULT

   Default arguments passed to ``podman pod create`` whenever the unit is
   started.

.. envvar:: PODLUCK_POD_ARGS

   Per-pod arguments passed to ``podman pod create`` whenever the unit is
   started.


Files (user scope)
------------------

.. envfile:: ~/.config/podluck/default/systemd-pod-env

   Optional environment file shared by all pods.

.. envfile:: ~/.config/podluck/pod/%p/systemd-pod-env

   Optional per-pod environment file.


Files (system scope)
--------------------

.. envfile:: /etc/podluck/default/systemd-pod-env

   Optional environment file shared by all pods.

.. envfile:: /etc/podluck/pod/%p/systemd-pod-env

   Optional per-pod environment file.


See Also
--------

:manpage:`podluck@.service(5)`
