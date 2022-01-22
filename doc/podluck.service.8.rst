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

.. envvar:: PODLUCK_POD_STOP_TIMEOUT

   Number of seconds to wait for a pod to be stopped. Note, that this value
   needs to be kept in sync with the ``TimeoutStopSec`` directive of the
   respective systemd unit. It is recommended that ``TimeoutStopSec`` is
   choosen by adding 60 to ``PODLUCK_POD_STOP_TIMEOUT``. Otherwise podman
   management processes might get killed by systemd before there was a chance
   to cleanup misbehaving containers. Defaults to 240 seconds.


Files (user scope)
------------------

.. envfile:: ~/.config/podluck/default/systemd-pod-env

   Optional environment file shared by all pods. Specify
   :envvar:`PODLUCK_POD_ARGS_DEFAULT` in this file.

.. envfile:: ~/.config/podluck/pod/%p/systemd-pod-env

   Optional per-pod environment file. Specify :envvar:`PODLUCK_POD_ARGS` in this
   file.


Files (system scope)
--------------------

.. envfile:: /etc/podluck/default/systemd-pod-env

   Optional environment file shared by all pods. Specify
   :envvar:`PODLUCK_POD_ARGS_DEFAULT` in this file.

.. envfile:: /etc/podluck/pod/%p/systemd-pod-env

   Optional per-pod environment file. Specify :envvar:`PODLUCK_POD_ARGS` in this
   file.


See Also
--------

:manpage:`podluck@.service(5)`
