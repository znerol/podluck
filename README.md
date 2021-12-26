# Podluck - Podman pods managed by systemd

[![CI](https://github.com/znerol/podluck/actions/workflows/ci.yml/badge.svg)](https://github.com/znerol/podluck/actions/workflows/ci.yml)

`Podluck` is a set of systemd units designed to run podman pods in `system` or
in `user` scope.

`Podluck` units are an alternative to `podman generate-systemd --new`. The units
are especially useful on systems deployed using configuration management. In
this situation it is often unpractical to spin up a pod with the sole purpose to
generate units from it. With `podluck`, units can be prepared and shipped to
host systems for entirely new pods in a consistent manner (i.e., idempotent).


## Installation

Navigate to the releases page and pick the latest `podluck-dist.tar.gz` tarball.
Copy it to the target machine and unpack it there.

    $ scp dist/podluck-dist.tar.gz me@example.com:~
    $ ssh me@example.com sudo tar -C /usr/local -xzf ~/podluck-dist.tar.gz


## Build

*Preferred method*: Build a distribution tarball, copy it to the target machine
and unpack it there.

    $ make dist
    $ scp dist/podluck-dist.tar.gz me@example.com:~
    $ ssh me@example.com sudo tar -C /usr/local -xzf ~:podluck-dist.tar.gz

*Alternative method*: Check out this repository on the traget machine and
install it directly. The destination directory can be changed with the `prefix`
variable in order to change the installation prefix to something else than
`/usr/local`.

    $ make all
    $ sudo make prefix=/opt/local install

[Sphinx] is necessary in order to build the man pages and the users guide. This
step can be skipped by using the `install-bin` target.

[Sphinx]: https://www.sphinx-doc.org/


## Ansible collection

The ansible collection [znerol.podluck] includes the `podluck` units and
provides modules and roles which simplify provisioning of `podman` pods.

[znerol.podluck]: https://galaxy.ansible.com/znerol/podluck

## Documentation

See [podluck.readthedocs.io] for more instructions and examples. Also the
manpages [podluck.service(8)] and [podluck@.service(8)] provide detailed
information.

[podluck.readthedocs.io]: https://podluck.readthedocs.io/en/latest/
[podluck.service(8)]: https://podluck.readthedocs.io/en/latest/podluck.service.8.html
[podluck@.service(8)]: https://podluck.readthedocs.io/en/latest/podluck@.service.8.html

## Why this name?

The name `podluck` is derived from
[Potluck]. The Potluck Dinner is a
community event where guests bring a dish for the benefit of all. This is an apt
metaphor for the microservice architecture where individual containers provide
services to form a useful application.

[Potluck]: https://en.wikipedia.org/wiki/Potluck

## License

* [GPL-3 or later](https://www.gnu.org/licenses/gpl-3.0.en.html)
