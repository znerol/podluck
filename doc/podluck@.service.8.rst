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

.. envvar:: PODLUCK_CONTAINER_STOP_TIMEOUT

   Number of seconds to wait for a container to be stopped. Note, that this
   value needs to be kept in sync with the ``TimeoutStopSec`` directive of the
   respective systemd unit. It is recommended that ``TimeoutStopSec`` is
   choosen by adding 60 to ``PODLUCK_POD_STOP_TIMEOUT``. Otherwise podman
   management processes might get killed by systemd before there was a chance
   to cleanup misbehaving containers. Defaults to 240 seconds.


Files (user scope)
------------------

.. envfile:: ~/.config/podluck/default/systemd-container-env

   Optional systemd environment file shared by all containers in all pods.
   Specify :envvar:`PODLUCK_CONTAINER_ARGS_DEFAULT` in this file.

.. envfile:: ~/.config/podluck/pod/%p/systemd-container-env

   Optional systemd per-pod container environment file. Specify
   :envvar:`PODLUCK_CONTAINER_ARGS_POD` in this file.

.. envfile:: ~/.config/podluck/pod/%p/systemd-container-%i-env

   Optional systemd per-container environment file. Specify
   :envvar:`PODLUCK_CONTAINER_IMAGE` (recommended) along with
   :envvar:`PODLUCK_CONTAINER_IMAGE_CMD` (optional) and
   :envvar:`PODLUCK_CONTAINER_ARGS` (optional) in this file.


Files (system scope)
--------------------

.. envfile:: /etc/podluck/default/systemd-container-env

   Optional systemd environment file shared by all containers in all pods.
   Specify :envvar:`PODLUCK_CONTAINER_ARGS_DEFAULT` in this file.

.. envfile:: /etc/podluck/pod/%p/systemd-container-env

   Optional systemd per-pod container environment file. Specify
   :envvar:`PODLUCK_CONTAINER_ARGS_POD` in this file.

.. envfile:: /etc/podluck/pod/%p/systemd-container-%i-env

   Optional systemd per-container environment file. Specify
   :envvar:`PODLUCK_CONTAINER_IMAGE` (recommended) along with
   :envvar:`PODLUCK_CONTAINER_IMAGE_CMD` (optional) and
   :envvar:`PODLUCK_CONTAINER_ARGS` (optional) in this file.


See Also
--------

:manpage:`podluck.service(5)`
