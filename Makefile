ifeq ($(prefix),)
    prefix := /usr/local
endif
ifeq ($(exec_prefix),)
    exec_prefix := $(prefix)
endif
ifeq ($(bindir),)
    bindir := $(exec_prefix)/bin
endif
ifeq ($(libdir),)
    libdir := $(exec_prefix)/lib
endif
ifeq ($(datarootdir),)
    datarootdir := $(prefix)/share
endif
ifeq ($(mandir),)
    mandir := $(datarootdir)/man
endif
ifeq ($(python),)
    python := python
endif

all: bin test doc

man1 := $(patsubst doc/%.1.rst,doc/_build/man/%.1,$(wildcard doc/*.1.rst))
man1_installed := $(patsubst doc/_build/man/%,$(DESTDIR)$(mandir)/man1/%,$(man1))
man8 := $(patsubst doc/%.8.rst,doc/_build/man/%.8,$(wildcard doc/*.8.rst))
man8_installed := $(patsubst doc/_build/man/%,$(DESTDIR)$(mandir)/man8/%,$(man8))

scriptdirs := bin $(wildcard lib/*-skel)
scripts := $(foreach dir,$(scriptdirs),$(wildcard $(dir)/*))
scripts_installed := \
    $(patsubst bin/%,$(DESTDIR)$(bindir)/%,$(filter bin/%,$(scripts))) \
    $(patsubst lib/%,$(DESTDIR)$(libdir)/podluck/%,$(filter lib/%,$(scripts)))

doc/_build/man/% : doc/%.rst
	${MAKE} -C doc man

bin: $(scripts)
	# empty for now

lint: bin
	shellcheck $(scripts)

test: bin
	PATH="$(shell pwd)/bin:${PATH}" $(python) -m test

doc: $(man1) $(man8)

clean:
	${MAKE} -C doc clean
	-rm -rf dist
	-rm -rf build

# Install rule for executables/scripts
$(DESTDIR)$(bindir)/% : bin/%
	install -m 0755 -D $< $@

# Install rule for hook scripts
$(DESTDIR)$(libdir)/podluck/% : lib/%
	install -m 0755 -D $< $@


# Install rule for manpages
$(DESTDIR)$(mandir)/man1/% : doc/_build/man/%
	install -m 0644 -D $< $@

# Install rule for manpages
$(DESTDIR)$(mandir)/man8/% : doc/_build/man/%
	install -m 0644 -D $< $@

install-doc: doc $(man1_installed) $(man8_installed)

install-bin: bin $(scripts_installed)

install: install-bin install-doc

uninstall:
	-rm -f $(man1_installed)
	-rm -f $(man8_installed)
	-rm -f $(scripts_installed)
	-rm -f $(DESTDIR)$(mandir)/man8/podluck-build-daily@.service.8
	-rm -f $(DESTDIR)$(mandir)/man8/podluck-build-weekly@.service.8
	-rm -f $(DESTDIR)$(mandir)/man8/podluck-build-daily@.timer.8
	-rm -f $(DESTDIR)$(mandir)/man8/podluck-build-weekly@.timer.8
	-rm -f $(DESTDIR)$(libdir)/podluck/git-hooks/post-receive
	-rmdir $(DESTDIR)$(libdir)/podluck/git-hooks
	-rmdir $(DESTDIR)$(libdir)/podluck

dist-bin:
	-rm -rf build
	${MAKE} DESTDIR=build prefix=/ install
	mkdir -p dist
	tar --owner=root:0 --group=root:0 -czf dist/podluck-dist.tar.gz -C build .

dist-src:
	mkdir -p dist
	git archive -o dist/podluck-src.tar.gz HEAD

dist: dist-src dist-bin
	cd dist && md5sum podluck-*.tar.gz > md5sum.txt
	cd dist && sha1sum podluck-*.tar.gz > sha1sum.txt
	cd dist && sha256sum podluck-*.tar.gz > sha256sum.txt

.PHONY: \
	all \
	clean \
	dist \
	dist-bin \
	dist-src \
	install \
	install-bin \
	install-doc \
	lint \
	test \
	uninstall \
