Installation
============

Dependencies
------------

The ``podluck`` systemd units only depend on ``podman``. Familiarity with
`podman docs`_ is a prerequisite.


Install
-------

Navigate to the Podluck releases_ page and pick the latest
``podluck-dist.tar.gz`` tarball. Copy it to the target machine and unpack it
there.

.. code-block:: shell

    $ scp dist/podluck-dist.tar.gz me@example.com:~
    $ ssh me@example.com sudo tar -C /usr/local -xzf ~/podluck-dist.tar.gz

Alternatively use the following ansible task to copy and unarchive a dist
tarball into `/usr/local`.

.. code-block:: yaml

    - name: podluck present
      unarchive:
        src: files/podluck-dist.tar.gz
        dest: /usr/local

.. _releases: https://github.com/znerol/podluck/releases/
.. _`podman docs`: https://docs.podman.io/
