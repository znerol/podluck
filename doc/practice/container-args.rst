Containers
==========


Init
----

Many applications are not designed to run as PID 0 and are not prepared to,
e.g., reap dead child processes (zombies).

Therefore, always run containers using the ``--init`` flag -- unless a real
init-system is running inside the container (such as ``systemd`` or ``openrc``).


Read-only images
----------------

Always run containers with the ``--read-only`` flag. If applications need to
write to the storage, either provide persistent storage using a ``--volume`` or
mount a temporary filesystem .


User namespace
--------------

Always specify a user namespace when running containers as root. Use one of the
following options:

================================= ===========
Arguments                         Description
================================= ===========
``--userns``                      Specify an existing user namespace, reuse userns of another container, obtain userns automatically.
``--uidmap``/``--gidmap``         Specify idmaps numerically
``--subuidname``/``--subgidname`` Specify an existing entry in ``/etc/subuid`` and ``/etc/subgid``
================================= ===========


Drop capabilities
-----------------

Always use ``--cap-drop=ALL`` for all containers. Individual containers must
explicitly specify ``--cap-add`` arguments for any capability required by an
application.

Also specify ``--security-opt=no-new-privileges`` by default.
