# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qemu"
PKG_VERSION="9.1.2"
PKG_SHA256="19fd9d7535a54d6e044e186402aa3b3b1bdfa87c392ec8884855592c8510c96f"
PKG_LICENSE="GPL"
PKG_SITE="https://www.qemu.org"
PKG_URL="https://download.qemu.org/qemu-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="toolchain:host glib:host pixman:host Python3:host zlib:host"
PKG_LONGDESC="QEMU is a generic and open source machine emulator and virtualizer."
PKG_TOOLCHAIN="configure"

pre_configure_host() {
  HOST_CONFIGURE_OPTS="\
    --bindir=${TOOLCHAIN}/bin \
    --extra-cflags=-I${TOOLCHAIN}/include \
    --extra-ldflags=-L${TOOLCHAIN}/lib \
    --libexecdir=${TOOLCHAIN}/lib \
    --localstatedir=${TOOLCHAIN}/var \
    --prefix=${TOOLCHAIN} \
    --sbindir=${TOOLCHAIN}/sbin \
    --sysconfdir=${TOOLCHAIN}/etc \
    --enable-tools \
    --enable-malloc=system \
    --disable-attr \
    --disable-auth-pam \
    --disable-install-blobs \
    --disable-capstone \
    --disable-curl \
    --disable-debug-info \
    --disable-debug-mutex \
    --disable-debug-tcg \
    --disable-docs \
    --disable-gcrypt \
    --disable-gnutls \
    --disable-system \
    --disable-user \
    --disable-vnc \
    --disable-werror \
    --disable-xkbcommon \
    --disable-zstd"

  export DONT_BUILD_LEGACY_PYC=1
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp ${PKG_BUILD}/.${HOST_NAME}/qemu-img ${TOOLCHAIN}/bin
}
