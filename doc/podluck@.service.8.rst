podluck@.service
================

Synopsis
--------

**podluck@.service**

Description
-----------

Systemd unit used to start and stop a podman container managed by podluck.


Environment
-----------

.. envvar:: PODLUCK_CONTAINER_ARGS_DEFAULT

   Default arguments passed to ``podman run`` whenever the unit is started.

.. envvar:: PODLUCK_CONTAINER_ARGS_POD

   Per-pod arguments passed to ``podman run`` whenever the unit is started.

.. envvar:: PODLUCK_CONTAINER_ARGS

   Per-container arguments passed to ``podman run`` whenever the unit is
   started.

.. envvar:: PODLUCK_CONTAINER_IMAGE

   Required. Container image to use.

.. envvar:: PODLUCK_CONTAINER_IMAGE_CMD

   Command passed to the container image. Empty by default.


Files (user scope)
------------------

.. envfile:: ~/.config/podluck/default/systemd-container-env

   Optional systemd environment file shared by all containers in all pods.

.. envfile:: ~/.config/podluck/pod/%p/systemd-container-env

   Optional systemd per-pod container environment file.

.. envfile:: ~/.config/podluck/pod/%p/systemd-container-%i-env

   Optional systemd per-container environment file.


Files (user scope)
------------------

.. envfile:: /etc/podluck/default/systemd-container-env

   Optional systemd environment file shared by all containers in all pods.

.. envfile:: /etc/podluck/pod/%p/systemd-container-env

   Optional systemd per-pod container environment file.

.. envfile:: /etc/podluck/pod/%p/systemd-container-%i-env

   Optional systemd per-container environment file.


See Also
--------

:manpage:`podluck.service(5)`
