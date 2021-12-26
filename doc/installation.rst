Installation
============

Dependencies
------------

The ``podluck`` systemd units only depend on `podman`_. Familiarity with
`podman docs`_ is a prerequisite.

.. _`podman`: https://podman.io/



Install
-------

Navigate to the Podluck releases_ page and pick the latest
``podluck-dist.tar.gz`` tarball. Copy it to the target machine and unpack it
there.

.. code-block:: shell

    $ scp dist/podluck-dist.tar.gz me@example.com:~
    $ ssh me@example.com sudo tar -C /usr/local -xzf ~/podluck-dist.tar.gz

.. _releases: https://github.com/znerol/podluck/releases/
.. _`podman docs`: https://docs.podman.io/


Ansible collection
------------------

The ansible collection `znerol.podluck`_ includes the ``podluck`` units and
provides modules and roles which simplify provisioning of ``podman`` pods.

.. _`znerol.podluck`: https://galaxy.ansible.com/znerol/podluck
