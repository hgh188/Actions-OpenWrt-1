#!/bin/bash
#============================================================
# sxml
# 2025-07-25 1806
#https://github.com/HoldOnBro/Actions-OpenWrt
#https://github.com/breakings/OpenWrt
#============================================================
#移除不用软件包
rm -rf feeds/luci/applications/luci-app-dockerman
#rm -rf package/lean/luci-app-wrtbwmon
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
rm -fr feeds/luci/themes/luci-theme-design
rm -rf feeds/luci/applications/luci-app-ddns-go
rm -rf feeds/packages/net/ddns-go
#重新编译时没有旧的或不必要的文件干扰 #staging_dir：编译生成的文件和依赖库 #build_dir：软件包的源代码和编译生成的文件
rm -rf staging_dir build_dir

# 修改默认主题（从 uci-theme-bootstrap 更改为 luci-theme-design）
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' ./feeds/luci/collections/luci/Makefile

# 修改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 设置ttyd免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

# 克隆 kenzok8仓库
git clone --depth=1 https://github.com/kenzok8/openwrt-packages.git kenzok8-packages
cp -rf kenzok8-packages/smartdns package/smartdns
cp -rf kenzok8-packages/luci-app-smartdns package/luci-app-smartdns
#cp -rf kenzok8-packages/luci-theme-argon package/luci-theme-argon
#cp -rf kenzok8-packages/ddns-go package/ddns-go
#cp -rf kenzok8-packages/gost package/gost
#git clone --depth=1 https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
git clone --depth=1 https://github.com/kenzok8/small-package.git small-package
#cp -rf small-package/gost package/gost
#cp -rf small-package/luci-app-gost package/luci-app-gost
#cp -rf small-package/sagernet-core package/sagernet-core
#cp -rf small-package/v2ray-geodata package/v2ray-geodata
cp -rf small-package/brook package/brook
cp -rf small-package/ssocks package/ssocks
cp -rf small-package/pdnsd-alt package/pdnsd-alt
cp -rf small-package/trojan-go package/trojan-go
cp -rf small-package/dns2tcp package/dns2tcp
cp -rf small-package/v2ray-geoview package/v2ray-geoview

# 克隆 fw876 仓库
git clone --depth=1 -b main https://github.com/fw876/helloworld.git
#cp -rf helloworld/luci-app-ssr-plus package/luci-app-ssr-plus
cp -rf helloworld/xray-core package/xray-core
cp -rf helloworld/xray-plugin package/xray-plugin
cp -rf helloworld/shadowsocks-rust package/shadowsocks-rust
cp -rf helloworld/shadowsocksr-libev package/shadowsocksr-libev
cp -rf helloworld/v2ray-plugin package/v2ray-plugin
cp -rf helloworld/v2ray-core package/v2ray-core
#cp -rf helloworld/v2ray-geodata package/v2ray-geodata
cp -rf helloworld/trojan package/trojan
#cp -rf helloworld/sagernet-core package/sagernet-core
cp -rf helloworld/microsocks package/microsocks
cp -rf helloworld/redsocks2 package/redsocks2
cp -rf helloworld/ipt2socks package/ipt2socks
cp -rf helloworld/dns2socks package/dns2socks
cp -rf helloworld/lua-neturl package/lua-neturl
cp -rf helloworld/gn package/gn
cp -rf helloworld/shadow-tls package/shadow-tls
cp -rf helloworld/tuic-client package/tuic-client
cp -rf helloworld/naiveproxy package/naiveproxy
#rm -rf helloworld

# 克隆openwrt-passwall仓库
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages.git
#cp -rf openwrt-passwall-packages/brook package/brook
#cp -rf openwrt-passwall-packages/ssocks package/ssocks
cp -rf openwrt-passwall-packages/simple-obfs package/simple-obfs
#cp -rf openwrt-passwall-packages/pdnsd-alt package/pdnsd-alt
cp -rf openwrt-passwall-packages/chinadns-ng package/chinadns-ng
cp -rf openwrt-passwall-packages/tcping package/tcping
#cp -rf openwrt-passwall-packages/trojan-go package/trojan-go
cp -rf openwrt-passwall-packages/trojan-plus package/trojan-plus
cp -rf openwrt-passwall-packages/hysteria package/hysteria
#cp -rf openwrt-passwall-packages/dns2tcp package/dns2tcp
cp -rf openwrt-passwall-packages/sing-box package/sing-box
cp -rf openwrt-passwall-packages/v2ray-geodata package/v2ray-geodata
#rm -rf openwrt-passwall-packages

#passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall.git
cp -rf openwrt-passwall/luci-app-passwall package/luci-app-passwall
#rm -rf openwrt-passwall

#passwall2
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git
cp -rf openwrt-passwall2/luci-app-passwall2 package/luci-app-passwall2
#rm -rf openwrt-passwall2

#解析
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb

#添加luci-app-amlogic
git clone --depth=1 https://github.com/ophub/luci-app-amlogic.git
cp -rf luci-app-amlogic/luci-app-amlogic package/luci-app-amlogic
#rm -rf luci-app-amlogic
#修改晶晨宝盒默认配置
# 1.设置OpenWrt 文件的下载仓库
sed -i "s|https.*/OpenWrt|https://github.com/sxml/Actions-OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
# 2.设置 Releases 里 Tags 的关键字
sed -i "s|ARMv8|ARMv8|g" package/luci-app-amlogic/root/etc/config/amlogic
# 3.设置 Releases 里 OpenWrt 文件的后缀
sed -i "s|.img.gz|.img.gz|g" package/luci-app-amlogic/root/etc/config/amlogic
# 4.设置 OpenWrt 内核的下载路径
#sed -i "s|opt/kernel|BuildARMv8|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|http.*/library|https://github.com/breakings/OpenWrt/tree/main/opt/kernel|g" package/luci-app-amlogic/root/etc/config/amlogic

# themes 主题
git clone --depth=1 https://github.com/sxml/luci-theme-design.git package/luci-theme-design
git clone --depth=1 https://github.com/sxml/luci-app-design-config.git package/luci-app-design-config

#mosdns
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
#命令中的 -b v5-lua 的意思是指定要克隆的分支（branch）为 v5-lua
git clone -b v5-lua https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns
git clone -b v5-lua https://github.com/sbwml/luci-app-mosdns package/mosdns

#添加ddns-go 动态域名解析
#git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go.git
cp -rf luci-app-ddns-go/ddns-go package/ddns-go
cp -rf luci-app-ddns-go/luci-app-ddns-go package/luci-app-ddns-go

#文件浏览器
git clone --depth=1 https://github.com/sxml/luci-app-filebrowser.git package/luci-app-filebrowser

#小猫
git clone --depth=1 https://github.com/vernesong/OpenClash.git
cp -rf OpenClash/luci-app-openclash package/luci-app-openclash
# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
#rm -rf OpenClash

#libcryptopp 编译问题
# 在 Makefile 中显式指定编译器
sed -i '/include $(INCLUDE_DIR)\/package.mk/a TARGET_CC:=aarch64-openwrt-linux-musl-gcc\nTARGET_CXX:=aarch64-openwrt-linux-musl-g++' package/lean/libcryptopp/Makefile
# 清理 libcryptopp 的缓存
make package/lean/libcryptopp/clean

#修改makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/luci\.mk/include \$(TOPDIR)\/feeds\/luci\/luci\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/lang\/golang\/golang\-package\.mk/include \$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang\-package\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHREPO/PKG_SOURCE_URL:=https:\/\/github\.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload\.github\.com/g' {}

# 修复 GCC 工具链配置以支持 QEMU ARMv8 Cortex-A53 
#echo "Fixing GCC architecture configuration for Cortex-A53..." 
#sed -i 's/--with-arch=armv8-a+crypto/--with-arch=armv8-a --with-cpu=cortex-a53/' toolchain/gcc/initial/Makefile
#sed -i 's/--with-arch=armv8-a+crypto/--with-arch=armv8-a+crc+crypto --with-cpu=cortex-a53/' toolchain/gcc/initial/Makefil

#强制GCC配置接 受加密扩展
sed -i 's/--with-arch=armv8-a+crypto/--with-arch=armv8-a --with-cpu=cortex-a53 --enable-crypto/g' /workdir/openwrt/toolchain/gcc/initial/Makefile

# # 更新 GCC 版本
# echo "Updating GCC version to 12.3.0..."
# sed -i 's/gcc-11.3.0/gcc-12.3.0/' toolchain/gcc/initial/Makefile
# sed -i 's/GCC_VERSION:=11.3.0/GCC_VERSION:=12.3.0/' toolchain/gcc/initial/Makefile
# sed -i 's|https://gcc.gnu.org/pub/gcc/releases/gcc-11.3.0/|https://gcc.gnu.org/pub/gcc/releases/gcc-12.3.0/|' toolchain/gcc/initial/Makefile

./scripts/feeds update -a
./scripts/feeds install -a
