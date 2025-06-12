# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2024-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="eden-sa"
PKG_LICENSE="GPLv3"
PKG_DEPENDS_TARGET="toolchain SDL2 boost libevdev libdrm ffmpeg zlib libpng lzo libusb zstd ecm openal-soft pulseaudio alsa-lib llvm libfmt cmake:host ninja:host qt6-base"
PKG_LONGDESC="Eden is the world's most popular open-source Nintendo Switch emulator, forked from the Yuzu emulator."
PKG_TOOLCHAIN="cmake"
PKG_SITE="https://git.eden-emu.dev/eden-emu/eden"
PKG_URL="${PKG_SITE}.git"
PKG_VERSION="1037bff8aca05f78ec6f40e35c7b17c933350033"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
fi

PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS_RELEASE='-DNDEBUG' -DCMAKE_CXX_FLAGS_RELEASE='-DNDEBUG' \
                       -DENABLE_QT=OFF -DENABLE_QT_TRANSLATION=OFF \
                       -DENABLE_WEB_SERVICE=OFF \   # (if you want to disable telemetry services on device)
                       -DENABLE_TESTING=OFF -DENABLE_PROGRAMS=OFF"


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/.${TARGET_NAME}/bin/eden  ${INSTALL}/usr/bin/
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  chmod 755 ${INSTALL}/usr/bin/*
  mkdir -p ${INSTALL}/usr/config/eden
  cp -rf ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/eden/
}
