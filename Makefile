# Copyright (C) 2024 Mattéo Rossillol‑‑Laruelle <beatussum@protonmail.com>
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.


VERSION	:::= $(shell date "+%Y%m%d")

DESTDIR	?=
PREFIX	?= /usr/local

BUILDDIR	?= build

INSTALLEXECCMD	?= install -D -m0755
INSTALLMKDIRCMD	?= install -d
RMDIRCMD		?= rm -fr
SEDCMD			?= sed
SHELLSPECCMD	?= shellspec

.PHONY: all
all: $(BUILDDIR)/join

$(BUILDDIR):
	$(INSTALLMKDIRCMD) $@

$(BUILDDIR)/join: src/join.in $(BUILDDIR)
	$(SEDCMD) "s/@VERSION@/$(VERSION)/g" $< > $@

.PHONY: clean
clean:
	$(RMDIRCMD) $(BUILDDIR)

.PHONY: coverage
coverage: $(BUILDDIR)/join
	$(SHELLSPECCMD) --kcov

.PHONY: test
test: $(BUILDDIR)/join
	$(SHELLSPECCMD)

.PHONY: install
install: $(BUILDDIR)/join
	$(INSTALLEXECCMD) $(BUILDDIR)/join $(DESTDIR)/$(PREFIX)/bin/join