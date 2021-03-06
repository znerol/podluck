Minimal rootless example (shell)
================================

Create the expected directory structure for a pod
``minimal.example.com``.

::

   $ mkdir -p ~/.config/podluck/pod/minimal.example.com ~/.config/systemd/user

Set arguments for pod creation in ``systemd-pod-env``:

::

   $ echo "PODLUCK_POD_ARGS=--share net,uts" > \
       ~/.config/podluck/pod/minimal.example.com/systemd-pod-env

Set arguments for container creation and specify the desired image in
``systemd-container-hello-world-env``:

::

   $ echo "PODLUCK_CONTAINER_ARGS=--log-driver journald --cap-drop ALL" > \
       ~/.config/podluck/pod/minimal.example.com/systemd-container-hello-world-env
   $ echo "PODLUCK_CONTAINER_IMAGE=docker.io/library/hello-world:latest" >> \
       ~/.config/podluck/pod/minimal.example.com/systemd-container-hello-world-env

Copy ``podluck`` units:

::

   $ cp /usr/local/lib/podluck/systemd-skel/podluck.service \
       ~/.config/systemd/user/minimal.example.com.service
   $ cp /usr/local/lib/podluck/systemd-skel/podluck@.service \
       ~/.config/systemd/user/minimal.example.com@.service

Note: ``minimal.example.com.service`` is used to manage the pod,
``minimal.example.com@.service`` is a service template for containers in
that pod.

Call ``systemctl --user daemon-reload`` to inform systemd about the
added unit files.

::

   $ systemctl --user daemon-reload

Now use ``systemctl`` to ``enable`` the pod, and after that all the
``containers``. The command sequence is important. The pod must be
enabled first.

::

   $ systemctl --user enable --now minimal.example.com.service
   $ systemctl --user enable --now minimal.example.com@hello-world.service

After completing those steps, the ``minimal.example.com`` pod should be
up and running along with ``hello-world.minimal.example.com`` container.
Also systemd units ``minimal.example.com.service`` as well as
``minimal.example.com@hello-world`` are expected to be started. Inspect
the results as follows:

::

   $ systemctl --user status minimal.example.com.service
   ??? minimal.example.com.service - Podman pod minimal.example.com managed by podluck
   [...]

   $ systemctl --user status minimal.example.com@hello-world.service
   ??? minimal.example.com@hello-world.service - Podman container hello-world in pod minimal.example.com managed by podluck
   [...]

   $ journalctl --user --unit minimal.example.com.service
   -- Journal begins at Sat 2021-05-22 14:40:55 CEST, ends at Sun 2021-12-19 14:49:14 CET. --
   systemd[676]: Starting Podman pod minimal.example.com managed by podluck...
   [...]

   $ journalctl --user --unit minimal.example.com@hello-world.service
   -- Journal begins at Sat 2021-05-22 14:40:55 CEST, ends at Sun 2021-12-19 14:49:14 CET. --
   systemd[676]: Starting Podman container hello-world in pod minimal.example.com managed by podluck...
   [...]
   conmon[20303]:
   conmon[20303]: Hello from Docker!
   conmon[20303]: This message shows that your installation appears to be working correctly.
   conmon[20303]:
   conmon[20303]: To generate this message, Docker took the following steps:
   conmon[20303]:  1. The Docker client contacted the Docker daemon.
   conmon[20303]:  2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
   conmon[20303]:     (amd64)
   conmon[20303]:  3. The Docker daemon created a new container from that image which runs the
   conmon[20303]:     executable that produces the output you are currently reading.
   conmon[20303]:  4. The Docker daemon streamed that output to the Docker client, which sent it
   conmon[20303]:     to your terminal.
   conmon[20303]:
   conmon[20303]: To try something more ambitious, you can run an Ubuntu container with:
   conmon[20303]:  $ docker run -it ubuntu bash
   conmon[20303]:
   conmon[20303]: Share images, automate workflows, and more with a free Docker ID:
   conmon[20303]:  https://hub.docker.com/
   conmon[20303]:
   conmon[20303]: For more examples and ideas, visit:
   conmon[20303]:  https://docs.docker.com/get-started/
   conmon[20303]:
   [...]
   systemd[676]: minimal.example.com@hello-world.service: Succeeded.
   systemd[676]: minimal.example.com@hello-world.service: Consumed 1.344s CPU time.
