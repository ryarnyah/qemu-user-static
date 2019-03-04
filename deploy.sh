#!/bin/bash

set -e

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

BASE_REPO=ryarnyah/qemu-user-static

from_arch="x86_64"
to_archs="aarch64 alpha arm armeb cris hppa i386 m68k microblaze microblazeel mips mips64 mips64el mipsel mipsn32 mipsn32el nios2 or1k ppc ppc64 ppc64abi32 ppc64le s390x sh4 sh4eb sparc sparc32plus sparc64 x86_64"

for to_arch in $to_archs; do
    if [ "$from_arch" != "$to_arch" ]; then
        docker push ${BASE_REPO}:$from_arch-$to_arch
    fi
done
