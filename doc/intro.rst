Intro
=====

``Podluck`` is a set of systemd units designed to run podman pods in ``system``
or in ``user`` scope.

``Podluck`` units are an alternative to ``podman generate-systemd --new``. The
units are especially useful on systems deployed using configuration management.
In this situation it is often unpractical to spin up a pod with the sole purpose
to generate units from it. With ``podluck``, units can be prepared and shipped
to host systems for entirely new pods in a consistent manner (i.e., idempotent).


Design
------

A ``podluck`` pod consists of three systemd unit files:

* One service unit file (``my-pod-name.service``) used to start and stop the
  entire pod. Copied from `podluck.service`_ unit file.
* One target unit file (``my-pod-name.target``) used to synchronize pod and
  container startup. Copied from `podluck.target`_ unit file.
* One template service unit file (``my-pod-name@.service``) used to start and
  stop individual containers. Copied from `podluck@.service`_ unit file.

The unit files make liberal use of `systemd specifiers`_. It is enough to copy
and rename the unit files shipping with ``podluck`` in order to setup a new pod
either in `user` or `system` scope.

Pods and containers are configured using `systemd environment files`_.

.. _`systemd specifiers`: https://www.freedesktop.org/software/systemd/man/systemd.unit.html#Specifiers
.. _`systemd environment files`: https://www.freedesktop.org/software/systemd/man/systemd.exec.html#EnvironmentFile=
.. _`podluck.service`: https://github.com/znerol/podluck/blob/develop/lib/systemd-skel/podluck.service
.. _`podluck.target`: https://github.com/znerol/podluck/blob/develop/lib/systemd-skel/podluck.target
.. _`podluck@.service`: https://github.com/znerol/podluck/blob/develop/lib/systemd-skel/podluck@.service
