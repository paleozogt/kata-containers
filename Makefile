# Copyright (c) 2020 Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0
#

# List of available components
COMPONENTS =

COMPONENTS += agent
COMPONENTS += runtime
COMPONENTS += trace-forwarder

# List of available tools
TOOLS =

TOOLS += agent-ctl

STANDARD_TARGETS = build check clean install test vendor

include utils.mk
include ./tools/packaging/kata-deploy/local-build/Makefile

all: build

# Create the rules
$(eval $(call create_all_rules,$(COMPONENTS),$(TOOLS),$(STANDARD_TARGETS)))

# Non-standard rules

generate-protocols:
	make -C src/agent generate-protocols

# Some static checks rely on generated source files of components.
static-checks: build
	bash ci/static-checks.sh

.PHONY: all default static-checks binary-tarball install-binary-tarball
