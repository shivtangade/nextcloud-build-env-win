#!/bin/bash
startdir=$(pwd)
installdir=$startdir/install
rm -rf $installdir
cd sprycloud-client-next
git submodule update --init
rm -rf build
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX="$installdir" \
	  -DCMAKE_BUILD_TYPE=Debug \
	  -DNO_SHIBBOLETH=1 \
	  -DCMAKE_PREFIX_PATH="C:\Qt\5.11.1\msvc2017_64" \
	  -DQTKEYCHAIN_LIBRARY="C:\Users\TabFitts\nextcloud-toolchain\lib\qt5keychain.lib" \
	  -DQTKEYCHAIN_INCLUDE_DIR="C:\Users\TabFitts\nextcloud-toolchain\include\qt5keychain" \
	  -G "Visual Studio 15 2017 Win64" ..&&
cmake --build . --config Debug --target install&&
cp $installdir/bin/sprycloud/* $installdir/bin/
cp /c/OpenSSL-Win64/bin/libcrypto-1_1-x64.dll $installdir/bin/
cp /c/OpenSSL-Win64/bin/libssl-1_1-x64.dll $installdir/bin/
cp /c/Users/TabFitts/nextcloud-toolchain/bin/libeay32.dll $installdir/bin/
cp /c/Users/TabFitts/nextcloud-toolchain/bin/ssleay32.dll $installdir/bin/
cp $installdir/config/spryCloud/* $installdir/bin/
windeployqt $installdir/bin
cd $startdir
rm -rf installer
mkdir installer
cmd //c "C:\Program Files (x86)\NSIS\Bin\makensis.exe" project.nsi