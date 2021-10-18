podluck.target
==============

Synopsis
--------

**podluck.target**

Description
-----------

Systemd synchronisation unit used when starting and stopping a podman pod
managed by podluck. Individual containers (i.e., ``podluck@.service``) specify
a ``WantedBy=podluck.target`` dependency in their ``[Install]`` section, so as
to be started automatically when the pod starts.

:manpage:`podluck.service(5)`
