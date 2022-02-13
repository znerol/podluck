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
* One template service unit file (``my-pod-name@.service``) used to start and
  stop individual containers. Copied from `podluck@.service`_ unit file.

The unit files make extensive use of `systemd specifiers`_. It is enough to copy
and rename the unit files shipping with ``podluck`` in order to setup a new pod
either in `user` or `system` scope.

Pods and containers are configured using `systemd environment files`_. The final
`podman-pod-create(1)`_ and `podman-run(1)`_ command lines are pieced together
from various environment variables. As a result it is easy to specify arguments
for ``pods`` and ``containers`` which should be the same for all pods on the
same host, or all containers of a specific pod, without repeating them in
instance specific environment files for each single container.

Note that pods and containers managed by ``podluck`` are ephemeral. Containers
are created from scratch when the respective systemd unit is started and removed
upon termination. As a result, pods and containers managed by ``podluck`` are
compatible with `podman-auto-update(1)`_ mechanism.

.. _`systemd specifiers`: https://www.freedesktop.org/software/systemd/man/systemd.unit.html#Specifiers
.. _`systemd environment files`: https://www.freedesktop.org/software/systemd/man/systemd.exec.html#EnvironmentFile=
.. _`podluck.service`: https://github.com/znerol/podluck/blob/develop/lib/systemd-skel/podluck.service
.. _`podluck@.service`: https://github.com/znerol/podluck/blob/develop/lib/systemd-skel/podluck@.service
.. _`podman-pod-create(1)`: https://docs.podman.io/en/latest/markdown/podman-pod-create.1.html
.. _`podman-run(1)`: https://docs.podman.io/en/latest/markdown/podman-run.1.html
.. _`podman-auto-update(1)`: https://docs.podman.io/en/latest/markdown/podman-auto-update.1.html
