#!/bin/bash

set -e

REPO=multiarch/qemu-user-static
BASE_REPO=ryarnyah/qemu-user-static

from_arch="x86_64"
to_archs="aarch64 alpha arm armeb cris hppa i386 m68k microblaze microblazeel mips mips64 mips64el mipsel mipsn32 mipsn32el nios2 or1k ppc ppc64 ppc64abi32 ppc64le s390x sh4 sh4eb sparc sparc32plus sparc64 x86_64"

for to_arch in $to_archs; do
    if [ "$from_arch" != "$to_arch" ]; then
        curl -LO https://github.com/${REPO}/releases/latest/download/${from_arch}_qemu-${to_arch}-static.tar.gz
        cat > Dockerfile <<EOF
FROM scratch
ADD ${from_arch}_qemu-${to_arch}-static.tar.gz /usr/bin/
EOF
        docker build -t ${BASE_REPO}:$from_arch-$to_arch .
    fi
done
