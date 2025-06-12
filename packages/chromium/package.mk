PKG_NAME=chromium  
PKG_VERSION=131.0.6778.264-1  
PKG_ARCH=aarch64  
PKG_URL=https://mirror.archlinuxarm.org/aarch64/extra/chromium-${PKG_VERSION}-aarch64.pkg.tar.xz  
PKG_LICENSE="BSD-3-Clause"  
PKG_DEPENDS_TARGET="alsa-lib dbus fontconfig freetype2 gtk3 harfbuzz icu libcups libffi \
                     libgcrypt libjpeg-turbo libpng libpulse libva libwebp libxml2 libxslt \
                     libxss nss opus pciutils systemd ttf-liberation xdg-utils"  


makeinstall_target(){
    mkdir -p ${INSTALL}/usr/config/modules
	tar -xJf $(PKG_SOURCE_DIR)/chromium-$(PKG_VERSION)-aarch64.pkg.tar.xz -C $(TARGET_DIR)
	cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/config/modules
  	chmod 0755 ${INSTALL}/usr/config/modules/*
    rm -f $(TARGET_DIR)/.PKGINFO $(TARGET_DIR)/.MTREE
}
